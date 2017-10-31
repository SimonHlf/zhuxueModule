<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
<head>
<title>助学网--学习建议</title>
<meta http-equiv="description" content="助学网学习建议">
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/studyAdvice/css/studyAdviceCss.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
$(function(){
	adviceTab();
});
function adviceTab(){
	var iNow = 0;;
	$(".navAdviceTop li").click(function(){
		var index = $(this).index();
		if(index==iNow){
			return
		}
		$(".navAdviceTop li").removeClass("active");
		$(this).addClass("active");
		$(".adviceCon div").eq(iNow).stop().animate({"margin-left":-550, "opacity":0},300);
		iNow = index;
		$(".adviceCon div").eq(index).css({"margin-left":550,opacity:0}).stop().animate({"margin-left":0,opacity:1},300);
	});
}
</script>
</head>
 
<body>
	<div class="nowPosition">
		<p>助学网&gt;学习建议</p>
	</div>
	
	<div class="adviceWrap">
		<div class="bglayer"></div>
		<div class="navAdviceTop">
			<ul>
				<li class="active">
					<span class="txtNum">01</span>
					<p>考试前五名</p>
					<p>优等生</p>
				</li>
				<li>
					<span class="txtNum">02</span>
					<p>分数不上不下</p>
					<p>中等生</p>
				</li>
				<li>
					<span class="txtNum">03</span>
					<p>分数拖后腿</p>
					<p>后进生</p>
				</li>
			</ul>
		</div>
		<div class="adviceCon">
			<span class="dot posL"></span>
			<span class="dot posR"></span>
			<div class="moveBox" style="opacity:1;filter:alpha(opacity=100);">
				<p class="tit">我把助学网当成一个网上的练习册</p>
				<p class="detailWay">具体方法:把知识点当成一种日常练习,与课堂学习同步，在课堂上学习了一个新的知识点之后，通过知识点的诊断，检测自己对新学知识点时候掌握了,通常基本上就可以一次通过诊断。</p>
			</div>
			<div class="moveBox">
				<p class="tit">助学网帮助我巩固课堂知识，课下巩固训练，让我学会了高效率的学习</p>
				<p class="detailWay">具体方法：把助学网当成一种参考工具，与课堂学习同步，加强练习。课堂上学习了新的知识点，回到家利用助学网，先诊断自己对新知识点的掌握情况，通常因为概念掌握不牢，不会应用等多种问题，还能同时巩固关联知识。</p>
			</div>
			<div class="moveBox">
				<p class="tit">上课听不懂，题目不会做，助学网帮助我找到学不会的根源</p>
				<p class="detailWay">具体方法：把助学网当成亲密家教，辅导查漏补缺，疑难解答，成绩急速上升，上课总听不懂，新的知识点似懂非懂，回到家利用助学网再学习一遍，帮助理解。做题能力加强，有问题可以问网络导师，成绩上有所提高。</p>
			</div>
		</div>
	</div>
</body>
</html>
