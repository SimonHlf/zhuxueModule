<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>培优欢迎界面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/buffetStudy/css/buffetMain.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/mobiscroll/css/mobiscroll.custom-2.5.0.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
	<script src="Module/appWeb/mobiscroll/js/jquery.mobile-1.3.0.min.js"></script>
	<script src="Module/appWeb/mobiscroll/js/mobiscroll.custom-2.5.0.min.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/buffetStudy/js/buffetMain.js" type="text/javascript"></script>
	<script type="text/javascript">
	var subId = "${requestScope.subId}";//初始学科编号
	var gradeNumber = "${requestScope.gradeNumber}";//年级号-非年级编号
	var userId = "${sessionScope.userId}";//学生编号
	var stime = "${requestScope.stime}";
	var etime = "${requestScope.etime}";
	var result = "${requestScope.result}";
	var pageNo = 1;
	var myScroll,pullUpEl, pullUpOffset;
	var noDataFlag = false;
	//防止不点击查询按钮直接向上拖动刷新数据
	var subId_temp = "";
	var stime_temp = "";
	var etime_temp = "";
	var studyStatus_temp = "";
	var cliWid = document.documentElement.clientWidth;
	var cliHei = document.documentElement.clientHeight;
	$(function(){
		$("#stime").val(stime);
		$("#etime").val(etime);
		$("#studyStaInpVal").val(result);
		initDateSel("stime",2020);
		initDateSel("etime",2020);
		getCurrSubjectList();
		getSelfBuffetList("clickQuery");
		initWid();
	});
	</script>
  </head>
  
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon"></span>
		<p>培优辅差</p>
		<div class="subjDiv">
			<span id="subjSpan">数学</span>
			<span id="spanTri"><span class="triSpan topTri"></span></span>
		</div>
	</div>
	<!-- 加载学科列表数据层  -->
	<div id="stuSubWrapper">
		<ul id="subjectDiv" class="clearfix"></ul>
	</div>
  	<!-- 搜索查询buffet层  -->
  	<div class="searchBox">
  		<div class="searInner clearfix">
  			<div id="studyStaDiv" class="subBox fl">
				<input id="studyStaInpVal" type="hidden"/>
				<span class="triIcon"></span>
				<span id="studyStaSpan" class="ellip">全部</span>
				<div id="statusDiv" class="comDataUl">
					<span class="stuTriSpan"></span>
					<ul id="resultStatus">
						<li value="-1">全部</li>
						<li value="0">未学习</li>
						<li value="2">未完成</li>
						<li value="1">已完成</li>
					</ul>
				</div>
    		</div>
  			<div class="timeBox fl">
				<input id="stime"/><span class="fl">至</span><input id="etime"/>
			</div>
  			<a class="searBtn fl" href="javascript:void(0)"  ontouchend="getSelfBuffetList('clickQuery')"></a>
  		</div>
  	</div>
  	<!-- 数据层  -->
  	<div id="bsDiv">
	   	<div id="scroller">
			<ul id="buffetSendInfo">
	   			
	   		</ul>
			<div id="pullUp">
				<span class="pullup-icon"></span>
				<span class="pullUpLabel">上拉加载更多...</span>
			</div>
		</div>
  	</div>	
  	<!-- layer层  -->
	<div id="subjLayer"></div>
	<div id="studyStaLayer"></div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
