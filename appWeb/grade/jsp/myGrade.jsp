<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>我的班级</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/appWeb/grade/css/myGrade.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
	<script src="Module/appWeb/grade/js/myGrade.js" type="text/javascript"></script>
	<script type="text/javascript">
	var pageNo = 1;
	var noDataFlag = false;
	var userId = "${sessionScope.userId}";
	var loginStatus = "${sessionScope.loginStatus}";
	var cliWid = document.documentElement.clientWidth;
	var cliHei = document.documentElement.clientHeight;
	var paystu = "${requestScope.paystu}";
	$(function(){
		$("body").height(cliHei);
		changeUseState();
		changePayState();
		$("#stuInfo").height(cliHei - 115);
		$(".payLayer").height($("#stuInfo").height());
		getMyBindListJson("init");
		$("#paystu").html(paystu);
		$(".bindLayer").height(cliHei - 50);
	});
	</script>
  </head>
  
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon"></span>
		<p class="titP">我的班级</p>
		<p class="useState">
			<input id="stateInpVal" type="hidden" value="-1"/>
			<span class="fl">使用状态</span>
			<span class="useStateSpan fl">全部</span>
			<span id="spanTri"><span class="triSpan topTri"></span></span>
		</p>
	</div>
	<div id="bindDivWrap">
		<span class="bindTriSpan"></span>
		<ul id="bindStatus">
			<li value="-1">全部</li>
			<li value="1">正在使用</li>
			<li value="2">已到期</li>
			<li value="3">已取消</li>
			<li value="4">已升学</li>
		</ul>
	</div>
	<!-- 支付状态 搜索学生姓名  -->
	<div class="searBox">
		<p class="totalNumP">班级共<span id="paystu"></span>名学生(已付费)</p>
		<div class="searchDiv clearfix">
			<div class="payStateWrap fl">
				<span class="fl">支付状态</span>
				<div class="payStateDiv fl">
					<span class="triIcon"></span>
					<input id="payStateInp" type="hidden" value="1"/>
					<em class="payStateEm">付费</em>
				</div>
			</div>
			<div class="searStName fr">
				<input id="stuName" type="text" placeholder="请输入学生姓名"/>
				<a class="removeAFocBg" href="javascript:void(0)" ontouchend="getMyBindListJson('init');"><span></span></a>
			</div>
		</div>
	</div>
	<div id="payStatusDiv">
		<span class="bindTriSpan_1"></span>
		<ul id="payStatus">
			<li value="1">付费</li>
			<li value="0">免费试用</li>
			<li value="2">免费</li>
			<li value="-1">全部</li>
		</ul>
	</div>
	<!-- 数据层  -->
	<div id="stuInfo">
		<div id="scroller">
			<ul id="stuInfoDiv"></ul>
			<div id="pullUp">
				<span class="pullup-icon"></span>
				<span class="pullUpLabel">上拉加载更多...</span>
			</div>
		</div>
	</div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
	<div class="bindLayer"></div>
	<div class="payLayer"></div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
