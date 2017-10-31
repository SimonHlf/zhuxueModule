/**
 * 拉滚动翻页 （自定义实现此方法）
 * myScroll.refresh();		// 数据加载完成后，调用界面更新方法
 */
function pullUpAction () {
	setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
		getMyBindListJson("pull");
		myScroll.refresh();		// 数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
	}, 1000);	// <-- Simulate network congestion, remove setTimeout from production!
	
}

/**
 * 初始化iScroll控件
 */
 function loaded() {
	pullUpEl = document.getElementById('pullUp');	
	pullUpOffset = pullUpEl.offsetHeight;
		
	myScroll = new iScroll('stuInfo', {
		checkDOMChanges : true,
		onRefresh: function () {
			if (pullUpEl.className.match('loading')) {
				pullUpEl.className = '';
				if(noDataFlag){//没有数据
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '没有更多了...';
				}else{
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				}
			}
		},
		onScrollMove: function () {
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
				pullUpEl.className = 'flip';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '释放加载更多...';
				this.maxScrollY = this.maxScrollY;
			} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
				pullUpEl.className = '';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
				this.maxScrollY = pullUpOffset;
			}
		},
		onScrollEnd: function () {
			if (pullUpEl.className.match('flip')) {
				pullUpEl.className = 'loading';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载数据中...';				
				pullUpAction();	// Execute custom function (ajax call?)
			}
		}
	});
		
	setTimeout(function () { document.getElementById('stuInfo').style.left = '0'; }, 800);
}

document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);

document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 200); }, false);
//获取我的班级
function getMyBindListJson(option){
	var bindStatus = $("#stateInpVal").val();
	var payStatus = $("#payStateInp").val();
	var stuName = $("#stuName").val();
	var flag = false;
	var flag_async = true;
	if(option == "init"){//手动点击查询或初始化查询
		pageNo = 1;
		flag_async = true;
	}else{
		flag_async = false;
	}
	$.ajax({
		  type:"post",
		  async:flag_async,//异步
		  dataType:"json",
		  data:{bindStatus:bindStatus,payStatus:payStatus,stuName:escape(stuName),pageNo:pageNo},
		  url:"myGradeApp.do?action=getMyBindListJson&cilentInfo=app",
		  beforeSend:function(){
			  $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		  },
		  success:function (json){ 
			  showMyBindList(json["result"],option);
		  },
		  complete:function(){
			  $("#loadDataDiv").hide();
        	  $(".loadingIcon").remove();
		  }
	});
}
//显示我的班级成员列表
function showMyBindList(list,option){
	var content = "";
	if(list.length > 0){//有记录
		$("#pullUp").show();
		$("#stuInfo").css({"background":"#f3f2f6"});
		pageNo++;
		noDataFlag = false;
		for(var i = 0 ; i < list.length ; i++){
			content += "<li><p class='stNameP'><strong>"+list[i].user.realname+"</strong></p>";
			var payStatus = "";
			if(list[i].payStatus == 0){
				payStatus = "免费试用";
			}else if(list[i].payStatus == 1){
				payStatus = "付费";
			}else if(list[i].payStatus == 2){
				payStatus = "免费";
			}
			content += "<p class='pasStateP'>支付状态："+payStatus+"</p>";
			content += "<p class='useTimeP'>使用期限："+getLocalDate_new(list[i].addDate)+"&nbsp;至&nbsp;"+ getLocalDate_new(list[i].endDate)+"</p>";
			var diffDays = daysBetween(getLocalDate_new(list[i].endDate),getCurrDate("date"));
			if((list[i].bindFlag==-1 || list[i].bindFlag==1) && list[i].clearStatus==0 && diffDays >0){
				content += '<p class="stateP"><span class="triangles"></span><a href="javascript:void(0)" ontouchend="goGuide('+list[i].user.id+','+list[i].teacher.subject.id +',\''+list[i].user.realname+'\')">跟踪指导</a></p>';
			}else if(diffDays <0 && list[i].clearStatus==0 || list[i].bindFlag==2 && list[i].cancelDate !=undefined){
				content += '<p class="stateP"><span class="triangles"></span><a href="javascript:void(0)" ontouchend="sendEmailToStu()")>发送邮件</a></p>';
			}else if(list[i].clearStatus==1){
				content += '<p class="stateP"><span class="pauseSpan"></span><a class="pauseBtn">已升学，无法操作</a></p>';
			}
			content += "</li>";
		}
		if(option == "init"){//初始加载或者查询按钮加载或者条件发生变化拖动加载
			$("#stuInfoDiv").html(content);
		}else{//拖动且查询条件没发生变化
			$("#stuInfoDiv").append(content);
		}
	}else{//无记录
		noDataFlag = true;
		if(option == "init"){
			$("#pullUp").hide();
			$("#stuInfo").css({"background":"#fff"});
			$("#stuInfoDiv").html("<div class='noStBox'><img src='Module/trainSchoolManager/images/noNtDyPic.jpg' width='110'/><p>此状态暂无学生</p></div>");
		}
	}
}
//发送邮件
function sendEmailToStu(){
	//$("#warnPTxt").html("该功能正在紧急施工中");
	//commonTipInfoFn($(".warnInfoDiv"));
}
//获取当前时间
function getCurrDate(option){
	var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = "";
    if(option == "date"){
    	currentdate = year + seperator1 + month + seperator1 + strDate;
    }else if(option == "dateTime"){
    	currentdate = year + seperator1 + month + seperator1 + strDate + " " + date.getHours() + seperator2 + date.getMinutes()+ seperator2 + date.getSeconds();
    }
    return currentdate;
}
//两个日期的时间差（日期格式为 YYYY-MM-dd）
function daysBetween(DateOne,DateTwo){   
    var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-'));  
    var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1);  
    var OneYear = DateOne.substring(0,DateOne.indexOf ('-'));  
  
    var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-'));  
    var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1);  
    var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-'));  
  
    var cha=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);   
    return cha; 
} 
//获取日期格式
function getLocalDate_new(nS){
	if(nS != undefined){
		return nS.substring(0,10);
	}else{
		return "";
	}
}
//跟踪指导
function goGuide(stuId,stuName){
	window.location.href = "guideApp.do?action=goGuidePage&userId="+userId+"&loginStatus="+loginStatus+"&stuId="+stuId+"&stuName="+stuName+"&cilentInfo=appInit";
}
//改变使用状态
function changeUseState(){
	$(".useState").on("touchend",function(event){
		$("#spanTri").addClass("flip");
		$(".triSpan").css({"top":17});
		$("#bindDivWrap").show();
		$(".bindLayer").show();
		$("#payStatusDiv").hide();
		$(".payLayer").hide();
		event.stopPropagation();
	});
	$("#bindStatus>li").on("touchend",function(){
		var nowUseState = $(this).attr("value");
		$("#stateInpVal").val(nowUseState);
		$(".useStateSpan").html($(this).html());
		$("#spanTri").removeClass("flip");
		$(".triSpan").css({"top":24});
		$("#bindDivWrap").hide();
		$(".bindLayer").hide();
		getMyBindListJson("init");
	});
	$("body").on("touchend",function(){
		$("#spanTri").removeClass("flip");
		$(".triSpan").css({"top":24});
		$("#bindDivWrap").hide();
		$(".bindLayer").hide();
	});
}
function changePayState(){
	$(".payStateDiv").on("touchend",function(event){
		$("#payStatusDiv").show();
		$(".payLayer").show();
		$("#bindDivWrap").hide();
		event.stopPropagation();
	});
	$("#payStatus>li").on("touchend",function(){
		var nowUseState = $(this).attr("value");
		$("#payStateInp").val(nowUseState);
		$(".payStateEm").html($(this).html());
		$("#payStatusDiv").hide();
		$(".payLayer").hide();
		getMyBindListJson("init");
	});
	$("body").on("touchend",function(){
		$("#payStatusDiv").hide();
		$(".payLayer").hide();
	});
}
function commonTipInfoFn(obj){
	setTimeout(function(){
		$(obj).show().stop().animate({opacity:1},600,function(){
			$(obj).animate({opacity:0},1500,function(){
				$(obj).hide();
			});
		});
	},300);
}
