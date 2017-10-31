<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
    <title>buffetTraceBackList.jsp</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/buffetStudy/css/buffetTraceBackList.css" type="text/css" rel="stylesheet"/>
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
	<script src="Module/appWeb/buffetStudy/js/buffetTraceBackList.js" type="text/javascript"></script>
	<script type="text/javascript">
		var buffetSendId = "${requestScope.buffetSendId}";
		var buffetStudyDetailId = "${requestScope.buffetStudyDetailId}";
		var basicLoreId = "${requestScope.basicLoreId}";
		var basicLoreName = "${requestScope.basicLoreName}";
		var bsdId = "${requestScope.buffetStudyDetailId}";
		var buffetId = "${requestScope.buffetId}";
		var buffetName = "${requestScope.buffetName}";
		var tracebackType = "${requestScope.tracebackType}";
		var totalMoney = "${requestScope.totalMoney}";
		var stepComplete = "${requestScope.stepComplete}";
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
		var option = "${requestScope.option}";
		var path = "${requestScope.path}";
		var studyPath = "${requestScope.studyPath}";
		var success = "${requestScope.success}";
		var successStep = "${requestScope.successStep}";
		var nextLoreStep = "${requestScope.nextLoreStep}";
		var currentloreName_study = "${requestScope.currentloreName_study}";
		var closeFlag = "${requestScope.closeFlag}";
		var relateLoreIdStr = "${requestScope.relateLoreIdStr}";
		var access = "${requestScope.access}";//??
		
		var stime = "${sessionScope.stime}";
		var etime = "${sessionScope.etime}";
		var subId = "${sessionScope.subId}";
		var result = "${sessionScope.result}";
		var cliWidth = document.documentElement.clientWidth;
		var cliHei = document.documentElement.clientHeight;
		$(function(){
			$(".diagIconUl li").width(parseInt(cliWidth/3));
			//动态计算知识树父级的高度
			$("#loreTreePar").height(cliHei - $("#nowLoc").height() - $(".diagIconWrap").height());
			initDiagInfoTxt();
		});
	</script>
  </head>
  
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage();"></span>
		<p class="bigTit ellip">${requestScope.buffetName}</p>
		<p class="smallTit">当前自助餐题的“溯源路线图”如下</p>
	</div>
	<!-- 已诊断 未诊断 将要诊断 表示图标 -->
	<div class="diagIconWrap">
		<ul class="diagIconUl noUseDiv">
			<li><i class="comDiagIcon hasDiag"></i><span>已诊断</span></li>
			<li><i class="comDiagIcon diagIng"></i><span>将要诊断</span></li>
			<li><i class="comDiagIcon noDiag"></i><span>未诊断</span></li>
		</ul>
		<ul class="diagIconUl useLineDiv">
			<li><i class="comDiagIcon hasDiag"></i><span>已诊断</span></li>
			<li><i class="comDiagIcon diagIng"></i><span>将要诊断</span></li>
			<li><i class="comDiagIcon noDiag"></i><span>未诊断</span></li>
		</ul>
		<ul class="diagIconUl studyLineBox">
			<li><i class="comDiagIcon hasDiag"></i><span>已掌握</span></li>
			<li><i class="comDiagIcon diagIng"></i><span>将要学习</span></li>
			<li><i class="comDiagIcon noDiag"></i><span>未学习</span></li>
		</ul>
		<!-- 
	  		success(诊断时)
	  		0：本节知识点的诊断没做完 显示noComplete
	  		1：本节知识点已做完，但没全做对，进行溯源。 显示noSuccess
	  		2：本知识点诊断全部正确。全部结束，finish=2.显示success
	  	-->
		<!-- 
	  		success(学习时)
	  		0：当前知识典学习通过显示studySuccess
	  		1：学习时没通过显示studyNoSuccess
	  		2：最后诊断没通过，进入学习时提示显示partSuccess
	  		3：诊断时某级诊断完全正确，进入学习提示显示zdSuccess
		 --> 	
	</div>
	<!-- 任务描述说明层  -->
	<div id="loreTreePar">
		<div id="treeScroller">
			<div class="taskInfoBox">
				<strong></strong>
				<p>本知识点的“溯源路线图”如下，根据它能够帮你查找出你不会的根源！</p>
				<a class='sureBtn removeAFocBg' href='javascript:void(0)' ontouchend = 'backPage();'>确&nbsp;&nbsp;定</a>
			</div>
			<div id="loreTreeDiv" class="treeBox">
				<div id="nowKpWrap"><span class="nowKpLine"></span></div>
				<div id="divKpWrap"><span class="lineDiv"></span></div>
			</div>
		</div>
	</div>
</body>
</html>
