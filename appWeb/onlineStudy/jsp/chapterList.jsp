<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>    
    <title>章节知识点页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/onlineStudy/css/chapterList.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/onlineStudy/js/chapterList.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
	var educationId = "${requestScope.educationId}";
	var userId = "${requestScope.userId}";
	var infoText = "${requestScope.infoText}";
	var roleId = "${sessionScope.roleId}";
	var loginStatus = "${sessionScope.loginStatus}";
	var myScroll;
	var chapterFlag = true;
	$(function(){
		if(checkLoginStatus()){
			inintSubjHei();
			getChapterList(educationId);
		}
	});
	function backPage(){
		window.location.href = "studyApp.do?action=init&userId="+userId+"&roleId="+roleId+"&loginStatus="+loginStatus+"&educationId="+educationId+"&openStatus=returnPage&cilentInfo=appInit";
	}
	</script>
  </head>
  
  <body>
  	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage();"></span>
		<p>${requestScope.infoText }</p>
	</div>
	<!-- 注释盒子 -->
	<div id="introInfo" class="introInfo clearfix">
		<p class="noteTit fl">注</p>
		<div class="infoTxt fl">
			<p class="infoCol1">表示课后诊断已掌握</p>
			<p class="infoCol2">表示课后诊断没有掌握</p>
			<p class="infoCol3">表示课后诊断没有学习</p>
		</div>
		<i class="starIcon finIcon posLR1"></i>
		<i class="starIcon noFinIcon posLR2"></i>
		<i class="starIcon noLearnIcon posLR3"></i>
	</div>
    <div id="chapterDiv"><div id="scroller" class="absoSubDiv"></div></div>
    <!-- 暂无 -->
	<div class="noDataDiv">
		<span id="noExistTxt" class="noExPos">暂无章节</span>
		<img src="Module/appWeb/onlineStudy/images/zanwu.png" alt="章节">
	</div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p class="longTxt">一个知识点一天只能完成一次</p>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
  </body>
</html>
