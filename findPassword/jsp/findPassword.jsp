<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>助学网找回密码</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/findPassword/css/findPassCss.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript"> 
    var phone;
    //新老密码是否符合规则flag
    var passwordFlag = true;
	$(function() {
		textFoucsCheck();
	});
	function textFoucsCheck() {
		inpTipFocBlur("userName", "请输入用户名", "#c2c2c2", "#444");
		inpTipFocBlur("vercodes", "请输入验证码", "#c2c2c2", "#444");
		passwordDisplay("passTxt", "newPassWord", "设置新登录密码");
		passwordDisplay("passTxt1", "confirmPass", "确认新密码");
		inpTipFocBlur("phoneCode", "请输入手机校验码", "#c2c2c2", "#444");
		checkScreen();
		inpBlurAcc();
		inpBlurVer();
		setNewPass();
		conNewPass();
		checkPasStrongWeak($("#newPassWord"));
		phoneCondeBlur();
	}

	function checkScreen() {
		var oWidth = $(window).width();
		if (oWidth >= 1000 && oWidth <= 1600) {
			$(".logo").hide();
			$(".hideLogo").show();
		}
	}
	var iNow = 0;
	function showNextStep() {
		var ouserName = document.getElementById("userName").value;
		var oVercode = document.getElementById("vercodes").value;
		if (iNow == 0) {
			if (ouserName == "请输入用户名") {
				$(".accountNameE").show();
				$(".accInfo").show();
				$(".accountNameR").hide();
				getId("userName").focus();
				return false;
			} else if (oVercode == "请输入验证码") {
				$(".vercondeE").show();
				$(".verInfo").show();
				$(".vercondeR").hide();
				$(".verNumInfo").hide();
				getId("vercodes").focus();
				return false;
			} else {
				$(".noExiVer").hide();
				$(".noExitAcc").hide();
				$(".accInfo").hide();
				$(".verInfo").hide();
				$(".accountNameE").hide();
				$(".vercondeE").hide();
				$(".accountNameR").show();
				$(".vercondeR").show();

				//判断用户名是否存在
				var flag = checkUserNameExist(ouserName, oVercode);

				if (flag == "true") {
					//插入数据库,发送短信验证
					iNow += 1;
					$(".findPasNav li").eq(iNow).addClass("active");
					$(".fixPasConBox").hide().eq(iNow).show();
					$(".account").html($("#userName").val());
					$(".phoneNum").html(phone.slice(0,3)+"****"+phone.slice(7));
					inpTipFocBlur("phoneCode", "请输入手机校验码", "#c2c2c2", "#444");
				}
				return true;
			}
		} else if (iNow == 1) {//判断手机校验码
			if ($("#phoneCode").val() != ""
					&& $("#phoneCode").val() != "请输入手机校验码") {
				if (checkPhoneFlag) {
					iNow += 1;
					$(".findPasNav li").eq(iNow).addClass("active");
					$(".fixPasConBox").hide().eq(iNow).show();
				} else {
					//短信验证出错
					//$(".phoneCoInfo").show();
					//$(".phpneCodeE").show();
				}
			} else {

			}
		} else if (iNow == 2) {
			var psssword = getId("newPassWord").value.replace(/ /g,"");
			var username = ouserName;
			if(passwordFlag && getId("passTxt").style.display != "block"){
				//设置新密码
				if (updatePassword(username, psssword)) {
					iNow += 1;
					$(".findPasNav li").eq(iNow).addClass("active");
					$(".fixPasConBox").hide().eq(iNow).show();
					$(".newPassword").html(psssword);
				 }
			}else{
				/*$(".setNewPasE").show();
				$(".conNewPasE").show();
				$(".emptyNewPas").show();
				$(".conEmptyNews").show();*/
				
			}
		}

	}
	//设置新密码
	function updatePassword(username, psssword) {
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : "login.do?action=updatePassword&userName=" + username
					+ "&password=" + psssword,
			success : function(json) {
				if (json) {
					flag = true;
				} else {
					flag = false;
				}
			}
		});
		return flag;
	}

	//验证码是否正确
	var checkPhoneFlag = true;
	function checkPhoneCode() {
		var code = getId("phoneCode").value;
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : "commonManager.do?action=checkMobileCode&phoneNum=" + phone
					+ "&code=" + code + "&purpose=1",
			success : function(json) {
				if (json) {
					checkPhoneFlag = true;
					$(".phoneCodeR").show();
					$(".phoneCodeE").hide();
					$(".phoneCoInfo").hide();
				} else {
					checkPhoneFlag = false;
					$(".phoneCoInfo").show();
					$(".phoneCodeE").show();
					$(".phoneCodeR").hide();
				}
			}
		});
		return checkPhoneFlag;
	}

	//发送短信
	function getNumber() {
		var phoneCode = "";
		var phoneNumber = phone.replace(/ /g, "");
		//插入一条数据到数据库(status=0)
		phoneCode = addPhoneCode(phoneNumber);
		if (phoneCode != "") {
			//向注册的手机好发送一条手机验证码
			sendMobileCode(phoneNumber, phoneCode);
		}

	}
	//向数据库插入\修改一条手机验证码数据
	function addPhoneCode(phoneNumber) {
		var code = "";
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : "commonManager.do?action=addMobileCode&phoneNum="
					+ phoneNumber + "&purpose=1",
			success : function(json) {
				if (json != "") {
					code = json;
				} else {
					code = "";
				}
			}
		});
		return code;
	}
	//向注册的手机号发送一条短信验证码
	function sendMobileCode(phoneNumber, phoneCode) {
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : "commonManager.do?action=sendMessage&phoneNum=" + phoneNumber
					+ "&vercode=" + phoneCode,
			success : function(json) {

			}
		});
	}

	//验证码
	function verCode() {
		var obj = document.getElementById("sessCode");
		obj.src = "authImg?code=" + Math.random() + 100;
	}

	//检查验证码和是否存在该用户
	function checkUserNameExist(userName, vercode) {
		var flag;
		$.ajax({
			type : "POST",
			async : false,
			url : "login.do?action=checkUsernameVercodeExist&username="
					+ encodeURIComponent(userName) + "&vercode=" + vercode,
			success : function(json) {
				if (json == "vercodeFail") {
					document.getElementById("vercodes").value = '';
					verCode();
					//alert('验证码不匹配,请重新输入');
					$(".noExiVer").show();
					$(".vercondeE").show();
					$(".vercondeR").show();
					$(".verInfo").hide();
					$(".verNumInfo").hide();
					getId("vercodes").focus();
				} else if (json == "false") {
					//alert('用户名不存在,请重试');
					$(".noExitAcc").show();
					$(".accountNameR").hide();
					$(".accountNameE").show();
					getId("userName").focus();
				} else {
					phone = json;
					flag = "true";
					$(".noExiVer").hide();
					$(".noExitAcc").hide();
				}
			}
		});
		return flag;
	}

	function inpBlurAcc() {
		var ouserName = getId("userName");
		$("#userName").blur(function() {
			if (ouserName.value == "请输入用户名") {
				$(".accountNameE").show();
				$(".accInfo").show();
				$(".accountNameR").hide();
				$(".noExitAcc").hide();
			} else {
				$(".accountNameE").hide();
				$(".accInfo").hide();
				$(".accountNameR").show();
			}
		});
	}
	function inpBlurVer() {
		var oVercode = getId("vercodes");
		$("#vercodes").blur(function() {
			if (oVercode.value == "请输入验证码") {
				$(".vercondeE").show();
				$(".verInfo").show();
				$(".vercondeR").hide();
				$(".noExiVer").hide();
				$(".verNumInfo").hide();
			} else {
				var regNum = $(this).val().replace(/ /g,"");
				if(/\D/.test(this.value)){
					$(".vercondeE").show();
					$(".verNumInfo").show();
					$(".verInfo").hide();
					$(".noExiVer").hide();
				}else{
					$(".vercondeE").hide();
					$(".verInfo").hide();
					$(".vercondeR").show();	
					$(".verNumInfo").hide();	
				}
			}
		});
	}
	//获取手机验证码
	var count = 60;
	function getPhoneCode() {
		if (count == 60) {
			getNumber();
		}
		$(".phoneCodeTip").show();
		$(".timerNum").html(count);
		$(".getCondes").removeAttr("onclick");
		$(".getCondes").attr("onlcick", "null");
		if (count >= 0) {
			count--;
			var timer = setTimeout(getPhoneCode, 1000);
		} else {
			$(".phoneCodeTip").hide();
			$(".getCondes").removeAttr("onlcick");
			$(".getCondes").attr("onclick", "getPhoneCode()");
			count = 60;

		}
	}
    //设置新密码
	function setNewPass() {
		$("#passTxt").focus(function() {
			$(".pasInfos").show();
			$(".emptyNewPas").hide();
			$(".setNewPasE").hide();
			$(".lesSixLen").hide();
			$(".setNewPasR").hide();
		});
		$("#newPassWord").blur(function() {
			if (getId("passTxt").style.display == "block") {
				if ($("#newPassWord").val() == "") {
					$(".emptyNewPas").show();
					$(".setNewPasE").show();
					$(".pasInfos").hide();
					$(".lesSixLen").hide();
					$(".setNewPasR").hide();
					passwordFlag = false;
				}
			} else {
				if ($("#newPassWord").val().length < 6) {
					$(".lesSixLen").show();
					$(".setNewPasE").show();
					$(".emptyNewPas").hide();
					$(".pasInfos").hide();
					$(".setNewPasR").hide();
					passwordFlag = false;
				} else {
					$(".setNewPasR").show();
					$(".emptyNewPas").hide();
					$(".setNewPasE").hide();
					$(".pasInfos").hide();
					$(".lesSixLen").hide();
				}
			}
		});
	}
	//确认新密码验证
	function conNewPass() {
		$("#confirmPass").blur(function() {
			if (getId("passTxt1").style.display == "block") {
				if ($("#confirmPass").val() == "") {
					$(".conEmptyNews").show();
					$(".conNewPasE").show();
					$(".difPass").hide();
					$(".conNewPasR").hide();
					passwordFlag = false;
				}
			} else {
				if ($("#confirmPass").val() != $("#newPassWord").val()) {
					$(".difPass").show();
					$(".conNewPasE").show();
					$(".conEmptyNews").hide();
					passwordFlag = false;
				} else {
					$(".conNewPasR").show();
					$(".conEmptyNews").hide();
					$(".difPass").hide();
					$(".conNewPasE").hide();
					passwordFlag = true;
				}
			}
		});
	}
	function phoneCondeBlur(){
		$("#phoneCode").blur(function(){
			checkPhoneCode();
		});  
	}
	
</script>  
</head>
  
<body>
	<div class="imgBg">
		<img src="Module/account/registerPage/images/bg2.jpg"/>
	</div>
	<div class="findPassWrap">
		<a href="http://www.zhu-xue.cn" title="返回首页" class="hideLogo">
			<img src="Module/images/logoZxw.png" alt="助学网中小学生课堂反馈系统">
		</a>
		<div class="logo">
			<a href="http://www.zhu-xue.cn" title="返回首页" class="logoA"><img src="Module/images/logoZxw.png" alt="助学网中小学生课堂反馈系统"></a>
		</div>
		<div class="findPasCon">
			<!-- 导航  -->
			<ul class="findPasNav">
				<li class="active">
					<span class="enterName"></span>
				</li>
				<li>
					<span class="identify"></span>
				</li>
				<li> 
					<span class="setNewPas"></span>
				</li>
				<li class="noArrow">
					<span class="done"></span>
				</li>
			</ul>
			<!-- 修改主体内容盒子  -->
			<div class="fixPasBox">
				<!-- 填写账户名  -->
				<div class="fixPasConBox" style="display:block;">
					<span class="triangles posOne"></span>
					<div class="autoBox">
						<div class="comInpBox userNames">
							<input type="text" id="userName" class="comInp" value="请输入用户名">
							<!-- 提示信息的正确和错误状态的图标  -->
							<span class="comIcon rightIcon accountNameR"></span>
							<span class="comIcon errorIcon accountNameE"></span>
						</div>
						<div class="comInpBox vercodes">
							<input type="text" id="vercodes" class="comInp" value="请输入验证码">
							<!-- 提示信息的正确和错误状态的图标  -->
							<span class="comIcon rightIcon vercondeR"></span>
							<span class="comIcon errorIcon vercondeE"></span>
						</div>
						<div class="vercodeImgBox">
							<img id="sessCode" src="authImg" alt="请输入验证码">
							<a href="javascript:void(0)" onclick="verCode()">看不清，换一张</a>
						</div>
						<span class="nextBtn posBot" onclick="showNextStep()">下一步</span>
					</div>
					<!-- 输入用户名提示信息  -->
					<p class="accInfo">请输入用户名</p>
					<p class="noExitAcc">用户名不存在，请从新输入</p>
					<!-- 验证码提示信息  -->
					<p class="verInfo">验证码不能为空</p>
					<p class="verNumInfo">验证码只能是数字，请从新输入</p>
					<p class="noExiVer">验证码不匹配，请从新输入</p>
				</div>
				<!-- 验证身份  -->
				<div class="fixPasConBox" style="display:none;">
					<span class="triangles posTwo"></span>
					<div class="autoBox">
						<div class="comIdenBox">
							<span>用户名：</span><strong class="account"></strong>
						</div>
						<div class="comIdenBox">
							<span>已验证手机：</span><strong class="phoneNum"></strong>
						</div>
						<div class="comInpBox vercodes margTop">
							<input type="text" id="phoneCode" class="comInp" maxlength="6" value="请输入手机校验码">
							<a href="javascript:void(0)" class="getCondes" onclick="getPhoneCode()"></a>
							<!-- 提示信息的正确和错误状态的图标  -->
							<span class="comIcon rightIcon phoneCodeR"></span>
							<span class="comIcon errorIcon phoneCodeE"></span>
						</div>
						<span class="nextBtn posBot" onclick="showNextStep()">下一步</span>
					</div>
					<p class="phoneCodeTip">手机校验码已发出，请注意查收短信，如果没有收到，您可以在<span class="timerNum"></span>秒后从新获取手机校验码</p>
					<!-- 短信验证码输入有误，请从新输入 -->
					<p class="phoneCoInfo">短信验证码不正确!</p> 
				</div>
				<!-- 设置新密码  -->
				<div class="fixPasConBox" style="display:none;">
					<span class="triangles posThree"></span>
					<div class="autoBox">
						<div class="comInpBox setNewPas">
							<input type="text" id="passTxt" value="设置新登录密码" class="comInp" style="display: block;">
							<input type="password" id="newPassWord" class="comInp writeCol" maxlength="16" style="display:none;">
							<!-- 提示信息的正确和错误状态的图标  -->
							<span class="comIcon rightIcon setNewPasR"></span>
							<span class="comIcon errorIcon setNewPasE"></span>
						</div>
						<div id="pasStrongWeak" class="pasStrongWeak clearfix">
							<div class="pasBox">
								<p class="gray1"></p>
								<span>弱</span>
							</div>
							<div class="pasBox">
								<p class="gray2"></p>
								<span>中</span>
							</div>
							<div class="pasBox">
								<p class="gray3"></p>
								<span>强</span>
							</div>
						</div>
						<div class="comInpBox confirPas">
							<input type="text" id="passTxt1" value="确认新密码" class="comInp" style="display: block;">
							<input type="password" id="confirmPass" class="comInp writeCol" style="display:none;">
							<!-- 提示信息的正确和错误状态的图标  -->
							<span class="comIcon rightIcon conNewPasR"></span>
							<span class="comIcon errorIcon conNewPasE"></span>
						</div>
						<span class="nextBtn posBot1" onclick="showNextStep()">提交</span>
					</div>
					<!-- 设置新登录提示信息  -->
					<p class="pasInfos">密码由6-16字符（字母、数字、符号）组成，区分大小写</p>
					<!-- 设置新密码不能为空  -->
					<p class="emptyNewPas">设置新登录密码不能为空</p>
					<!-- 设置新密码不能少于6个字符  -->
					<p class="lesSixLen">设置新登录密码不能少于6个字符</p>
					<!-- 确认新密码提示信息  -->
					<p class="conEmptyNews">确认新密码不能为空</p>
					<p class="difPass">两次密码输入不一致,请从新输入</p>
				</div>
				<!-- 完成  -->
				<div class="fixPasConBox" style="display:none;">
					<span class="triangles posFour"></span>
					<div class="autoBox">
						<span class="doneIcon"></span>
						<p class="succTxt">新密码设置成功</p>
						<p class="succTxt1">请牢记您新设置的密码：<span class="newPassword"></span></p>
						<p class="succTxt2"><a href="login.do?action=commonLogin">立即登录</a>&nbsp;&nbsp;&nbsp;<a href="http://www.zhu-xue.cn">返回首页</a></p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
