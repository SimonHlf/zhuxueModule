<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>助学网联系我们</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/contractUs/css/newsListCss.css" type="text/css" rel="stylesheet" />
<link href="Module/contractUs/css/commonTitCss.css" type="text/css" rel="stylesheet" />
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
</head>
  
<body>
	<!-- 新闻动态列表  -->
	<div class="newsListWrap w1000">
		<!-- 头部面包屑导航 -->
		<div class="navTit">
			<span class="decPic"></span>
			<p class="aPar">您当前的位置 <a href="http://www.zhu-xue.cn" target="_top">首页</a> | <a href="index.do?action=fourParts">关于我们</a> | <a href="index.do?action=newsList">新闻动态</a> | 内容详情</p>
		</div>
		<div class="newListBox">
			<c:forEach items = "${requestScope.newsList}" var="newDetail">
				<h2 class="detailTit">${newDetail.title}</h2>
				<div class="detailConBox"><p>${newDetail.content}</p></div>
			</c:forEach>
			<div class="backBox"><a class="backNewsList" href="index.do?action=newsList">返回新闻列表&gt;&gt;</a></div>
		</div>
	</div>
</body>
</html>
