<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>培优学习界面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/buffetStudy/css/buffetQuestionList.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/onlineStudy/js/common.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/buffetStudy/js/buffetQuestionList.js" type="text/javascript"></script>
	<script src="Module/appWeb/onlineStudy/js/comMainStudy.js" type="text/javascript"></script>
	<script type="text/javascript">
	var buffetSendId = "${requestScope.buffetSendId}";
	var loreName = "${requestScope.loreName}";
	var questionLength = 0;
	var currentAllQuestionFlag = 1;
	var totalMoney = 0;
	var lastCommitNumber = 0;
	var questionLength = 0;
	var currBuffetNumber = 1;
	var closeFlag = "${requestScope.closeFlag}";
	var userId = "${sessionScope.userId}";
	var roleId = "${sessionScope.roleId}";
	var loginStatus = "${sessionScope.loginStatus}";
	//下面用session是为了不用后面页面传递过来的参数，直接使用点击查看、学习时获取的参数
	var stime = "${sessionScope.stime}";
	var etime = "${sessionScope.etime}";
	var subId = "${sessionScope.subId}";
	var result = "${sessionScope.result}";
	var cliHei = document.documentElement.clientHeight;
	var cliWid = document.documentElement.clientWidth;
	var completeNum = 0; //当前已经做过题的数量包括对和错
	var perScale = 0; // 当前已做过题的比例
	var goFlag = true;
	var botCardFlag = true;
	var quesAreaFlag = true;
	$(function(){
		$("#mainQuesWrap").height(cliHei - $("#nowLoc").height());
		initBuffetQuestionListDiv();
	});
	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	</script>
  </head>
  
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage();"></span>
		<p class="bigTit ellip">${requestScope.loreName}</p>
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
		<p id="goldenTxt"></p>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
