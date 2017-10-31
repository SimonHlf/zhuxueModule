<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.kpoint.util.Constants" %>
<html>
  <head>
    <title>在线购买</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/onlineBuy/css/onlineBuy.css" type="text/css" rel="stylesheet"/>
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript" ></script>
	<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
	<script type="text/javascript" src="Module/appWeb/onlineBuy/js/onlineBuyApp.js"></script>
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
		var cliHei = document.documentElement.clientHeight;
		var cliWid = document.documentElement.clientWidth;
		$(function(){
			if(checkLoginStatus()){
				calHei();
				listvip();
			}
		});
		function calHei(){
			if(cliWid <= 500){
				$(".imgBg").on("load",function(){
					$(".listItem").height(50+$(".imgBg").height());
					$(".detailCon").height($(".listItem").height() - 50);
				});
				$("#onlineWrapper").height(cliHei - 50);
				onlineBuyScroll();
			}
			$(".detailCost").height(cliHei);
			$("#costWrapper").height(cliHei-50);
		}
		//在线购买scroll
		function onlineBuyScroll() {
			myScroll = new iScroll('onlineWrapper',{
				checkDOMChanges : true,
				vScrollbar : false
			});
		}
		//价格如何拟定弹窗iscroll
		function detailCostScroll() {
			myScroll = new iScroll('costWrapper',{
				checkDOMChanges : true,
				vScrollbar : false
			});
		}
		//屏幕小于390时价格如何拟定内部头部的导航左右iscroll
		function smallWidScroll() {
			myScroll = new iScroll('costHead',{
				checkDOMChanges : true,
				hScrollbar : false
			});
		}
		//展开价格如何拟定的弹窗
		function showDetialCost(aDays){
			if(cliWid <= 390){
				$(".headUl").width(($(".headUl li").outerWidth() * 3)+10);
				smallWidScroll();
			}
			$(".detailCost").css({
				"-webkit-transform":"translateX(0)",
				"transform:":"translateX(0)"
			});
			detailCostScroll();
			var feeInfoArray = getSelfFeeInfo(aDays).split(":");
			$("#userEndDate").html(" = "+feeInfoArray[1]);
			$("#userEndDateGradeTxt").html(" = "+feeInfoArray[2]);
			$("#feeInfo").html(" = " +feeInfoArray[0]);
		}
		//关闭价格如何拟定的弹窗
		function hideDetailCost(){
			$(".detailCost").css({
				"-webkit-transform":"translateX(100%)",
				"transform:":"translateX(100%)"
			});
		}
		document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
		//返回主界面
		function goHome(module){
			if(confirm(module)){
				alert("确定退出")
			}else{
				alert("取消退出")
			}
		}
	</script>
  </head>
  
<body>
	<div class="nowLoc">
		<!-- span class="backIcon" onclick="goHome('确定退出在线购买?');"></span -->
		<span class="backIcon"></span>
		<p>在线购买</p>
	</div>
	<!-- mainCon halfYear  -->
	<div id="onlineWrapper" class="wrap">
		<div class="scroller clearfix" id="vips">
			<div class="list">
				<div class="listItem halYear">
					<p class="titP">助学网VIP会员学习卡(180天)</p>
					<div class="detailCon">
						<img width=100% class="imgBg" src="Module/appWeb/onlineBuy/images/halfYearBg.png" alt="助学网vip半年学习卡">
						<div class="infoTxt">
							<strong>价格：<span id="price0"></span>元<span class="helpSpan" ontouchend="showDetialCost(180)"></span></strong>
							
							<p>产品增值服务：</p>
							<p>惊喜1：享受180天所有课程的免费学习</p>
							<p>惊喜2：一线课堂网络到时精心录制的全程知识点视频讲解，能够帮你更快更容易的对课堂学习的知识点掌握</p>
							<p>惊喜3：独特的溯源诊断和五步学习法让你彻底学会这个知识点！</p>
						</div>
					</div>
				</div>
				<div class="goBuyDiv">
					<a class="goBuyBtn" href="javascript:void(0)" onclick="goBuy(1)">去购买</a>
					<!--a class="goBuyBtn" href="javascript:void(0)" onclick="window.webView.jsFunction(hello);">去购买</a-->
				</div>
			</div>
			<!-- mainCon OneYear  -->
			<div class="list">
				<div class="listItem oneYear">
					<p class="titP">助学网VIP会员学习卡(365天)</p>
					<div class="detailCon">
						<img width=100% class="imgBg" src="Module/appWeb/onlineBuy/images/oneYearBg.png" alt="助学网vip一年学习卡">
						<div class="infoTxt">
							<strong>价格：<span id="price1"></span>元<span class="helpSpan" ontouchend="showDetialCost(365)"></span></strong>
							<p>产品增值服务：</p>
							<p>惊喜1：享受365天所有课程的免费学习</p>
							<p>惊喜2：一线课堂网络到时精心录制的全程知识点视频讲解，能够帮你更快更容易的对课堂学习的知识点掌握</p>
							<p>惊喜3：独特的溯源诊断和五步学习法让你彻底学会这个知识点！</p>
						</div>
					</div>
				</div>
				<div class="goBuyDiv">
					<a class="goBuyBtn" href="javascript:void(0)" onclick="goBuy(2)">去购买</a>
				</div>
			</div>
		</div>
	</div>
	 <!-- 费用解读说明层  -->
	<div class="detailCost">
		<div class="nowLoc">
			<span class="backIcon" ontouchend="hideDetailCost()"></span>
			<p>帮助文档</p>
		</div>
		<div id="costWrapper">
			<div class="costScroller">
				<div id="costHead" class="costHead">
					<ul class="headUl clearfix">
						<li>
							<div class="topLi">
								<p>半年费用</p>
								<p>￥<%=Constants.PRIMARY_MONEY_HALF %>元</p>
								<p>全年费用</p>
								<p>￥<%=Constants.PRIMARY_MONEY %>元</p>
							</div>
							<div class="botLi">
								<p>小学</p>
								<p>(一年级至六年级)</p>
							</div>
						</li>
						<li>
							<div class="topLi">
								<p>半年费用</p>
								<p>￥<%=Constants.JUNIOR_MONEY_HALF %>元</p>
								<p>全年费用</p>
								<p>￥<%=Constants.JUNIOR_MONEY %>元</p>
							</div>
							<div class="botLi">
								<p>初中</p>
								<p>(七年级至九年级)</p>
							</div>
						</li>
						<li>
							<div class="topLi">
								<p>半年费用</p>
								<p>￥<%=Constants.HIGN_MONEY_HALF %>元</p>
								<p>全年费用</p>
								<p>￥<%=Constants.HIGN_MONEY %>元</p>
							</div>
							<div class="botLi">
								<p>高中</p>
								<p>(高一至高三)</p>
							</div>
						</li>
					</ul>
				</div>
				<div class="costCon">
					<h3><span></span>价格如何拟定</h3>
					<div class="innerDetailCon">
						<p>具体费用解读如下：</p>
						<p>助学网收费系统按照学段收费，不同学段产生的费用也不同，系统会根据当前学生所在的学段，根据基础费用自动计算出平均每天的费用，再结合用户购买天数（累计天数后是否年级增加）来计算当前用户购买半年、一年的实际费用（注：高三年级时间即使超出，年级不会增加，基础费用按照高中年级费用收取）。</p>
						<p class="noteP">注：系统判定学段增加的具体日期为每年8月31日，超过后基础费用自动增加。</p>
						<p>举个范例：</p>
						<p>王同学，购买了半年（180天）的服务，那么计算方式为。</p>
						<p>当前学段基础费用 ：CGP(参考当前学段基础价格表)。</p>
						<p>下一学段基础费用：NGP(参考下一学段基础价格表)。</p>
						<p>当前实际费用 ：TP</p>
						<p>当前学段平均每天费用：CGAP = CGP / 365天。</p>
						<p>下一学段平均每天费用：NGAP = NGP / 365天 。</p>
						<p>如过累计后的日期超过当年的8月31日</p>
						<p>计算出当前日期到当年9月1日相差天数 DD</p>
						<p>TP = DD * CGAP + (180 - DD) * NGAP。</p>
						<p>如过累计后的日期没超过当年8月31日</p>
						<p>TP = CGAP * 180。</p>
						<p>您的费用计算公式</p>
						<p>到期时间  <span id="userEndDate"></span></p>
						<p>到期时间所在年级 <span id="userEndDateGradeTxt"></span></p>
						<p>费用<span id="feeInfo"></span></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
