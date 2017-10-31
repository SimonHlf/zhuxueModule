<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

<head>
<title>助学网我的订单详情</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/goldenCommon.css" type="text/css" rel="stylesheet"/>
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/goldMallJs.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/exPage.js"></script>
<script type="text/javascript">
$(function(){
	checkScreenWidth(".head");
	moveTopBottom(52);
	$(".listCon tr:odd").addClass("oddColor");
	displayPage(1);
	moveLeftRight(455);
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
	<!-- 主要核心内容  -->
	<div class="goldWrap w1000 clearfix">
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
					<li>
						<span class="comIcon proListIcon"></span>
						<a href="shopManager.do?action=welcome">商品列表</a>
					</li>
					<li class="active">
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
				<span id="moveBor" class="borL top2"></span>
			</div>
		</div>
		<!-- 右侧订单详情区  -->
		<div class="sectionR rMinHei fl">
			<!-- 头部  -->
			<div class="detailHead">
				<h2 class="orBg">订单详情</h2>
			</div>
			<div class="orderList">
				<ul class="listTit">
					<li class="wid1">订单编号</li>
					<li class="wid2">订单详情</li>
					<li class="wid1">交易时间</li>
					<li class="wid1">交易状态</li>
					<li class="wid1">操作</li>
				</ul>
				<table id="tabListCon" class="listCon" cellpadding="0" cellspacing="0">
					<c:forEach items="${requestScope.upmoList}" var="upmo">
						<!-- 产生兑换后生成的列表  -->
						<c:if test="${upmo!=null}">
						<tr>
							<td align="center" class="wid1">${upmo.ordersNumber}</td>
							<td align="center" class="wid2">
								<a href="javascript:void(0)">${upmo.ordersTitle}</a>
							</td>
							<td align="center" class="wid1">${upmo.tradingHours}</td>
							<c:if test="${upmo.status==1}">
								<td align="center" class="wid1">支付成功</td>
							</c:if>
							<c:if test="${upmo.status==0}">
								<td align="center" class="wid1">尚未支付</td>
							</c:if>
							<td align="center" class="wid1"><a class="goDetail" href="javascript:void(0)">查看详情</a></td>
						</tr>
						</c:if>
						<!-- 未产生兑换交易时出现的提示盒子  -->
						<c:if test="${upmo==null}">
							<div class="noExitDiv">
								<img src="Module/goldenMall/images/emptyIcon.png" alt="暂无订单详情"/>
								<p>您当前订单详情为空，去<a  href="shopManager.do?action=welcome">金币商城</a>兑换自己的喜欢的商品吧~</p>
							</div>
						</c:if>
				  </c:forEach>
				</table>
			</div>
			<!-- 翻页内容  -->
			<div class="page" id="page">
                <div class="right">
                	<p class="fl">共${requestScope.upmoCount}条结果</p>
                    <p class="fl">第<input class="turnInp" id="current" readonly>页</p>
					<p class="fl">共${requestScope.pageCount}页</p>
					<a href="javscript:void(0)" onclick="first()">首页</a>
					<a href="javscript:void(0)" onclick="previous()">上一页</a>
					<a href="javscript:void(0)" onclick="next()">下一页</a>
					<a href="javscript:void(0)" onclick="last()">尾页</a>
                </div>
            </div>
		</div>
	</div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
</body>
</html>
