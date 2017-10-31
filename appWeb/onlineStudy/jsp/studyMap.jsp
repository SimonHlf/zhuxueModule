<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>    
    <title>章节知识点页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>	
	<link href="Module/appWeb/onlineStudy/css/studyMap.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/onlineStudy/js/studyMap.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/loreManager/flowPlayer/flowplayer-3.2.13.min.js"></script>
	<script type="text/javascript" src="Module/appWeb/ckplayer/ckplayer.js" charset="utf-8"></script>
	<!--script type="text/javascript" src="Module/appWeb/commonJs/ajaxCommon.js" charset="utf-8"></script-->
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
		var loreId = "${requestScope.loreId}";//主知识点编号
		var loreName = "${requestScope.loreName}";//主知识点编号
		var userId = "${requestScope.userId}";
		var chapterId = "${requestScope.chapterId}";
		var subjectId = "${requestScope.subId}";
		//var para = "${requestScope.para}";//当前学段.
		var buttonValue = "${requestScope.buttonValue}";//按钮名称
		var studyLogId = "${requestScope.studyLogId}";//学习记录编号
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";//下级知识点数组
		var path = "${requestScope.path}";
		var subId = "${requestScope.subId}";
		var pathType = "${requestScope.pathType}";
		var loreTypeName_p = "${requestScope.loreTypeName}";
		var loreTaskName = "${requestScope.loreTaskName}";
		var access = "${requestScope.access}";
		var isFinish = "${requestScope.isFinish}";
		var educationId = "${requestScope.educationId}";
		var task = "${requestScope.task}";
		var rewordNum = "${requestScope.money}";
		var mapId = 0;//地图编号
		var myScroll;
		var stepFalg = true;
		var oClieHei = document.documentElement.clientHeight;
		var stepCount = "${requestScope.stepCount}";//多少级
		var loreCount = "${requestScope.loreCount}";//多少知识点
		$(function(){
			if(checkLoginStatus()){
				var currStep = getStudyMapInfo();
				$("#studyMap").height(oClieHei - $("#nowLoc").height());
				initPage(currStep);
				getStudyTaskInfo();
				loaded();
			}
		});
		function backPage(){
			window.location.href = "studyApp.do?action=showChapterPage&educationId="+educationId+"&userId="+userId+"&cilentInfo=app";
		}
		
	</script>
  </head>
  
  <body>
  	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage();"></span>
		<p class="ellip">${requestScope.loreName}</p>
		<i class="giftIcon" ontouchend="showTaskWin()"></i>
	</div>
    <div id="studyMap"></div>
    <div id="studyInfoDivWin">
    	<a id="closeWinBtn" class="videoAbtn removeAFocBg" href = "javascript:void(0)" ontouchend="closeWindow();"></a>
    	<div id="videoInfo" style="width:100%;height:100%"></div>
    	<div id="studyInfoLay">
    		<a id="closeWinBtn_1" class="otherBtn removeAFocBg" href = "javascript:void(0)" ontouchend="closeWindow();"></a>
    		<div id="studyInfo"></div>
    	</div>
    </div>
    
    <!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
	
	<!-- 任务奖励盒子  -->
	<div id="taskWrap">
		<a id="closeTask" class="otherBtn removeAFocBg" href = "javascript:void(0)" ontouchend="closeTaskWin()"></a>
		<div id="taskBox" class="taskBox">
			<div id="topTask" class="comHeadTit">
				<strong>完成任务描述及奖励</strong>
			</div>
			<div id="mainTaskCon" class="mainTaskCon">
				
				<div id="tasklist" class="taskListCon">
					<div class="noRecordP">
						<img src="Module/appWeb/studyRecord/images/noRecord.png" alt="暂无答题记录"/>
						<p>暂无做题记录，点击开始挑战进行在线答题任务来获得对应奖励</p>
					</div>
					<ul id="stadus"></ul>
				</div>
			</div>
		</div>
	</div>
	<div class="layer"></div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
  </body>
</html>
