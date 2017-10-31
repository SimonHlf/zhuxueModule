<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>勤奋报告</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link  href="Module/appWeb/reportCen/css/studyReport.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/dist/echarts.js"></script>
	<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/themes/macarons.js"></script>
	<script src="Module/appWeb/reportCen/js/studyReport.js" type="text/javascript"></script>
    <script type="text/javascript">
    var cliWid = document.documentElement.clientWidth;
    var cliHei = document.documentElement.clientHeight;
    $(function(){
    	initWid();
 	   stuReport(5);
    });
    document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
   </script>
  </head>
  
  <body>
  	<div id="loader-wrapper">
	    <div id="loader"></div>
	    <div class="loader-section section-left"></div>
	    <div class="loader-section section-right"></div>
	</div>
  	<div id="nowLoc" class="nowLoc">
		<span class="backIcon"></span>
		<p>勤奋报告</p>
	</div>
    <!-- 图标盒子  -->
    <div class="imgTabBox">
    	<!-- 导航部分 -->
    	<ul class="imgTabNav clearfix">
    		<li class="active" onclick="stuReport(5)">当月</li>
    		<li onclick="stuReport(1)">第一周</li>
    		<li onclick="stuReport(2)">第二周</li>
    		<li onclick="stuReport(3)">第三周</li>
    		<li onclick="stuReport(4)">第四周<span class="decSpan"></span></li>
    	</ul>
    	<!--  统计信息  -->
    	<div class="tongjiBox">
    		本月<span id="weeks"></span>您<span id="stuInfo"></span>共在助学网学习<span id="stuRepCount"></span>个知识点，<span id="stuRepCom"></span>
    	</div>
    	<div class="tableBox" id="chart_report"></div>
    </div>
  </body>
</html>
