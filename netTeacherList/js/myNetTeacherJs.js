// JavaScript Document

//查看个人简介的弹窗
function showPerIntro_1(id){
	var oParent = window.parent;
	var ntId = id;
	var scrollTop=oParent.document.documentElement.scrollTop||oParent.document.body.scrollTop;
	var oPcliHeight = oParent.document.documentElement.clientHeight;
	var oPerResumeFrame = oParent.getId("perResumeFrame");
	var mainWin = oPerResumeFrame.contentWindow;
	mainWin.location.href = "netTeacher.do?action=personalResume&ntId="+id;
	oParent.$(".layer").show();
	oParent.$(".teaResumeBox").show();
	if(oPcliHeight>831){
		oParent.$(".teaResumeBox").height(831);
		oParent.$(".teaResumeBox").css({
			"top":(oPcliHeight - oParent.$(".teaResumeBox").height())/2 + scrollTop
		});
	}else if(oPcliHeight<831){
		oParent.$(".teaResumeBox").css({"top":scrollTop}).show().height(oPcliHeight);
	}
}
//关闭个人荣誉的原图展现的相册
function closeImgOrgBox_1(){
	var oParWinWidth = document.documentElement.clientWidth;
	$("#bigImgBox").hide();
	setTimeout(function(){
		$(".newLayer").animate({left:-oParWinWidth},function(){
			$(".layer").animate({opacity:0.5});
			$("#originPic").removeAttr("style");
		});
	},200);
	
}

//我要评分
function goJudgeScore(ntId){
	//限制每个月只能评价一次
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudentAssessment.do?action=checkReAssess&ntId="+ntId,
		success:function(json){
			if(json){
				alert("该月您已对该导师进行评价，不能重复评分！");
			}else{
				var oParent = window.parent;
				var oParWinHeight = oParent.document.documentElement.clientHeight;
				var scrollTop = oParent.document.documentElement.scrollTop || oParent.document.body.scrollTop;
				oParent.$(".myNetTeaScore").css({"top":parseInt((oParWinHeight - oParent.$(".myNetTeaScore").height())/2) + scrollTop}).show();
				oParent.$(".layer").show();
				oParent.document.getElementById("ntId").value=ntId;
				judgeByStar();
				selectTag();
			}
		}
	});
}

//评分函数
function judgeByStar(){
	var oParent = window.parent;
	var oScoreStar = oParent.getId("scoreStar");
	var aLi = oScoreStar.getElementsByTagName("li");
	var oSpan = oScoreStar.getElementsByTagName("span")[1];
	var i = iScore = iStar = 0;
	for (i = 1; i <= aLi.length; i++){
		aLi[i - 1].index = i;
		//鼠标移过显示分数
		aLi[i - 1].onmouseover = function (){
			fnPoint(this.index);
		};
		//鼠标离开后恢复上次评分
		aLi[i - 1].onmouseout = function (){
			fnPoint();
		};
		//点击后进行评分处理
		aLi[i - 1].onclick = function (){
			iStar = this.index;
			oSpan.innerHTML = "<strong>" + (this.index) + "分</strong>";
		};
	}
	//评分处理
	function fnPoint(iArg){
		//分数赋值
		iScore = iArg || iStar;
		
		for (i = 0; i < aLi.length; i++) {
			if(i < iScore){
				 aLi[i].className = "on";
			}else{
				aLi[i].className = "";
			}
		}
	}
	
}

//对于网络导师的标签选中方法
function selectTag(){
	var oParent = window.parent;
	var aTagRadio = oParent.$(".tagRadio");
	aTagRadio.each(function(i){
		$(this).click(function(){
			$(this).parent("li").append("<em class='choiceState'></em>").siblings().find('em').remove();
		});
	});
	oParent.$(".wid1").click(function(){
		oParent.$(".diyInpTxt").attr("disabled",true).val("");
		$(this).parent("li").append("<span class='bor wid1_bor'></span>").siblings().find('span').remove();
	});
	oParent.$(".wid2").click(function(){
		oParent.$(".diyInpTxt").attr("disabled",false);
		$(this).parent("li").append("<span class='bor wid2_bor'></span>").siblings().find('span').remove();
	});
	
}

//关闭星级评价窗口
function closeJudgeWin(){
	$(".layer").hide();
	$(".myNetTeaScore").hide();
}

//获得导师标签内容
function checkRadio(){
	var netTag = "";
	var chkObjs = document.getElementsByName("tags");
	for(var i=0;i<chkObjs.length;i++){
		if(chkObjs[i].checked){
			netTag = chkObjs[i].value;
			break;
		}
	}
	return netTag;
}
//获得标签Id
function checkRadioId(){
	var assessmentLabel = -1;
	var chkObjs = document.getElementsByName("tags");
	for(var i=0;i<chkObjs.length;i++){
		if(chkObjs[i].checked){
			assessmentLabel = $(chkObjs[i]).attr("id");
			break;
		}
	}
	return assessmentLabel;
}

//提交星级评价标签和心得
function subJudgeScore(){
	var ntId = document.getElementById("ntId").value;
	var assessmentScore = $(".scoreTxt").html();
	var netTag = checkRadio();
	var assessmentLabel = checkRadioId();
	var assessmentContent = document.getElementById("assessment").value;
	if(netTag=="0"){
		netTag = document.getElementById("diyTag").value;
	}
	if($(".scoreTxt").html() == ""){
		alert("给该导师打个评分吧亲~！");
	}else if(netTag==""){
		alert("请选择或填写导师标签！");
	}else if(assessmentContent==""||assessmentContent=="导师回答问题是否给力？快来分享你的心得吧..."){
		alert("请对该导师进行详细评价！");
	}else{
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"netTeacherStudentAssessment.do?action=saveAssessment&ntId="+ntId+"&assessmentScore="+assessmentScore+"&netTag="+netTag
			                     +"&assessmentContent="+assessmentContent+"&assessmentLabel="+assessmentLabel,
			success:function(json){
				if(json){
					alert("您对导师的评价已提交！");
					window.location.reload(true);
				}
			}
		});
	}
}

//显示星星总评价
function showTotalStar(className,subId,ntId){
	var month=$("#month");
	var checkDate = null;
	if(month.length!=0){
		checkDate = $("#month").datebox('getValue');
	}
	$.ajax({
		type:"post",
		dataType:"json",
		url:"netTeacherStudentAssessment.do?action=showTotalStar&subId="+subId+"&ntId="+ntId+"&checkDate="+checkDate,
		success:function(json){
			for(var i=0;i<json.length;i++){
				if(json[i]!=null){
					var dd = $(className+" dd");
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber>=10){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="1分"){
								$(dd[k]).addClass("on");
								break;
							}
						}
						$("#totalScore"+json[i].id).addClass("low");
					}
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber>10&&json[i].totalScoreMonth*10/json[i].totalPjStuNumber<20){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="2分"){
								$(dd[k]).addClass("halfStar");
								break;
							}
						}
						$("#totalScore"+json[i].id).addClass("low");
						break;
					}
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber>=20){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="2分"){
								$(dd[k]).addClass("on");
								break;
							}
						}
						$("#totalScore"+json[i].id).removeClass("low");
						$("#totalScore"+json[i].id).addClass("mid");
					}
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber>20&&json[i].totalScoreMonth*10/json[i].totalPjStuNumber<30){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="3分"){
								$(dd[k]).addClass("halfStar");
								break;
							}
						}
						$("#totalScore"+json[i].id).addClass("mid");
						break;
					}
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber>=30){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="3分"){
								$(dd[k]).addClass("on");
								break;
							}
						}
						$("#totalScore"+json[i].id).addClass("mid");
					}
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber>30&&json[i].totalScoreMonth*10/json[i].totalPjStuNumber<40){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="4分"){
								$(dd[k]).addClass("halfStar");
								break;
							}
						}
						$("#totalScore"+json[i].id).addClass("mid");
						break;
					}
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber>=40){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="4分"){
								$(dd[k]).addClass("on");
								break;
							}
						}
						$("#totalScore"+json[i].id).removeClass("mid");
						$("#totalScore"+json[i].id).addClass("hig");
					}
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber>40&&json[i].totalScoreMonth*10/json[i].totalPjStuNumber<50){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="5分"){
								$(dd[k]).addClass("halfStar");
								break;
							}
						}
						$("#totalScore"+json[i].id).addClass("hig");
						break;
					}
					if(json[i].totalScoreMonth*10/json[i].totalPjStuNumber==50){
						for(var j=0;j<5;j++){
							var k = j+i*5;
							var title = $(dd[k]).attr("title");
							if(title=="5分"){
								$(dd[k]).addClass("on");
							}
						}
						$("#totalScore"+json[i].id).addClass("hig");
					}
				}
			}
		}
	});
}