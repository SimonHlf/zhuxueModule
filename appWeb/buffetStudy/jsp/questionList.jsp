<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../../exception/exception.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>助学网在线答题巴菲特(启动溯源)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/buffetStudy/css/questionList.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/buffetStudy/css/buffetQuestionList.css" type="text/css" rel="stylesheet"/>
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/buffetStudy/js/questionList.js" type="text/javascript"></script>
	<script src="Module/appWeb/onlineStudy/js/comMainStudy.js" type="text/javascript"></script>
	<script type="text/javascript">
		var buffetStudyDetailId = "${requestScope.buffetStudyDetailId}";
		var loreId = "${requestScope.loreId}";
		var buffetId = "${requestScope.buffetId}";
		var buffetName = "${requestScope.buffetName}";
		var studyLogId = "${requestScope.studyLogId}";
		var lastCommitNumber = 0;
		var questionLength = 0;
		var currentAllQuestionFlag = 1;
		var totalMoney = 0;
		var allLorePath = "${requestScope.path}";
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
		var studyType = "${requestScope.studyType}";
		var pathType = "${requestScope.pathType}";
		var loreTaskName = "${requestScope.loreTaskName}";
		var loreTypeName = "${requestScope.loreTypeName}";
		var access = "${requestScope.access}";
		var stepNumber = "${requestScope.stepNumber}";
		var closeFlag = "${requestScope.closeFlag}";
		var basicLoreId = "${requestScope.basicLoreId}";
		var basicLoreName = "${requestScope.basicLoreName}";
		var buffetSendId = "${requestScope.buffetSendId}";
		var relateLoreIdStr = "${requestScope.relateLoreIdStr}";
		var cliHei = document.documentElement.clientHeight;
		var cliWid = document.documentElement.clientWidth;
		var completeNum = 0; //当前已经做过题的数量包括对和错
		var perScale = 0; // 当前已做过题的比例
		var myScroll;
		var botCardFlag = true;//底部答题卡左右的iscroll
		var quesAreaFlag = true;//答题区域每个li上下滚动的iscroll
		var goFlag = true; //展开底部答题卡执行iscroll只执行一次
		var closeFlag = true;
		$(function(){
			$("#mainQuesWrap").height(cliHei - $("#nowLoc").height());
			initDiv();
		});
		document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
		
	</script>
	<style>

	</style>
  </head>
  
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage();"></span>
		<p class="bigTit ellip">${requestScope.buffetName}</p>
		<p class="smallTit">针对该知识点而设定的自助餐诊断题目共<span id="questionLength"></span>题</p>
	</div>
	<!-- 中间答题核心区域  -->
	<div id="mainQuesWrap">
		<!-- 做题进度条  -->
		<div id="proBarWrap">
			<div id="innerProBarDiv">
				<span class="queNumSpan"></span>
				<div class="finalDiv finalCol"><i class='finalFlag'></i></div>
				<div class="proBarDiv">
					<span class="rateLine"></span>
				</div>
			</div>
		</div>
		<!-- 题库区域 -->
		<div id="questionInfo"></div>
	</div>
	<!-- 题库序号区域 -->
	<div id="botCardBox">
		<div id="botCard"></div>
		<a class="closeBot removeAFocBg" ontouchend="closeBotCard()">
			<i class="closeBotIcon"></i>
			<span class="shadow"></span>
		</a>
	</div>
	<span class='showHideBtn' ontouchend="showHidBotCardBox()"></span>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
	<!-- 答题正确或者错误的提示以及正确下金币的奖励  -->
	<div id="tipInfoBox">
		<div id="tipFace"><span id="facePic"></span></div>
		<p id="infoTxt"></p>
	</div>
		<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
