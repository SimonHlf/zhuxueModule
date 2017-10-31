<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
<title>知识典--后台模块管理</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/myAsk.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/personalInfo.css" type="text/css" rel="stylesheet"/>
<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/personalCen/js/personalJs.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
$(function(){
	changeColor('.wrap');
	checkQuestionList();
});
function checkQuestionList(){
		var questionCount = ${requestScope.pageCount};
		if(questionCount == 0){
			$(".turnPage").hide();
		}else{
			$(".turnPage").show();
		}
}

</script>
</head>

<body>
  <form id="questionList" action="" >
	<!-- 没有问题的时候 -->
	
		<c:if test="${sessionScope.roleName == '学生' || sessionScope.roleName == '家长'}">
			<c:if test="${requestScope.pageCount == 0}">
				<div class="queeEmpty">
					<img src="Module/personalCen/images/noAskQue.png" width="234" height="94" alt="暂无答疑" />
					<p>暂无提问！</p>
				</div>
			</c:if>
		</c:if>
		<c:if test="${sessionScope.roleName == '网络导师'}">
			<c:if test="${requestScope.pageCount == 0}">
				<div class="queeEmpty">
					<img src="Module/personalCen/images/noAskQue.png" width="234" height="94" alt="暂无学生提问" />
					<p>暂无学生提问！</p>
				</div>
			</c:if>
		</c:if>
	<!-- 有问题 -->
	<div class="queHave">
		<!-- 问题列表 -->
		<c:if test="${sessionScope.roleName=='学生' || sessionScope.roleName == '家长'}">
		    <c:forEach items="${requestScope.qVOList}" var="question">
				<div class="wrap" >
				   <div class="queListWrap">
					 <p class="title fl" title="${question.title}"><c:out value="${question.title}"></c:out></p>
					 <p class="pubTime fl"><fmt:formatDate value="${question.queTime}" type="both"/></p>
					 <c:if test="${question.isRead=='1'}">
					 <p class="anState fl"><font color="green">回答</font></p> 
					 </c:if>
					 <c:if test="${question.isRead=='2'}">
					 <p class="anState fl"><font color="red">未回答</font></p> 
					 </c:if>
					 <div>
					    <input type="hidden" id="queId" value="${question.id}">
					    <span  class="showBox fr" title="查看" onclick="showQuestion(${question.id})"></span>
					 </div>
				   </div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${sessionScope.roleName=='网络导师'}">
			<c:forEach items="${requestScope.qVOList1}" var="question">
				<div class="wrap" >
				   <div class="queListWrap">
					 <p class="title fl"><c:out value="${question.title}"></c:out></p>
					 <p class="pubTime fl"><c:out value="${question.queTime}"></c:out></p>
					 <c:if test="${question.isRead=='1'}">
					 	<p class="anState fl"><font color="green">回答</font></p> 
					 </c:if>
					 <c:if test="${question.isRead=='2'}">
						 <p class="anState fl"><font color="red">未回答</font></p> 
					 </c:if>
					 <div>
						 <input type="hidden" id="queId" value="${question.id}">
						 <span  class="showBox fr" title="查看" onclick="showQuestion(${question.id})"></span>
					 </div>
				   </div>
				</div>
			</c:forEach>
		</c:if>
	</div>
  </form>
  
  <!-- 翻页盒子 --> 
	<div class="turnPage" id="turnPage">
		<div id="page">
		  <c:if test="${sessionScope.roleName=='学生' || sessionScope.roleName == '家长'}">
		    <c:if test="${requestScope.subId=='0'&&requestScope.status=='0'}">
			<div class="pageNum">
				<p>第<span class="nowNum" >${requestScope.pageNo}</span>页&nbsp;</p>
				<p>共<span class="totalNum">${requestScope.pageCount}</span>页</p>
			</div>
			<a href="questionManager.do?action=myQuestionList"  class="indexPage" id="indexPage">首页</a>
			<a href="questionManager.do?action=myQuestionList&pageNo=${requestScope.pageNo-1}" class="pagePrev" id="pagePrev">上一页</a>
			<a href="questionManager.do?action=myQuestionList&pageNo=${requestScope.pageNo+1}" class="pageNext" id="pageNext">下一页</a>
			<a href="questionManager.do?action=myQuestionList&pageNo=${requestScope.pageCount}" class="endPage" id="endPage">尾页</a>
			</c:if>
			<c:if test="${requestScope.subId!='0'||requestScope.status!='0'}">
			<div class="pageNum">
				<p>第<span class="nowNum" >${requestScope.pageNo}</span>页&nbsp;</p>
				<p>共<span class="totalNum">${requestScope.pageCount}</span>页</p>
			</div>
			<a href="questionManager.do?action=getQuestionList&subId=${requestScope.subId}&status=${requestScope.status}"  class="indexPage" id="indexPage">首页</a>
			<a href="questionManager.do?action=getQuestionList&pageNo=${requestScope.pageNo-1}&subId=${requestScope.subId}&status=${requestScope.status}" class="pagePrev" id="pagePrev">上一页</a>
			<a href="questionManager.do?action=getQuestionList&pageNo=${requestScope.pageNo+1}&subId=${requestScope.subId}&status=${requestScope.status}" class="pageNext" id="pageNext">下一页</a>
			<a href="questionManager.do?action=getQuestionList&pageNo=${requestScope.pageCount}&subId=${requestScope.subId}&status=${requestScope.status}" class="endPage" id="endPage">尾页</a>
			</c:if>
		  </c:if>
		  <c:if test="${sessionScope.roleName=='网络导师'}">
		    <c:if test="${requestScope.studentId=='0'&&requestScope.status=='0'}">
			<div class="pageNum">
				<p>第<span class="nowNum" >${requestScope.pageNo}</span>页&nbsp;</p>
				<p>共<span class="totalNum">${requestScope.pageCount}</span>页</p>
			</div>
			<a href="questionManager.do?action=myQuestionList"  class="indexPage">首页</a>
			<a href="questionManager.do?action=myQuestionList&pageNo=${requestScope.pageNo-1}" class="pagePrev">上一页</a>
			<a href="questionManager.do?action=myQuestionList&pageNo=${requestScope.pageNo+1}" class="pageNext">下一页</a>
			<a href="questionManager.do?action=myQuestionList&pageNo=${requestScope.pageCount}" class="endPage">尾页</a>
			</c:if>
			<c:if test="${requestScope.studentId!='0'||requestScope.status!='0'}">
			<div class="pageNum">
				<p>第<span class="nowNum" >${requestScope.tpageNo}</span>页&nbsp;</p>
				<p>共<span class="totalNum">${requestScope.tpageCount}</span>页</p>
			</div>
			<a href="questionManager.do?action=listQuestionByTSI&studentId=${requestScope.studentId}&status=${requestScope.status}"  class="indexPage">首页</a>
			<a href="questionManager.do?action=listQuestionByTSI&pageNo=${requestScope.pageNo-1}&studentId=${requestScope.studentId}&status=${requestScope.status}" class="pagePrev">上一页</a>
			<a href="questionManager.do?action=listQuestionByTSI&pageNo=${requestScope.pageNo+1}&studentId=${requestScope.studentId}&status=${requestScope.status}" class="pageNext">下一页</a>
			<a href="questionManager.do?action=listQuestionByTSI&pageNo=${requestScope.pageCount}&studentId=${requestScope.studentId}&status=${requestScope.status}" class="endPage">尾页</a>
			</c:if>
		  </c:if>
		</div>
	</div>
</body>
</html>
