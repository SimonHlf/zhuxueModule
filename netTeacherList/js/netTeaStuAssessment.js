//分页
var direct = 0;
var pageSize = 8;
var currentPage = 1;
var pageCount = 1;
function displayPage(currentPage){
	var div = $(".comListParent");
	var count = div.length;
	pageCount = count%pageSize==0?count/pageSize:Math.floor(count/pageSize)+1;
	if(pageCount == 0){
		$("#noComRecords").show();
		$(".turnPageBox").hide();
		pageCount = 1;
	}
	document.getElementById("total").value=pageCount;
	if(currentPage<=1&&direct==-1){
		alert("已经是第一页了！");
		currentPage = 1;
		direct = 0;
		initReplayDivStyle();
		return;
	}else if(currentPage>=pageCount&&direct==1){
		alert("已经是最后一页了！");
		currentPage = pageCount;
		direct = 0;
		initReplayDivStyle();
		return;
	}
	if(count>pageSize){
		currentPage = (currentPage+direct+count)%count;
	}else{
		currentPage = 1;
	}
	document.getElementById("current").value=currentPage;
	
	var begin = (currentPage-1)*pageSize;
	var end = begin+pageSize-1;
	if(end>count){
		end = count;
	}
	div.hide();
	initReplayDivStyle();
	autoHeight_parent("personalModu","parent");
	$(".comListParent").each(function(i){
		if(i>=begin&&i<=end){
			$(this).show();
		}
	});
}
function First(){
	currentPage = 1;
	direct = 0;
	displayPage(currentPage);
}
function Previous(){
	 direct = -1;
	 currentPage = document.getElementById("current").value;
	 displayPage(currentPage--);
}
function Next(){
	 direct = 1;
	 currentPage = document.getElementById("current").value;
	 displayPage(currentPage++);
}
function Last(){
	 direct = 0;
	 currentPage = pageCount;
	 displayPage(currentPage);
}

//提交回复评论
function subResponse(ntsaId){
	var responseContent = document.getElementById("reply"+ntsaId).value;
	if(responseContent==""){
		alert("请填写回复内容！");
	}else{
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"netTeacherStudentAssessment.do?action=saveResponse&ntsaId="+ntsaId+"&responseContent="+encodeURIComponent(responseContent),
			success:function(json){
				if(json>0){
					alert("您对上述评论的回复已提交！");
					document.getElementById("replyList"+ntsaId).innerHTML="";
					showResponse(ntsaId);
					document.getElementById("reply"+ntsaId).value="";
					var num = document.getElementById("replyNo"+ntsaId).innerHTML;
					document.getElementById("replyNo"+ntsaId).innerHTML = parseInt(num)+1;
					window.location.reload(true);
				}else if(json==0){
					alert("您不能对该条评论进行回复！回复者只能对自己发起的评论进行回复！");
					window.location.reload(true);
				}else{
					alert("回复失败！请重新提交！");
				}
				window.parent.$("#personalModu").height(window.parent.$("#personalModu").height() - 114 - $(".hasReplayBox").height() - $(".turnPageBox").height());
			}
		});
	}
}
function showEditReplay(){
	$(".replayBtn").each(function(i){
		$(this).click(function(){
			window.parent.$("#personalModu").removeAttr("style");
			window.parent.$("#personalModu").height(window.parent.$("#personalModu").height() + 114 + $(".hasReplayBox").eq(i).height() + $(".turnPageBox").height());
			//window.parent.$("#personalModu").attr("flag","true");
			$(".replayArea").hide();
			$(".hasReplayBox").hide();
			$(".replayArea").eq(i).show();	
			$(".hasReplayBox").eq(i).show();
		});
	});
}
function initReplayDivStyle(){
	$(".hasReplayBox").css("display","none");
	$(".replayArea").css("display","none");
	window.parent.$("#personalModu").removeAttr("style");
}
//显示评论
function showResponse(ntsaId){
	var v = document.getElementById("replyList"+ntsaId).innerHTML;
	if(v==""){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"netTeacherStudentAssessment.do?action=showResponse&ntsaId="+ntsaId,
			success:function(json){
				if(json){
					for(var i=0;i<json.length;i++){
						var p1="";
						if(json[i].user.username==json[i].netTeacherStudentAssessment.user.username){
							p1="<div class='listConBox'><p class='replayerBox fl'><span class='stIcon'></span><span class='nowReplayer'>"+json[i].user.username+"</span>回复<span>"
							  +json[i].netTeacherStudentAssessment.netTeacher.user.username+"导师</span>：</p>";
						}else{
							p1="<div class='listConBox'><p class='replayerBox fl'><span class='ntIcon'></span><span class='nowReplayer'>"+json[i].user.username+"导师</span>回复<span>"
							  +json[i].netTeacherStudentAssessment.user.username+"</span>：</p>";
						}
						var p2="<p class='replayCons'>"+json[i].responseContent+"<span class='time_Replay'>" +new Date(json[i].responseDate).toLocaleString()+"</span></p></div>";
						
						//$(".listConBox").append(p1+p2);
						$("#replyList"+ntsaId).append(p1+p2);
					}
				}
			}
		});
	}
}
//设置日期不可手动输入
function loadCheckMonth(){  
	$('#month').datebox( {      
		currentText : '今天',      
		closeText : '关闭',      
		disabled : false,     
		required : false, 
		formatter : function(formatter){    	  	
			var year = formatter.getFullYear().toString();
			var month = formatter.getMonth() + 1;
			var day = formatter.getDate();
			if(month < 10){
				month = "0"+month;
			}
			if(day < 10){
				day = "0"+day;
			}
			return year + "-" + month + "-" + day;
		}
    });
	$(".datebox :text").attr("readonly", "readonly");
}

//查看某月的导师评论
function checkMonthPj(){
	var checkDate = $("#month").datebox('getValue');
	window.location.href="netTeacherStudentAssessment.do?action=load&checkDate="+checkDate+"&ntId="+ntId;
}
