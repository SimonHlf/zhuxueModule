<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>助学网中小学生课堂反馈系统</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/css/switchSys.css" type="text/css" rel="stylesheet" />
<link href="Module/account/loginPage/css/loginPageCss.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js"></script>
<script src="Module/js/login.js"></script>
<script type="text/javascript">  
$(function(){
	midScreen();
	randomBg();
	checkScreenLogo();
	textFoucsChecks();
});
//根据不同分辨率来动态让登录的父级层处于可视区的中间
function midScreen(){
	$(".loginWrap").css({"top":parseInt(($(window).height() - $(".loginWrap").height())/2)});
}
//页面刷新随机显示登录框的背景图片
function randomBg(){
	var randomBgIndex = Math.round( Math.random() * 1 + 1 );
	$(".randomImgBox").html("<img src='Module/account/loginPage/images/bg"+randomBgIndex+".jpg'/>");
}
//检测屏幕分辨率来确定logo的位置
function checkScreenLogo(){
	if($(window).height()<=768){
		$(".logo").css({top:-108});
	}else{
		$(".logo").css({top:-175});
	}
}
function findPass(){
    window.location.href = "index.do?action=findPassword";
    }
</script>
</head>

<body>
<div class="autoImgBg"><img src="Module/account/loginPage/images/loginBg.jpg" /></div>
<div class="loginWrap">
	<div class="logo">
    	<a class="logoA" href="http://www.zhu-xue.cn" hidefocus="true">
        	<img src="Module/images/logoZxw.png" alt="助学网中小学生课堂反馈系统" />
        </a>
    </div>
	<!-- 主要核心部分 -->
    <div class="loginMainBox">
    	<!-- 随机显示的背景层 -->
        <div class="randomImgBox"></div>
        <div class="loginBox">
        	<!-- 登录底部透明层 -->
        	<div class="loginOpacity"></div>
            <div class="relLoginBox">
            	<span class="decTri triangleL"></span>
     			<span class="decTri triangleR"></span>
                <form id="loginForm" name="loginForm" action="">
                    <strong class="loginTit">用户登录</strong>
                    <div class="loginCon clearfix">
                    	<div class="comInpBox userName">
                    		<input type="text" id="userName" class="comInp inpHei1" value="请输入用户名" onkeypress="enterPress(event)" />
                        </div>
                    	<div class="comInpBox passwordBox">
                        	<input type="text" id="passTxt" value="请输入密码" class="comInp inpHei2"/>
                            <input type="password" id="password" class="comInp1 inpHei2" style="display:none;" onkeypress="enterPress(event)"/>
                        </div>
                    	<div class="comInpBox enterVercodeBox">
                        	<input type="text" id="vercode" class="comInp inpHei1" value="请输入验证码" name="vercode" title="不区分大小写" onkeypress="enterPress(event)"/>
                        </div>
                        <div class="vercodeImgBox">
							<img id="sessCode" src="authImg" alt="请输入验证码" />
							<a href="javascript:void(0)" onclick="verCode()">看不清，换一张</a>
						</div>
                        <p class="forgetPasBox">
                        	<input type="button" value="忘记密码?" id="forgetPass" class="noDis" onclick="findPass()"/>
                        </p>
                        <a class="loginBtn" href="javascript:void(0)" onclick="login()">登录</a>
                    </div>
                </form>
                <p class="freeReg">没有账号？<a href="login.do?action=registGoPage">免费注册</a></p>
            </div>
        </div>
    </div>
    <div class="footer">
    	<p>
    		<a class="footerMod" href="javascript:void(0)" hidefocus="true">关于我们</a> | <a class="footerMod" href="javascript:void(0)" hidefocus="true">联系我们</a> | <a class="footerMod" href="javascript:void(0)" hidefocus="true">在线客服</a> | <a class="footerMod" href="javascript:void(0)" hidefocus="true">免费声明</a> 
    	</p> 
    </div>
</div>
<!-- 遮罩层 -->
<div id="layer"></div>
	<!-- 身份选择 -->
	<div id='selectRoleWindowDiv' class="roleChoice" >
		<p>系统检测到您有多重身份，请选择一个身份进入系统！</p>
		<div id='selectRole' class="choiceBox">
		</div>
	</div>
	<html:form action="userManager.do?action=goPage" method="post">
   		<input type="hidden" id="roleID" name="roleID"/>
   		<input type="hidden" id="roleName" name="roleName"/>
   </html:form>
</body>
</html>
