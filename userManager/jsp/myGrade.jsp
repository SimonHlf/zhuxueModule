<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/Module/taglibs/taglibs.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>助学网--我的班级</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
  <link href="Module/userManager/css/myGrade.css" type="text/css" rel="stylesheet" />
  <script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
  <script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
  <script type="text/javascript" src="Module/userManager/js/myGrade.js"></script>
<script>
$(function(){
	$(".memberListBox li:even").addClass("color");
	$(".memberListBox li:odd").addClass("color_1");
});

</script>
<body>
	<div class="nowPosition">
       	<p><span>我</span>的班级</p>
   	</div>	
   	<div class="myGradeWrap clearfix">
   		<!-- 辅导价格盒子  -->
   		<div class="tipBox1">
   			<span class="tipIcon"></span>
	  	 	<c:forEach items="${ntsList}" var="nts" end="0" >
	          	<p class="tip">辅导价格：<strong>${nts.teacher.baseMoney }元</strong>（每一个学生购买助学网，您将获得${nts.teacher.baseMoney }元）</p>
	        </c:forEach>
   		</div>
   		<!-- 班级资料盒子  -->
   		<div class="gradeData fl">
   			<span class="dataIcon"></span>
   			<h2 class="dataTit">班级资料</h2>
   			<div class="databox">
   				 <c:forEach items="${ntList}" var="nt">
				 	  <p>学科资料：${nt.schoolType}<label id="ntSubName">${nt.subject.subName }</label></p>
				 	  <p>辅导价格：${nt.baseMoney }元</p>
				 	  <p>辅导收益：18000元</p>
				 	  <p>付费学员：66人</p>
   				 </c:forEach>
   				 <p>试用学员：${requestScope.total} 人</p>
   			</div>
   			 <span class="myInvite" onclick="showOpen()">邀请学生</span>
   		</div>
   		<!-- 辅导班介绍盒子  -->
   		<div class="introBox fl">
   			<div class="dec"></div>
   			<p class="introTit">辅导班介绍</p>
   			<div class="pBox">
   				<p>
   					利用助学网学习平台，老师在网上创办的属于自己的班级。本网站利用独特的溯源学习法和丰富的学习资源帮您减轻教学负担。您只需邀请您的学生加入您的班级，学生加入您的班级后，可免费学习10天，如果想继续学习，则需要进行购买，学生购买的价格：基础价（298）+ 您设置的辅导价格（500）。如果有一名学生进行购买，那您将获得您设置的辅导价格500元哦！
   				</p>
   			</div>
   		</div>
   	</div>
   	<!-- 班级成员列表盒子  -->
	<div class="inviteListBox">
   		<div class="memberTit">
   			<span class="memberIcon"></span>
   			<p>班级成员列表&nbsp;共<strong>${requestScope.total}</strong>名学生</p>	
   		</div>	
   		<div class="borBox">
	   		<div class="memberList">
	   			<ul>
	   				<li class="one">学生姓名</li>
	   				<li class="two">使用期限</li>
	   				<li class="one">操作</li>
	   			</ul>
	   		</div>
	   		<div class="memberListBox">
	   			<ul>
	   				<c:forEach items="${ntsList}" var="nts" >
		   				<li>
							<p class="one">${nts.user.realname}</p>
							<p class="two">
								<fmt:parseDate value="${nts.addDate}" var="addDate"/><fmt:formatDate value="${addDate}" pattern="yyyy-MM-dd"/>至
								 <fmt:parseDate value="${nts.endDate}" var="endDate"/><fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/> 
							</p>
							<p class="one"><a href="javascript:void(0)" onclick="goGuide(${nts.user.id},${nts.teacher.subject.id },'${nts.user.realname }')">跟踪指导</a></p>
		   				</li>	
			
	   				</c:forEach>
	   			</ul>
	   		</div>
   		</div>
	</div>
	<!-- 翻页盒子  -->
	<div class="turnPageBox">
		<div class="numBox fr">
			<a  hidefocus="true" href="userManager.do?pageNo=1&action=getOwerUser">首页</a>
			<logic:greaterThan name="currentPage" scope="request" value="1">
				<a hidefocus="true" href="userManager.do?pageNo=${requestScope.currentPage - 1}&action=getOwerUser">
			</logic:greaterThan>上一页
			<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
			<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}">
				<a hidefocus="true" href="userManager.do?pageNo=${requestScope.currentPage + 1}&action=getOwerUser">
			</logic:lessThan>下一页
			<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}"></a></logic:lessThan>
			<a hidefocus="true" href="userManager.do?pageNo=${requestScope.countPage}&action=getOwerUser">尾页</a>
		</div>
		<div class="totalBox fr">
			<p>共${requestScope.countPage}页 第${requestScope.currentPage}页</p>
		</div>
	</div>
</body>
</html>
