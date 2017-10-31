<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>溯源页面</title>
	<meta http-equiv="pragma" content="no-cache"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>	
	<link href="Module/appWeb/onlineStudy/css/traceBackList.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/onlineStudy/js/traceBackList.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
		var loreId = "${requestScope.loreId}";
		var loreName = "${requestScope.loreName}";
		var educationId = "${requestScope.educationId}";
		var chapterId = "${requestScope.chapterId}";
		var tracebackType = "${requestScope.tracebackType}";
		var totalMoney = "${requestScope.totalMoney}";
		var stepComplete = "${requestScope.stepComplete}";
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
		var option = "${requestScope.option}";
		var path = "${requestScope.path}"; 
		var studyPath = "${requestScope.studyPath}";
		var success = "${requestScope.success}";
		var successStep = "${requestScope.successStep}";
		var nextLoreStep = " ${requestScope.nextLoreStep}";
		var currentloreName_study = "${requestScope.currentloreName_study}";
		var isFinish = "${requestScope.isFinish}";
		var access = "${requestScope.access}";
		var cliWidth = document.documentElement.clientWidth;
		var cliHei = document.documentElement.clientHeight;
		var myScroll;
		
		$(function(){
			$(".diagIconUl li").width(parseInt(cliWidth/3));
			initDiagInfoTxt();
			$("#loreTreePar").height(cliHei - $("#nowLoc").height() - $(".diagIconWrap").height());
		});
	</script>
  </head>
  
<body>
  	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="closeWindow();"></span>
		<p class="ellip">${requestScope.loreName}</p>
	</div>
	<!-- 已诊断 未诊断 将要诊断 表示图标 -->
	<div class="diagIconWrap">
		<ul class="diagIconUl">
			<li><i class="comDiagIcon hasDiag"></i><span>已诊断</span></li>
			<li><i class="comDiagIcon diagIng"></i><span>将要诊断</span></li>
			<li><i class="comDiagIcon noDiag"></i><span>未诊断</span></li>
		</ul>
	</div>
	<!-- 任务描述说明层  -->
	<div id="loreTreePar">
		<div id="treeScroller">
			<div class="taskInfoBox">
				<strong></strong>
				<p>本知识点的“溯源路线图”如下，根据它能够帮你查找出你不会的根源！</p>
				<a class='sureBtn removeAFocBg' href='javascript:void(0)' ontouchend = 'closeWindow()'>确&nbsp;&nbsp;定</a>
			</div>
			<div id="loreTreeDiv" class="treeBox">
				<div id="nowKpWrap"><span class="nowKpLine"></span></div>
				<div id="divKpWrap"><span class="lineDiv"></span></div>
			</div>
		</div>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
