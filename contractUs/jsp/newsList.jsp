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
<script type="text/jscript">
$(function(){
	newsModMove();
});
//新闻列表的当前状态的运动小icon
function newsModMove(){
	$(".ulList li").each(function(i){
		$(this).hover(function(){
			$(".moveActive").show().stop().animate({top:this.offsetTop + 14},300);
		});
	});
}
//根据新闻编号获取该新闻详细信息
function showNewDetail(newId){
	window.location.href = "index.do?action=aboutUs&newId="+newId;
}
</script>
</head>
  
<body>
	<!-- 新闻动态列表  -->
	<div class="newsListWrap w1000">
		<!-- 头部面包屑导航 -->
		<div class="navTit">
			<span class="decPic"></span>
			<p class="aPar">您当前的位置 <a href="http://www.zhu-xue.cn" target="_top">首页</a> | <a href="index.do?action=fourParts">关于我们</a> | 新闻动态</p>
		</div>
		<div class="newListBox">
			<h2 class="comH2 newsTxt">新闻动态</h2>
			<div class="ulList">
				<ul>
					<c:forEach items = "${requestScope.newsList}" var="news">
						<li>
							<p><a href="index.do?action=aboutUs&newId=${news.id}"  target="_top">${news.title}</a></p>
							<span class="pubTime">${news.addDate}</span>	
						</li>
					</c:forEach>
					
				</ul>
				<div class="moveActive"></div>
			</div>
			<!-- 翻页  -->
			<c:if test="${requestScope.currentPage != '-1'}">
				<div class="page">
					<div class="right">
					<p class="fl">第${requestScope.currentPage}页&nbsp;</p>
					<p class="fl">共${requestScope.pageCount}页</p>
					<a href="index.do?action=newsList" class="indexPage">首页</a>
					<c:if test="${requestScope.currentPage > 1}">
						<a href="index.do?action=newsList&pageNo=${requestScope.currentPage - 1}">上一页</a>
					</c:if>
					<c:if test="${requestScope.currentPage <= 1}">
						上一页
					</c:if>
					<c:if test="${requestScope.currentPage < requestScope.pageCount}">
					    <a href="index.do?action=newsList&pageNo=${requestScope.currentPage + 1}">下一页</a>
					</c:if>
					<c:if test="${requestScope.currentPage >= requestScope.pageCount}">
					          下一页
					</c:if>
					<a href="index.do?action=newsList&pageNo=${requestScope.pageCount}">尾页</a>
					</div>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>
