<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

<head>
<title>助学网金币商城</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/goldenMallCss.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/goldenCommon.css" type="text/css" rel="stylesheet"/>
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/goldMallJs.js"></script>
<script type="text/javascript">
$(function(){
	checkScreenWidth(".head");
	moveTopBottom(12);
	fnTab($(".catag1"),'click');
	fnTab($(".catag2"),'click');
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
					<li class="active">
						<span class="comIcon proListIcon"></span>
						<a href="javascript:void(0)">商品列表</a>
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
		<div class="sectionR rMinHei fl">
			<!-- 筛选条件  -->
			<div class="selBox">
				<div class="comSeleBox margB">
					<span class="selTit fl">商品分类：</span>
					<ul class="catag1 proList fl">
						<li id="type0" class="active" value="0" onclick="showIP('type0',0,1)">全部</li>
						<li id="type1" value="1" onclick="showIP('type1',0,1)">学习文具</li>
						<li id="type2" value="2" onclick="showIP('type2',0,1)">体育用品</li>
						<li id="type3" value="3" onclick="showIP('type3',0,1)">数码产品</li>
						<li id="type4" value="4" onclick="showIP('type4',0,1)">虚拟产品</li>
					</ul>
				</div>
				
				<div class="comSeleBox">
					<span class="selTit fl">积分价格：</span>
					<ul class="catag2 proList fl">
						<li id="credits0" class="active" onclick="showIP(5,'credits0',1)">全部</li>
						<li id="credits1" onclick="showIP(5,'credits1',1)">0-100</li>
						<li id="credits2" onclick="showIP(5,'credits2',1)">101-1000</li>
						<li id="credits3" onclick="showIP(5,'credits3',1)">1001-10000</li>
						<li id="credits4" onclick="showIP(5,'credits4',1)">10001-100000</li>
						<li id="credits5" onclick="showIP(5,'credits5',1)">100001-1000000</li>
					</ul>
				</div>
			</div>
			<!-- 产品内容  -->
			<div class="productWrap clearfix">
				<ul class="clearfix" id="ip">
					<c:forEach items="${requestScope.ipList}" var="IP">
					<li>
						<a class="imgBox" href="shopManager.do?action=proDetail&id=${IP.id}">
							<img title="${IP.productName}" src="Module/goldenMall/images/pro.jpg"/>
							<!--img src="${pageContext.request.contextPath}/${IP.thumbnail}"/>-->
						</a>
						<a class="proName" href="shopManager.do?action=proDetail&id=${IP.id}">${IP.productName}</a>
						<p class="needGold">${IP.credits}金币</p>
						<p class="leaveNum">剩余：${IP.stocks}个</p>
						<c:if test="${IP.stocks!=0}">
							<a class="buyBtn" href="shopManager.do?action=goldenMallPay&ipId=${IP.id}"><span>立即</span><br/>兑换</a>
						</c:if>
						<c:if test="${IP.stocks==0}">
							<!-- 已售完  -->
						    <a class="soldOutBtn" href="javascript:void(0)"><span>已经</span><br/>售罄</a>
						</c:if>
					</li>
					</c:forEach>
				</ul>
			</div>
			<!-- 翻页内容  -->
			<div class="page">
                <div class="right">
                	<p class="fl">共<input class="turnInp" id="ipCount" value="${requestScope.ipCount}" readonly>条结果</p>
                    <p class="fl">第<input class="turnInp" id="pageNo" value="${requestScope.pageNo}"  readonly>页</p>
					<p class="fl">共<input class="turnInp" id="pageCount" value="${requestScope.pageCount}" readonly>页</p>
					<a href="javascript:void(0)" onclick="first()">首页</a>
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
