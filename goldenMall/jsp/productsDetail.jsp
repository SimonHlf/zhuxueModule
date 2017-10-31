<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

<head>
<title>助学网商品详情</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/goldenCommon.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/productDetailCss.css" type="text/css" rel="stylesheet"/>
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/goldMallJs.js"></script>
<script type="text/javascript">
$(function(){
	checkScreenWidth(".head");
	moveLeftRight(455);
	moveTopBottom(12);
});
//立即兑换
function goExchange(ipId){
	window.location.href = "shopManager.do?action=goldenMallPay&ipId="+ipId;
}
window.onscroll = function(){
	var oBackTop = getId("backTop");
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	if(scrollTop<450){
		$(".leftRank").removeClass("addFixed");
		$(".rightHead").removeClass("addFixed");
		$(".exchangeBtn").hide();
		if(scrollTop==0){
			$(".backTop").hide();
			$(".rankImg").show(150);
		}
	}else{
		$(".leftRank").addClass("addFixed");
		$(".rightHead").addClass("addFixed");
		$(".exchangeBtn").show();
		$(".backTop").show();
		if(scrollTop>=parseInt(($(".imgTxtBox").height())/2)){
			$(".rankImg").hide(150);
		}else{
			$(".rankImg").show(150);
		}
	}
};
</script>
</head>
  
<body>
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
					<li id="markLayer" style="left:455px;"></li>
					<li class="navList"><a href="userManager.do?action=goPage">首页</a></li>
					<li class="navList"><a href="studyOnline.do?action=load">在线答题</a></li>
					<li class="navList"><a href="personalCenter.do?action=welcome">个人中心</a></li>
					<c:if test="${sessionScope.roleName == '学生' }">
						<li class="navList"><a href="javascript:void(0)" onclick="ntList()">导师列表</a></li>
						<li class="navList"><a href="onlineBuy.do?action=load">在线购买</a></li>
						<li class="navList"><a href="javascript:void(0)">金币商城</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<!-- 面包屑导航  -->
	<div class="smallNav w1000">
	  <c:forEach items="${requestScope.iplist}" var="ip">
	  	<p class="autoBox">
	  		<span class="triangDec"></span>
			<a href="shopManager.do?action=welcome">返回商品列表 </a> / ${ip.productName}
		</p>
	  </c:forEach>
	</div>
	<div></div>
	<!-- 商品详情 -->
	<div class="topProDetail w1000 clearfix">
		<!-- 左侧分导航  -->
		<div class="sectionL fl">
			<!-- 头部  -->
			<div class="goldTop">
				<c:forEach items="${requestScope.uVOList}" var="user">
					<div class="imgUserBox">
						<img src="${pageContext.request.contextPath}/${user.portrait}" width="68" height="68"/>
					</div>
					<strong class="userNames">${user.username}</strong>
					<div class="goldenBox">
						<p class="goldenNum">金币：<span>${user.coin}</span></p>
						<span class="decIcon"></span>
					</div>
			    </c:forEach>
			</div>
			<!-- 中间列表导航  -->
			<div class="navList_1">
				<ul>
					<li class="active">
						<span class="comIcon proListIcon"></span>
						<a href="shopManager.do?action=welcome">返回商品列表</a>
					</li>
					<li>
						<span class="comIcon ordIcon"></span>
						<a href="shopManager.do?action=orderDetail">我的订单详情</a>
					</li>
					<li>
						<span class="comIcon goldsIcon"></span>
						<a href="shopManager.do?action=goldenDetail">我的金币详情</a>
					</li>
					<li>
						<span class="comIcon addMagIcon"></span>
						<a href="shopManager.do?action=deliveryAddManager">收货地址管理</a>
					</li>
					<li>
						<span class="comIcon queIcon"></span>
						<a href="shopManager.do?action=usualQuestion">常见问题</a>
					</li>
				</ul>
				<span id="moveBor" class="borL top1"></span>
			</div>
		</div>
		<!-- 右侧金币兑换产品区  -->
		<div class="sectionR fl">
		  <c:forEach items="${requestScope.iplist}" var="IP">
			<!-- 产品图片  -->
			<div class="proImgBox fl">
				<img src="Module/goldenMall/images/proImg.jpg"/>
				<!--  img src="${pageContext.request.contextPath}/${IP.thumbnail}"/>-->
			</div>
			<!-- 产品描述  -->
			<div class="proDetails fr">
				<h2 class="proTit">${IP.productName}</h2>
				<p class="prodetails">${IP.productInfo}</p>
				<div class="goldBox">
					<p class="price">所需金币：<span class="nums">${IP.credits}金币</span></p>
					<div class="clearfix">
						<p class="stock fl">库存数量：<span>${IP.stocks}</span>件</p>
						<p class="buyNum fl">已购买人数：<span>${requestScope.buyNo}</span>人</p>
					</div>
				</div>
				<div class="freePackage">运费：包邮</div>
				<a href="javascript:void(0)" class="goBuyBtn" onclick="goExchange(${IP.id})">立即兑换</a>
			</div>
		  </c:forEach>
		</div>
	</div>
	<div class="midProDetail w1000 clearfix">
		<!-- 左侧侧兑换排行 兑换及时播报  -->
		<div class="leftRank fl">
			<div class="rankHead">兑换排行</div>
			<div class="rankCon">
				<ul>
				  <c:forEach items="${requestScope.ipRankList}" var="ipRank" begin="0" end="4" varStatus="status">
				   <c:set var="index" value="${status.index}"></c:set>
				    <li class="clearfix">
						<span class="rankNum hotRank fl">0${index+1}</span>
						<a class="rankImgBox fl" href="shopManager.do?action=proDetail&id=${ipRank.id}">
							<img class="rankImg" src="Module/goldenMall/images/rankImg.jpg">
							<!--  img class="rankImg" src="${pageContext.request.contextPath}/${ipRank.thumbnail}">-->
							<span class="rankProName">${ipRank.productName}</span>
							<span class="goldens">${ipRank.credits}金币</span>
						</a>
					</li>
				  </c:forEach>
				</ul>
			</div>
		</div>
		<!-- 右侧商品详情图片文字信息 -->
		<div class="rightInfos fr">
		  <c:forEach items="${requestScope.iplist}" var="Ip">
			<!-- 头部  -->
			<div class="rightHead">
				<!-- fixed定位下的立即兑换按钮  -->
				<a href="javascript:void(0)" class="exchangeBtn" onclick="goExchange(${Ip.id})"></a>
			</div>
			<!-- 图片文字信息  -->
			<div class="imgTxtBox">
				${Ip.productInfo}
				<p>科技智能饮水杯，触摸感应、温度感应、自动提醒喝水</p>
				<img src="Module/goldenMall/images/ceshi1.jpg"/>
				<p>科技智能饮水杯，触摸感应、温、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水、温度感应、自动提醒喝水度感应、自动提醒喝水</p>
				<img src="Module/goldenMall/images/ceshi2.jpg"/>
				<p>科技智能饮水杯，触摸感应、温度感应、自动提醒喝水</p>
				<img src="Module/goldenMall/images/ceshi3.jpg"/>
			</div>
		  </c:forEach>
		</div>
	</div>
	<!-- 返回顶部  -->
	<a id="backTop" href="javascript:scroll(0,0)" class="backTop"></a>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
</body>
</html>
