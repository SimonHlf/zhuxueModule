<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
<head>
<title>知识典--网络导师论坛</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/netTeaBBS.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/personalCen/js/personalJs.js"></script>
<script type="text/javascript">
$(function(){
	changeColor('#listTable tr');
	moveAddColor();
});
function showBbsList(id){
	window.location.href="bbsManager.do?action=bbsList&topicID="+id;
}
</script>
</head>
 
  <body>
   <body>
    <div class="nowPosition">
        <P><span>导</span>师论坛</P>
        <span class="pubTopicBtn" onclick="showNoneBox('.pubTopicWin')">发帖</span>
    </div>
    <!-- 导航 -->
    <div class="bbsNav">
    	<ul>
        	<li class="width1">主题</li>
            <li class="width3">发帖人</li>
            <li class="width2">时间</li>
            <li class="width3">回复次数</li>
            <li class="width3">查看</li>
        </ul>
    </div>
    <!-- 帖子列表盒子 -->
    <div class="listBox">
    	<!-- 不存在帖子的情况下 -->
        <div class="noListTopicBox">
        	<img src="Module/studyOnline/images/noAddSubjectBg.png" width="233" height="165" alt="暂无帖子" />
			<p>暂无帖子！</p>
        </div>
    	<!-- 存在帖子的情况下 -->
        <div class="haveListTopicBox">
            <table id="listTable" cellspacing="0" cellpadding="0">
            <c:forEach items="${requestScope.tList}" var="tl" varStatus="t2">
                <tr>
                    <td class="width1">
                    	<c:if test="${tl.replyCount >= 20}"><span class="hotTopic"></span></c:if>
                   		${tl.topicname }
                   	</td>
                    <td class="width3">${tl.user.username }</td>
                    <td class="width2"><fmt:formatDate value="${tl.time }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td class="width3">${tl.replyCount }</td>
                    <td class="width3">
                        <span class="showBox" title="查看" onclick="showBbsList(${tl.id})""></span>
                    </td>
                </tr>
                </c:forEach>
            </table>
           <!-- 翻页盒子 -->
           <div id="bbsturnPage" class="turnPage">
                <div class="aParent">
	               <a class="indexPage" href="bbsManager.do?action=load&pageNo=1">首页</a>
					<logic:greaterThan name="currentPage" scope="request" value="1">
						<a class="pagePrev" href="bbsManager.do?pageNo=${requestScope.currentPage - 1}&action=load">
					</logic:greaterThan>上一页
					<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
					<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}">
						<a class="pageNext" href="bbsManager.do?pageNo=${requestScope.currentPage + 1}&action=load">
					</logic:lessThan>下一页
					<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}"></a></logic:lessThan>
					<a class="endPage" href="bbsManager.do?pageNo=${requestScope.countPage}&action=load">尾页</a>
				</div>
                <div class="pageNum">
                    <p>第<span class="nowNum">${requestScope.currentPage }</span>页&nbsp;</p>
                    <p>共<span class="totalNum">${requestScope.countPage }</span>页</p>
                </div>
           </div>
        </div>
    </div>
  </body>
</html>
