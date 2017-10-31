<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

<head>
<title>助学网我的金币详情</title>
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
	moveTopBottom(92);
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
					<li>
						<span class="comIcon ordIcon"></span>
						<a href="shopManager.do?action=orderDetail">我的订单详情</a>
					</li>
					<li class="active">
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
				<span id="moveBor" class="borL top3"></span>
			</div>
		</div>
		<!-- 右侧订单详情区  -->
		<div class="sectionR rMinHei fl">
			<!-- 头部  -->
			<div class="detailHead">
				<h2 class="goldBg">我的金币<span class="recentTxt"><span class="triangleIcon"></span>最近消耗金币</span></h2>
			</div>
			<div class="useGoldenList">
				<ul class="listTit">
					<li class="wid1">交易时间</li>
					<li class="wid1">扣除金币</li>
					<li class="wid2">来源</li>
					<li class="wid1">交易状态</li>
					<li class="wid1">交易备注</li>
				</ul>

				<table id="tabListCon" class="listCon" cellpadding="0" cellspacing="0">
				  <c:forEach items="${requestScope.ucdList}" var="ucd" varStatus="status">
				  <c:if test="${ucd!=null}">
				  	<!-- 有金币消费详情下创建的table  -->
				    <c:set var="index" value="${status.index}"></c:set>
				    <c:forEach items="${requestScope.upmoList}" var="upmo" begin="${index}" end="${index}">
					<tr>								
						<td align="center" class="wid1">${upmo.tradingHours}</td>
						<td align="center" class="wid1"><span class="goldCol">${ucd.credits}</span></td>
						<td align="center" class="wid2">
							<a href="javascript:void(0)">${ucd.source}</a>
						</td>
						<c:if test="${upmo.status==1}">
						<td align="center" class="wid1">支付成功</td>
						</c:if>
						<c:if test="${upmo.status==0}">
						<td align="center" class="wid1">尚未支付</td>
						</c:if>
						<td align="center" class="wid1">订单号：${ucd.remark}</td>
					</tr>
					</c:forEach>
				  </c:if>
				  <c:if test="${ucd==null}">
				  	<!-- 没有金币消费的情况小的提示盒子  -->
					<div class="noExitDiv">
						<img src="Module/goldenMall/images/emptyIcon.png" alt="暂无金币消费"/>
						<p>您还未有金币消费的情况，去<a  href="shopManager.do?action=welcome">金币商城</a>兑换自己的喜欢的商品吧~</p>
					</div>
				  </c:if>
				  </c:forEach>
				</table>
			</div>
			<!-- 翻页内容  -->
			<div class="page" id="page">
                <div class="right">
                	<p class="fl">共${requestScope.ucdCount}条结果</p>
                    <p class="fl">第<input id="current" class="turnInp" readonly>页</p>
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
