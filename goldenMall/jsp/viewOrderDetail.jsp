<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

<head>
<title>助学网查看订单详情</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/goldenCommon.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/viewDetailCss.css" type="text/css" rel="stylesheet"/>
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/goldMallJs.js"></script>
<script type="text/javascript">
$(function(){
	checkScreenWidth(".head");
	moveTopBottom(42);
	$(".listCon tr:odd").addClass("oddColor");
});
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
					<li class="navList"><a href="javascript:void(0)" onclick="backIndex()">首页</a></li>
					<li class="navList"><a href="studyOnline.do?action=load">在线答题</a></li>
					<li class="navList"><a href="personalCenter.do?action=welcome">个人中心</a></li>
					<c:if test="${sessionScope.roleName == '学生' }">
						<li class="navList"><a href="javascript:void(0)" onclick="ntList()">导师列表</a></li>
						<li class="navList"><a href="javascript:void(0)">在线购买</a></li>
						<li class="navList active"><a href="javascript:void(0)">金币商城</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<!-- 主要核心内容  -->
	<div class="goldWrap w1000 clearfix">
		<!-- 左侧分导航  -->
		<div class="sectionL fl">
			<!-- 头部  -->
			<div class="goldTop">
				<img src="Module/welcome/images/ceshi1.jpg" width="50" height="50"/>
				<strong class="userNames fl">李明臣</strong>
				<span class="goldenNum fl">124544</span>
			</div>
			<!-- 中间列表导航  -->
			<div class="navList">
				<ul>
					<li>
						<a href="shopManager.do?action=welcome">商品列表</a>
					</li>
					<li class="active">
						<a href="javascript:void(0)">我的订单详情</a>
					</li>
					<li>
						<a href="shopManager.do?action=goldenDetail">我的金币详情</a>
					</li>
					<li>
						<a href="shopManager.do?action=deliveryAddManager">收货地址管理</a>
					</li>
					<li>
						<a href="shopManager.do?action=usualQuestion">常见问题</a>
					</li>
				</ul>
				<span id="moveBor" class="borL top2"></span>
			</div>
		</div>
		<!-- 右侧订单详情区  -->
		<div class="sectionR rMinHei fl">
			<!-- 头部  -->
			<div class="detailHead">
				<h2 class="orBg">查看订单详情</h2>
			</div>
			<div class="viewDetailWrap">
				<!-- 订单概况  -->
				<div class="comModBox">
					<strong class="modTit">订单概况</strong>
					<div class="detailBox">
						<p class="comPstyle">订单号：123456789012 <span class="tradeState">交易状态：已完成</span></p>
						<p class="comPstyle">订单金额：15368金币</p>
						<p class="comPstyle">发货仓库：河南濮阳</p>
						<p class="comPstyle">收货信息：黄利峰,18790958171,河南省 濮阳市 华龙区 孟轲乡 濮东产业集聚区新东路北华龙区科技创业园濮阳亮宇实业</p>
						<p class="comPstyle">支付方式：助学网金币</p>
						<p class="comPstyle">送货方式：快递送货上门</p>
					</div>
				</div>
				<!-- 订单跟踪  -->
				<div class="comModBox">
					<strong class="modTit">订单跟踪</strong>
					<div class="detailBox">
						<!-- 跟踪状态  -->
						<div class="fllowStateBox">
							<div class="stateBoxPar">
								<ul class="clearfix">
									<li>
										<span class="iconStep"></span>
										<span class="completeState"></span>
										<i class="stepNum">1</i>
										<p class="introTxt txt1">兑换成功</p>
									</li>
									<li>
										<span class="iconStep"></span>
										<span class="completeState"></span>
										<i class="stepNum">2</i>
										<p class="introTxt txt1">商品出库</p>
									</li>
									<li>
										<span class="iconStep"></span>
										<span class="completeState"></span>
										<i class="stepNum">3</i>
										<p class="introTxt txt2">已发货</p>
									</li>
									<li>
										<span class="iconStep"></span>
										<span class="completeState"></span>
										<i class="stepNum">4</i>
										<p class="introTxt txt3">已完成</p>
									</li>
								</ul>
								<div class="throughLine"></div>
								<div class="colorLine"></div>
							</div>
						</div>
						<!-- 订单跟踪详情  -->
						<div class="fllowDetail">
							<p>订单跟踪详情</p>
							<div class="innnerDetail clearfix">
								<strong class="comTit fllowWid1">处理时间</strong>
								<strong class="comTit fllowWid2">处理信息</strong>
								<strong class="comTit fllowWid3">操作人</strong>
								<ul class="listFllowInfo">
									<li class="active">
										<p class="comTit fllowWid1">2015-02-06 20:13:26</p>
										<p class="comTit fllowWid2">您已经兑换成功支付成功</p>
										<p class="comTit fllowWid3">会员</p>
									</li>
									<li>
										<p class="comTit fllowWid1">2015-02-06 20:13:26</p>
										<p class="comTit fllowWid2">订单已经打印完毕，正在拣货中</p>
										<p class="comTit fllowWid3">系统</p>
									</li>
									<li>
										<p class="comTit fllowWid1">2015-02-06 20:13:26</p>
										<p class="comTit fllowWid2">订单商品已经打包，正在派发给承运商</p>
										<p class="comTit fllowWid3">系统</p>
									</li>
									<li>
										<p class="comTit fllowWid1">2015-02-06 20:13:26</p>
										<p class="comTit fllowWid2">您的订单将在1天内到达河南省配送中心</p>
										<p class="comTit fllowWid3">系统</p>
									</li>
									<li>
										<p class="comTit fllowWid1">2015-02-06 20:13:26</p>
										<p class="comTit fllowWid2">您的订单已经从ADC郑州中心【ADC郑州中心】发出，正在送往濮阳一部【濮阳一部】途中</p>
										<p class="comTit fllowWid3">系统</p>
									</li>
									<li>
										<p class="comTit fllowWid1">2015-02-06 20:13:26</p>
										<p class="comTit fllowWid2">您的订单已经到达濮阳一部【濮阳一部】，正在开始检货</p>
										<p class="comTit fllowWid3">系统</p>
									</li>
									<li>
										<p class="comTit fllowWid1">2015-02-06 20:13:26</p>
										<p class="comTit fllowWid2">您的订单正在派件,配送员:中原油田总部,电话:13213479369</p>
										<p class="comTit fllowWid3">系统</p>
									</li>
									<li>
										<p class="comTit fllowWid1">2015-02-06 20:13:26</p>
										<p class="comTit fllowWid2">您已签收本次订单包裹，本次配送完成。感谢您在唯品会购物，祝您生活愉快！</p>
										<p class="comTit fllowWid3">系统</p>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="bgDec"></div>
				<!-- 商品清单  -->
				<div class="comModBox">
					<strong class="modTit">商品清单</strong>
					<div class="detailBox">
						<ul class="proListTit">
							<li class="headWid1">商品</li>
							<li class="headWid2">金币</li>
							<li class="headWid2">数量</li>
							<li class="headWid2">小计</li>
						</ul>
						<table id="proListInfo" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left" class="thumbnailTd headWid1">
									<a href="javascript:void(0)" class="thumbnailBox">
										<img class="thumbnail" src="Module/goldenMall/images/smallPic.jpg" width="50" height="63"/>
										<span class="proNames">矿物理肤海藻泥面膜120g</span>
									</a>
								</td>
								<td align="center" class="needGoldNum headWid2">15368</td>
								<td align="center" class="headWid2">1</td>
								<td align="center" class="totlalNum headWid2">15368</td>
							</tr>
						</table>
						
					</div>
				</div>
				<!-- 右下方总结  -->
				
			</div>
		</div>
	</div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
</body>
</html>
