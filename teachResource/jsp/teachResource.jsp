<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>助学网教学资源</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/css/layout.css" type="text/css" rel="stylesheet" />
<link href="Module/css/switchSys.css" type="text/css" rel="stylesheet" />
<link href="Module/teachResource/css/resourceCss.css" type="text/css" rel="stylesheet" />
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	backTop("backTop");
	moveLeftRight(202);
});
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
					<li id="markLayer" style="left:202px;"></li>
					<li class="navList"><a href="javascript:void(0)" onclick="showIndexMainCon()">首页</a></li>
					<li class="navList"><a href="index.do?action=feature">教学特色</a></li>
					<li class="navList active"><a href="index.do?action=resource">教学资源</a></li>
					<li class="navList"><a href="index.do?action=aboutUs">关于我们</a></li>
					<li class="navList"><a href="index.do?action=useHelp">使用帮助</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="resWrap w1000">
		<h2 class="resBigTit">助学网教学资源</h2>
		<div class="comResDiv">
			<h3 class="smallTit">版本齐全</h3>
			<p class="detailCon">人教版、鲁教版、科教版、鲁教版（新版）、人教版（新版）、科教版（新版）、上海教育出版社</p>
		</div>
		<div class="banben">
			<div class="listBanBen posL1">
				<img src="Module/teachResource/images/renjiao.png" alt="人教版"/>
				<p class="pdTop">人教版</p>
				<p>人教版（新版）</p>
			</div>
			<div class="listBanBen posL2">
				<img src="Module/teachResource/images/kejiao.png" alt="科教版"/>
				<p class="pdTop">科教版</p>
				<p>科教版（新版）</p>
			</div>
			<div class="listBanBen posR1">
				<img src="Module/teachResource/images/lujiao.png" alt="鲁教版"/>
				<p class="pdTop">鲁教版</p>
				<p>鲁教版（新版）</p>
			</div>
		</div>
		<div class="comResDiv">
			<h3 class="smallTit">溯源学习</h3>
			<p class="detailCon">学科知识具有关联性,溯源倒查,帮助学生找到每个知识链条的断点和薄弱点,开启由 "不会到会" 的全新的、正确学习方式</p>
		</div>
		<div class="suyuan clearfix">
			<img src="Module/teachResource/images/suyuan.png" alt="溯源学习"/>
			<p>智能查找学生学习的薄弱环节,针对性的巩固加深,循环渐进的溯源学习法</p>
		</div>
		<div class="comResDiv">
			<h3 class="smallTit">五维教学</h3>
			<p class="detailCon">每个知识点五项学习资源</p>
		</div>
		<div class="wuwei clearfix">
			<p class="expTit">听"视频讲解"、看"点拨指导"、在理解的基础上背"知识清单"、学"解题示范"、规范解答,梳理解题方法; 做"巩固训练",巩固知识,熟练运用。</p>
			<div class="leftPart fl">
				<div class="innerTop mb">
					<div class="innerPart fl mr">
						<img src="Module/teachResource/images/ting.jpg" alt="听视频讲解"/>
					</div>
					<div class="innerPart fl tingBg">
						<p>听"视频讲解"</p>
					</div>
				</div>
				<div class="innerBottom">
					<div class="innerPart fl mr">
						<img src="Module/teachResource/images/jieti.jpg" alt="学解题示范"/>
					</div>
					<div class="innerPart fl xueBg">
						<p>学"解题示范"</p>
					</div>
				</div>
			</div>		
			<div class="cenPart fl">
				<div class="innerTop mb">
					<div class="innerPart fl mr">
						<img src="Module/teachResource/images/kan.jpg" alt="看点拨指导"/>
					</div>
					<div class="innerPart fl kanBg">
						<p>看"点拨指导"</p>
					</div>
				</div>
				<div class="innerBottom">
					<div class="innerPart fl mr">
						<img src="Module/teachResource/images/zuo.jpg" alt="做巩固训练"/>
					</div>
					<div class="innerPart fl zuoBg">
						<p>做"巩固训练"</p>
					</div>
				</div>
			</div>
			
			<div class="rightPart fr clearfix">
				<div class="innerTop mb">
					<div class="innerPart">
						<img src="Module/teachResource/images/bei.jpg" alt="背知识清单"/>
					</div>
				</div>
				<div class="innerBottom">
					<div class="innerPart beiBg">
						<p>背"知识清单"</p>
					</div>
				</div>
				
			</div>	
		</div>
		<div class="comResDiv">
			<h3 class="smallTits">资源丰富</h3>
		</div>
		<div class="ziyuan clearfix">
			<img src="Module/teachResource/images/ziyuan.png" alt="资源丰富"/>
			<p class="ziyuanTxt fl"><span class="font18">小学、初中、高中</span><span class="font14"> 课程应有尽有...</span></p>
		</div>
	</div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
	<!-- 客服  -->
	<%@include file="../../kefu/kefu.jsp"%>
	<!-- 返回顶部  -->
    <span id="backTop" class="backIndex"></span>
</body>
</html>
