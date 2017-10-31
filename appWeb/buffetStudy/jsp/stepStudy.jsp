<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>    
    <title>五步学习法</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/appWeb/onlineStudy/css/stepStudy.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/appWeb/ckplayer/ckplayer.js" charset="utf-8"></script>
	<script src="Module/appWeb/buffetStudy/js/stepStudy.js" type="text/javascript"></script>
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
	var currentLoreId = "${requestScope.nextLoreIdArray}";
	var studyType = "${requestScope.studyType}";
	var pathType = "${requestScope.pathType}";
	var loreTaskName = "${requestScope.loreTaskName}";
	var loreTypeName = "${requestScope.loreTypeName}";
	var access = "${requestScope.access}";
	var stepNumber = "${requestScope.stepNumber}";
	var option = "${requestScope.option}";
	var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
	var closeFlag = "${requestScope.closeFlag}";
	var basicLoreId = "${requestScope.basicLoreId}";
	var basicLoreName = "${requestScope.basicLoreName}";
	var buffetSendId = "${requestScope.buffetSendId}";
	var relateLoreIdStr = "${requestScope.relateLoreIdStr}";
	var cliHei = document.documentElement.clientHeight;
	var cliWid = document.documentElement.clientWidth;
	var exampleFlag = true;
	var quesAreaFlag = true;//答题区域每个li上下滚动的iscroll
	var botCardFlag = true; //底部答题卡左右的iscroll
	var completeNum = 0; //当前已经做过题的数量包括对和错
	var goFlag = true; //展开底部答题卡执行iscroll只执行一次
	
	$(function(){
		$("#curr_lore_name").html("<span>" + loreTaskName + "</span>");
		initLiWid();//动态分配五步学习导航li的宽度
		getStepStudyInfo();
	});
	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);

	</script>
  </head>
  
  <body>
 	 <!-- 头部区域  -->
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage();"></span>
		<h2 id="curr_lore_name" class="ellip"></h2>
	</div>
	<div class="studyNavWrap">
		<ul class="studyNav">
			<li class="active">
				<span class="stepTit">听</span>
				<p class="stepTitTxt">视频讲解</p>
			</li>
			<li id="guidePoint">
				<span class="stepTit">看</span>
				<p class="stepTitTxt">点拨指导</p>
			</li>
			<li id="loreListBox">
				<span class="stepTit">背</span>
				<p class="stepTitTxt">知识清单</p>
			</li>
			<li id="exampleKpBox">
				<span class="stepTit">写</span>
				<p class="stepTitTxt">解题示范</p>
			</li>
			<li id="consolidKpBox">
				<span id="consoSpan" class="stepTit">固</span>
				<p class="stepTitTxt">巩固训练</p>
			</li>
		</ul>
		<div id="throughDiv" class="throughLine"></div>
		<div id="moveLineDiv" class="moveLine"></div>
		<div class="moveCirWrap">
			<div id="moveDiv"><span id="moveBox" class="moveCir"></span></div>
		</div>
	</div>
	<div id="studyInfo">
		<div id="videoBox"></div>
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
 	<a id="buttonInfo" class="removeAFocBg" href="javascript:void(0)" ontouchend="getStepStudyInfo()">我听完了</a>
 	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
	<!-- 答题正确或者错误的提示以及正确下金币的奖励  -->
	<div id="tipInfoBox">
		<div id="tipFace"><span id="facePic"></span></div>
		<p id="infoTxt"></p>
		<p id="relAnsTxt"></p>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
  </body>
</html>
