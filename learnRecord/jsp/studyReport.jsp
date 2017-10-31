<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>勤奋报告</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link type="text/css" rel="stylesheet" href="Module/learnRecord/css/studyReport.css">
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/learnRecord/js/studyReport.js"></script>
   <script type="text/javascript">
   $(document).ready(function () {
	   fnTab($(".imgTabNav"),"click");
	   stuReport(5);
   });
   </script>
  </head>
  
  <body>
  	<!-- 当前位置  -->
  	<div class="nowPosition">
        <P><span>勤</span>奋报告</P>
    </div>
    <!-- 图标盒子  -->
    <div class="imgTabBox">
    	<!-- 导航部分 -->
    	<ul class="imgTabNav clearfix">
    		<li class="active" onclick="stuReport(5)">本月报告</li>
    		<li onclick=" stuReport(1)">第一周</li>
    		<li onclick=" stuReport(2)">第二周</li>
    		<li onclick=" stuReport(3)">第三周</li>
    		<li onclick=" stuReport(4)">第四周</li>
    	</ul>
    	<!--  统计信息  -->
    	<div class="tongjiBox">
    		本月<span id="weeks"></span>您<c:if test="${sessionScope.roleName == '家长'}">的孩子</c:if>共在助学网学习<span id="stuRepCount"></span>个知识点，<span id="stuRepCom"></span>
    	</div>
    	<!--  动态生成图表  -->
    	<div class="activeImgBox">
    		<img id="ImageId" alt="图表" src="">
    	</div>
    </div>
    
    

  </body>
</html>
