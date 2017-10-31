<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>助学网教学特色</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/css/layout.css" type="text/css" rel="stylesheet" />
<link href="Module/css/switchSys.css" type="text/css" rel="stylesheet" />
<link href="Module/teachFeature/css/teachFeatureCss.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/teachFeature/js/jquery.roundabout.js"></script>
<script src="Module/teachFeature/js/jquery.roundabout-shapes.js"></script>
<script src="Module/teachFeature/js/fullPage.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script src="Module/teachFeature/js/teachFeatureJs.js"></script>
<script type="text/javascript">
$(function(){
	moveLeftRight(101);
	fullPageMove();
	checkViewScreen();
	page2FlashAuto();
});
</script>
</head>

<body>
	<!-- header头部部分 -->

	<div id="pageContain">
		<div class="page page1 current">
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
						<li id="markLayer" style="left:101px;"></li>
						<li class="navList"><a href="javascript:void(0)" onclick="showIndexMainCon()">首页</a></li>
						<li class="navList active"><a href="index.do?action=feature">教学特色</a></li>
						<li class="navList"><a href="index.do?action=resource">教学资源</a></li>
						<li class="navList"><a href="index.do?action=aboutUs">关于我们</a></li>
						<li class="navList"><a href="index.do?action=useHelp">使用帮助</a></li>
					</ul>
				</div>
				</div>
			</div>
			<!-- 主体内容部分  -->
			<div class="mainContent w1000">
				<h2 class="comH2Tit comFontH2">网络导师在线导学</h2>
				<p class="decTxt comTxtP">招募名师作为网络导师，实施网络导师导学。网络导师在网络环境下，对学生答疑解惑，进行一对一个性化帮扶。是学生在知识的海洋里旅行”全程导游“，适时的给学生正确的”探索指南“</p>
				<div class="centerImgBox">
					<div class="imgLayer"></div>
					<div class="imgBox">
						<img src="Module/teachFeature/images/page1Img.jpg">
					</div>
					
				</div>
				<div class="page1BotBox">
					<img class="page1Bot" src="Module/teachFeature/images/page1Bot.png"/>
				</div>
			</div>	
		</div>
	
		<div class="page page2">
			<div class="mainContent2_1"></div>
			<div class="mainContent2 w1000">
				<h2 class="comH2Tit2 comFontH2">五步学习 打牢基础</h2>
				<p class="decTxt2 comTxtP_1">听“视频讲解”、看“点拨指导”、背“知识清单”、学“解题示范”、做“巩固训练”。（每个知识点五项学习资源：视频讲解 点拨指导 知识清单 解题示范 巩固训练）</p>
				<ul class="roundabout" id="myroundabout"> 
					<li><img src="Module/teachFeature/images/ting.png"></li> 
					<li><img src="Module/teachFeature/images/kan.png"></li> 
					<li><img src="Module/teachFeature/images/bei.png"></li> 
					<li><img src="Module/teachFeature/images/xue.png"></li> 
					<li><img src="Module/teachFeature/images/gu.png"></li> 
				</ul>
			</div>
		</div>
	
		<div class="page page3">
			<div class="mainContent3 w1000">
				<h2 class="comH2Tit3 comFontH2">游戏化探究式学习</h2>
				<p class="decTxt3 comTxtP_1">学生的学习不再是外在的压力与负担，而是像游戏闯关一样的知识“探险”。会员成长体系计划，让学生对在线学习充满兴趣，并能感受到成绩进步带来的鼓励。</p>
			</div>
			<img class="page3DecImg" src="Module/teachFeature/images/page3Dec.png"/>
			<img class="page3MagicImg page3ComImg" src="Module/teachFeature/images/page3Img.png"/>
			<div class="page3SmallPicBox page3ComImg">
				<img class="page3SmallImg_1" src="Module/teachFeature/images/smallImg1.png" alt="兴趣"/>
				<img class="page3SmallImg_2" src="Module/teachFeature/images/smallImg2.png"  alt="进步"/>
				<img class="page3SmallImg_3" src="Module/teachFeature/images/smallImg3.png" alt="探险"/>
			</div>
			
		</div>
	
		<div class="page page4">
			<div class="mainContent4 w1000">
				<h2 class="comH2Tit4 comFontH2">溯源诊断 查找根源</h2>
				<p class="decTxt4 comTxtP_1">在助学网进行课后巩固，根据助学网打造的可溯知识体系，通过智能诊断系统，找到每个知识点学不会的根源（即知识点链条的断点和薄弱点），形成学生清晰的个性学习路线图。由不会到会，让学习从此变得如此轻松！</p>
			</div>
			<img class="page4Img comPage4Pic" src="Module/teachFeature/images/page4Img.png" />
			<div class="page4DecLayer comPage4Pic">
				<img class="page4ZoomPic" src="Module/teachFeature/images/zoomPic.png" />
				<img class="zoomPicCon" src="Module/teachFeature/images/page4Img1.png"/>
			</div>
		</div>
	</div>
	
	<ul id="navBar">
		<li title="网络导师在线导学"></li>
		<li title="五步学习 打牢基础"></li>
		<li title="游戏化探究式学习"></li>
		<li title="溯源诊断 查找根源"></li>
	</ul>

</body>
</html>
