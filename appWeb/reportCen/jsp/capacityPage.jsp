<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>    
    <title>能力报告</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<!-- 日历插件样式  -->
	<link href="Module/appWeb/mobiscroll/css/mobiscroll.custom-2.5.0.min.css" rel="stylesheet" type="text/css" />
	<link  href="Module/appWeb/reportCen/css/capacityPage.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/mobiscroll/js/jquery.mobile-1.3.0.min.js"></script>
	<script src="Module/appWeb/mobiscroll/js/mobiscroll.custom-2.5.0.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/appWeb/commonJs/idangerous.swiper.min.js"></script>
	<script src="Module/appWeb/reportCen/js/capacityPage.js" type="text/javascript"></script>
	<script type="text/javascript">
	var cliWid = document.documentElement.clientWidth;
	var cliHei = document.documentElement.clientHeight;
	var roleName = "${sessionScope.roleName}";
	$(function(){
		initWid();
		initDateSel("startTime",2020);
		initDateSel("endTime",2020);
		getCapacityJson();
	});
	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	</script>
  </head>
  
<body>
	<!-- div id="loader-wrapper">
	    <div id="loader"></div>
	    <div class="loader-section section-left"></div>
	    <div class="loader-section section-right"></div>
	</div -->
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon"></span>
		<p>能力报告</p>
	</div>
	<div class="searchBox">
		<div class="searInner clearfix">
			<div class="subBox fl">
				<input id="subInpVal" type="hidden"/>
				<span class="triIcon"></span>
				<span id="subNameSpan" class="ellip"></span>
				<div id="subDataUlDiv">
					<span class="subTriSpan"></span>
					<ul id="subDataUl"></ul>
				</div>
			</div>
			<div class="timeBox fl">
				<input id="startTime"/><span class="fl">至</span><input id="endTime"/>
			</div>
			<a class="searBtn fl" href="javascript:void(0)"  ontouchend="getCapacityJson();"></a>
		</div>
	</div>
  	<div class="capWrap">
  		<p class="currentP">最近<span id="diffDays"></span>天，您<span id="stuInfo"></span>在<span id="subName"></span>各方面的能力如下</p>
  		<div class="bigWrap">
	  		<div class="capWrapBox swiper-container">
		  		<div class="capaBox swiper-wrapper">
			  		<div id="liaojieDiv" class="comCapBox swiper-slide"></div>
				  	<div id="lijieDiv" class="comCapBox swiper-slide"></div>
				  	<div id="yingyongDiv" class="comCapBox swiper-slide"></div>
			  	</div>
		  	</div>
		  	<span class="comShadow leftShadow"></span>
		  	<span class="comShadow rightShadow"></span>
		  	<ul class="tabNav"></ul>
	  	</div>
  	</div>
  	<div class="capaLayer"></div>
  	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
