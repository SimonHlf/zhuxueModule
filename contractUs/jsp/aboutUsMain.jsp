<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>助学网联系我们</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/css/layout.css" type="text/css" rel="stylesheet" />
<link href="Module/css/switchSys.css" type="text/css" rel="stylesheet" />
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script type="text/jscript">
var newId = "${requestScope.newId}";
var para = "${requestScope.para}";
$(function(){
	backTop("backTop");
	moveLeftRight(303);
	autoHeight("aboutUsIframe");
	showFourParts();
});
function showFourParts(){
	var mainWin = getId("aboutUsIframe").contentWindow;
	if(newId == "0"){
		if(para == ""){
			mainWin.location.href = "index.do?action=fourParts";
		}else{
			mainWin.location.href = "index.do?action=newsList";
		}
	}else{
		mainWin.location.href = "index.do?action=detailNewsCon&newId="+newId;	
	}
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
					<li id="markLayer" style="left:303px;"></li>
					<li class="navList"><a href="javascript:void(0)" onclick="showIndexMainCon()">首页</a></li>
					<li class="navList"><a href="index.do?action=feature">教学特色</a></li>
					<li class="navList"><a href="index.do?action=resource">教学资源</a></li>
					<li class="navList active"><a href="index.do?action=aboutUs">关于我们</a></li>
					<li class="navList"><a href="index.do?action=useHelp">使用帮助</a></li>
				</ul>
			</div>
		</div>
	</div>
	<iframe id="aboutUsIframe" allowTransparency="true" name="aboutUsIframe" width="100%" height="100%" src="" frameborder="0" scrolling="no"></iframe>
	
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
	<!-- 客服  -->
	<%@include file="../../kefu/kefu.jsp"%>
	<!-- 返回顶部  -->
    <span id="backTop" class="backIndex"></span>
</body>
</html>
