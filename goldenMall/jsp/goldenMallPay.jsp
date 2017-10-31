<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

<head>
<title>助学网金币商城立即兑换</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/goldenMallPayCss.css" type="text/css" rel="stylesheet"/>
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/goldMallJs.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/selectPC.js"></script>
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/ecmascript"></script>
<script type="text/javascript">
$(function(){
	checkScreenWidth(".head");
	newFixAddress();
	packageAddress();
	//fixedAddress();
	showPC();
	moveLeftRight(455);
});

function packageAddress(){
	var len = $(".addressBox li").length;
	if(len == 0){
		//假如不存在收货地址，页面初始化时候将暂无收货地址的li给加载出来 判断li length
		$(".noAddressLi").show();
	}else{
		//假如存在收货地址，一个地址的情况下 -->页面初始化动态给第一个li增加一个选中状态,并且是默认状态
		mouseHoverAdd();
		$(".addressBox li:first").addClass("nowChoice").removeClass("defBg");
		$(".addressBox li:first .selAddRadio").attr("checked",true);
		$(".addressBox li:first .setAddress").show();//修改地址的按钮的显示
	}
}

//收货地址鼠标移入和移出
function mouseHoverAdd(){
	$(".selAddRadio").each(function(i){
		$(this).click(function(){
			$(".addressBox li").removeClass("nowChoice").addClass("defBg");
			$(this).parent("li").addClass("nowChoice");
			$(".setAddress").hide();
			$(".setAddress").eq(i).show();

		});
	});
}
//修改收货地址val的替换
function exchangeVal(){

}
//新增收货地址按钮的点击事件
//var onOff = true;
function addNewAddress(){
	/*if(onOff){
		$(".newAddBtn").removeClass("newAddBg");
		$(".newAddBtn").addClass("clickAddBtn");
		$(".newAddressBox").slideDown();
		onOff = false;
		getInputVal();
	}else{
		$(".newAddBtn").removeClass("clickAddBtn");
		$(".newAddBtn").addClass("newAddBg");
		$(".newAddressBox").slideUp();
		onOff = true;
		getInputVal();
	}*/
	$(".layer").show();
	$(".newAddressBox").show();
}
//新增收货地址、修改收货地址盒子的input文本框的onfoucs onblur事件
function newFixAddress(){
	var oBuyerName = getId("buyer_Name");
	var oDetailAdd = getId("detailAddress");
	var oEmailNum = getId("emailNum");
	var oTelPhone = getId("telPhone");
	textFocusCheck(oBuyerName,"长度不超过16个字符");
	textFocusCheck(oDetailAdd,"建议您如实填写详细收货地址，例如街道名称、门牌号码");
	textFocusCheck(oEmailNum,"请填写您所在地的邮编号码");
	textFocusCheck(oTelPhone,"请填写有效的手机号码");
}
//增加修改地址各个input里面的默认val值的获取
function getInputVal(){
	$("#buyer_Name").val("长度不超过16个字符");
	$("#detailAddress").val("建议您如实填写详细收货地址，例如街道名称、门牌号码");
	$("#emailNum").val("请填写您所在地的邮编号码");
	$("#telPhone").val("请填写有效的手机号码");
}
//关闭收货地址，修改地址的动作
function closeAddressBox(){
	$(".newAddressBox").hide();
	$(".layer").hide();
	$(".newAddBtn").removeClass("clickAddBtn");
	$(".newAddBtn").addClass("newAddBg");
	//onOff = true;
	getInputVal();
}
//修改收货地址
function fixedAddress(usaId,province,city,messrs,addressDetail,mobile,zip){
	$(".newAddBtn").removeClass("newAddBg");
	$(".newAddBtn").addClass("clickAddBtn");
	$(".layer").show();
	$(".newAddressBox").slideDown();
	onOff = false;
	$("#usaId").val(usaId);
	$("#province").val(province);
	$("#city").val(city);
	$("#buyer_Name").val(messrs);
	$("#detailAddress").val(addressDetail);
	$("#emailNum").val(zip);
	$("#telPhone").val(mobile);		
}

//选择省市
function showPC(){
	init(remote_ip_info["province"],remote_ip_info["city"],"","");
}
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
						<li class="navList active"><a href="javascript:void(0)">金币商城</a></li>
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
	  		<a href="shopManager.do?action=welcome">商品列表 </a> / <a href="shopManager.do?action=proDetail&id=${ip.id}">${ip.productName}</a> / 兑换中心	
	  	</p>
	  </c:forEach>
	</div>
	<!-- 支付盒子  -->
	<div class="goldenPayBox w1000 clearfix">
		<!-- 头像 流程  -->
		<div class="payTop clearfix">
			<div class="topL fl">
			  <c:forEach items="${requestScope.uVOList}" var="user">
			  	<div class="userImgBox fl">
			  		<img src="${pageContext.request.contextPath}/${user.portrait}" width="64" height="64"/>
			  	</div>
			  	<div class="userInfo fl">
				  	<strong class="userNames">${user.username}</strong>
					<p class="goldenNum"><span>金币：</span>${user.coin}</p>
			  	</div>
			  </c:forEach>
			</div>
			<!-- 流程  -->
			<ul class="flowBox fl">
				<li>
					<span class="payNums">01</span>
					<span class="payArrow"></span>
					<p>确认兑换商品信息</p>
				</li>
				<li>
					<span class="payNums">02</span>
					<span class="payArrow"></span>
					<p>完善收货地址信息</p>
				</li>
				<li>
					<span class="payNums">03</span>
					<p>完成商品兑换交易</p>
				</li>
			</ul>
		</div>
		<!-- 商品清单 收货地址管理 立即兑换  -->
		<div class="proPayBox">
			<form id="payForm" action="" method="post">
				<!-- 商品清单  -->
				<p class="tits listProTit"></p>
				<ul class="proList">
					<li class="bor_R">商品名称</li>
					<li class="bor_R">数量</li>
					<li>商品价格</li>
				</ul>
				<c:forEach items="${requestScope.iplist}" var="IP">
				<ul class="proList1 clearfix">
					<li>${IP.productName}</li>
					<li>1</li>
					<li><span class="needGold">${IP.credits}金币</span></li>
				</ul>
				</c:forEach>
				<!-- 完善收货地址  -->
				<div class="confirmAdd">
					<p class="tits addTit"></p>
					<!-- 收货地址  -->
					<ul class="addressBox clearfix">
					  <c:forEach items="${requestScope.usalist}" var="usa">
					    <c:if test="${usa!=null}">
						<!-- 新增收货地址的li卡片结构  -->
						<li class="defBg">
							<input type="radio" name="addRadio" class="selAddRadio" value="${usa.id}"/>
							<div class="topAdd clearfix">
								<p class="fl"><span class="sheng">${usa.province}</span><strong>${usa.city}</strong></p>
								<p class="buyerName fl">(<span class="buyerNameSpan">${usa.messrs}</span>)收</p>
							</div>
							<div class="botAdd">
								<p class="detail_Add">${usa.addressDetail}</p>
								<p><span class="phoneNum">${usa.mobile}</span>邮编：<span class="mailNum">${usa.zip}</span></p>
							</div>
							<input type="hidden" id="addrName" value="${usa.province}${usa.city}${usa.addressDetail}${usa.messrs}${usa.mobile}"/>
							<a class="setAddress" href="javascript:void(0)" 
							   onclick="fixedAddress(${usa.id},'${usa.province}','${usa.city}','${usa.messrs}','${usa.addressDetail}','${usa.mobile}','${usa.zip}')">修改</a>
							<c:if test="${usa.defaultFlag==1}">
								<span class="defauleAdd">默认地址</span>
							</c:if>
						</li>
						</c:if>
						<c:if test="${usa==null}">
							<!-- 不存在收货地址的情况下  -->
							<li class="noAddressLi">
								<div class="noAddIconTxt">
									<img src="Module/goldenMall/images/noAddressPic.png"/>
									<p>系统检测您暂无收货地址，请点击下方“增加新地址”按钮来添加收货地址~</p>
								</div>
							</li>
						</c:if>
					  </c:forEach>
					</ul>
					<!-- 增加新地址  -->
					<a class="newAddBtn newAddBg" href="javascript:void(0)" onclick="addNewAddress()">增加新地址</a>
					<!--  填写新增收货地址的盒子  -->
					<div class="newAddressBox">
						<input type="hidden" id="usaId">
						<div class="comDivBox">
							<span>姓<span class="oneBlank"></span>名：</span><input id="buyer_Name" type="text" value="长度不超过16个字符" maxlength="16" class="comInp wid1"/>
						</div>
						<div class="comDivBox">
							<span>所在地区：</span>
							<select id="province"></select>
							<select id="city"></select>
						</div>
						<div class="comDivBox">
							<span>详细地址：</span><input id="detailAddress" type="text" value="建议您如实填写详细收货地址，例如街道名称、门牌号码" class="comInp wid2"/>
						</div>
						<div class="comDivBox">
							<span>邮政编码：</span><input id="emailNum" type="text" value="请填写您所在地的邮编号码"  maxlength="6" class="comInp wid1"/>
						</div>
						<div class="comDivBox">
							<span>手机号码：</span><input id="telPhone" type="text" value="请填写有效的手机号码" maxlength="11" class="comInp wid1"/>
						</div>
						<!-- 新增 修改地址的确定和取消按钮  -->
						<div class="btnBox">
							<a class="comBtn" href="javascript:void(0)" onclick="saveAddress()">保存</a>
							<a class="comBtn" href="javascript:void(0)" onclick="closeAddressBox()">取消</a>
						</div>
						<span class="closeAddBox" onclick="closeAddressBox()"></span>
					</div>
				</div>
				<!-- 兑换交易扣除金币 立即兑换-->
				<div class="payGoldenBox">
				  <c:forEach items="${requestScope.uVOList}" var="user">
					<p class="tits buyTit"></p>
					<c:forEach items="${requestScope.iplist}" var="Ip">
					<div class="deductGolden">
						<p>扣除金币：<strong class="deductNums">${Ip.credits}</strong></p>
					</div>
					<a href="javascript:void(0)" class="goBuyNow" onclick="exchangeIP(${Ip.id},'${Ip.productName}',${Ip.credits},${user.coin})">立即兑换</a>
					</c:forEach>
				  </c:forEach>
				</div>
			</form>
		</div>
	</div>
	<!-- 遮罩层  -->
	<div class="layer"></div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
</body>
</html>
