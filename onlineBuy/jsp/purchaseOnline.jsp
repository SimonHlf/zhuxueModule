<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
<head>
<title>助学网在线购买</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/onlineBuy/css/purchaseOnlineCss.css" type="text/css" rel="stylesheet"/>
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/onlineBuy/js/onlineBuy.js"></script>
<script type="text/javascript">
$(function(){
	checkScreenWidth(".head");
	intLoadCon();
	autoHeight("olBuyIframe");
	moveLeftRight(364);
});
//iframe初始加载vip年卡列表
function intLoadCon(){
	var mainWin = getId("olBuyIframe").contentWindow;
	mainWin.location.href = "onlineBuy.do?action=listVip";
}
function closeResumeWin(){
	$(".layer").hide();
	$(".useHelpWin").hide();
}
</script>
</head>
  
<body class="bigBody">
	<!-- head头部部分 -->
	<div class="headWrap">
		<div class="head">
			<div class="logo">
				<a href="javascript:void(0)">
					<img src="Module/images/logo.png" alt="助学网--中小学生课堂信息反馈系统" />
				</a>
			</div>
			<div id="userCenter" class="userCenter">
				<span class="userChanel">${sessionScope.roleName}频道</span>
				|
				<a href="javascript:void(0)" onclick="loginOut()">退出</a>
				<span class="decTriangle"></span>
			</div>
			<div class="nav">
				<ul class="tabNav">
					<li id="markLayer" style="left:364px;"></li>
					<li class="navList"><a href="userManager.do?action=goPage">首页</a></li>
					<li class="navList"><a href="studyOnline.do?action=load">在线答题</a></li>
					<li class="navList"><a href="personalCenter.do?action=welcome">个人中心</a></li>
					<c:if test="${sessionScope.roleName == '学生' }">
						<li class="navList"><a href="javascript:void(0)" onclick="ntList()">导师列表</a></li>
						<li class="navList active"><a href="javascript:void(0)">在线购买</a></li>
						<li class="navList"><a href="shopManager.do?action=welcome">金币商城</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<!-- 在线购买主体内容  -->
	<div class="onlineBuyWrap w1000">
		<iframe id="olBuyIframe" name="olBuyIframe" src="" width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="true"></iframe>
	</div>
	<!-- 优惠券了解更多弹窗  -->
	<div class="knowMoreWin">
		<div class="leftDec"></div>
		<div class="rightDec"></div>
		<div class="topInfo">
			<p class="tit">优惠券</p>
			<p class="introInfo">助学网优惠券是一种线下发给各个用户的一种实体卡；</p>
			<p class="introInfo">持优惠券者可以通过卡券上的账号和密码在购买助学网年限Vip上抵挡现金使用；</p>
			<p class="introInfo">当您购买助学网年限vip时进行付款支付时只能使用一张优惠券(且每张优惠券只能使用一次)；</p>
			<p class="introInfo">如果您拥有多张优惠券可以多次在购买助学网Vip年限时进行使用；</p>
			<p class="introInfo">每张优惠券的有效期限是一年；</p>
		</div>
		<div class="botInfo">
			<p>温馨提示：使用前请认准有效期</p>
			<a href="javascript:void(0)" class="closeBtn" onclick="closeKonWin()">我知道了</a>
		</div>
	</div>
	<!-- 使用帮助弹窗  -->
	<div class="useHelpWin">
		<div class="helpHead">
			<span class="closeIcon" onclick="closeResumeWin()"></span>
			<h2 class="helpTit"></h2>
		</div>
		<div class="mainPart">
			<div class="onePart">
				<h2 class="comTit"><em>01</em>年级基础价格表</h2>
				<ul class="priceTab">
					<li>
						<p><span class="posL">一年级</span><span class="posR">¥1000</span></p>
						<p><span class="posL">二年级</span><span class="posR">¥2000</span></p>
					</li>
					<li>
						<p><span class="posL">三年级</span><span class="posR">¥3000</span></p>
						<p><span class="posL">四年级</span><span class="posR">¥4000</span></p>
					</li>
					<li>
						<p><span class="posL">五年级</span><span class="posR">¥5000</span></p>
						<p><span class="posL">六年级</span><span class="posR">¥6000</span></p>
					</li>
					<li>
						<p><span class="posL">七年级</span><span class="posR">¥7000</span></p>
						<p><span class="posL">八年级</span><span class="posR">¥8000</span></p>
					</li>
					<li>
						<p><span class="posL">九年级</span><span class="posR">¥9000</span></p>
						<p><span class="posL">高&nbsp;&nbsp;&nbsp;一</span><span class="posR">¥10000</span></p>
					</li>
					<li class="noBor">
						<p><span class="posL">高&nbsp;&nbsp;&nbsp;二</span><span class="posR">¥11000</span></p>
						<p><span class="posL">高&nbsp;&nbsp;&nbsp;三</span><span class="posR">¥12000</span></p>
					</li>
				</ul>
				<span class="cenLine"></span>
			</div>
			<div class="twoPart">
				<h2 class="comTit"><em>02</em> 价格如何拟定</h2>
				<div class="priceDetail">
					<p>具体费用解读如下：</p>
					<p>助学网收费系统按照年级制收费，不同年级产生的费用也不同，系统会根据当前学生所在的年级，根据基础费用自动计算出平均每天的费用，再结合用户购买天数（累计天数后是否年级增加）来计算当前用户购买半年、一年的实际费用（注：高三年级时间即使超出，年级不会增加，基础费用按照高三年级费用收取）。</p>
					<p class="note">注：系统判定年级增加的具体日期为每年8月31日，超过后年级自动增加，基础费用也自动增加。</p>
					<p>举个范例：</p>
					<p>王同学，购买了半年（180天）的服务，那么计算方式为：</p>
					<!--  p>当前日期 currDate,累加后日期 resultDate,当前年级 currGrade</p-->
					<p>当前年级基础费用 ：<span class="color1">currGraPrice</span>(参考当前年级基础价格表);</p>
					<p>下一年级基础费用：<span class="color1">nextGraPrice</span>(参考当前年级基础价格表);</p>
					<p>当前实际费用 ：<span class="color1">totalPrice</span>;</p>
					<p>当前年级平均每天费用：<span class="color1">currGraAvgPrice</span> = currGraPrice / 365天 ;</p>
					<p>下一年级平均每天费用：<span class="color1">nextGraAvgPrice</span> = nextGraPrice / 365天 ;</p>
					<p class="note">如过累计后的日期超过当年的8月31日</p>
					<p>计算出当前日期到当年9月1日相差天数 diffDays</p>
					<p><span class="color1">totalPrice</span> = diffDays * currGraAvgPrice + (180 - diffDays) * nextGraAvgPrice ;</p>
					<p class="note">如过累计后的日期没超过当年8月31日</p>
					<p><span class="color1">totalPrice</span> = currGraAvgPrice * 180 ;</p>
				</div>
			</div>
		</div>
		<div class="footWin">
			<div class="logoBox">
         		<img src="Module/images/logo.png" alt="濮阳亮宇助学网" width="120" height="83">
         	</div>
		</div>
	</div>
	<div class="layer"></div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
</body>
</html>
