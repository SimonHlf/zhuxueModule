<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
<title>助学网--后台模块管理</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/personalInfo.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="Module/commonJs/progressBar/css/progressBar.css">
<link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
<link type="text/css" rel="stylesheet" href="Module/personalCen/css/imgareaselect-default.css">
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/personalCen/js/personalJs.js"></script>
<script type="text/javascript" src="Module/commonJs/progressBar/js/progressBar.js"></script>
<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="Module/personalCen/js/updatePass.js"></script>
<script type="text/javascript" src="Module/personalCen/js/jquery.imgareaselect.min.js"></script>
<script type="text/javascript" src="Module/personalCen/js/cutImg.js"></script>
<script type="text/javascript">
var oldPhoneNumber = "";
$(function(){
	fnTabNav($('.tab'),$('.tabcon'),'click');
	checkPasStrongWeak();
	checkNewPass();
	checkConfirmPas();
	choiceOptionAns();
});

function checkEmail(email){
	//var szReg=/^[A-Za-zd]+([-_.][A-Za-zd]+)*@([A-Za-zd]+[-.])+[A-Za-zd]{2,5}$/; 
	var szReg = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
	var flag = szReg.test(email); 
	return flag;
}
function checkPhone(phone){
	var partten = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
	return partten.test(phone);
}
function checkQQ(qq){
	var szReg = /^[1-9][0-9]{4,9}$/;
	var flag = szReg.test(qq); 
	return flag;
}
function saveInfo(){
	var nickname = document.getElementById("nickName").value;
	var realname = document.getElementById("realName").value;
	var mobile = document.getElementById("phoneNum").value;
	var birthday = $('#birthday').datebox('getValue');
	var email = document.getElementById("contractMail").value;
	var qq = document.getElementById("qqNum").value;
	var sex = check_radio();

	if(nickname=="null"||nickname==""){
		alert("昵称未填写！");
		getId("nickName").focus();
		return false;
	}
	else if(realname=="null"||realname==""){
		alert("真实姓名未填写！");
		getId("realName").focus();
		return false;
	}
	else if(birthday=="null"||birthday==""){
		alert("生日未填写！");
		return false;
	}
	else if(sex=="null"||sex==""){
		alert("性别未选择！");
		return false;
	}
	else if(email=="null"||email==""){
		alert("联系邮箱未填写！");
		getId("contractMail").focus();
		return false;
	}
	else if(mobile=="null"||mobile==""){
		alert("手机号码未填写！");
		getId("phoneNum").focus();
		return false;
	}
	else if(checkEmail(email) == false){
		alert("邮箱格式不正确！");
		getId("contractMail").focus();
		return false;
	}
	else if(qq=="null"||qq==""){
		alert("QQ号码未填写！");
		getId("qqNum").focus();
		return false;
	}
	else if(checkQQ(qq) == false){
		alert("QQ号码格式不正确！");
		getId("qqNum").focus();
		return false;
	}
	else{
		$.ajax({
			type:"post",
			async:false,
		    dataType:"json",
			url:'userManager.do?action=saveInfo&realname='+encodeURIComponent(realname)+'&nickname='+encodeURIComponent(nickname)+'&sex='+encodeURIComponent(sex)+'&email='+encodeURIComponent(email)
					+'&mobile='+mobile+'&birthday='+birthday+'&qq='+qq,
			success:function(json){
				if(json){
					alert("信息已保存！");
					return true;
				}else {
					alert("用户修改个人信息保存失败，请重试！");
				}
			}
		});
	}
} 
function check_radio(){
   var sexValue = "";
   var chkObjs = document.getElementsByName("sex");
   for(var i=0;i<chkObjs.length;i++){
       if(chkObjs[i].checked){
           sexValue = chkObjs[i].value;
           if(sexValue != "男" && sexValue != "女"){
        	   sexValue = "男";
           }
       }
   }
   return sexValue;
}

$(function(){  
	$('#birthday').datebox( {      
		currentText : '今天',      
		closeText : '关闭',      
		disabled : false,     
		required : false, 
		editable :false,
		formatter : function(formatter){
		    var year = formatter.getFullYear().toString();
		    var month = (formatter.getMonth() + 1);
		    if(month < 10){
		    	month = "0"+month;
		    }
		    var day = formatter.getDate();
		    if(day < 10){
		    	day = "0"+day;
		    }
    	  	return year+"-"+month+"-"+day;  
		}
    });
});

function showUploadWindow(){
	   document.getElementById("upLoadImageDiv").style.display="";
	   $("#upLoadImageDiv").window({
		   title:"头像上传",
		   width:400,
		   height:245,
		   collapsible:false,
		   minimizable:false,
		   maximizable:false,
		   resizable:false,
		   modal:true
	   });
}
function closeWindow(){
	   $("#upLoadImageDiv").window("close");
}


function updateUserImage(){
	   var image = document.getElementById("dd").value;
	   var x=$("#x1").val();
	   var y=$("#y1").val();
	   var w=$("#w").val();
	   var h=$("#h").val();
	   if(image==""){
		   parent.window.location.href="personalCenter.do?action=welcome"; 
	   }else{
		   if(x==""){
			   alert("请截取上传的头像!");
		   }else{
			   if(image!=""){
				   $.ajax({
					   type:"post",
					   async:false,
					   dataType:"json",
					   url:'userManager.do?action=updateUserImage&portrait='+image+'&x='+x+'&y='+y+'&w='+w+'&h='+h,
					   success:function(json){
						   if(json){
							   alert("上传成功！");
							   parent.window.location.href="personalCenter.do?action=welcome";
						   }else{
							   alert("上传失败，请重试！");
						   }
					   }
				   }); 
			   }else{
				   alert("请选择头像图片！");
			   }
		   }
	   }
}

function checkPass(){
	   var nowPass = document.getElementById("nowPass").value;
	   var newPass = document.getElementById("newPass").value;
	   var conNewPass = document.getElementById("conNewPas").value;
	   if(nowPass==""){
		  alert("请输入当前密码！");
	   }else if(!checkExist(nowPass)){
		   alert("当前密码输入错误！请重新输入！");
		   document.getElementById("nowPass").value="";
	        }else if(newPass==""){
	        	   alert("请输入新密码！");
	             }else if(newPass.length<6){
	            	 alert("新密码必须大于等于6位，请重新输入");
	            	 $('.succPass').hide();
	            	 document.getElementById("newPass").value="";
	            	 document.getElementById("conNewPas").value="";
	             }else if(newPass==nowPass){
	            	 alert("新密码不能与旧密码相同，请重新输入");
	            	 $('.succPass').hide();
	            	 document.getElementById("newPass").value="";
	            	 document.getElementById("conNewPas").value="";
	             }else if(conNewPass==""){
	        	        alert("请再次输入新密码进行确认！");
                 }else if(conNewPass!=newPass){
       	             alert("两次输入的密码不一致,请重新输入！");
       	             document.getElementById("conNewPas").value="";
                 }else{
      	               updatePass(newPass);
      	               window.location.reload();
	        }
}

function verCode(){
	var obj = document.getElementById("sessCode");
		obj.src = "authImg?code="+Math.random()+100;
}
function detachEmail(){
	document.getElementById("detachMailWin").style.display="";
	$("#detachMailWin").window({
		title:"绑定邮箱",
		width:400,
		height:245,
		collapsible:false,
		minimizable:false,
		maximizable:false,
		resizable:false,
		modal:true
	});
}
function closeAttachMail(){
	$("#detachMailWin").window("close");
}
function sendMail(){
	var vercode = document.getElementById("vercode1").value;
	var email = document.getElementById("contractMail1").value;
	if(email==""){
		alert("请输入绑定邮箱！");
	}else if(email != "" && !checkEmail(email)){
		alert("邮箱格式不对！");
	}else if(vercode=="请输入验证码" || vercode == ""){
		alert("请输入验证码！");
		document.getElementById("vercode1").value="";
	}else {
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"userManager.do?action=sendMail&email="+email+"&vercode="+vercode,
			success:function(json){
				 if(json=="vercodeFail"){
						alert("验证码输入错误，请重试！");
				}else if(json=="success"){
						alert("邮箱绑定成功！绑定信息已发送至邮箱，请查收！");
						closeAttachMail();
						window.location.reload(true);
				}
			}
		});
	}
}
function connPhone(){
	oldPhoneNumber = document.getElementById("phoneNum").value;
	document.getElementById("connPhoneWin").style.display="";
	$("#connPhoneWin").window({
		title:"绑定手机",
		width:400,
		height:245,
		collapsible:false,
		minimizable:false,
		maximizable:false,
		resizable:false,
		modal:true
	});
}
function closeConnPhone(){
	$("#connPhoneWin").window("close");
}
var count=120;
var curCount=60;
var vercodeLength=6;
var InterTime;

function sendMessage(){
	var phoneNum=document.getElementById("phoneNum1").value;
	var vercode="";
	if(phoneNum==""){
		alert("请输入要绑定的手机号码！");
	}else {
		if(oldPhoneNumber == phoneNum){
			alert("系统检测到你需要绑定的手机号码未发生变化，不能进行绑定!");
		}else{
			if(!checkPhone(phoneNum)){
				alert("手机格式不对!");
			}else{
				for(var i=0;i<vercodeLength;i++){
					vercode+=parseInt(Math.random()*9);
				}
				showBtnCodeStyle();
				$.ajax({
					type:"post",
					async:false,
					dataType:"json",
					url:"userManager.do?action=sendMessage&phoneNum="+phoneNum+"&vercode="+vercode,
					success:function(json){
						if(json=="1"){
							getId("sessionCode").value = vercode;
							alert("短信验证码已发送到您手机，请查收！");
						}else if(json=="0"){
							alert("短信验证码发送失败，请重新获取！");
						}
					}
				});		
			}	
		}		
	}
}
//获取按钮禁止动作
function showBtnCodeStyle(){
	$("#sessCode_btn").attr("disabled", "disabled");
    $("#sessCode_btn").val(curCount + "秒后重新获取");
    curCount--;
	if(curCount > 0){
		setTimeout(showBtnCodeStyle,1000);
	}else{
		$("#sessCode_btn").val("重新获取验证码");
        $("#sessCode_btn").removeAttr("disabled");
		curCount = 60;
	}
}
function bindMobile(){
	var phoneNum = document.getElementById("phoneNum1").value;
	var vercode = document.getElementById("vercode").value;
	var vercode1=document.getElementById("sessionCode").value;
	if(phoneNum.length<11){
		alert("请输入正确的手机号码！");
	}else if(!checkPhone(phoneNum)){
		alert("手机格式不对!");
	}else if(vercode=="" || vercode=="请输入验证码"){
		alert("请输入收到的验证码！");
	}else if(vercode!=vercode1){
		alert("验证码输入错误，请重新输入！");
	}else{
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"userManager.do?action=bindMobile&phoneNum="+phoneNum,
			success:function(json){
				if(json){
					alert("手机绑定成功！");
					closeConnPhone();
					window.location.reload(true);
				}else{
					alert("手机绑定失败，请重试！");
				}
			}
		});
		
	}
}

function choiceOptionAns(){
	$(".sexBox input").each(function(){
		$(this).click(function(){
			$(this).parent("div").addClass("choiceActive").append("<em class='choiceIcon'></em>").siblings().removeClass("choiceActive").find('em').remove();
			
		});
	});
}

</script>
</head>

<body>
	<div class="nowPosition">
		<p><span class="fontSet"><span class="weightSpan">个</span>人资料设置</span> &gt; <span class="nowInfo">资料设置</span></p>
	</div>
	<div class="perFixCon">
		<ul class="tab">
			<li onclick="replaceText1()" class="active">资料设置</li>
			<li onclick="replaceText2()">头像设置</li>
			<li onclick="replaceText3()">安全设置</li>
			<li onclick="replaceText4()">密码管理</li>
			<c:if test="${sessionScope.roleName == '学生'}">
				<li onclick="replaceText5()">绑定家长</li>
			</c:if>
		</ul>
		<div class="con">
			<!-- 资料设置 -->
			<div class="tabcon clearfix"  style="display:block;">
				<form id="perForm" method="post" action="">
				 <input type="hidden"  id="id" value=${sessionScope.userID}/>
                  <c:forEach items="${requestScope.uList}" var="user">
					<div class="parentLay">
						<span class="smallIcon"></span>
						<div class="titleFont fl">
							<span class="fl">基本信息</span><span class="line fl"></span>
						</div>
						<div class="account fl">
							<div class="comDiv">
								帐<span class="twoBlank"></span>号：<span class="color"><c:out value="${user.username}"/></span>
							</div>	
							<div class="comDiv">
								昵<span class="twoBlank"></span>称：<input id="nickName" class="comInp" type="text" maxlength="6" value="<c:out value="${user.nickname}"/>"/>
								<span class="color1">用于页面显示的名字</span>
							</div>
							<div class="comDiv">
								<span class="ml">真实姓名</span>：<input id="realName" class="comInp" type="text" value="<c:out value="${user.realname}"/>"/>
								<span class="color1">请输入中文真实姓名</span>
							</div>
							<div class="comDiv">
								生<span class="twoBlank"></span>日：<input id="birthday"  class="easyui-datebox" type="text"  value="<c:out value="${user.birthday}"/>" />
							</div>
							<div class="comDiv">
								<span class="fl">性<span class="twoBlank"></span>别：</span>
								<c:if test="${user.sex=='男'}">
								  <div class="sexBox">
								  	男
								  	<input id="sex" type="radio" name="sex" checked="checked" value="男"/>
								  	<em class="choiceIcon"></em>
								  </div>
								  <div class="sexBox">
								  	女
								  	<input id="sex" type="radio" name="sex" value="女"/>
								  </div>
                                </c:if>
                                <c:if test="${user.sex=='女'}">
                                 <div class="sexBox">
								  	男
								  	<input id="sex" type="radio" name="sex" value="男"/>
								  </div>
								  <div class="sexBox">
								  	女
								  	<input id="sex" type="radio" name="sex"  checked="checked" value="女"/>
								  	<em class="choiceIcon"></em>
								  </div>
                                </c:if>
                                <c:if test="${user.sex==''}">
                                 <div class="sexBox">
								  	男
								  	<input id="sex" type="radio" name="sex" checked="checked" value="男"/>
								  	<em class="choiceIcon"></em>
								  </div>
								  <div class="sexBox">
								  	女
								  	<input id="sex" type="radio" name="sex" value="女"/>
								  </div>
                                </c:if>
							</div>
						</div>
					</div>
					
					<div class="parentLay">
						<span class="smallIcon top2"></span>
						<div class="titleFont fl">
							<span class="fl">联系信息</span><span class="line fl"></span>
						</div>
						<div class="account fl">
							<div class="comDiv">
							   	联系邮箱：<input id="contractMail" class="comInp" type="text" value="<c:out value="${user.email}"/>"/>
							</div>	
							<div class="comDiv">
								<c:if test="${user.mobile != ''}">
									手机号码：<input id="phoneNum" class="comInp" type="text" maxlength="11" value="<c:out value="${user.mobile}"/>" disabled/>
								</c:if>
								<c:if test="${user.mobile == ''}">
									手机号码：<input id="phoneNum" class="comInp" type="text" maxlength="11" value="<c:out value="${user.mobile}"/>"/>
								</c:if>
							</div>
							<div class="comDiv">
								QQ<span class="qqBlank"></span>号码：<input id="qqNum" class="comInp" type="text" value="<c:out value="${user.qq}"/>"/>
							</div>
						</div>
					</div>
					<input class="savaInfo" type="submit" value="保存" onClick="return saveInfo()"/>
				  </c:forEach>
                  
				</form> 
			</div>
			<!-- 头像设置 -->
			<div class="tabcon">
			 <input type="hidden"  id="id" value=${sessionScope.userID}/>
              <c:forEach items="${requestScope.uList}" var="user">
	               <div><font size="3">我的头像：</font></div>
	               <div class="Img">
	                  <img src="${user.portrait}" id="imgID" style="background-color: white;" alt="" />
				     <input type="hidden" id="dd" > 
	               </div> 
	               <form action="userManager.do" method="post">
	               	 <span class="uploadBtn" onclick="showUploadWindow()">
	               	 	<i class="upIcon"></i>
	               	 	上传头像
	               	 </span>
	                 <!--  input type="button" value="头像上传" onclick="showUploadWindow()"/-->
	                 	<input type="hidden" size="4" id="x1" name="x1" />
				   	    <input type="hidden" size="4" id="y1" name="y1" />
				        <input type="hidden" size="4" id="w" name="w" />
				        <input type="hidden" size="4" id="h" name="h" />
	                 <input type="button" class="savaInfo1" value="保存" onclick="updateUserImage()"/>
	              </form>
	             <div id="upLoadImageDiv" style="display:none">
	              	<iframe name="upIframeFile" id="upIframeFile" height="98%" width="100%" src="userManager.do?action=uploadImage" frameborder="0" scrolling="no"></iframe>
	             </div>
             </c:forEach>
		    </div>
			<!-- 安全设置 -->
			<div class="tabcon clearfix">
			  <input type="hidden"  id="id" value=${sessionScope.userID}/>
              <c:forEach items="${requestScope.uList}" var="user">
				<div class="parentLay">
					<span class="smallIcon"></span>
					<div class="titleFont fl">
						<span class="fl">设置信息</span><span class="line fl"></span>
					</div>
					<div class="account fl">
						<!-- IP地址 -->
						<div class="comDiv">
							<span class="gpsIcon"></span>
							<span class="Gps">
								位置信息：上次登录:
								<!--  <span class="sysTime">2014-07-14 16:31:23 </span>
								（<span class="detailGps">郑州</span>） -->
								<span class="sysTime"><c:out value="${user.lastLoginDate}"></c:out></span>
								（<span class="detailGps"><c:out value="${user.lastLoginIp}"></c:out></span>）
							</span>
						</div>	
						<!-- 邮箱 -->
						<div class="comDiv">
							<span class="mailIcon"></span>
							<span class="ml3 fl">安全邮箱：</span>
							<c:if test="${user.email==''}">
							<div class="noDetachMail fl">
								<span class="noMail">暂未绑定安全邮箱</span>
								<span id="mailInfo" class="color1">邮箱可以用于帮您找回密码</span>
							</div>
							<a href="javascript:void(0)" id="attachMail" class="attachBtn fl" onclick="detachEmail()">绑定</a>
							<!--a href="javascript:void(0)" id="fixMail" class="attachBtn">修改</a-->
							</c:if>
							<c:if test="${user.email!=''}">
							 <div class="noDetachMail fl">
							   <span>已设置安全邮箱
							     <c:out value="${fn:substring(user.email,0,1)}"/>
							     <c:forEach  begin="1" end="${fn:indexOf(user.email,'@')-1}">*</c:forEach>
							     <c:out value="@${fn:split(user.email,'@')[1]}"/>
							   </span>
							   <!--input type="button" value="更改绑定邮箱" onclick="detachEmail()"-->
							   <a href="javascript:void(0)" id="fixMail" class="attachBtn" onclick="detachEmail()">修改</a>
							 </div>
							</c:if>
						</div>
						<!-- 手机 -->
						<div class="comDiv">
						  <c:if test="${user.mobile==''}">
							<span class="phoneIcon"></span>
							<span class="ml3 fl">绑定手机：</span>
							<div class="noDetachPhone fl">
								<span class="noPhone">暂未绑定手机</span>
								<span id="phoneInfo" class="color1">用于帮您找回密码，另外还可以接收相关资讯</span>
							</div>
							<!-- a href="javascript:void(0)" id="attachPhone" class="attachBtn" onclick="connPhone()">绑定</a-->
						  </c:if>
						  <c:if test="${user.mobile!=''}">
						    <div class="noDetachPhone fl">
						    <span class="phoneIcon"></span>
							<span class="ml3 fl">绑定手机：</span>
						      <span>已绑定手机号<c:out value="${fn:substring(user.mobile,0,2)}*******${fn:substring(user.mobile,9,11)}"></c:out></span>
						      <!-- input type="button" value="更改绑定手机" onclick="connPhone()"-->
						      <a href="javascript:void(0)" id="fixPhone" class="attachBtn" onclick="connPhone()">更改绑定手机</a>
						    </div>
						  </c:if>
						</div>
					</div>
				</div>
		       </c:forEach>
			</div>
			<!-- 密码设置 -->
			<div class="tabcon clearfix">
				<div class="parentLay">
				 <form name="changePassForm" action="" method="post">
                 <input type="hidden" id="userName" name="userName">
					<span class="smallIcon"></span>
					<div class="titleFont fl">
						密码管理
						<span class="line"></span>
					</div>
					<div class="account fl">
						<!-- 当前密码  -->
						<div class="comDiv">
							当前密码：<input id="nowPass" type="password" class="comInp" maxlength="16"  onpaste="return false;" onblur="checkOldPass()"/>
							<!-- 当前密码错误 -->
							<div class="nowPasError">
								<span class="errorIcon iCon"></span>
								<span class="errorPas">原密码错误</span>
							</div>
							<!-- 当前密码不能为空 -->
							<div class="nowPasNull">
								<span class="nullIcon iCon"></span>
								<span class="nullPas">原密码不能为空</span>
							</div>
							<!-- 当前密码正确 -->
							<div class="nowPasSucc">
								<span class="succIcon iCon"></span>
							</div>
						</div>	
						<!-- 新密码  -->
						<div class="comDiv">
							<span class="ml2">新密码</span>：<input id="newPass" type="password" class="comInp" maxlength="16" onpaste="return false;"/>
							<!-- 新密码设置说明 -->
							<div class="newPassDesc">
								<span class="infoIcon iCon"></span>
								<div class="newPasInfo">新密码由6-16字符（字母、数字、符号）组成，区分大小写</div>
							</div>
							<!-- 新密码不能为空 -->
							<div class="newPasNull">
								<span class="nullPassIcon iCon"></span>
								<div class="newNullPass">新密码不能为空</div>		
							</div>
							<!-- 新密码长度不能小于6个字符 -->
							<div class="newPassLen">
								<span class="lenIcon iCon"></span>
								<div class="passLength">新密码长度不能小于6个字符</div>
							</div>
							<!-- 新密码不能与旧密码相同 -->
							<div class="newPasDifOld">
								<span class="lenIcon iCon"></span>
								<div class="diffNew">新密码不能与旧密码一样</div>
							</div>
							<!-- 新密码设置正确-->
							<div class="succNewPas">
								<span class="succIcon iCon"></span>
							</div>
						</div>
						<!-- 密码强弱 -->
						<div id="pasStrongWeak" class="pasStrongWeak">
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
						<!-- 确认新密码  -->
						<div class="comDiv1">
							<span class="conText">确认新密码：</span><input id="conNewPas" type="password" class="comInp" maxlength="16" onpaste="return false;"/>
							<!-- 确认新密码不能为空 -->
							<div class="conPassNull">
								<span class="conPasNullIcon iCon"></span>
								<div class="conNullPass">确认新密码不能为空</div>	
							</div>
							<!-- 两次输入的密码不一样，请重新输入 -->
							<div class="diffPas">
								<span class="conPasNullIcon iCon"></span>
								<div class="passDIff">两次输入的密码不一致，请从新输入</div>
							</div>
							<!-- 确认密码正确 -->
							<div class="succPass">
								<span class="succPassIcon iCon"></span>
							</div>
						</div>	
						<input class="savaInfo1" type="button" value="保存" onclick="checkPass()"/>
					</div>
				  </form>
				</div>
			</div>
			<!-- 绑定家长  -->
			<div class="tabcon clearfix">
				<div class="parentAttach">
					<h2 class="attTit">家长账号绑定</h2>
					<div class="botAttCon">
						<span class="attachIcon"></span>
						<p class="parPt">家长帐号：${requestScope.userName_jz}</p>
						<p class="parPl">家长密码：${requestScope.password_jz}</p>
					</div>
					<p class="useTxt">家长使用此号登录系统</p>
				</div>
			</div>
		</div>
	</div>
	<!-- 邮箱的绑定窗口 -->
	<div id="detachMailWin" style="display:none">
		 <input type="hidden"  id="id" value=${sessionScope.userID}/>
	     <c:forEach items="${requestScope.uList}" var="user">
			 <center>
			 	<div class="comDiv margT">
			 		<span class="ml">安全邮箱：</span><input type="text" id="contractMail1" class="comInp" value="<c:out value="${user.email}"/>" >
			 	</div>
				
			    <div class="comDiv">
					 <span class="ml">验<span class="blank"></span>证<span class="blank"></span>码：</span><input type="text" id="vercode1" class="comInp" value="请输入验证码" onfocus="this.value=''"/>
				</div>
				 <div class="vercodeBox">
					<img id="sessCode" src="authImg" alt="请输入验证码"/>
					<a href="javascript:void(0)" class="changePicBtn" onclick="verCode()">看不清，换一张</a>
				 </div>
				<br>
			    <input type="submit" class="sure" value="确定" onclick="sendMail()">
			    <input type="button" class="cancel" value="取消" onclick="closeAttachMail()">
			 </center>
		 </c:forEach>
	</div>
	<!-- 手机的绑定窗口 -->
	<div id="connPhoneWin" style="display:none">
	 	<input type="hidden"  id="id" value=${sessionScope.userID}/>
	     <c:forEach items="${requestScope.uList}" var="user">
		     <center>
		     	<div class="comDiv margT">
		       		<span class="ml">手机号码：</span><input id="phoneNum1" class="comInp" type="text" maxlength="11" value="<c:out value="${user.mobile}"/>"/>
		      	</div>
			   	<div class="comDiv">
				 	<span class="mlSp">验<span class="blank"></span>证<span class="blank"></span>码：</span><input type="text" id="vercode" class="comInp1" value="请输入验证码" onfocus="this.value=''"/>
				 	<input type="button" id="sessCode_btn" class="getFreeCode" value="获取验证码" onclick="sendMessage()">
			  	</div>
			   <br>
			    <input type="submit" class="sure" value="确定" onclick="bindMobile()">
			    <input type="button" class="cancel" value="取消" onclick="closeConnPhone()">
			    <br>
			    <div id="seeeionSoceDiv" style="display:none;">
			    	<input type="hidden" id="sessionCode"/>
			    </div>
		     </center>
	     </c:forEach>
	</div>
</body>
</html>
