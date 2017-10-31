<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
   <title>网络导师个人简介</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0"> 
	   
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/netTeacherList/css/personalResume.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/netTeaListJs.js"></script>
<!--[if IE]>
<style>
 .markLayer{filter:progid:DXImageTransform.Microsoft.gradient(enabled = 'true',startColorstr = '#80000000',endColorstr = '#80000000')}
</style>
<![endif]-->
<script type="text/javascript">
$(function(){
	hideScrollBar();
	checkOrigImg();
	checkGlory();
});
function checkGlory(){
	if($("#gloryImgBox li img").attr("alt") == "暂无荣誉"){
		$("#gloryScrollBox").hide();
	}else{
		scrollBar("imgBoxWraps","gloryImgBox","gloryScrollBox","gloryScrollSon",10);
	}
}
</script>
</head>

<body>
	<div id="resumeParent" class="resumeWrap">
		<c:forEach items="${requestScope.userList}" var="user" varStatus="status">
		<c:set var="index" value="${status.index}"></c:set>
		<!-- 头部导师头像  -->
		<div class="resumeTop">
        	<h2 class="topTit"></h2>
            <div class="netPicBox">
            	<div class="nameLayer"></div>
            	<p class="ntNames"><c:out value="${user.realname}"/></p>
            	<img src="${pageContext.request.contextPath}/<c:out value="${user.portrait}"/>" width="100" height="100" /> 
            </div>
        </div>
        <div class="resumeCen">
        	<!-- 个人信息 -->
        	<div class="perInfoBox">
                <!--  p class="sexs">性别：<c:out value="${user.sex}"/></p-->
                <p class="xueduans margL">担任学段：<c:forEach items="${requestScope.ntList}" var="netTeacher" begin="${index}" end="${index}"><c:out value="${netTeacher.schoolType}"/></c:forEach></p>
                <p class="xueduans">担任科目：<c:out value="${requestScope.subName}"/></p>
            </div>
            
            <!-- 个人介绍 -->
            <div class="perIntroBox">
                <div id="detailParent" class="detailConBox">
                	<c:forEach items="${requestScope.ntList}" var="netTeacher" begin="${index}" end="${index}">
                		<div id="sonCon" class="detialSonCon">
                			<span class="preIntroTxt">个人介绍：</span><c:out value="${netTeacher.teacherIntro}"></c:out>
                		</div>
                	</c:forEach>
                </div>
                <div id="parentScrollBox" class="scrollBox">
                	<div id="sonScrollBar" class="scrollBar"></div>	
                </div>
            </div>
         </div>
         <!--  个人荣誉  -->
         <div id="perGlory" class="perGloryBox">
         	<h2 class="gloryTxt">个人荣誉</h2>
         	<div id="imgBoxWraps" class="imgBoxWrap">
	           	<ul id="gloryImgBox">
	       			<c:forEach items="${requestScope.honorPictures}" var="honor">
		        		 <li>
		                	<c:if test="${honor!='0'}">
			                	<div class="markLayer">
			                		<span class="checkIcon" title="查看原图" onclick="showBigImg('${honor}')"></span>
			                	</div>
		                		<img class="gloryImg" src="${pageContext.request.contextPath}/<c:out value="${honor}"/>" width="125" height="125"/>
		                	</c:if>
		                	<c:if test="${honor=='0'}">
		                		<div class="noGloryBox">
		                			<img src="Module/netTeacherList/images/noGlory.png" alt="暂无荣誉">
		                		</div>     		
		                	</c:if>
		                 </li>
	       		 	</c:forEach>
	              </ul>
              </div>
              <!--  模拟滚动条  -->
              <div id="gloryScrollBox">
              	<div id="gloryScrollSon"></div>
              </div>
         </div>
         <!-- 底部   -->
         <div class="perResumeBot">
         	<div class="logoBox">
         		<img src="Module/images/logo.png" alt="濮阳亮宇助学网" width="120" height="83" />
         	</div>
         </div>
		</c:forEach>
		<span class="closeIcon" onclick="closeResumeWin()"></span>
    </div>
</body>
</html>

