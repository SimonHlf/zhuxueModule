<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
<head>
<title>助学网网络导师列表</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/appWeb/ntlist/css/netTeacherListApp.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/account/registerPage/js/GlobalProvinces_main.js" type="text/javascript"></script>
<script type="text/javascript" src="Module/account/registerPage/js/GlobalProvinces_extend.js" type="text/javascript"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
<script type="text/javascript" src="Module/appWeb/ntlist/js/ntListApp.js"></script>
<script type="text/javascript" src="Module/commonJs/location.js"></script>
<script type="text/javascript">
	//var comUID = "${sessionScope.userId}";
	var myScroll,
	pullUpEl, pullUpOffset,
	generatedCount = 0;
	var pageNo=0;
	var cliWid = document.documentElement.clientWidth;
	var cliHei = document.documentElement.clientHeight;
	//模拟select获取省市区
	var selectProv_G = "prov";
	var selectCity_G = "city";
	var selectCounty_G = "county";
	var selectTown_G = "town";
	var address_G = "";
	var listFlag = true;
	var provFlag = true;
	var cityFlag = true;
	var goProvFlag = true;
	var goCityFlag = true;
	var payFlag = true;
	$(function() {
		//init(remote_ip_info["province"],"","","","prov_sel","","","");
		init(getAddressByIp("prov").split(",")[0],"","","","prov_sel","","","");
		ntList(2,1,"init");
		ntListSubject();
		$("#subjLayer").height(cliHei - 50);
		$(".comLocLayer").height(cliHei - 95);
		showSubBg(); //选择学科下每个科目对应的背景图
		payScroll();
	});
</script>
</head>
<body>
	<%--<input type="hidden" id="comUserID" >--%>
	<input type="hidden" id="dySubID" value="2">
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon"></span>
		<p>导师列表</p>
		<div class="subjDiv">
			<span id="subjSpan">数学</span>
			<span id="spanTri"><span class="triSpan topTri"></span></span>
		</div>
	</div>   
	<%--选择学科数据层--%>
	<div id="stuSubWrapper">
		<ul id="stuSub" class="clearfix"></ul>
	</div>
	<%--定位(省市)--%>
	<div class="location">
    	<div id="prov" class="comLocDiv">
	   		<span id="provTri" class="comTriBotCol"></span>
	   		<span class="triIcon"></span>
			<span id="prov_sel">选择省/市</span>
     	</div>
		<!-- 市  -->
		<div id="city" class="comLocDiv">
			<span class="triIcon"></span>
			<span id="city_sel">选择市</span>
		</div>
		<div class="searDiv fr">
			<input id="ntName" class="removeAFocBg" type="text" placeholder="输入查询导师名字...">
			<a href="javascript:void(0)" class="searBtn" ontouchend="ntList('',1,'init')"><span></span></a>
		</div>
	</div>
	<!-- 省对应的数据  -->
	<div id="provData" class="dataBox">
		<div class="comLocScroll">
			<ul id="provDataUl" class="clearfix"></ul>
			<div class="comDecDiv"></div>
		</div>
		<span class="shadowSpan"></span>
	</div>
	<!-- 市对应的数据  -->
	<div id="cityData" class="dataBox">
		<div class="comLocScroll">
	    	<ul id="cityDataUl" class="clearfix"></ul>
	    	<div class="comDecDiv"></div>
	   </div>
	   <span class="shadowSpan"></span>
    </div>
    <!-- 导师列表层  -->
	<div id="wrapper" class="comLocLayer">
		<div id="scroller">
			<ul id="thelist"></ul>
			<div id="pullUp">
				<span class="pullup-icon"></span>
				<span class="pullUpLabel">上拉加载更多...</span>
			</div>
		</div>
	</div>
	<input type="hidden" id="new_ntsID">
	<!-- layer层  -->
	<div id="subjLayer"></div>
	<div id="locLayerProv" class="comLocLayer"></div>
	<div id="locLayerCity" class="comLocLayer"></div>	
	<!-- 支付层  -->
	<div class="payWinDiv">
		<div class="detailTit">
			<a class="goBackBtn fl" href="javascript:void(0)" ontouchend="goBack()"><span></span>返回</a>
			<p class="fl">绑定支付窗口</p>
		</div>
		<div id="payWrapper">
			<div class="payScroller">
				<p class="ntInfoTit">导师基本信息</p>
				<ul class="listPayTit">
					<li><span></span><i id="ntRealName"></i>老师</li>
					<li><span></span><i id="subName"></i></li>
					<li><span></span><i id="bMoney"></i>元</li>
				</ul>
				<p class="ypTit">使用元培币</p>
				<div class="ypCoinP">
					<span>元培币抵消</span>
					<input class="txtInp" type="text" id="ypNum" onkeyup="getFinalPrice(this)"/>
					<p><span></span>共拥有元培币<i id="ypCoin">0</i>枚</p>
				</div>
				<input id="payWayHidInp" type="hidden"/>
				<p class="selPayWayTit">选择支付方式</p>
				<ul class="payWayUl">
					<li>
						<label class="comPayLabel" for="aLiPay">
							<input type="radio" name="payStyRadio" id="aLiPay" class="comPayStyRad" />
						</label>
						<img width="30" src="Module/appWeb/onlineBuy/images/aLiPay.png" alt="支付宝支付">
						<div class="payStyTxt fl">
							<strong>支付宝支付</strong>
							<p>推荐拥有支付宝账户的用户使用</p>
						</div>
						<span class="comCirSpan cirSty_space"></span>
					</li>
					<li>
						<label class="comPayLabel" for="weixinPay">
							<input type="radio" name="payStyRadio" id="weixinPay" class="comPayStyRad" checked="checked"/>
						</label>
						<img width="30" src="Module/appWeb/onlineBuy/images/weixinPay.png" alt="微信支付">
						<div class="payStyTxt fl">
							<strong>微信支付</strong>
							<p>推荐安装微信5.0及以上版本的用户使用</p>
						</div>
						<span class="comCirSpan cirSty_full"></span>
					</li>
				</ul>
			</div>
		</div>
		<div class="payWayBot">
			<p>应付金额：<span>￥<span id="realVal"></span>元</span></p>
			<a href="javascript:void(0)" onclick="genOrder()">生成订单</a>
		</div>
	</div>
	<!-- confirm模拟层试用 -->
	<div id="freeBindDiv" class="confirmDiv">
		<p class="confirTxt">确定绑定该导师？</p>
		<div class="confirBtn">
			<a id="freeSureBtn" class="sureBtn removeAFocBg" href="javascript:void(0)">确定</a>
			<a class="cancelBtn removeAFocBg" href="javascript:void(0)" ontouchend="closeConfirmWin()">取消</a>
		</div>
	</div>
	<!-- confirm模拟层绑定成功转换其他导师 -->
	<div id="changeNtDiv" class="confirmDiv">
		<p class="confirTxt">确定取消绑定该导师？</p>
		<div class="confirBtn">
			<a id="changeSureBtn" class="sureBtn removeAFocBg" href="javascript:void(0)">确定</a>
			<a class="cancelBtn removeAFocBg" href="javascript:void(0)" ontouchend="closeConfirmWin()">取消</a>
		</div>
	</div>
	<!-- confirm点击确定后的提示信息层  -->
	<div class="tipInfoBox">
		<div class="iconDiv"><span></span></div>
		<div class="innerCon"><p></p></div>
	</div>
	<div class="bigLayer"></div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<img class="succImg" src="Module/appWeb/onlineStudy/images/succIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
