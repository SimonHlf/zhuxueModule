<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>在线支付</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/onlineBuy/css/onlinePay.css" type="text/css" rel="stylesheet"/>
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript" ></script>
	<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
	<script type="text/javascript" src="Module/appWeb/onlineBuy/js/onlineBuyApp.js"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
	    var vid = ${requestScope.vid};
	   // var oNuber = ${requestScope.oNuber};
		var cliHei = document.documentElement.clientHeight;
		var myScroll;
		var payFlag = true;
		var userId = "${sessionScope.userId}";
		var roleId = "${sessionScope.roleId}";
		var loginStatus = "${sessionScope.loginStatus}";
		$(function(){
			initHei();
			selCheckBox();
			comRadio();
			onlinePayScroll();
			detailPay(vid);
			getSelfCoin("coinYp");
		});
		function initHei(){
			var discountBoxHei = $(".discountBox").height();
			var yuanpeiBoxHei = $(".yuanpeiBox").height();
			var itemTitHei = $(".itemTit").height();
			$(".countLayer").height(discountBoxHei - itemTitHei);
			$(".yuanpeiLayer").height(discountBoxHei - itemTitHei);
			$(".bigWrap").height(cliHei - 50);
			$("#innerWrap").height($(".bigWrap").height() - $(".payBtnBox").height());
		}
		//优惠券圆培币选择使用的点击
		function selCheckBox(){
			$(".onoffswitch-label").each(function(i){  
			  	$(this).on('touchend',function(){ 
				  	var checkStatus = $("#myonoffswitch"+i).prop("checked");
				  	if(checkStatus){
						setTimeout(function(){
							$(".comInner").eq(i).hide();
							if(i==0){
								var oldPrice=parseInt($("#payable").text());
								var fValue=parseInt($("#yVip").text());
								$("#payable").text(oldPrice + fValue);
								$("#vipAcc").val("");
								$("#vipPass").val("");
								$("#vipPass").val("");
								$("#yVip").text("0");
								
							}else{
								var oldPrice=parseInt($("#payable").text());
								var fValue=parseInt($("#uYp").val());
								if(isNaN(fValue)){
									fValue=0;
								}
								$("#payable").text(oldPrice + fValue);
								$("#uYp").val("");
							}
							
						},300);
				  		
				  	}else{
						setTimeout(function(){
							$(".comInner").eq(i).show();
						},300);
				  		
				  	}
				}); 
			});
		}
		//选择支付方式radio点击
		function comRadio(){
			$(".comPayLabel").each(function(i){
				$(this).on("touchend",function(){
					if(payFlag){
						$(".comCirSpan").addClass("cirSty_space").removeClass("cirSty_full");
						$(".comCirSpan").eq(i).removeClass("cirSty_space").addClass("cirSty_full")
					}
				});
			});
		}
		//在线支付的iscroll
		function onlinePayScroll() {
			myScroll = new iScroll('innerWrap', { 
				checkDOMChanges: true,
				vScrollbar : false,
				onScrollMove : function(){
					payFlag = false;
				},
				onScrollEnd : function(){
					payFlag = true;
				}
			});
				
		}
		document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
		function showInfoDiv(option){
			if(option == 1){
				$(".disAccBox").show().stop().animate({"opacity":1}).css({"top":(cliHei - $(".disAccBox").height())/2});
			}else if(option == 2){
				$(".yuanPeiBox").show().stop().animate({"opacity":1}).css({"top":(cliHei - $(".yuanPeiBox").height())/2});
			}
			$(".layer").show();
		}
		function closeInfoDiv(option){
			if(option == 1){
				$(".disAccBox").animate({"opacity":0},function(){
					$(".disAccBox").hide();
					$(".layer").hide();
				});
			}else if(option == 2){
				$(".yuanPeiBox").animate({"opacity":0},function(){
					$(".yuanPeiBox").hide();
					$(".layer").hide();
				});
			}
		}
		function goBack(){
			//window.location.href = "OnlineBuyApp.do?action=goOnlineBuy&userId="+userId+"&roleId="+roleId+"&loginStatus="+loginStatus+"&cilentInfo=appInit";
			window.history.back();
		}
		function goPay(){
			var yvip=$("#yVip").text();//优惠劵金额
			var payable=$("#payable").text();//实付金额
			var uyp=$("#uYp").val();//元培币个数
			var vipAcc =$("#vipAcc").val();//优惠劵卡号
			var vipPass =$("#vipPass").val();//优惠劵密码
			var bank;
			var buy_type;
			if($("input:radio:checked").attr("id")=="aLiPay"){
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("暂不支持支付宝支付");
				commonTipInfoFn($(".warnInfoDiv"));
				return;
			}else{
				bank="微信支付";
				buy_type=2;
			}
			if(checkLoginStatus()){
				$.ajax({
					type:"post",
					async:false,
					dataType:"json",
					url:"OnlineBuyApp.do?action=addVipCardOrders&vipAcc="+vipAcc+"&vipPass="+vipPass+"&uyp="+uyp+"&payable="+payable+"&vid="+vid+"&buytype="+buy_type+"&bank="+bank+"&cilentInfo=app",
					success:function(json){
						if(json){
							$(".succImg").show();
							$(".tipImg").hide();
							$("#warnPTxt").html("订单生成成功,请到订单中心支付");
							commonTipInfoFn($(".warnInfoDiv"),function(){
								goBack();
							});
						}else{
							$(".succImg").hide();
							$(".tipImg").show();
							$("#warnPTxt").html("订单生成失败");
							commonTipInfoFn($(".warnInfoDiv"),function(){
								goBack();
							});
						}
						
					}
				});
			}
			//$("#warnPTxt").html("支付接口正在申请中...");
			//commonTipInfoFn($(".warnInfoDiv"));
		}
	</script>
  </head>
  
	<body>
		<div class="nowLoc">
			<span class="backIcon" ontouchend="goBack()"></span>
			<p>在线购买订单详情</p>
		</div>
		<div class="bigWrap">
			<div id="innerWrap">
				<div class="innerScroller">
					<div class="payHead">
						<img id="vipPic" class="fl" width="100" src="Module/appWeb/onlineBuy/images/halfYear.png"/>
						<div class="fl">
							<strong><span id="viName"></span></strong>
							<p>价格：￥<span id="viPrice"></span>元</p>
						</div>
					</div>
					<!-- 优惠券盒子 -->
					<div class="discountBox">
						<div class="itemTit">
							<span></span>使用优惠券
							<em class="helpIcon" ontouchend="showInfoDiv(1)"></em>
							<div class="onoffswitch posOnOff">
							    <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch0">
							    <label class="onoffswitch-label" for="myonoffswitch0"></label>
							</div>
						</div>
						<div class="comInner innerDiscount">
							<p>提示：每次购买只能使用一张优惠券</p>
							<ul>
								<li>
									<span>请输入您的优惠券卡号：</span><input class="cardPasInp" id="vipAcc" type="text" placeholder="输入优惠券卡号" maxlength="6" />
								</li>
								<li>
									<span>请输入您的优惠券密码：</span><input class="cardPasInp" id="vipPass" type="text" placeholder="输入优惠券密码" maxlength="20" onkeyup="input_onkeyup()" />
								</li>
								<li>您当前优惠券的面额是<strong id="valiVip"><span id="yVip">0</span>元</strong></li>
							</ul>
						</div>
					</div>
					<!-- 圆培币盒子 -->
					<div class="yuanpeiBox">
						<div class="itemTit">
							<span></span>使用圆培币
							<em class="helpIcon" ontouchend="showInfoDiv(2)"></em>
							<div class="onoffswitch posOnOff">
							    <input type="checkbox" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch1">
							    <label class="onoffswitch-label" for="myonoffswitch1"></label>
							</div>
						</div>
						<div class="comInner innerYuanpei">
							<p>系统检测到您目前共有<span id="yCoin">0</span>个圆培币</p>
							<ul>
								<li>
									<span>使用圆培币个数：</span><input type="text" id="uYp" onkeyup="getFinalPrice(this)"  class="yuanpeiInp" placeholder="输入圆培币个数" />
								</li>
							</ul>
						</div>
					</div>
					<!-- 选择支付方式 -->
					<div class="payMent">
						<div class="itemTit">
							<span></span>选择支付方式
						</div>
						<div class="innerPayStyle">
							<ul>
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
				</div>
			</div>
			<!-- 支付按钮 -->
			<div class="payBtnBox">
				<p>应付金额：<span>￥<span id="payable"></span>元</span></p>
				<a class="payBtn" href="javascript:void(0)" ontouchend="goPay()">生成订单</a>
			</div>
		</div>
		<!-- 优惠券说明  -->
		<div class="comIntroBox disAccBox">
			<!-- 头部装饰  -->
			<div class="titDec"><span class="comSpanDec lDecSpan"></span><span class="comSpanDec rDecSpan"></span></div>	
			<!-- 头部  -->
			<div class="titHead">
				<h3>优惠券</h3>
				<p>温馨提示：使用前请确认有效期</p>
			</div>	
			<!-- 优惠券介绍文字层  -->
			<div class="infoTxtDiv">
				<p>1.助学网优惠券是线下发给各个用户的一种实体卡；</p>
				<p>2.持优惠券者可以通过卡券上的账号和密码在购买助学网年限Vip上抵挡现金使用；</p>
				<p>3.购买助学网年限vip进行付款支付时只能使用一张优惠券且每张优惠券只能使用一次；</p>
				<p>4.每张优惠券的有效期限为一年；</p>
				<a class="knowBtn" href="javascript:void(0)" ontouchend="closeInfoDiv(1)">我知道了</a>
			</div>
		</div>
		<!-- 圆培币介绍说明  -->
		<div class="comIntroBox yuanPeiBox">
			<!-- 头部装饰  -->
			<div class="titDec"><span class="comSpanDec lDecSpan"></span><span class="comSpanDec rDecSpan"></span></div>	
			<!-- 头部  -->
			<div class="titHead">
				<h3>圆培币</h3>
				<p>温馨提示：圆培币不可以转让或提现</p>
			</div>	
			<!-- 优惠券介绍文字层  -->
			<div class="infoTxtDiv">
				<p>1.圆培币是在在线商城可以兑换实物商品的一种虚拟币；</p>
				<p>2.学生用户可以通过在线答题获得的金币进行兑换，兑换圆培币的比例为1:1000；</p>
				<p>3.圆培币可在在线商城兑换学习用品、其他类实物奖品或购买年卡抵消现金使用</p>
				<p>4.金币、圆培币的使用期限为永久有效；</p>
				<a class="knowBtn" href="javascript:void(0)" ontouchend="closeInfoDiv(2)">我知道了</a>
			</div>
		</div>
		<div class="layer"></div>
		<!-- 提示信息层  -->
		<div class="warnInfoDiv longDiv">
			<img class="succImg" src="Module/appWeb/onlineStudy/images/succIcon.png"/>
			<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
			<p id="warnPTxt" class="longTxt"></p>
		</div>
		<div id="loadDataDiv" class="loadingDiv">
			<p>数据加载中...</p>
		</div>
	</body>
</html>
