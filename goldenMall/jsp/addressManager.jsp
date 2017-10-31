<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

<head>
<title>助学网收货地址管理</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/goldenCommon.css" type="text/css" rel="stylesheet"/>
<link href="Module/goldenMall/css/addressManagerCss.css" type="text/css" rel="stylesheet"/>
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/goldMallJs.js"></script>
<script type="text/javascript" src="Module/goldenMall/js/selectPC.js"></script>
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/ecmascript"></script>
<script type="text/javascript">
$(function(){
	checkScreenWidth(".head");
	moveTopBottom(132);
	selRadioFn();
	inpFocusBlur();
	showPC();
	moveLeftRight(455);
});
var strConsignee = "请填写收货人姓名";
var strAddress = "建议您如实填写详细收货地址，例如街道名称、门牌号码";
var strEmailNum = "请填写您所在地的邮编号码";
var strPhoneNum = "请填写您的手机号码";

//收货地址raido的移入和移出
function selRadioFn(){
	$(".addManagerBox li").not('.default').each(function(i){
		$(this).hover(function(){
			$(this).addClass("hoverBor");
			$(".setdefauAdd").eq(i).stop().animate({top:0},200);	
			
		},function(){
			$(this).removeClass("hoverBor");
			$(".setdefauAdd").eq(i).stop().animate({top:-18},200);
			//$(".fixBtn").eq(i).hide();
		});
	});
}
function setDefaultAddFn(id){
	var deID=$("#dflag").val();
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"shopManager.do?action=ModifyAdressStuts&addressID="+id+"&deID="+deID,
		success:function(json){
			if(json){
				alert("设置默认收货地址保存成功！");
				window.location.reload(true);
			}else{
				alert("设置默认收货地址保存失败，请重试！");
			}
		}
	});
}
function inpFocusBlur(){
	var oTxtConsignee = getId("buyer_Name");
	var oTxtAddress = getId("detailAddress");
	var oEmailNum = getId("emailNum");
 	var oTxtPhoneNum = getId("telPhone");
	textFocusCheck(oTxtConsignee,strConsignee);
	textFocusCheck(oTxtAddress,strAddress);
	textFocusCheck(oEmailNum,strEmailNum);
	textFocusCheck(oTxtPhoneNum,strPhoneNum);
}
//新增收货地址
function addNewAddress(){
	$(".layer").show();
	$(".setFixAddBox").show().animate({left:"50%"});
}
//修改地址
function modifyAddress(usaId,province,city,messrs,addressDetail,mobile,zip){
	$(".layer").show();
	$(".setFixAddBox").show().animate({left:"50%"});
	$("#usaId").val(usaId);
	$("#province").val(province);
	$("#city").val(city);
	$("#buyer_Name").val(messrs);
	$("#detailAddress").val(addressDetail);
	$("#emailNum").val(zip);
	$("#telPhone").val(mobile);
}
function closeFixWin(){
	$(".setFixAddBox").animate({left:"-50%"},function(){
		$(".setFixAddBox").hide();
		$(".layer").hide();
		$("#buyer_Name").val(strConsignee);
		$("#detailAddress").val(strAddress);
		$("#telPhone").val(strPhoneNum);
		$(".tipInfos").hide();
	});
}
//保存新增或修改的收货地址信息检测
function saveFixInfoCheck(){
	var oTxtConsignee = getId("buyer_Name");
	var oTxtAddress = getId("detailAddress");
	var oTxtPhoneNum = getId("telPhone");
	if(oTxtConsignee.value == strConsignee){
		oTxtConsignee.focus();
		$(".writeNames").show();
		$("#buyer_Name").blur(function(){
			if($("#buyer_Name").val()!= strConsignee && $("#buyer_Name").val()!=""){
				$(".writeNames").hide();
				alert("成功");
				//return true;
				
			}else{
				$(".writeNames").show();
				return false;
			}			
		});
	}else if(oTxtAddress.value == strAddress){
		oTxtAddress.focus();
		$(".addressTip").show();
		$("#detailAddress").blur(function(){
			if($("#detailAddress").val()!= strAddress && $("#detailAddress").val()!=""){
				$(".addressTip").hide();
				alert("成功1");
				//return true;
				
			}else{
				$(".addressTip").show();
				return false;
			}			
		});
	}else if(oTxtPhoneNum.value == strPhoneNum){
		var partten = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
		$(".phoneTips").show();
		oTxtPhoneNum.focus();
		$("#telPhone").blur(function(){
			if($("#telPhone").val()!= strPhoneNum && $("#telPhone").val()!=""){
				//判断是手机号码格式
				if($(this).val().length == 11){
					if(!partten.test($(this).val())){
						$(".phoneTips").html("手机号码格式不正确");
						$(".phoneTips").show();
						oTxtPhoneNum.focus();
						if(oTxtPhoneNum.value == strPhoneNum){
							$(".phoneTips").html("请填写您的手机号码");
						}
						return false;
					}else{//手机号码格式正确
						$(".phoneTips").hide();
						alert("成功2");
						return true;
						
					}
				}else{
					$(".phoneTips").html("手机号码格式不正确");
					$(".phoneTips").show();
					return false;
				}
			}	
		});
	}else{
		return true;
	}
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
					<li class="active">
						<span class="comIcon addMagIcon"></span>
						<a href="shopManager.do?action=deliveryAddManager">收货地址管理</a>
					</li>
					<li>
						<span class="comIcon queIcon"></span>
						<a href="shopManager.do?action=usualQuestion">常见问题</a>
					</li>
				</ul>
				<span id="moveBor" class="borL top4"></span>
			</div>
		</div>
		<!-- 右侧订单详情区  -->
		<div class="sectionR rMinHei fl">
			<!-- 头部  -->
			<div class="detailHead">
				<h2 class="addBg">收货地址管理</h2>
			</div>
			<div class="orderList clearfix">
				<!-- 增加新地址盒子  -->
				<div class="addNewBox">
					<p>您最多可以创建3个收货地址</p>
					<span class="addNewAddBtn" onclick="addNewAddress()">新增收货地址</span>
				</div>
				
				<!-- 新增的收货地址  -->
				<ul class="addManagerBox">
				<c:forEach items="${requestScope.usaList}" var="usa">
				<c:if test="${usa!=null}">
				<c:choose>
					 <c:when test="${usa.defaultFlag==1 }">
						<li class="hoverBor default">
					 </c:when>
					 <c:otherwise>
					    <li>
					 </c:otherwise>
				</c:choose>
						<span class="boldBor"></span>
						<strong class="userName">${usa.messrs}</strong>
						<p class="addressTxt">${usa.province}省 ${usa.city}市 ${usa.addressDetail}&nbsp;&nbsp;${usa.zip}</p>
						<p class="phone">${usa.mobile}</p>
						<div class="setBox">
							<a class="fixBtn" href="javascript:void(0)" onclick="modifyAddress(${usa.id},'${usa.province}','${usa.city}','${usa.messrs}','${usa.addressDetail}','${usa.mobile}','${usa.zip}')">修改</a>
							<a class="delBtn" href="javascript:void(0)" onclick="delAddress(${usa.id})">删除</a>
						</div>
						<c:if test="${usa.defaultFlag==1}">
						<input type="hidden"  id="dflag" value="${usa.id }"/>
							<span class="defauAdd">默认地址</span>
						</c:if>
						<c:if test="${usa.defaultFlag==0}">
							<span class="setdefauAdd" onclick="setDefaultAddFn(${usa.id})">设为默认地址</span>
						</c:if>
						<div class="optIcon">
							<span class="choiceIcon"></span>
						</div>
					</li>
				</c:if>
					<c:if test="${usa==null}">
						<!-- 没有收货地址的情况下的提示  -->
						<div class="noExitDiv">
							<img src="Module/goldenMall/images/noAddressPic.png" alt="暂无收货地址"/>
							<p>您还未添加收货地址，点击”增加收货地址“按钮来添加您的收货地址吧~</p>
						</div>
					</c:if>
				</c:forEach>
			</ul>
			</div>
		</div>
	</div>
	<!-- 增加修改地址  -->
	<div class="setFixAddBox">
		<div class="addInfoHead">
			<strong class="setFixTit">收货地址</strong>
		</div>
		
		<form class="fixAddForm">
			<div class="fixEditBox">
			<input type="hidden" id="usaId">
				<div class="comEditFixBox">
					<em>
						<i>*</i>
						收货人姓名：
					</em>
					<input type="text" id="buyer_Name" class="comInpTxt inpWid1" value="请填写收货人姓名"/>
					<span class="tipInfos writeNames">请输入收货人姓名</span>
				</div>
				<div class="comEditFixBox">
					<em>
						<i>*</i>
						所<span class="blank"></span>在<span class="blank"></span>地<span class="blank"></span>区：
						<select id="province"></select>
						<select id="city"></select>
					</em>
					
				</div>
				<div class="comEditFixBox">
					<em>
						<i>*</i>
						详<span class="blank"></span>细<span class="blank"></span>地<span class="blank"></span>址：
					</em>																
					<input type="text" id="detailAddress" class="comInpTxt inpWid2" value="建议您如实填写详细收货地址，例如街道名称、门牌号码"/>
					<span class="tipInfos addressTip">请输入您的详细地址</span>
				</div>
				<div class="comEditFixBox">
					<span class="blankMl"></span>邮<span class="blank"></span>政<span class="blank"></span>编<span class="blank"></span>码：<input class="comInpTxt inpWid2 ml2" id="emailNum" type="text" value="请填写您所在地的邮编号码" maxlength="6" class="comInp wid1">
				</div>
				<div class="comEditFixBox">
					<em>
						<i>*</i>
						联<span class="blank"></span>系<span class="blank"></span>电<span class="blank"></span>话：
					</em>
					<input type="text" id="telPhone" class="comInpTxt inpWid1" value="请填写您的手机号码"/>
					<span class="tipInfos phoneTips">请填写您的手机号码</span>
					<!-- span class="tipInfos phonePatten" style="display:block">手机号码格式不正确</span -->
				</div>
				<input type="button" class="saveInfo" value="保存收货地址" onclick="saveAddress()">
				<a id="cancelUpdate" href="javascript:void(0);" onclick="closeFixWin()">取消</a>
			</div>
		</form>
		<span class="closeAddWin" onclick="closeFixWin()"></span>
	</div>
	<div class="layer"></div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
</body>
</html>
