<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

<head>
<title>助学网金币商城常见问题</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/goldenCommon.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/usualQueCss.css" type="text/css" rel="stylesheet"/>
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/goldMallJs.js"></script>
<script type="text/javascript">
$(function(){
	checkScreenWidth(".head");
	moveTopBottom(172);
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
					<li class="active">
						<span class="comIcon queIcon"></span>
						<a href="shopManager.do?action=usualQuestion">常见问题</a>
					</li>
				</ul>
				<span id="moveBor" class="borL top5"></span>
			</div>
		</div>
		<!-- 右侧订单详情区  -->
		<div class="sectionR rMinHei fl">
			<!-- 头部  -->
			<div class="detailHead">
				<h2 class="queIcons">常见问题</h2>
			</div>
			<div class="usualQueWrap">
				<div class="queListWrap">
					<h4>
						<i>1</i>
						金币是什么？
					</h4>
					<div class="queAnsBox">
						<div class="comStyleP">
							<p>金币是助学网学习平台对学生用户在线答题正确后获得的一种奖励。助学网学生用户可通过在线答题获得金币。
	金币可以在助学网金币商城兑换到学生学习用品或其他类实物奖品。</p>
						</div>
					</div>
				</div>
				<div class="queListWrap">
					<h4>
						<i>2</i>
						金币有什么用？
					</h4>
					<div class="queAnsBox">
						<div class="comStyleP">
							<p>金币可在金币商城兑换学习学习用品,助学网购买年卡的优惠券、或其他类实物奖品；去<a href="shopManager.do?action=welcome">助学网金币商城</a></p>
						</div>
					</div>
				</div>
				<div class="queListWrap">
					<h4>
						<i>3</i>
						如何获得金币？
					</h4>
					<div class="queAnsBox">
						<div class="comStyleP">
							<p>助学网学生用户可通过在线答题学习任务来获得金币！去<a href="studyOnline.do?action=load">在线答题</a></p>
						</div>
					</div>
				</div>
				<div class="queListWrap">
					<h4>
						<i>4</i>
						如何查询我的金币详情？
					</h4>
					<div class="queAnsBox">
						<div class="comStyleP">
							<p>登陆助学网金币商城首页，至[<a href="shopManager.do?action=goldenDetail">我的金币详情页面</a>]可查看金币余额以及对应的最近的金币使用兑换情况。</p>
						</div>
					</div>
				</div>
				<div class="queListWrap">
					<h4>
						<i>5</i>
						如何查询我的订单信息？
					</h4>
					<div class="queAnsBox">
						<div class="comStyleP">
							<p>登陆金币商城首页，至[<a href="shopManager.do?action=orderDetail">我的订单详情页面</a>]可查询历史订单记录，点击任意订单即可查询订单详情。</p>
						</div>
					</div>
				</div>
				<div class="queListWrap">
					<h4>
						<i>6</i>
						金币可以转让吗？
					</h4>
					<div class="queAnsBox">
						<div class="comStyleP">
							<p>助学网金币是以该以账号为单位，不可以转移给其他账号。金币一旦在商城兑换商品后，就会立即扣除！</p>
						</div>
					</div>
				</div>
				<div class="queListWrap">
					<h4>
						<i>7</i>
						金币具备有效期吗？
					</h4>
					<div class="queAnsBox">
						<div class="comStyleP">
							<p>过助学网在线答题获得的金币是永久有效的</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
</body>
</html>
