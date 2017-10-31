<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>助学网联系我们</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/contractUs/css/fourPartsCss.css" type="text/css" rel="stylesheet" />
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script type="text/jscript">
$(function(){
	showALayer();
});
function showALayer(){
	$(".comHoverBox").each(function(i){
		$(this).hover(function(){
			$(".comHoverBox a").eq(i).show().animate({"opacity":0.3});
		},function(){
			$(".comHoverBox a").eq(i).hide().animate({"opacity":0});
		});
	});
}
//助学网简介
function showZhuXueProJsp(){
	var mainWin = window.parent.getId("aboutUsIframe").contentWindow;
	mainWin.location.href = "index.do?action=zhuXuePro";
}
//新闻列表动态
function showNewsListJsp(){
	var mainWin = window.parent.getId("aboutUsIframe").contentWindow;
	mainWin.location.href = "index.do?action=newsList";
}
//公司简介
function showCompProfileJsp(){
	var mainWin = window.parent.getId("aboutUsIframe").contentWindow;
	mainWin.location.href = "index.do?action=comProfile";
}
//联系我们
function showContractJsp(){
	var mainWin = window.parent.getId("aboutUsIframe").contentWindow;
	mainWin.location.href = "index.do?action=contractUs";
}
//留言板
function showMessage(){
	var mainWin = window.parent.getId("aboutUsIframe").contentWindow;
	mainWin.location.href = "index.do?action=leaveMessage";
}
</script>
</head>
  
<body>
	<div class="fourPartsBox w1000">
		<!-- 头部  -->
		<div class="bigTit">
			<img src="Module/contractUs/images/aboutUs.png" alt="助学网关于我们"/>
		</div>
		<!-- 四块  -->
		<div class="moduleBox w1000">
			<!--  top -->
			<div class="topParts clearfix">
				<div class="topLeft fl comHoverBox">
					<img src="Module/contractUs/images/zhuXuePro.jpg" alt="助学网简介"/>
					<a class="comModA" href="javascript:void(0)" onclick="showZhuXueProJsp()"></a>
				</div>
				<div class="topRight fr comHoverBox">
					<img src="Module/contractUs/images/newsList.jpg" alt="助学网新闻动态"/>
					<a class="comModA" href="javascript:void(0)" onclick="showNewsListJsp()"></a>
				</div>
			</div>
			<!--  bottom -->
			<div class="botParts clearfix">
				<div class="botLeft fl comHoverBox">
					<img src="Module/contractUs/images/enterprise.png" alt="公司简介"/>
					<p>上海圆培网络科技有限公司是一家集教育培训、4D数字化校园、助学网学习平台...</p>
					<a class="comModA" href="javascript:void(0)" onclick="showCompProfileJsp()"></a>
				</div>
				<div class="botMid fl comHoverBox">
					<img src="Module/contractUs/images/message.png" alt="留言板"/>
					<a class="comModA" href="javascript:void(0)" onclick="showMessage()"></a>
				</div>
				<div class="botRight fr comHoverBox">
					<img src="Module/contractUs/images/contract.jpg" alt="助学网联系我们"/>
					<a class="comModA" href="javascript:void(0)" onclick="showContractJsp()"></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
