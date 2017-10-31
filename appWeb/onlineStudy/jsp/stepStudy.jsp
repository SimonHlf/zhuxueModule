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
	<script src="Module/appWeb/onlineStudy/js/comMainStudy.js" type="text/javascript"></script>
	<script src="Module/appWeb/onlineStudy/js/stepStudy.js" type="text/javascript"></script>
	<script src="Module/appWeb/onlineStudy/js/common.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
	var educationId = "${requestScope.educationId}";
	var subId = "${requestScope.subjectId}";
	var chapterId = "${requestScope.chapterId}";
	var loreId = "${requestScope.loreId}";
	var currentLoreId = "${requestScope.nextLoreIdArray}";
	var studyLogId = "${requestScope.studyLogId}";
	var questionLength = 0;
	var totalMoney = 0;
	var lastCommitNumber = 0;
	var currentAllQuestionFlag = 1;
	var loreTaskName = "${requestScope.loreTaskName}";
	var option = "${requestScope.option}";
	var loreName = "${requestScope.loreName}";
	var loreTypeName = "video";//默认未视频讲解
	var iNow = 0;
	var cliHei = document.documentElement.clientHeight;
	var cliWid = document.documentElement.clientWidth;
	var exampleFlag = true;
	var quesAreaFlag = true;//答题区域每个li上下滚动的iscroll
	var botCardFlag = true; //底部答题卡左右的iscroll
	var completeNum = 0; //当前已经做过题的数量包括对和错
	var goFlag = true; //展开底部答题卡执行iscroll只执行一次
	$(function(){
		if(chapterId != "0"){
			$("#curr_lore_name").html(loreName+"<span>" + loreTaskName + "</span>");
		}else{
			$("#curr_lore_name").html(loreName);
		}
		getStepStudyInfo();
		initLiWid();//动态分配五步学习导航li的宽度
	});
	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	function backPage_1(){
		window.location.href = "studyApp.do?action=goStudyMapPage&loreId="+loreId+"&loreName="+loreName+"&educationId="+educationId+"&chapterId="+chapterId+"&cilentInfo=app";
	}
	</script>
  </head>
  
  <body>
 	 <!-- 头部区域  -->
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage_1();"></span>
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
		<img class="succImg" src="Module/appWeb/onlineStudy/images/succIcon.png"/>
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
	<!-- 我要纠错窗口  -->
	<div class="errorDivWrap">
		<span class="closeSpan" ontouchend="closeErrorWindow()"></span>
		<!-- 头部  -->
		<div class="errInfoTxt">
			<p><span></span>欢迎提出宝贵意见和建议，您留下的每条纠错内容将被我们用来改善我们的服务和更好完善我们的产品!</p>
		</div>
		<!-- mainCon  -->
		<div class="errMainCon">
			<!-- 纠错标题  -->
			<div class="errTitDiv comErrDiv"><span class="errTitSpan fl">纠错标题：</span><p class="errTipP comErrRigDiv fl"></p></div>
			<!-- 问题类型  -->
			<div class="errQueType comErrDiv clearfix">
				<span class="errTitSpan fl">问题类型：</span>
				<div class="comErrRigDiv fl">
					<label class="comErrLabel" for="errType3" ontouchend="selErrType(3)">
						<span>语句不通顺</span>
						<input id="errType3" class="comErrInp" type="checkbox" name="errorBox"/>
						<span class="selSpan"><i id="choiceI3"></i></span>
					</label>
					<label class="comErrLabel" for="errType4" ontouchend="selErrType(4)">
						<span>答案不正确</span>
						<input id="errType4" class="comErrInp" type="checkbox" name="errorBox"/>
						<span class="selSpan"><i id="choiceI4"></i></span>
					</label>
					<label class="comErrLabel" for="errType1" ontouchend="selErrType(1)">
						<span>图<span class="oneBlank"></span>片<span class="oneBlank"></span>错<span class="oneBlank"></span>误</span>
						<input id="errType1" class="comErrInp" type="checkbox" name="errorBox"/>
						<span class="selSpan"><i id="choiceI1"></i></span>
					</label>
					<label class="comErrLabel" for="errType2" ontouchend="selErrType(2)">
						<span>其<span class="twoBlank"></span>他</span>
						<input id="errType2" class="comErrInp" type="checkbox" name="errorBox"/>
						<span class="selSpan"><i id="choiceI2"></i></span>
					</label>
				</div>
			</div>
			<!-- 意见内容  -->
			<div class="eidtCon comErrDiv clearfix">
				<span class="errTitSpan fl">纠错内容：</span>
				<div class="comErrRigDiv fl">
					<!-- textarea id="editArea" class="editTxtarea" onkeydown="LimitTextArea(this,200)" onkeypress="LimitTextArea(this,200)" onkeyup="LimitTextArea(this,200)" placeholder="请填写您对该知识点所存在问题的内容..."></textarea -->
					<textarea id="editArea" class="editTxtarea" placeholder="请填写您对该知识点所存在问题的内容...最多200字"></textarea>
					<!-- p class="maxTxtNum"><span id="nowNum">0</span>字/<span id="maxNum">共200字</span></p -->
				</div>
			</div>
			<!-- 提交取消  -->
			<div class="subErrDiv">
				<div>
					<a href="javascript:void(0)" class="comErrBtn subBtn" ontouchend="submitError()">提交纠错</a>
					<a href="javascript:void(0)" class="comErrBtn cancelBtn" ontouchend="closeErrorWindow()">取消</a>
				</div>
			</div>
		</div>
		<div class="botTip">
			<p>您提交的问题审核通过后系统会给予您10金币奖励，工作人员审核通过后会再次给予您10金币奖励！</p>
		</div>
	</div>
  </body>
</html>
