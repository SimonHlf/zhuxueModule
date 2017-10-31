<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>    
    <title>助学网在线充值卡</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/rechargeCard/css/rechargeCardCss.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script type="text/jscript">
$(function(){
	var realName = "${sessionScope.realName}";
	backTop("backTop",22,-50);
	formatAccount();
});
//验证码
function verCode(){
	$("#sessCode").attr("src","authImg?code="+Math.random()+100);
}
//查询充值卡是否能充值
function checkRechargeCard(account,password,vercode){
	var flag = false;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"rcManager.do?action=checkCard&account="+account+"&password="+password+"&vercode="+vercode,
		success:function(json){
			if(json == "0"){
				alert("只有学生用户才能进行充值!");
			}else if(json == "1"){
				$("#vercode").val("");
				verCode();
				alert("验证码不匹配,请重新输入!");
				$("#vercode").focus();
			}else if(json == "2"){
				alert("不存在该卡或者账号密码不对!");
			}else if(json == "3"){
				alert("该卡已过期!");
			}else if(json == "4"){
				alert("该卡只能使用一次!");
			}else if(json == "5"){
				alert("一年内只能参加一次充值活动!");
			}else{
				flag = true;
			}
		}
	});
	return flag;
}
//充值
function recharge(){
	var account = $("#account").val().replace(/\s/g,'');
	var password = $("#password").val();
	var verCode = $("#vercode").val();
	if(account == ""){
		alert("请输入充值卡号!");
		$("#account").focus();
	}else if(password == ""){
		alert("请输入充值卡密码!");
		$("#password").focus();
	}else if(verCode == ""){
		alert("请输入验证码!");
		$("#vercode").focus();
	}else if(checkRechargeCard(account,password,verCode)){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"rcManager.do?action=rechargeCard&account="+account+"&password="+password,
			success:function(json){
				if(json == true){
					alert("充值成功!");	
					window.location.reload();
				}else{
					alert("充值失败!");
				}
			}
		});
	}
}
//格式化充值卡号
function formatAccount(){
	$("#account").keydown(function(){
		setTimeout(function(){
			$("#account").val($("#account").val().replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ").replace(/(\w{4})(?=\w)/g,"$1 "));//四位数字一组，以空格分割     
		},30);
	} );
}
</script>
</head>

<body>
	<!-- 头部  -->
	<div class="chargeHead">
		<div class="headBox w1000">
			<p class="headDecBox">
				<span class="nameUser">${sessionScope.realName}</span>
			</p>
			<img src="Module/images/logoZxw.png" alt="助学网中小学生课堂反馈系统">
			<h2>中小学生课堂信息反馈系统</h2>
		</div>
	</div>
	<!-- banner  -->
	<div class="bannerBox">
		<div class="midBanner w1000">
			<img src="Module/rechargeCard/images/banner.png" alt="快速充，免费学"/>
		</div>
	</div>
	<!-- mainCon  -->
	<div class="mainConBox w1000">
		<!-- 助学网充值活动是什么  -->
		<div class="comQueBox queBox1">
			<h3 class="comH3">助学网充值活动是什么？</h3>
			<p class="conPdecTxt decTxt1">响应国家教育信息化政策的号召，助学网会不定时的开展免费活动，让学生易学无忧，提高学生学习兴趣和自信。</p>
		</div>
		<div class="comQueBox queBox2">
			<h3 class="comH3">助学网充值活动规则：</h3>
			<p class="conPdecTxt decTxt2">根据用户正确的账号信息填写充值卡正确的账号和密码进行充值，充值成功后，会获得充值卡相应金额的免费使用时间。<br/>注：一个账号仅限使用一张充值卡进行充值</p>
			<p class="conPdecTxt decTxt3">友情提示：如果有两种以上的充值活动，用户只能选择其中一种参加。</p>
		</div>
		<div class="comQueBox queBox3">
			<h3 class="comH3">助学网充值常见问题答疑</h3>
		</div>
		<div class="comQueBox queBox4">
			<h3 class="comH3">助学网充值</h3>
			<div class="formBox">
					<div class="comFormBox">
						充值卡号：<input type="text" maxlength="24" id="account"/>
					</div>
					<div class="comFormBox">
						充值密码：<input type="password" id="password"/>
					</div>
					<div class="comFormBox">
						验<span class="blank"></span>证<span class="blank"></span>码：<input type="text" id="vercode"/>
					</div>
					<div class="comFormBox mt">
						<img id="sessCode" class="vercodeImg" src="authImg" alt="请输入验证码"/>
						<a href="javascript:void(0)" onclick="verCode()">看不清，换一张</a>
					</div>
					<a class="subBtn" href="javascript:void(0)" onclick="recharge();"></a>
					
			</div>
		</div>
	</div>
	<!-- 返回顶部  -->
    <span id="backTop" class="backIndex"></span>
	<!-- 客服  -->
	<%@include file="../../kefu/kefu.jsp"%>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
</body>
</html>
