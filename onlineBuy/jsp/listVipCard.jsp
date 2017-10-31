<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
<head>
<title>助学网订单详情结算</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/onlineBuy/css/purchaseOnlineCss.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript">
function goDetailPay(vid){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"ordersManager.do?action=addVipCardOrders&vid="+vid,
		success:function(json){
			var mainWin = window.parent.getId("olBuyIframe").contentWindow;
			mainWin.location.href = "onlineBuy.do?action=detailPay&oNuber="+json+"&vid="+vid;
		}
	});
}
function getVipDetailById(vid){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"onlineBuyManager.do?action=listVipById&vid="+vid,
		success:function(json){
			
		}
	});
}
function showHelpWin(){
	var oParent = window.parent;
	var scrollTop=oParent.document.documentElement.scrollTop||oParent.document.body.scrollTop;
	var oCliHeight = oParent.document.documentElement.clientHeight;
	oParent.$(".layer").show();
	oParent.$(".useHelpWin").show().animate({"top":scrollTop});
}
</script>
<body>
	<div class="listBuyCon">
		<ul>
		 <c:forEach items="${vcList}" var="vc">
			<li>
				<img class="vipCard fl" src="${vc.cardImg }" alt="${vc.vipName }">
				<div class="rigPart fl">
					<h2>${vc.vipName }</h2>
					<p>价格：<span class="price">${vc.price }</span></p>
					<p><span class="fl">优惠价：</span><span class="offPrice clearfix"><span class="fl">${vc.favorablePrice }</span><span class="useHelp" title="有疑问" onclick="showHelpWin()"></span></span></p>
					<p>产品增值服务：</p>
					<p>惊喜1：享受全年${vc.activeDays }天所有课程的免费学习</p>
					<p>惊喜2：一线课堂网络到时精心录制的全程知识点视频讲解，能够帮你更快更容易的对课堂学习的知识点掌握</p>
					<p>惊喜3：独特的溯源诊断和五步学习法让你彻底学会这个知识点！</p>
				</div>
				<a href="javascript:void(0)" class="goBuyBtn fl" onclick="goDetailPay('${vc.id}')"></a>
			</li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>
