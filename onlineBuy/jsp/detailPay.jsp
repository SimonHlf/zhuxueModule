<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
<head>
<title>助学网订单详情结算</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/onlineBuy/css/purchaseOnlineCss.css" type="text/css" rel="stylesheet"/>
<link href="Module/onlineBuy/css/detailPayCss.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/onlineBuy/js/onlineBuy.js"></script>
<script type="text/javascript">
$(function(){
	checkRaido();
	payTab();
});
function inp1_onkeyup() {
	if(getId("password_1").value.length==5){
		getId("password_2").focus();
	}
}
function inp2_onkeyup() {
	if(getId("password_2").value.length==5){
		getId("password_3").focus();
	}
}
function inp3_onkeyup() {
	if(getId("password_3").value.length==5){
		getId("password_4").focus();
	}
}
var onOff = true;
//检测模拟复选框是否被选中
function checkRaido(){
	$(".useDisCard").click(function(){
		var favPrice=$("#faPrice").text();
		var faceVal=$("#faceVal").text();
		var payable=favPrice-faceVal;
		if(onOff){
			$("#checkBtn").addClass("active");
			onOff = false;
			$("#payable").text(payable);
		}else{
			$("#checkBtn").removeClass("active");
			onOff = true;
			$("#payable").text(favPrice);
		}
	});
}
function payTab(){
	$(".selectPayWay li").each(function(i){
		$(this).click(function(){
			$(".selectPayWay li").removeClass("active");
			$(".decPic").stop().animate({top:46},300);
			$(".payWayBox").hide();
			$(".decPic").eq(i).stop().animate({top:0},300);
			$(this).addClass("active");
			$(".payWayBox").eq(i).show();
		});
	});
}
</script>
</head>

<body>
	<div class="detailPayWrap w1000">
	 <c:forEach items="${vipcardinfos}" var="vcinfos">
		<!-- 核对商品信息  -->
		<div class="titTop">
			<h2>核对订单信息</h2>
		</div>
		<!-- 商品详情  -->
		<p class="smallTit proBg"></p>
		<ul class="goodsNav">
			<li class="goodsMr">商品</li>
			<li class="goodsMr">原价</li>
			<li>优惠价</li>
		</ul>
		<ul class="detailInfo">
		
			<li>
				<img src="${vcinfos.cardImg }" height="50">
				<p class="goodsName fl">${vcinfos.vipName }</p>
			</li>
			<li>
				<p class="origanPrice">${vcinfos.price }</p>
			</li>
			<li>
				<p class="offPrice" id="faPrice">${vcinfos.favorablePrice }</p>
			</li>
			
		</ul>
		<div class="decLine"></div>
		<!-- 优惠券  -->
		<p class="smallTit">优惠券<a class="konwMore" href="javascript:void(0)" onclick="showKonowMore()">[了解更多]</a></p>
		<div class="discountBox">
			<p class="tips">提示：每次购买只能使用一张优惠券</p>
			<div class="comInputBox margBot">
				<span>请输入您的优惠券卡号：</span><input type="text" id="coupAcc" class="comInp" maxlength="6"/>
			</div>
			<div class="comInputBox margBot">
				<span>请输入您的优惠券密码：</span><input type="text" id="password_1" class="comInp" onkeyup="inp1_onkeyup()" maxlength="5"/>-<input type="text" id="password_2" class="comInp" onkeyup="inp2_onkeyup()" maxlength="5"/>-<input type="text" id="password_3" class="comInp" onkeyup="inp3_onkeyup()" maxlength="5"/>-<input type="text" id="password_4" class="comInp" onkeyup="inp4_onkeyup()" maxlength="5"/>&nbsp;&nbsp;<span style="color: red" id="tipMsg"></span>
			</div>
			<p class="disCardPrice">您当前优惠券的面额是<span id="faceVal">0</span><span>元</span></p>
			<!-- 使用优惠券  -->
			<div class="useDisCard">
				<a id="checkBtn" href="javascript:void(0)"></a>
				<p>使用优惠券</p>
			</div>
		</div>
		<div class="decLine"></div>
		<!-- 付款金额  -->
		<div class="payBox">
			<p>应付金额：<span>￥</span><span id="payable">${vcinfos.favorablePrice }</span><span>元</span></p>
		</div>
		<input type="hidden" id="coupID" value="0">
		<input type="hidden" id="odNumer" value="${oNuber }">
		<input type="hidden" id="vid" value="${vcinfos.id }">
	  </c:forEach>
		<!-- 选择支付方式  -->
		<p class="smallTit selPayBg"></p>
		<div class="selectPayWay">
			<ul>
				<li class="active margLi">
					<span class="payTxt">支付宝</span>
					<span class="decPic"><i></i></span>
					<input type="radio" class="comRadio" name="payWay" checked/>
				</li>
				<li>
					<input type="radio" class="comRadio" name="payWay"/>
					<span class="payTxt">银联支付</span>
					<span class="decPic"><i></i></span>
				</li>
			</ul>
		</div>
		<!-- 支付方式对应的div盒子  -->
		<div class="payWayParent">
			<div class="payWayBox clearfix" style="display:block;">
				<img class="zhi" src="Module/onlineBuy/images/zhifubao.png" alt="支付宝在线支付">
				<span class="infos">如果您拥有支付宝账号，可以用支付宝进行在线支付！</span>
				<a href="javascript:void(0)" class="goPayBtn" onclick="vipPay()">付款</a>
			</div>
			<div class="payWayBox clearfix">
				<img class="chinaPay" src="Module/onlineBuy/images/yinlian.gif" alt="银联在线支付">
				<span class="infos1">如果您拥有银联账号，可以用银联进行在线支付！</span>
				<a href="javascript:void(0)" class="goPayBtn" onclick="vipChinaPay()">付款</a>
			</div>
		</div>
	</div>
</body>
</html>
