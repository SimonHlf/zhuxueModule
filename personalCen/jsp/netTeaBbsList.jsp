<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
<head>
<title>知识典--网络导师论坛帖子列表</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/netTeaBBS.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="Module/personalCen/js/personalJs.js"></script>
<script type="text/javascript">
window.onload = function(){
	toBlockTriangle();
	checkImg();
};
</script>
</head>
  
  <body>
	<div class="nowPosition">
        <P><span>帖</span>子详情</P>
         <span class="backIcon"></span>
         <a href="bbsManager.do?action=load">返回导师论坛首页</a>
    </div>
    <div class="mainListCon">
    	<!-- 楼主发的主题盒子 -->
    	 <c:forEach items="${requestScope.tList}" var="tl3" end="0">
        <div class="pubBox clearfix">
        	<div class="rightTopBg1"></div>
        	<!-- 左侧头像 -->
        	<div class="userImg fl">
            	<img src="${tl3.user.portrait }" width="64" height="64" />
            </div>
            <!-- 右侧主题对应的内容 -->
            <div class="puberConWrap fl">
                <div class="puberConTop"></div>
                <div class="puberConMid">
                	<!-- 发布者头部 -->
                	<div class="midTopCon clearfix">
                    	<span class="topicIcon fl"></span>
                        <h2 class="moreHid">${tl3.topicname }</h2>
                        <c:if test="${tl3.replyCount >=20}">
                        <span class="hotTopic1"></span>
                        </c:if>
                        <!-- 发布者，发布时间 -->
  						<div class="pubNaTime fl">
                        	<p class="puberName">${tl3.user.username }发表于&nbsp;<span class="pubTime"><fmt:formatDate value="${tl3.time }" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
                        </div>
                        <!-- 楼主 -->
                        <div class="puberFloor">楼主</div>
                    </div>
                    <!-- 发布者发布内容的盒子 -->
                    <div class="mainContents clearfix">
                    	<p>${tl3.topicContent }</p>
                    </div>
                </div>
                <div class="puberConBot"></div>
            </div>
        </div>
        </c:forEach>
       <!-- 回复者回复内容的主题盒子 -->
         <c:forEach items="${requestScope.rList}" var="rl">
        <div class="replayBox clearfix">
        	<!-- 右上侧装饰  -->
        	<div class="rightTopBg"></div>
        	<div class="rightDec"></div>
        	<!-- 左侧头像 -->
        	<div class="userImg fl">
            	<img src="${rl.user.portrait }" width="64" height="64" />
            </div>
            <!-- 右侧主题对应的内容 -->
            <div class="puberConWrap fl">
                <div class="puberConTop"></div>
                <div class="puberConMid">
                	<!-- 发布者头部 -->
                	<div class="midTopCon clearfix">
                        <!-- 发布者，发布时间 -->
  						<div class="replayNaTime fl">
                        	<p class="replayerName">${rl.user.username }回复于&nbsp;<span class="replayTime"><fmt:formatDate value="${rl.replyTime }" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
                        </div>
                        <!-- 回复者盒子 -->
                        <c:if test="${rl.floors ==1}">
                        <div class="replayerFloor bgCol1">沙发</div>
                        </c:if>
                           <c:choose>
                                <c:when test="${rl.floors == 1}">
                                    <div class="replayerFloor bgCol1">沙发</div>
                                </c:when>
                                <c:when test="${rl.floors == 2}">
                                   <div class="replayerFloor bgCol2">板凳</div>
                                </c:when>
                                <c:when test="${rl.floors == 3}">
                                 	 <div class="replayerFloor bgCol3">地板</div>
                                </c:when>
                            </c:choose>
                           <c:if test="${rl.floors >3}">
                              <div class="replayerFloor">#${rl.floors}楼</div>
                           </c:if>
                    </div>
                    <!-- 发布者发布内容的盒子 -->
                    <div class="mainContents clearfix">
                   		<p>${rl.content }</p>
                    </div>
                </div>
                <div class="puberConBot"></div>
            </div>
        </div>
       </c:forEach>
        
        <!-- 翻页盒子 -->
        <div class="turnPage pt">
            <div class="aParent mr1">
	            <a class="indexPage" href="bbsManager.do?action=bbsList&pageNo=1&topicID=${requestScope.topicID}">首页</a>
				<logic:greaterThan name="currentPage" scope="request" value="1">
					<a class="pagePrev" href="bbsManager.do?pageNo=${requestScope.currentPage - 1}&action=bbsList&topicID=${requestScope.topicID}">
				</logic:greaterThan>上一页
				<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
				<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}">
					<a class="pageNext" href="bbsManager.do?pageNo=${requestScope.currentPage + 1}&action=bbsList&topicID=${requestScope.topicID}">
				</logic:lessThan>下一页
				<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}"></a></logic:lessThan>
		       <a class="endPage" href="bbsManager.do?pageNo=${requestScope.countPage}&action=bbsList&topicID=${requestScope.topicID}">尾页</a>
	       </div>
            <div class="pageNum">
                <p>第<span class="nowNum">${requestScope.currentPage }</span>页&nbsp;</p>
                <p>共<span class="totalNum">${requestScope.countPage }</span>页</p>
            </div>
        </div>
    </div>
    <!-- 发布帖子的盒子 -->
    <div class="pubTopicBox">
        <div class="leftPic fl">
            <div class="imgBox">
            	<img id="userImg" src="${sessionScope.protrait}" height="130" />
            </div>
        </div>
        <div class="rightCon fl">
            <div class="mainTopicCon">
                <div id="myEditor"></div>
                <script type="text/javascript">					
					var editor;
					editor = new baidu.editor.ui.Editor( {
						//这里可以选择自己需要的工具按钮名称,此处仅选择如下五个  
				        toolbars:[['Source', 'italic','bold', 'underline',
				                   'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify','|',
				                   'insertimage']], 
						initialFrameWidth : 523,
						initialFrameHeight : 196,
						wordCount:true,
						textarea : 'description'
					});
					editor.render("myEditor");
				</script>	
            </div>
        </div>
        <input type="button" class="subTopicBtn" value="提交" onclick="addResp(${requestScope.topicID})">
    </div>
  </body>
</html>
