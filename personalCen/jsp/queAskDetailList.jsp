<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
    <title>知识典个人中心--学生老师我的提问和答疑列表</title>
    <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/personalCen/css/myAsk.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="Module/personalCen/js/personalJs.js"></script>
	<script type="text/javascript">
	window.onload = function(){
		checkImg();
	};
	function reply(id){
		var queId = id;
		var queReply = editor.getContent();
		var headUrl = window.parent.document.getElementById("headUrl").value;
		var moduleId = window.parent.document.getElementById("moduleId").value;
		if(queReply.length == 1){
			alert("回复内容不能为空");
		}else{
			$.ajax({
				type:"post",
				async:false,
				dataType:"json",
				url:"questionManager.do?action=reply&queId="+queId+"&queReply="+encodeURIComponent(queReply),
				success:function(json){
					if(json){
						alert("回复内容已保存！");
						window.parent.location.href = headUrl + moduleId;
						
					}else{
						alert("回复保存失败，请重新回复！");
					}
				}
			});
		}
	}
	</script>
	</head>

<body>
	<!-- 我的提问/答疑列表层 -->
	<div id="parentListBox" class="askListBox">
		<input type="hidden" id="quesId" />
      <c:if test="${sessionScope.roleName=='学生' || sessionScope.roleName == '家长'}">
		<c:forEach items="${requestScope.qVOList}" var="question">
		<div class="stQuesBox clearfix">
			<!-- 左侧用户名 用户头像 用户身份 -->
			<div class="picBox fl">
			<c:forEach items="${requestScope.uVOList}" var="user">
				<div class="pic"> 
					<img src="${pageContext.request.contextPath}/<c:out value="${user.portrait}"></c:out>" width="120" height="120" />
				</div>		
				<div class="stName">
					<p><span class="identify">学生</span>：<span class="username"><c:out value="${user.realname}"/></span></p>
				</div>
			</c:forEach>
			</div>
			
			<!-- 右侧主体内容 -->
			<div class="detailCon fl">
			    <h2 class="quesTitle" title="${question.title}">问题编号<c:out value="${question.id}"/>:&nbsp;<c:out value="${question.title}"/></h2>
				<div class="timeBox">
					<span class="userIcon"></span>
					<p>发表于：<span class="pubTime"><fmt:formatDate value="${question.queTime}" type="both"/></span></p>
				</div>
				<!-- 发表内容的主要部分 文字+图片 -->
				<div class="mainContents">
				    <p>${question.question}</p>
				</div>
			</div>
		 </div>
			<!-- 文本编辑器盒子  -->
		 <div class="textEdit clearfix">
			  <div class="picBox noBor fl">
			  <c:forEach items="${requestScope.teacList}" var="teacher">
			 	<div class="pic">
					<img src="${pageContext.request.contextPath}/<c:out value="${teacher.portrait}"/>" width="120" height="120" />
				</div>
				<div class="stName">
					<p><span class="identify">老师</span>：<span class="username"><c:out value="${teacher.realname}"/></span></p>
				</div>
			  </c:forEach>
			  </div>
			  <div class="editParent fl">
			    <c:if test="${question.isRead=='1'}">
			    	<div class="timeBox">
				    	<span class="replayUserIcon"></span>
						<p>回复于：<fmt:formatDate value="${question.queReplyTime}" type="both"/></p>
					</div>
					<div class="mainContents">
						<p>${question.queReply}</p>
					</div>
				</c:if>
				<c:if test="${question.isRead=='2'}">
					<div class="boxNoReplay">
						<img class="noReplayImg" src="Module/personalCen/images/emptyReplay.gif">
						<p class="noReplayTxt">该问题老师尚未答复！</p>
					</div>
				</c:if>
			  </div>
		 </div>
		 </c:forEach>
	  </c:if>
	  <c:if test="${sessionScope.roleName=='网络导师'}">
	     <c:forEach items="${requestScope.qVOList}" var="question">
		 <div class="stQuesBox clearfix">
			<!-- 左侧用户名 用户头像 用户身份 -->
			<div class="picBox fl">
			<c:forEach items="${requestScope.stuList}" var="student">
				<div class="pic"> 
					<img src="${pageContext.request.contextPath}/<c:out value="${student.portrait}"></c:out>" width="120" height="120" />
				</div>		
				<div class="stName">
					<p><span class="identify">学生</span>：<span class="username"><c:out value="${student.realname}"/></span></p>
				</div>
			</c:forEach>
			</div>
			
			<!-- 右侧主体内容 -->
			<div class="detailCon fl">
			    <h2 class="quesTitle">问题编号<c:out value="${question.id}"/>:&nbsp;<c:out value="${question.title}"/></h2>
				<div class="timeBox">
					<span class="userIcon"></span>
					<p>发表于：<span class="pubTime"><fmt:formatDate value="${question.queTime}" type="both"/></span></p>
				</div>
				<!-- 发表内容的主要部分 文字+图片 -->
				<div class="mainContents">
				    <p>${question.question}</p>
				</div>
			</div>
		 </div>
		<!-- 文本编辑器盒子-->
		 <div class="textEdit clearfix">
			 <div class="picBox noBor fl">
			 <c:forEach items="${requestScope.uVOList}" var="user">
			 	<div class="pic">
					<img src="${pageContext.request.contextPath}/<c:out value="${user.portrait}"/>" width="120" height="120" />
				</div>
				<div class="stName">
					<p><span class="identify">老师</span>：<span class="username"><c:out value="${user.realname}"/></span></p>
				</div>
			 </c:forEach>
			 </div>
			 <div class="editParent fl">
                <c:if test="${question.isRead=='1'}">
                	<div class="timeBox">
                		<span class="replayUserIcon"></span>
	                    <p>回复于：<fmt:formatDate value="${question.queReplyTime}" type="both"/></p>
	                </div>
					<div class="mainContents">
						<p>${question.queReply}</p>
					</div>
                </c:if>
                <c:if test="${question.isRead=='2'}">
					<div id="myEditor"></div>	
						<script type="text/javascript">					
							var editor;
							editor = new baidu.editor.ui.Editor( {
								//这里可以选择自己需要的工具按钮名称,此处仅选择如下五个  
						        toolbars:[['Source', 'italic','bold', 'underline',
						                   'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify','|',
						                   'insertimage']], 
								initialFrameWidth : 608,
								initialFrameHeight : 230,
								wordCount:true,
								textarea : 'description'
							});
							editor.render("myEditor");
						</script>	
					 <div class="btnParent">
						<input id="save" class="save" type="button" value="发表回复" onclick="reply(${question.id})"/>
					 </div>
				</c:if>
			 </div> 
		 </div> 
		 </c:forEach>
	  </c:if>
	</div>
	<!-- 我的提问答疑列表查看后弹窗的关闭按钮 -->
	<span class="close" title="关闭" onclick="closeAskWin()"></span>
</body>
</html>
