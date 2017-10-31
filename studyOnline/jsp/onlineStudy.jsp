<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>助学网在线答题</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/images/logo.ico" rel="shortcut icon"/>
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/studyOnline.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/askAlertWin.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
	<link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/studyOnline/js/studyOnlineJs.js"></script>
	<script type="text/javascript">
	var subjectId = 0;
	var classId = 0;
	var roleName = "${sessionScope.roleName}";
	var roleId = "${sessionScope.roleID}";
	var educationId = "${requestScope.educationId}";
	$(function(){
		checkScreenWidth(".head");
		fnTab($('.tabNav'),'click');
		fnTab($('.tabNav1'),'click');
		autoHeight('studyOnline');
		if("${requestScope.subId}" != "0"){
			subjectId = "${requestScope.subId}";
			$("#li_"+subjectId).addClass("active");
		}else{
			$("#mainHead").find("ul li:first-child").addClass("active");
			var liId = $("#mainHead").find("ul li:first-child").attr("id");
			subjectId = liId.split("_")[1];
		}
		classId = ${requestScope.classId};
		if(educationId != "0"){
			showChapter(educationId);
		}else{
			showBook(subjectId,classId);
		}
		moveLeftRight(91);
		hoverImgMoveTop($(".tabNav1 li"),$(".subImgs"),0,-3);
		checkSubLiLen();
	});
	function showBook(subjectId){
		var mainWin = document.getElementById("studyOnline").contentWindow;
		mainWin.location.href = "studyOnline.do?action=queryEducationList&classId="+classId+"&subId="+subjectId;
	}
	function showChapter(educationId){
		var mainWin = document.getElementById("studyOnline").contentWindow;
		mainWin.location.href = "studyOnline.do?action=showChapter&educationId="+educationId;
	}
	function backIndex(){
		getId("roleID").value = roleId;
		getId("roleName").value = roleName;
		getId("roleForm").submit();
	}
</script>
  </head>
  
  <body>
	<!-- head头部部分 -->
	<div class="headWrap">
		<div class="head">
			<div class="logo">
				<img src="Module/images/logo.png" alt="助学网--中小学生课堂信息反馈系统" />
			</div>
			<div id="userCenter" class="userCenter">
				<span class="userChanel">${sessionScope.roleName}频道</span>
				|
				<a href="javascript:void(0)" onclick="loginOut()">退出</a>
				<span class="decTriangle"></span>
			</div>
			<div class="nav">
				<ul class="tabNav">
					<li id="markLayer" style="left:91px;"></li>
					<li class="navList"><a href="javascript:void(0)" onclick="backIndex()">首页</a></li>
					<li class="navList active"><a href="studyOnline.do?action=load">在线答题</a></li>
					<li class="navList"><a href="personalCenter.do?action=welcome">个人中心</a></li>
					<c:if test="${sessionScope.roleName == '学生' }">
						<li class="navList"><a href="javascript:void(0)" onclick="ntList()">导师列表</a></li>
						<li class="navList"><a href="onlineBuy.do?action=load">在线购买</a></li>
						<li class="navList"><a href="shopManager.do?action=welcome">金币商城</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<!-- 中间主体内容  -->
	<div class="mainContent">
		<!-- 答题部分头部 -->
		<div class="mainHead clearfix" id="mainHead">
			<!-- 左侧  -->
			<div class="head_L"></div>
			<div class="tabNav1Wrap">
				<div class="tabNav1Box">
					<ul id="tabNav1" class="tabNav1 clearfix">
						<c:forEach items="${requestScope.gList}" var="grade">
							<li class="smallNavList" id="li_<c:out value="${grade.subject.id}"/>">
								<span class="bookMark"></span>
								<a onclick="showBook('${grade.subject.id}')"><img class="subImgs" src='${grade.subject.subImgUrl}'/></a>
							</li>
						</c:forEach>
					</ul>
					<span class="bookDec1"></span>
					<span class="bookDec2"></span>
				</div>
				<span id="prevBtns" class="prevBtn comBtns"></span>
				<span id="nextBtns" class="nextBtn comBtns"></span>
			</div>
		</div>
		<!-- 答题部分主要内容 -->
		<div class="mainCon">
			<iframe id="studyOnline" name="studyOnline" src="" width="100%" height="100%" scrolling="no" frameborder="0"></iframe>
		</div>
	</div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
	
	<!-- 向老师提问的弹窗 -->
	<div class="myAskBox">
		<div class="topAsk topTiwen1">
			<p class="myAsks">我的提问</p>
			<span class="askIcon"></span>
			<span class="closeAskBox" title="关闭" onclick="closeLearnWin()"></span>
		</div>
		
		<div class="midAsk">
			<div class="askConTit clearfix">
				<ul>
					<li class="bor2">
						<p class="gradeName comFontCol font2" style="text-indent:10px;">年级：<span class="gradeNum"></span></p>
					</li>
					<li class="bor2">
						<p class="scheName comFontCol font2">科目：<span class="scheNum"></span></p>
					</li>
				</ul>
			</div>
			<input type="hidden" id="subId">
			<input type="hidden" id="ntId">
			<!-- 提问标题  -->
			<div class="askTitle bor2">
				<span class="comFontCol font2">标题：</span>&nbsp;<input type="text" id="tiwen" class="askHeadCon" maxlength="30" class="tiwen_text" />
			</div>
			<!-- 提问内容  -->
			<div class="askCon">
				<div class="mainAskCon">
					<div id="myEditor" name="editorContent"></div>	
					<script type="text/javascript">
						var editor;
						editor = new baidu.editor.ui.Editor( {
							initialFrameWidth : 548,
							initialFrameHeight : 250,
							wordCount:true,
							textarea : 'description'
						});
						editor.render("myEditor");
					</script>	
				</div>
			</div>
		</div>
		
		<div class="botAsk">
			<div class="botAskR botTiwen1"></div>
			<div class="botAskMid"></div>
			<!-- 提交  -->
			<input class="tijiaoBtn saveBtn2" type="submit" value="提交" onclick="submitQuestion()"/>
		</div>
	</div>
	<form id="roleForm"  action="userManager.do?action=goPage" method="post">
   		<input type="hidden" id="roleID" name="roleID"/>
   		<input type="hidden" id="roleName" name="roleName"/>
    </form>
</body>
</html>
