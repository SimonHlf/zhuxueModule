//获取自己绑定有效的学生列表（没过期，没取消，没清除）
function getSelfBindStuList(){
	$.ajax({
		  type:"post",
		  async:false,//同步
		  dataType:"json",
		  data:{ntId:ntId},
		  url:"guideApp.do?action=getSelfBindStuInfo&cilentInfo=app",
		  success:function (json){ 
			  showStuList(json["stuInfo"]);
		  }
	});
}
//显示学生列表
function showStuList(list){
	var stuCon = "";
	for(var i = 0 ; i < list.length ; i++){
		stuCon += "<li value='"+list[i].user.id+"'>"+list[i].user.realname+"</li>";
	}
	$("#stuDataUl").html(stuCon);
	if($("#stuDataUl li").length > 0){
		loadStudent();
		getStuData();
	}
}
function getStuData(){
	$(".showStBtn").on("touchend",function(event){
		$("#stuWrapper").css({
			"-webkit-transform":"translateY(50px)",
			"transform":"translateY(50px)"
		});
		$("#spanTri").addClass("flip");
		$(".triSpan").css({"top":17});
		$("#statusDiv").hide();
		$(".recordLayer").hide();
		event.stopPropagation();
	});
	$("#stuDataUl li").on("touchend",function(){
		if(loadStFlag){
			var selectedSt = $(this).attr("value");
			$("#stNaInpVal").val(selectedSt);
			$("#stNameSpan").html($(this).html());
			$("#stuName").html($(this).html());
			$("#stuWrapper").css({
				"-webkit-transform":"translateY(-100%)",
				"transform":"translateY(-100%)"
			});
			$("#spanTri").removeClass("flip");
			$(".triSpan").css({"top":24});
			getSRList('manu');
		}
	});
	//进入学习记录匹配对应的学生编号和名字
	$("#stuDataUl li").each(function(i){
		var selectedSt = $("#stuDataUl li").eq(i).attr("value");
		if(selectedSt == stuId){
			$("#stNameSpan").html($("#stuDataUl li").eq(i).html());
		}
		
	});
	$("body").on("touchend",function(){
		if(loadStFlag){
			$("#stuWrapper").css({
				"-webkit-transform":"translateY(-100%)",
				"transform":"translateY(-100%)"
			});
			$("#spanTri").removeClass("flip");
			$(".triSpan").css({"top":24});
		}
		
	});
};
function loadStudent() {
	myScroll = new iScroll('stuWrapper', { 
		checkDOMChanges: true,
		onScrollMove:function(){
			loadStFlag = false;
		},
		onScrollEnd:function(){
			loadStFlag = true;
		}
	});		
}
//nt下获取指导状态
function getGuideStatus(){
	$("#guideStaSpan").on("touchend",function(event){
		$("#statusDiv").show();
		$(".recordLayer").show();
		event.stopPropagation();
	});
	$("#guideStatus li").on("touchend",function(){
		var selectedGuSta = $(this).attr("value");
		$("#guidInpVal").val(selectedGuSta);
		$("#guideStaSpan").html($(this).html());
		$("#statusDiv").hide();
		$(".recordLayer").hide();
	});
	$("body").on("touchend",function(){
		$("#statusDiv").hide();
		$(".recordLayer").hide();
	});
}
//格式化日期控件
function initDateSel(obj,endYear){
	var opt = {
        preset: 'date', //日期
        theme: 'android-ics light', //皮肤样式
        display: 'modal', //显示方式 
        mode: 'scroller', //日期选择模式
        dateFormat: 'yy-mm-dd', // 日期格式
        setText: '确定', //确认按钮名称
        cancelText: '取消',//取消按钮名籍我
        dateOrder: 'yymmdd', //面板中日期排列格式
        dayText: '日', monthText: '月', yearText: '年', //面板中年月日文字
        endYear:endYear //结束年份
    };
    $("#"+obj).mobiscroll(opt).date(opt);
}
//获取学生对应的学科列表
function getSelfSubjectList(){
	$.ajax({
		  type:"post",
		  async:false,//同步
		  dataType:"json",
		  url:"studyRecordApp.do?action=getSelfSubject&cilentInfo=app",
		  success:function (json){ 
			  showSubList(json["gList"]);
		  }
	});
}
//显示学生对应的学科列表
function showSubList(list){
	var subCon = "";
	for(var i = 0 ; i < list.length ; i++){
		subCon += "<li class='ellip' value='"+list[i].subject.id+"'>"+list[i].subject.subName+"</li>";
	}
	$("#subDataUl").html(subCon);
	getUlData();
}
//获取学科列表值
function getUlData(){
	$("#subNameSpan").on("touchend",function(event){
		$("#subDataUlDiv").show();
		$(".recordLayer").show();
		event.stopPropagation();
	});
	$("#subDataUl li").on("touchend",function(){
		var selectedSub = $(this).attr("value");
		$("#subInpVal").val(selectedSub);
		$("#subNameSpan").html($(this).html());
		$("#subDataUlDiv").hide();
		$(".recordLayer").hide();
	});
	$("body").on("touchend",function(){
		$("#subDataUlDiv").hide();
		$(".recordLayer").hide();
	});
}
//获取学习记录
function getSRList(option){
	if(checkLoginStatus()){
		if(roleName == "stu" || roleName == "family"){
			subId = $("#subInpVal").val();
			subName = $("#subNameSpan").html();
			startTime = $("#startTime").val();
			endTime = $("#endTime").val();
			$.ajax({
				  type:"post",
				  async:true,//异步
				  dataType:"json",
				  data:{subId:subId,startTime:startTime,endTime:endTime},
				  url:"studyRecordApp.do?action=getSRJson&cilentInfo=app",
				  beforeSend:function(){
					  $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
				  },
				  success:function (json){ 
					  showSRList(json);
				  },
				  complete:function(){
		        	  $("#loadDataDiv").hide();
		        	  $(".loadingIcon").remove();
				  }
			});
			$("#sname").html(subName);
			if(roleName == "family"){
				$("#stuName").html("您的孩子");
			}
		}else if(roleName == "nt"){
			stuId = $("#stNaInpVal").val();
			stuName = $("#stNameSpan").html();
			status = $("#guidInpVal").val();
			startTime = $("#startTime").val();
			endTime = $("#endTime").val();
			if(stuId == 0){
				if(option == "init"){
					$(".txtSpan").hide();
					$(".showStBtn").hide();
					$("#recordWrap").html("<div class='noStDiv'><img width='110' src='Module/trainSchoolManager/images/noNtDyPic.jpg'/><p>暂无学生</p></div>");
				}else{
					if($("#stuDataUl li").length > 0){
						$("#warnPTxt").html("请选择学生");
						commonTipInfoFn($(".warnInfoDiv"));
					}else{
						$("#warnPTxt").html("暂无学生");
						commonTipInfoFn($(".warnInfoDiv"));
					}
				}
			}else{
				$.ajax({
					  type:"post",
					  async:true,//同步
					  dataType:"json",
					  data:{stuId:stuId,subId:subId,guideStatus:status,stime:startTime,etime:endTime},
					  url:"guideApp.do?action=getSpecStuStudyInfo&cilentInfo=app",
					  beforeSend:function(){
						  $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
					  },
					  success:function (json){ 
						  showSRList(json);
					  },
					  complete:function(){
			        	  $("#loadDataDiv").hide();
			        	  $(".loadingIcon").remove();
				      }
				});
				$("#stuName").html(stuName);
				$("#sname").html(subName);
			}
		}
	}
}
//显示学习记录
function showSRList(list){
	var srList = list["slList"];//学习记录
	var ntAdvice = list["ntAdvice"];//导师建议
	var sysAdvice = list["sysAdvice"];//系统建议
	var days = list["days"];//间隔天数
	var allStudyNumber = list["allStudyNumber"];//学过知识点
	var succStudyNumber = list["succStudyNumber"];//完成个数
	var noSuccStudyNumber = list["noSuccStudyNumber"];//未完成个数
	var completeRate = list["completeRate"];//完成率
	var recCon = "";
	if(srList.length == 0){//暂无学习记录
		if(roleName == "stu" || roleName == "family"){
			$("#recordInfo").html("<div class='noRecoDiv'><img src='Module/appWeb/studyRecord/images/noRecord.png' alt='暂无学习记录'><p>暂无学习记录</p></div>");
		}else if(roleName == "nt"){
			$("#recordInfo").html("<div class='noRecoDiv'><img src='Module/appWeb/studyRecord/images/noRecord.png' alt='暂无学习记录'><p>该学生暂无学习记录</p></div>");
		}
		$(".noRecoDiv").css({"margin-top":($("#innerRecoWrap").height() - $(".noRecoDiv").height())/2});
	}else{
		for(var i = 0 ; i < srList.length ; i++){
			if(srList[i].isFinish == 1){//未完成
				recCon += "<div id=study_"+srList[i].id+" class='recordDiv'><span class='noCompSpan'></span><p class='recordTxtp ellip fl' ontouchend=getAdviceList("+srList[i].id+","+srList[i].isFinish+")>"+srList[i].lore.loreName+"</p></div>";
			}else if(srList[i].isFinish == 2){//完成
				recCon += "<div id=study_"+srList[i].id+" class='recordDiv'><span class='compSpan'></span><p class='recordTxtp ellip fl' ontouchend=getAdviceList("+srList[i].id+","+srList[i].isFinish+")>"+srList[i].lore.loreName+"</p></div>";
			}	
		}
		$("#recordInfo").html(recCon);
		function recoListScroll() {
			myScroll = new iScroll('innerRecoWrap', { 
				checkDOMChanges: true,
				onScrollMove:function(){
					recordFlag = false;
				},
				onScrollEnd:function(){
					recordFlag = true;
				}
			});	
		}
		recoListScroll();
	}

	$("#days").html(days);
	var totalCon = "<p class='totalTxt'>共学<strong id='asn'>"+allStudyNumber+"</strong>个知识点,完成<strong id='ssn'>"+succStudyNumber+"</strong>个,未完成<strong id='nssn'>"+noSuccStudyNumber+"</strong>个,完成率<strong id='cr'>"+completeRate+"</strong></p>";
	$("#totalInfo").html(totalCon);
	if($("#totalInfo").width() > $(".totalTxt").outerWidth()){
		$(".totalTxt").css({"top":12});
	}
}
//显示指定学习记录的建议
function getAdviceList(studyLogId,isFinish){
	isFinish_a = isFinish;
	if(recordFlag){
		if(checkLoginStatus()){
			$.ajax({
				  type:"post",
				  async:false,//同步
				  dataType:"json",
				  data:{studyLogId:studyLogId},
				  url:"studyRecordApp.do?action=getAdviceJson&cilentInfo=app",
				  success:function (json){ 
						initAdvice(json["sysAdvice"],json["ntAdvice"],studyLogId,isFinish);
				  }
			});
			$(".recordDiv").removeClass("active");
			$("#study_"+studyLogId).addClass("active");
			//隐藏学习明细
			getStudyRelaList(studyLogId);
			$("#studyRelaDivWin").css({
				"-webkit-transform":"translateX(0px)",
				"transform":"translateX(0px)"
			});
			detailScroll();
		}
	}else{
		recordFlag = false;
	}
}
function detailScroll() {
	myScroll = new iScroll('wrapper', { 
		checkDOMChanges: true
	});	
}
//初始建议区域
function initAdvice(sysAdvice,ntAdvice,studyLogId,isFinish){
	if(sysAdvice.length != 0){
		$("#sysAdviceCon").html(sysAdvice);
	}else{
		$("#sysAdviceCon").html("<img class='noSysNtAdImg' src='Module/appWeb/studyRecord/images/noSys.png' alt='暂无系统评价'/>");
	}
	if(roleName == "nt"){
		if(isFinish == 2){
			if(ntAdvice == ""){//网络导师下不存在暂无导师建议 为空创建文本框
				var ntAdviceCon = "<textarea id='ntAdviceTxt' class='removeAFocBg' onkeydown='LimitTextArea(this,100)' onkeypress='LimitTextArea(this,100)' onkeyup='LimitTextArea(this,100)' placeholder='请填写您对该学生的学习指导建议...'></textarea>";
				ntAdviceCon += "<span class='limitNum'><span id='nowNum'>0</span>/<span id='maxNum'>100</span></span>";
				ntAdviceCon += "<a href=javascrpit:void(0) class='subAdvice' ontouchend=addNtAdvice("+studyLogId+");>提交</a>";
				$("#ntAdviceCon").html(ntAdviceCon);
			}else{//不为空显示该导师的建议
				$("#ntAdviceCon").html(ntAdvice);
			}
		}else{
			$("#ntAdviceCon").html("<img class='noSysNtAdImg' src='Module/appWeb/studyRecord/images/noComment.png' alt='只有完成该知识点才能进行指导建议'/>");
		}
		
	}else{//学生身份下导师建议
		if(ntAdvice.length != 0){
			$("#ntAdviceCon").html(ntAdvice);
		}else{
			$("#ntAdviceCon").html("<img class='noSysNtAdImg' src='Module/appWeb/studyRecord/images/noNtAd.png' alt='暂无导师建议'/>");
		}
	}
}
function goBack(){
	$("#studyRelaDivWin").css({
		"-webkit-transform":"translateX("+ cliWid +"px)",
		"transform":"translateX("+ cliWid +"px)"
	});
	$("#sysAdviceCon").html("");
	$("#ntAdviceCon").html("");
	if($(".completeImg").length > 0){
		$(".completeImg").remove();
	}
}
//增加导师建议
function addNtAdvice(studyLogId){
	var ntAdvice = $("#ntAdviceTxt").val();
	if(ntAdvice == ""){
		$("#warnPTxt").html("导师建议不能为空");
		commonTipInfoFn($(".warnInfoDiv"));
	}else{
		$.ajax({
	        type:"post",
	        dataType:"json",
	        data:{studyLogId:studyLogId,slContent:escape(ntAdvice)},
	        url:"guideApp.do?action=addNtAdvice&cilentInfo=app",
	        success:function (json){
	        	if(json["result"] == "succ"){
	        		$("#ntAdviceCon").html(ntAdvice);
	        	}else if(json["result"] == "fail"){
	        		$("#warnPTxt").html("添加导师建议失败，请重试");
	    			commonTipInfoFn($(".warnInfoDiv"));
	        	}else if(json["result"] == "limitAdd"){
	        		$("#warnPTxt").html("该题尚未完成，不能添加导师建议");
	    			commonTipInfoFn($(".warnInfoDiv"));
	        	}
	        }
	    });
	}
}
//获取指定学习记录的关系学习情况
function getStudyRelaList(studyLogId){
	$.ajax({
		  type:"post",
		  async:false,//同步
		  dataType:"json",
		  data:{studyLogId:studyLogId},
		  url:"studyRecordApp.do?action=getStudyRelaJson&cilentInfo=app",
		  success:function (json){ 
				showStudyRelaList(json["slList"]);
		  }
	});
}
//显示指定学习记录的关系学习情况
function showStudyRelaList(list){
	var curStep1 = "未通过";//针对性诊断
	var curStep2 = "未诊断";//关联性诊断
	var curStep3 = "未学习";//关联知识点学习
	var curStep4 = "未学习";//本知识点学习
	var curStep5 = "未诊断";//再次诊断
	if(list.length > 0){
		var isFinish = list[0].isFinish;
		var step = list[0].step;
		var stepComplete = list[0].stepComplete;
		var score = list[0].finalScore;
		if(score != undefined){
			score += "分";
		}else{
			score = "暂无";
		}
		$("#scoreInfo").html(score);
		$("#loreName").html(list[0].lore.loreName);
		if(isFinish == 2){
			$("#curStep1").text("通过");
			$("#curStep2").text("通过");
			$("#curStep3").text("完成");
			$("#curStep4").text("完成");
			$("#curStep5").text("通过");
			$("#completeInfo").text("完成");
			$(".detailInfo").append("<img class='completeImg' src='Module/studyOnline/images/completeIcon.png' alt='任务完成'/>");
		}else{
			if(step == 1){//本知识点的针对性诊断做完题(未通过)，还未进入到关联知识点
				$("#curStep1").text("未通过");
 				$("#curStep2").text("未诊断");
     			$("#curStep3").text("未学习");
     			$("#curStep4").text("未学习");
     			$("#curStep5").text("未诊断");
     			$("#completeInfo").text("未完成");
			}else if(step == 2){
				if(stepComplete == 0){//表示关联性诊断未完成
					$("#curStep1").text("未通过");
     				$("#curStep2").text("诊断未完成");
         			$("#curStep3").text("未学习");
         			$("#curStep4").text("未学习");
         			$("#curStep5").text("未诊断");
				}else{//关联性诊断已经完成
					$("#curStep1").text("未通过");
					$("#curStep2").text("诊断已完成");
         			$("#curStep3").text("未学习");
         			$("#curStep4").text("未学习");
         			$("#curStep5").text("未诊断");
				}
				$("#completeInfo").text("未完成");
			}else if(step == 3){
				if(stepComplete == 0){//表示关联知识点未完成学习
					$("#curStep1").text("未通过");
     				$("#curStep2").text("诊断已完成");
         			$("#curStep3").text("学习未完成");
         			$("#curStep4").text("未学习");
         			$("#curStep5").text("未诊断");
				}else{//表示关联知识点完成学习
					$("#curStep1").text("未通过");
     				$("#curStep2").text("诊断已完成");
         			$("#curStep3").text("学习已完成");
         			$("#curStep4").text("未学习");
         			$("#curStep5").text("未诊断");
				}
				$("#completeInfo").text("未完成");
			}else if(step == 4){
				$("#curStep1").text("未通过");
 				$("#curStep2").text("诊断已完成");
     			$("#curStep3").text("学习已完成");
     			$("#curStep4").text("学习未完成");
     			$("#curStep5").text("未诊断");
     			$("#completeInfo").text("未完成");
			}else{//本知识点再次诊断
				if(stepComplete == 0){//表示本知识点未完成诊断
					$("#curStep1").text("未通过");
     				$("#curStep2").text("诊断已完成");
         			$("#curStep3").text("学习未完成");
         			$("#curStep4").text("学习未完成");
         			$("#curStep5").text("诊断未通过");
         			$("#completeInfo").text("未完成");
				}
			}
		}
		
		if(roleName == "stu"){
			$("#showStudyButt").html("<a href=javascript:void(0) ontouchend=goStudyPage("+list[0].lore.id+",'"+list[0].lore.loreName+"',"+list[0].lore.chapter.id+");>去学习</a>"); 
		}else if(roleName == "family"){
			$("#showStudyButt").hide();
			$("#showRecordButt").css({"width":"100%"});
		}else if(roleName == "nt"){
			var stuName = $("#stNameSpan").html();
			$("#showStudyButt").hide();
			$("#showRecordButt").css({"width":"100%"});
			$(".detailInfo h3").html(stuName + "的学习明细");
			$("#ntAdvice h3").html("我的建议");
		}
		$("#showRecordButt").html("<a href=javascript:void(0) ontouchend=goRecordPage("+list[0].id+","+list[0].lore.id+",'"+list[0].lore.loreName+"',"+subId+")>查看答卷</a>");
	}
}
//根据章节编号获取教材编号
function getEducationId(chapterId){
	var educationId = 0;
	$.ajax({
        type:"post",
        dataType:"json",
        async:false,
        data:{chapID:chapterId},
        url:"studyRecordApp.do?action=getEducationID&cilentInfo=app",
        success:function (json){
        	educationId = json["result"][0].education.id;
        }
	});
	return educationId;
}
function goStudyPage(loreId,loreName,chapterId){
	var educationId = getEducationId(chapterId);
	window.location.href = "studyApp.do?action=goStudyMapPage&loreId="+loreId+"&loreName="+loreName+"&educationId="+educationId+"&cilentInfo=app";
}
//导向查看答卷页面
function goRecordPage(studyLogId,loreId,loreName,subId){
	if(checkLoginStatus()){
		if(roleName == "stu" || roleName == "family"){
			window.location.href = "studyRecordApp.do?action=showStudyDetailPage&studyLogId="+studyLogId+"&loreId="+loreId+"&loreName="+loreName+"&subId="+subId+"&subName="+subName+"&startTime="+startTime+"&endTime="+endTime+"&roleName="+roleName+"&cilentInfo=app";
		}else if(roleName == "nt"){
			window.location.href = "studyRecordApp.do?action=showStudyDetailPage&studyLogId="+studyLogId+"&isFinish="+isFinish_a+"&loreId="+loreId+"&loreName="+loreName+"&isFinish="+isFinish_a+"&stuId="+stuId+"&guideStatus="+status+"&ntId="+ntId+"&subId="+subId+"&startTime="+startTime+"&endTime="+endTime+"&roleName="+roleName+"&cilentInfo=app";
		}
	}
}
//重置input日期宽度
function initWid(){
	var strSpan = "<span class='calIcon'></span>";
	$(".timeBox").width($(".searInner").width() - $(".subBox").width() - $(".searBtn").width()-11);
	$(".timeBox div").width(($(".timeBox").width()/2) - $(".timeBox span").width()+7);
	$(".timeBox div").each(function(i){
		$(".timeBox div").eq(i).append(strSpan);
	});
	$("#recordWrap").height(cliHei - 100);
	$(".recordLayer").height(cliHei - 90);
	$("#wrapper").height(cliHei - 40);
	$(".loreNameP").width(cliWid - $(".goBackBtn").width() - 5).css({"max-width":$(".loreNameP").width() - 10});
	var recWrapHei = $("#recordWrap").height();
	$(".recListWrap").css({"height":recWrapHei * 0.95});
	$(".recListPar").css({"height":recWrapHei * 0.95});
	$("#innerRecoWrap").css({"height":$(".recListPar").height() - $(".recordTit").height() - $(".recordBot").height()});
	//初始化调整学习记录底部代表已完成未完成的位置
	if(cliWid > 410 && cliWid <= 500){
		$(".completeP").html("<span></span>代表已完成");
		$(".noCompleteP").html("<span></span>代表未完成");
	}else if(cliWid > 500 && cliWid <=600){
		$(".statusP").css({"text-indent":35});
		$(".completeP").html("<span></span>代表已完成");
		$(".noCompleteP").html("<span></span>代表未完成");
		$(".statusP span").css({"left":18});
	}else if(cliWid > 600 && cliWid <= 650){
		$(".statusP").css({"text-indent":45});
		$(".completeP").html("<span></span>代表已完成");
		$(".noCompleteP").html("<span></span>代表未完成");
		$(".statusP span").css({"left":28});
	}else if(cliWid >650 && cliWid <= 700){
		$(".statusP").css({"text-indent":55});
		$(".completeP").html("<span></span>代表已完成");
		$(".noCompleteP").html("<span></span>代表未完成");
		$(".statusP span").css({"left":38});
	}else if(cliWid > 700 && cliWid <= 730){
		$(".statusP").css({"text-indent":65});
		$(".completeP").html("<span></span>代表已完成");
		$(".noCompleteP").html("<span></span>代表未完成");
		$(".statusP span").css({"left":48});
	}else if(cliWid > 730){
		$(".statusP").css({"text-indent":75});
		$(".completeP").html("<span></span>代表已完成");
		$(".noCompleteP").html("<span></span>代表未完成");
		$(".statusP span").css({"left":58});
	}
}
function LimitTextArea(obj,maxLimtNum){
	var maxlimit = maxLimtNum;
	var oNowNum = $("#nowNum");
	var oMaxNum = $("#maxNum");
	if(obj.value.length>maxlimit){
		obj.value = obj.value.substring(0,maxlimit);
	}else{
		oMaxNum.html(maxlimit - obj.value.length);
		oNowNum.html(obj.value.length);
	}
}