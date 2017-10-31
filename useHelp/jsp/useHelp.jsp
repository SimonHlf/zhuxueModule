<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>助学网使用帮助</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/css/layout.css" type="text/css" rel="stylesheet" />
<link href="Module/useHelp/css/useHelp.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript">  
$(function(){
	moveLeftRight(404);
	autoHeight("helpRightIframe");
	newsModMove();
	showRegLoginJsp();
	backTop("backTop");
	$(".moveActive_1").show().stop().animate({top:29},300);
});
function newsModMove(){
	$(".useHelpLeft p").each(function(i){
		$(this).hover(function(){
			$(".moveActive_1").show().stop().animate({top:this.offsetTop + 4},300);
		});
		$(this).click(function(){
			$(".useHelpLeft p").removeClass("navActive");
			$(this).addClass("navActive");
		});
	});
}
//登录注册
function showRegLoginJsp(){
	var mainWin = getId("helpRightIframe").contentWindow;
	mainWin.location.href = "index.do?action=regLogHelp";
}
//在线学习
function showStudyOnline(){
	var mainWin = getId("helpRightIframe").contentWindow;
	mainWin.location.href = "index.do?action=studOnlHelp";
}
//学习记录
function showLearnRecordJsp(){
	var mainWin = getId("helpRightIframe").contentWindow;
	mainWin.location.href = "index.do?action=learnRecordHelp";
}
//能力报告
function showAbilityJsp(){
	var mainWin = getId("helpRightIframe").contentWindow;
	mainWin.location.href = "index.do?action=abilityHelp";
}
//我的账户
function showAccountJsp(){
	var mainWin = getId("helpRightIframe").contentWindow;
	mainWin.location.href = "index.do?action=accountHelp";
}
//我的班级
function showMyClassJsp(){
	var mainWin = getId("helpRightIframe").contentWindow;
	mainWin.location.href = "index.do?action=myClassHelp";
}
//学习记录（家长端）
function showParRecordJsp(){
	var mainWin = getId("helpRightIframe").contentWindow;
	mainWin.location.href = "index.do?action=parRecordHelp";
}
//能力报告（家长端）
function showParAbilityJsp(){
	var mainWin = getId("helpRightIframe").contentWindow;
	mainWin.location.href = "index.do?action=parAbilityHelp";
}
</script>  
</head>
  
<body>
	<!-- header头部部分 -->
	<div id="headerWrap">
		<div id="header" class="w1000">
			<p class="headLoginBox">
				<span class="decTri"></span>
				<a class="logA" href="login.do?action=commonLogin">登录</a>
				|
				<a class="regA" href="login.do?action=registGoPage">注册</a>
			</p>
			<div id="logo">
				<a href="javascript:void(0)" onclick="showIndexMainCon()"><img src="Module/images/logoZxw.png" width="112" height="77" alt="助学网--课堂信息反馈系统" /></a>
			</div>
			<h2>中小学生课堂信息反馈系统</h2>
			<div id="nav">
				<ul class="tabNav">
					<li id="markLayer" style="left:404px;"></li>
					<li class="navList"><a href="javascript:void(0)" onclick="showIndexMainCon()">首页</a></li>
					<li class="navList"><a href="index.do?action=feature">教学特色</a></li>
					<li class="navList"><a href="index.do?action=resource">教学资源</a></li>
					<li class="navList"><a href="index.do?action=aboutUs">关于我们</a></li>
					<li class="navList active"><a href="index.do?action=useHelp">使用帮助</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="useWrapCon w1000 clearfix">
		<div class="useHelpLeft fl">
			<!-- 注册登录  -->
			<strong class="navTit">注册登录</strong>
			<p class="leftNav navActive"><a href="javascript:void(0)" onclick="showRegLoginJsp()">注册登录</a></p>
			<span class="line"></span>
			<strong class="navTit">学生端</strong>
			<p class="leftNav"><a href="javascript:void(0)" onclick="showStudyOnline()">在线答题</a></p>
			<p class="leftNav"><a href="javascript:void(0)" onclick="showLearnRecordJsp()">学习记录</a></p>
			<p class="leftNav"><a href="javascript:void(0)" onclick="showAbilityJsp()">能力报告</a></p>
			<span class="line"></span>
			<strong class="navTit">网络导师端</strong>
			<p class="leftNav"><a href="javascript:void(0)" onclick="showAccountJsp()">我的账户</a></p>
			<p class="leftNav"><a href="javascript:void(0)" onclick="showMyClassJsp()">我的班级</a></p>
			<!--  p class="leftNav"><a href="javascript:void(0)" onclick="showFollowJsp()">跟踪指导</a></p-->
			<span class="line"></span>
			<strong class="navTit">家长端</strong>
			<p class="leftNav"><a href="javascript:void(0)" onclick="showParRecordJsp()">学习记录</a></p>
			<p class="leftNav"><a href="javascript:void(0)" onclick="showParAbilityJsp()">能力报告</a></p>
			<span class="moveActive_1"></span>
		</div>
		<div class="useHelpRight fl">
			<iframe src="" id="helpRightIframe" name="helpRightIframe" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		</div>
	</div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
	<!-- 返回顶部  -->
    <span id="backTop" class="backIndex"></span>
   	<!-- 客服  -->
	<%@include file="../../kefu/kefu.jsp"%>
</body>
</html>
