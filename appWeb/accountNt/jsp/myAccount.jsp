<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>我的账户</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/appWeb/accountNt/css/myAccount.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/appWeb/accountNt/js/myAccount.js"></script>
	<script type="text/javascript">
	var noDataFlag = false;
	var bankFlag = true;//新增或者修改银行卡弹层flag
	var tmpBankFlag = false;
	//var pullScroll = true;
	var myScroll,pullUpEl, pullUpOffset;
	var txFlag = true;
	var buyFlag = true;
	var wrapperObj = "infoDiv_incWrap";
	var tmpBankVal = "";
	var userId = "${sessionScope.userId}";
	var loginStatus = "${sessionScope.loginStatus}";
	var option_a = "account";//默认为我的账户
	var pageNo_1 = 1;//收支页面
	var pageNo_2 = 1;//提现页面
	var pageNo_3 = 1;//购买记录页面
	var pageSize = 3;
	var baseMoney = "${requestScope.baseMoney}";
	var cliWid = document.documentElement.clientWidth;
	var cliHei = document.documentElement.clientHeight;
	$(function(){
		calLiWid();
		getSelfAccount(option_a,"init");
	});
	</script>
  </head>
  
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon"></span>
		<p class="titP">我的账户</p>
	</div>
	<!-- 导航  -->
	<div class="accNav">
		<ul>
			<li id="li_account" class="active" ontouchend="getSelfAccount('account','init');">我的账户</li>
			<li id="li_income" ontouchend="getSelfAccount('income','init')">收入明细</li>
			<li id="li_tx" ontouchend="getSelfAccount('tx','init')">提现记录</li>
			<li id="li_buy" ontouchend="getSelfAccount('buy','init')">购买记录</li>
		</ul>
	</div>
	<!-- 对应数据层  -->
	<div id="accountInfo">
		<div id="scroller">
			<!-- 我的账户  -->
			<div id="infoDiv_account" class="accountType" style="display:block;"></div>
			<!-- 收入明细  -->
			<div id="infoDiv_income" class="accountType">
				<div class="titDiv">
					<span class='titIcon fl'></span>
					<p class="fl" id="titleInfo"></p>
				</div>
				<div id="infoDiv_incWrap">
					<div id="scroller_inc" class="scroller">
						<!-- 数据层  -->
						<ul id="infoDiv_con_income"></ul>
						<div id="pullUp">
							<span class="pullup-icon"></span>
							<span class="pullUpLabel">上拉加载更多...</span>
						</div>
					</div>
				</div>
			</div>
			<!-- 提现记录  -->
			<div id="infoDiv_tx" class="accountType">
				<div id="scroller_tx" class="scroller">
					<!-- 数据  -->
					<ul id="infoDiv_con_tx"></ul>
				</div>
			</div>
			<!-- 购买记录  -->
			<div id="infoDiv_buy" class="accountType">
				<div id="scroller_buy" class="scroller">
					<!-- 数据  -->
					<ul id="infoDiv_con_buy"></ul>
				</div>
			</div>
		</div>
	</div>
	<!-- 申请提现弹窗  -->
	<div id="applyWindow">
		<div class="detailTit">
			<a class="goBackBtn fl" href="javascript:void(0)" ontouchend="goBackTx()"><span></span>返回</a>
			<p>申请提现</p>
		</div>
		<!-- 提现数据层  -->
		<div id="applyConDiv"></div>
	</div>
	<!-- 更换银行层  -->
	<div class="changeBank">
		<div class="detailTit">
			<a class="goBackBtn fl" href="javascript:void(0)" ontouchend="goBack()"><span></span>返回</a>
			<p class="fixChangeTit">更换银行</p>
			<a class="compBtn" href="javascript:void(0)" ontouchend="saveBankName()">完成</a>
		</div>
		<div id="bankWrapper">
			<div class="bankScroller">
				<ul class="bankMidWinDiv">
	    			<li>
	    				<span class="comBankIcon icbcIcon"></span>
	    				<p>中国工商银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国工商银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon abcIcon"></span>
	    				<p>中国农业银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国农业银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon ccbIcon"></span>
	    				<p>中国建设银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国建设银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon cmbIcon"></span>
	    				<p>招商银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="招商银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon bocIcon"></span>
	    				<p>中国银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon psbcIcon"></span>
	    				<p>中国邮政储蓄银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国邮政储蓄银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon commIcon"></span>
	    				<p>交通银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="交通银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon citicIcon"></span>
	    				<p>中信银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中信银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon cmbcIcon"></span>
	    				<p>中国民生银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国民生银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon cebIcon"></span>
	    				<p>中国光大银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国光大银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon cibIcon"></span>
	    				<p>兴业银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="兴业银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon spdbIcon"></span>
	    				<p>浦发银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="浦发银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon gdbIcon"></span>
	    				<p>广发银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="广发银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon hxbankIcon"></span>
	    				<p>华夏银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="华夏银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon shbankIcon"></span>
	    				<p>上海银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="上海银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    			<li>
	    				<span class="comBankIcon shnsbankIcon"></span>
	    				<p>上海农商银行</p>
	    				<input type="radio" class="com_BankRdio" name="bankRadio" value="上海农商银行"/>
	    				<span class="comCirSpan"></span>
	    			</li>
	    		</ul>
			</div>
		</div>
	</div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="succImg" src="Module/appWeb/onlineStudy/images/succIcon.png"/>
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
</body>
</html>
