var now=0;
var iNow=0;
var freeCodeFlag = false;
var classCodeFlag = false;
var familyCodeFlag = false;
var accountFlag = false;
var passFlag = false;
var confirmFlag = false;
var realNameFlag = false;
var mobileFlag = false;
var nextClickFlag = true;
//角色名称的选择
function choiceRole(){
	var oRoleBridge=getId("roleBridge");
	var oRoleChoice=getId("roleChoice");
	var aInput=oRoleChoice.getElementsByTagName("input");
	var aEm=oRoleChoice.getElementsByTagName("em");
	for(var i=0;i<aInput.length;i++){
		aInput[i].index=i;
		aInput[i].onclick=function(){
			if(aInput[this.index].checked==true){
				oRoleBridge.value=aEm[this.index].innerHTML;
			}
		};
	}
}

//判断基本信息
function checkBasicInfo(){
	if(checkRegLoginAccount() && checkLoginPassword() && checkConfirmPassword() && checkRealName() && checkPhoneNum()){
		return true;
	}else{
		return false;
	}
}

//判断学科有么有选择
function checkSubjectSelect(){
	var roleName = $("#roleBridge").val();
	if(roleName == "老师" || roleName == "网络导师"){
		var subjectID = getId("subjectID").value;
		if(subjectID == "0"){
			//alert("请选择学科");
			$("#subJect").show();
			return false;
		}else {
			$("#subJect").hide();
			return true;
		}
	}else{//如果是其他身份，不用选择，直接返回true
		return true;
	}
	
}
//判断学段有没有选择
function checkSchoolTypeSelect(){
	var roleName = $("#roleBridge").val();
	if(roleName == "网络导师"){
		var schoolTypeName = getId("schoolTypeName").value;
		if(schoolTypeName == "0"){
			//alert("请选择学段");
			$("#xueduan").show();
			return false;
		}else {
			$("#xueduan").hide();
			return true;
		}
	}else{//如果是其他身份，不用选择，直接返回true
		return true;
	}
}
//判断教材版本有没有选择
function checkEditionSelect(){
	var roleName = $("#roleBridge").val();
	if(roleName == "老师"){
		var editionID = getId("editionID").value;
		if(editionID == "0"){
			//alert("请选择教材版本");
			$("#pub").show();
			return false;
		}else{
			$("#pub").hide();
			return true;
		}
	}else{//其他身份不需要判断。
		return true;
	}
}
//DIV跳转(1：跳一步，2：跳转2部)
function gotoDiv(value){
	if(value < 3){
		now += 1;
	}
	if(now==$("#registerNav li").length-1){		
		$("#next").removeClass("showBtn");
		$("#prev").removeClass("showBtn");
		//添加插入数据库动作（有邀请码）
	}
	$("#registerNav li").removeClass("active").eq(now).addClass("active");
	$("#registerForm dd").hide().eq(now).show();
}

//注册上一步下一步
//下一步
function showRegFormNext(){
	var flag_freeCode = false;
	var flag_classCode = false;
	var flag_userName = false;
	var flag_password = false;
	var flag_confirm = false;
	var flag_realName = false;
	var flag_mobile = false;
	var flag_code = false;
	var flag_subject = false;
	var flag_schoolType = false;
	var flag_eidtion = false;
	$("#next").click(function(){
		$("#prev").addClass("showBtn");
		if(now == 0){//第一步
			now += 1;
			$("#registerNav li").removeClass("active").eq(now).addClass("active");
			$("#registerForm dd").hide().eq(now).show();
			if($("#roleBridge").val()=='老师' || $("#roleBridge").val()=='网络导师'){
	
				getId("basicSubejctTypeDiv").style.display = "block";
				//老师不需要选择学段(第三步有学段)
				if($("#roleBridge").val()=='老师'){
					getId("basicSchoolTypeDiv").style.display = "none";
					getId("basicEditionDiv").style.display = "block";
				}else{
					getId("basicSchoolTypeDiv").style.display = "block";
					getId("basicEditionDiv").style.display = "none";
				}
			}else{
				getId("basicSubejctTypeDiv").style.display = "none";
				getId("basicSchoolTypeDiv").style.display = "none";
				getId("basicEditionDiv").style.display = "none";
			}
		}else if(now == 1){//第二步
			
			
			if($('#freeCode').val()!=''){
				if(checkFreeCode()){//数据库判断邀请码
					flag_freeCode = true;
				}else{//未成功
					flag_freeCode = false;
				}
			}else{
				flag_freeCode = true;
			}
			if($('#classCode').val()!=''){
				if(checkClassInviteCode()){//数据库判断班级邀请码(老师和学生用)
					flag_classCode = true;
					now += 2;
				}else{//未成功
					
					flag_classCode = false;
				}
			}else{
				if(now == 3){
					now -= 2;
				}
				flag_classCode = true;
			}
			if($("#userName").val() == ""){
				$(".regAccount1").show();
				$(".regAccount").hide();
				$(".regAccountSucc").hide();
				flag_userName = false;
			}else{
				if(checkRegLoginAccount()){//判断用户名
					flag_userName = true;
				}else{
					flag_userName = false;
				}
			}
			if($("#userPassword").val() == ""){
				$(".passwordNull").show();
				$(".passwordWarn").hide();
				flag_password = false;
			}else{
				if(checkLoginPassword()){//判断登录密码
					flag_password = true;
				}else{
					flag_password = false;
				}
			}
			if($("#confirmPass").val() == ""){
				$(".passConfirmNull").show();
				$(".passConfirm").hide();
				flag_confirm = false;
			}else{
				if(checkConfirmPassword()){//判断确认密码
					flag_confirm = true;
				}else{
					flag_confirm = false;
				}
			}
			if($("#realName").val() == ""){
				$(".relNameNull").show();
				$(".relNameSucc").hide();
				flag_realName = false;
			}else{
				if(checkRealName()){//判断真实姓名
					flag_realName = true;
				}else{
					flag_realName = false;
				}
			}
			if($("#phoneNumber").val() == ""){
				$(".rightPhoneNum").show();
				$(".phoneNum").hide();
				flag_mobile = false;
			}else{
				if(checkPhoneNum()){//判断手机号码
					flag_mobile = true;
				}else{
					flag_mobile = false;
				}
			}
			if($("#codeNumber").val() == ""){
				//alert("请输入手机短信验证码!");
				$(".emptyCode").show();
				flag_code = false;
			}else{
				if(checkPhoneCode()){//判断手机验证码
					$(".rightCode").show();
					flag_code = true;
				}else{
					//alert("短信验证码不正确或已过期!");
					$(".wrongCode").show();
					flag_code = false;
				}
			}
			if(checkSubjectSelect()){//判断学科
				//老师和网络导师需要验证，其他身份直接通过
				flag_subject = true;
			}else{
				flag_subject = false;
			}
			if(checkSchoolTypeSelect()){//判断学段
				//老师和学生需要判断，其他身份直接通过
				flag_schoolType = true;
			}else{
				flag_schoolType = false;
			}
			if(checkEditionSelect()){//判断教材版本
				flag_eidtion = true;
			}else{
				flag_edition = false;
			}
			if(flag_freeCode && flag_classCode && flag_userName && flag_password && flag_confirm && flag_realName && flag_mobile && flag_code && flag_subject && flag_schoolType && flag_eidtion){
				if($("#roleBridge").val()=='网络导师'){
					now = 3;
				}
				if(now == 3){
					if(nextClickFlag){
						if(checkAddInfo()){
							gotoDiv(now);
						}else{
							now -= 2;
						}
						nextClickFlag = false;
					}
				}else{
					gotoDiv(now);
				}
				
			}else{
				if(now == 3){
					now -= 2;
				}
			}
		}else{//第三步
			if(now < $("#registerNav li").length-1){
				if(nextClickFlag){
					if(checkAddInfo()){
						nextClickFlag = false;
						now++;
						if(now == $("#registerNav li").length-1){
							//将下一步按钮设置成不可点击状态
							$("#next").removeClass("showBtn");
							$("#prev").removeClass("showBtn");
						}
						$("#registerNav li").removeClass("active").eq(now).addClass("active");
						$("#registerForm dd").hide().eq(now).show();
					}else{
						nextClickFlag = true;
					}
				}
			}else{
				$("#prev").removeClass("showBtn");
			}
		}
		//当前身份的判断以及当前身份下对应的图片判断
		$("#regUser").html($("#roleBridge").val());
		if($("#roleBridge").val()=='学生'){
			$(".idenImg").attr('id','student');
		}else if($("#roleBridge").val()=='管理员'){
			$(".idenImg").attr('id','manager');
		}else if($("#roleBridge").val()=='老师'){
			$(".idenImg").attr('id','teacher');
		}else if($("#roleBridge").val()=='网络导师'){
			$(".idenImg").attr('id','netTeacher');
		}else{
			$(".idenImg").attr('id','parentUser');
		}
		//邀请码输入框的判断
		if($("#roleBridge").val() != "管理员"){
			if($("#roleBridge").val() == "学生"){
				$("#freeInvCode").show();
				$("#classInvCode").show();
			}else if($("#roleBridge").val() == "老师"){//老师
				$("#freeInvCode").hide();
				$("#classInvCode").show();
			}else{
				$("#freeInvCode").show();
				$("#classInvCode").hide();
			}
		}else{
			$("#freeInvCode").hide();
			$("#classInvCode").hide();
		}
		//导航绑定学校信息或者绑定学段信息的文字判断
		if($("#roleBridge").val()=='网络导师'){
			$("#attach").html('绑定学段信息');
			$(".attachTit").html("绑定学段信息");
		}else{
			$("#attach").html('绑定学校信息');
			$(".attachTit").html("绑定学校信息");
		}
		//注册成功后的帐号和用户名的传值
		$("#succUserIden").html($("#roleBridge").val());
		$("#succAccount").html($("#userName").val());
		if($("#roleBridge").val() == "学生"){
			$(".parentAccount").show();
			$("#parAccount").html($("#userName").val());
		}
	});
}
//上一步
function showRegFormPrev(){
	$("#prev").click(function(){
		if(now==0){
			return;
		}else{
			if(now < $("#registerNav li").length-1){
				now--;
				if(now==$("#registerNav li").length-2){
					$("#next").addClass("showBtn");
				}else if(now==0){
					window.location.reload(true);
					$("#prev").removeClass("showBtn");
				}
				$("#registerNav li").removeClass("active").eq(now).addClass("active");
				$("#registerForm dd").hide().eq(now).show();
			}
		}
	});
}
//input 邀请码的检测
//第一个邀请码
function checkFreeCode(){
	var flag = false;
	var oFreeCode=$("#freeCode");
	var roleName = $("#roleBridge").val();
	var inviteType = "";
	if(roleName == "学生" || roleName == "网络导师"){
		inviteType = "导师邀请码";
		flag = true;
	}else{//其他身份不需要
		flag = false;
	}
	if(flag){
		oFreeCode.focus(function(){
			$(".freeInvite").show();
			$(".freeCodeReq").hide();
			$(".notExistCode").hide();
			$(".succFreeCode").hide();
			$(".succNetTea").hide();
		});
		oFreeCode.blur(function(){
			if($(this).val()==''){
				$(".freeInvite").hide();
				$(".freeCodeReq").hide();
				$(".notExistCode").hide();
				$(".succNetTea").hide();
			}else{
				if($(this).val().length<6){
					$(".freeCodeReq").show();
					$("#infoDetail").show();
					$(".freeInvite").hide();
					$(".notExistCode").hide();
					$(".succFreeCode").hide();
					$(".succNetTea").hide();
					freeCodeFlag = false;
				}else{
					if(checkDataBaseInviteCode(inviteType,oFreeCode.val()) != ""){
						var inviteInfoJson = checkDataBaseInviteCode(inviteType,oFreeCode.val());
						var inviteInfo = inviteInfoJson[0].inviteMan;
						var netTeacherInfoJson = getNetTeacher(inviteInfo);
						$(".succNetTea").show();
						$(".succText").html('系统为您分配为的网络导师是：<em style="color:green;font-style:normal;">'+ netTeacherInfoJson[0].user.nickname +'</em>');
						//alert(netTeacherInfoJson[0].user.nickname);
						//----------------------获取网络导师信息-------------------------//
						//这里只需要显示网络导师名字和所辅导的课程
						$(".freeInvite").hide();
						$(".freeCodeReq").hide();
						$(".notExistCode").hide();
						freeCodeFlag = true;
					}else{
						oFreeCode.focus();
						$(".notExistCode").show();
						$(".freeCodeReq").hide();
						$(".freeInvite").hide();
						$(".succNetTea").hide();
						freeCodeFlag = false;
					}
					
				}
			}
			
		});
	}else{
		freeCodeFlag = false;
	}
	
	return freeCodeFlag;
}

//邀请码检测（第二个）主要针对是班级邀请码（老师和学生用）
function checkClassInviteCode(){
	var oClassCode=$("#classCode");
	var roleName = $("#roleBridge").val();
	var inviteType = "班级邀请码";
	if(roleName == "学生" || roleName == "老师"){
		oClassCode.focus(function(){
			$(".classInvite").show();
			$(".classCodeReq").hide();
			$(".notExistCode1").hide();
			$(".succTipBtn").hide();
		});
		oClassCode.blur(function(){
			if($(this).val()==''){
				$(".classInvite").hide();
				$(".classCodeReq").hide();
				$(".notExistCode1").hide();
				$(".succTipBtn").hide();
				classCodeFlag = true;
			}else{
				if($(this).val().length<6){
					$(".classCodeReq").show();
					$(".classInvite").hide();
					$(".notExistCode1").hide();
					$(".succTipBtn").hide();
					classCodeFlag = false;
				}else{
					if(checkDataBaseInviteCode(inviteType,oClassCode.val()) != ""){
						var inviteInfoJson = checkDataBaseInviteCode(inviteType,oClassCode.val());
						var inviteInfo = inviteInfoJson[0].inviteMan;
						var classInfoJson = getClassInfo(inviteInfo)[0];
						var schoolInfo = classInfoJson.school;
						var county = schoolInfo.county;
						var town = schoolInfo.town;
						if(county == "0"){
							county = "";
						}
						if(town == "0"){
							town = "";
						}
						var classInfo = schoolInfo.province+"省"+schoolInfo.city+county+town+"["+schoolInfo.schoolType+"]"+schoolInfo.schoolName+classInfoJson.buildClassDate+classInfoJson.className;
						$(".succTipBtn").show();
						$(".infoText").html(classInfo);
						//alert(classInfo);
						//成功
						$(".classInvite").hide();
						$(".classCodeReq").hide();
						$(".notExistCode1").hide();
						classCodeFlag = true;
					}else{
						//失败
						oClassCode.focus();
						$(".notExistCode1").show();
						$(".classCodeReq").hide();
						$(".classInvite").hide();
						$(".succTipBtn").hide();
						classCodeFlag = false;
					}
				}
			}
			
		});
	}else{
		classCode = true;
	}
	return classCodeFlag;
}
//让快速绑定班级信息的盒子显示
function showInfoBox(){
	$(".succTipBtn").hover(function(){
		$("#classInvCode").css('z-index','10');
		$(".infoBox").show(300);
	},function(){
		$("#classInvCode").css('z-index','1');
		$(".infoBox").hide(300);
	});
}

//第三个邀请码（家庭邀请码）主要给家长和孩子用
function checkFamilyInviteCode(){
	var oFamilyCode=$("#familyCode");
	var roleName = $("#roleBridge").val();
	inviteType = "家庭邀请码";
	if(roleName == "学生" || roleName == "家长"){
		oFamilyCode.focus(function(){
			$(".freeInvite").show();
			$(".freeCodeReq").hide();
		});
		oFamilyCode.blur(function(){
			if($(this).val()==''){
				$(".freeInvite").hide();
				$(".freeCodeReq").hide();
			}else{
				if($(this).val().length<6){
					$(".freeCodeReq").show();
					$(".freeInvite").hide();
					familyCodeFlag = false;
				}else{
					//alert(checkDataBaseInviteCode(inviteType,oClassCode.val())+":::家庭邀请");
					$(".freeInvite").hide();
					$(".freeCodeReq").hide();
					familyCodeFlag = true;
				}
			}
			
		});
	}else{
		classCode = true;
	}
	return familyCodeFlag;
}
//input登录帐号注册input框提示
function checkRegLoginAccount(){
	var oUserName=$("#userName");
	oUserName.focus(function(){
		$(".regAccount").show();
		$(".regAccountSucc").hide();
		$(".regAccount1").hide();
		$(".existAccount").hide();
		$(".regAccountNull").hide();
		$(".regHasCn").hide();
		$(".specDot").hide();
	});
	oUserName.blur(function(){
		if($(this).val()==""){//判断注册账号不能为空
			$(".regAccountNull").show();
			$(".regAccount").hide();
			$(".regAccountSucc").hide();
			$(".regAccount1").hide();
			$(".existAccount").hide();
			$(".regHasCn").hide();
			$(".specDot").hide();
			accountFlag = false;
		}else{
			if((/[\u4e00-\u9fa5]+/).test(($(this).val()))){//判断注册账号不能为中文
				$(".regHasCn").show();
				$(".regAccountNull").hide();
				$(".regAccount").hide();
				$(".regAccountSucc").hide();
				$(".regAccount1").hide();
				$(".existAccount").hide();
				$(".specDot").hide();
				accountFlag = false;
			}else if(!(/^[a-zA-z0-9\u4E00-\u9FA5]*$/).test(($(this).val()))){//判断注册账号不能是特殊字符标点符号或者空格
				$(".specDot").show();
				$(".regAccount").hide();
				$(".regAccountSucc").hide();
				$(".regAccount1").hide();
				$(".existAccount").hide();
				$(".regAccountNull").hide();
				$(".regHasCn").hide();
				accountFlag = false;
			}else{
				if($(this).val().length<4){//注册账号长度不能小于四个字符
					$(".regAccount1").show();
					$(".regAccountNull").hide();
					$(".regAccount").hide();
					$(".regAccountSucc").hide();
					$(".existAccount").hide();
					$(".regHasCn").hide();
					$(".specDot").hide();
					accountFlag = false;
				}else if(checkExist(oUserName.val())){//true表示存在相同用户名
					$(".existAccount").show();
					$(".regAccount1").hide();
					$(".regAccount").hide();
					$(".regAccountNull").hide();
					$(".regHasCn").hide();
					$(".specDot").hide();
					accountFlag = false;
				}else{
					$(".specDot").hide();
					$(".regHasCn").hide();
					$(".regAccountNull").hide();
					$(".regAccount1").hide();
					$(".regAccount").hide();
					$(".regAccountSucc").show();
					accountFlag = true;
				}
			}
		}
	});
	return accountFlag;
}

//input登录密码提示
function checkLoginPassword(){
	var oUserPassword=$("#userPassword");
	oUserPassword.focus(function(){
		$(".passwordWarn").show();
		$(".passwordWarn1").hide();
		$(".passwordNull").hide();
		$(".passwordSuc").hide();
		$(".passSpace").hide();
	});
	oUserPassword.blur(function(){
		if($(this).val()==''){
			$(".passwordNull").show();
			$(".passwordWarn").hide();
			$(".passSpace").hide();
			$(".passwordWarn").hide();
			passFlag = false;
		}/*else if($("#confirmPass").val()!=""){
			$(".passwordWarn").hide();
			if($(this).val() != $("#confirmPass").val()){
				$(".passwordDif").show();
				$(".passConfirmSucc").hide();
				//getId("userPassword").focus();
				passFlag = false;
			}else{
				$(".passwordSuc").show();
				$(".passConfirmSucc").show();
				$(".passwordDif").hide();
				$(".passConfirm").hide();
				passFlag = true;
			}
			
		}else if($(this).val().indexOf(" ")>=0){
			
			$(".passSpace").show();
			$(".passwordWarn").hide();
			$(".passwordWarn1").hide();
			$(".passwordNull").hide();
			$(".passwordSuc").hide();
			//$(this).val("");
			//getId("userPassword").focus();
			passFlag = false;
			
		}*/else if($("#confirmPass").val()!=""){
			$(".passwordWarn").hide();
			if($(this).val() != $("#confirmPass").val()){
				$(".passwordDif").show();
				$(".passConfirmSucc").hide();
				//getId("userPassword").focus();
				passFlag = false;
			}else{
				$(".passwordSuc").show();
				$(".passConfirmSucc").show();
				$(".passwordDif").hide();
				$(".passConfirm").hide();
				passFlag = true;
			}
			
		}else if($(this).val().length<6){
			$(".passwordWarn1").show();
			$(".passwordNull").hide();
			$(".passwordWarn").hide();
			$(".passSpace").hide();
			passFlag = false;
		}else{
			$(".passwordSuc").show();
			$(".passwordWarn1").hide();
			$(".passwordNull").hide();
			$(".passwordWarn").hide();
			$(".passSpace").hide();
			passFlag = true;
		}
	});
	return passFlag;
}

//input确认密码提示
function checkConfirmPassword(){
	var oConfirmPass=$("#confirmPass");
	oConfirmPass.focus(function(){
		$(".passConfirm").show();
		$(".passwordDif").hide();
		$(".passConfirmNull").hide();
		$(".passConfirmSucc").hide();
	});
	oConfirmPass.blur(function(){
		if($(this).val()==""){
			$(".passConfirmNull").show();
			$(".passConfirm").hide();
			confirmFlag  = false;
		}else if($(this).val()!=$("#userPassword").val()){
			$(".passwordDif").show();
			confirmFlag = false;
		}else{
			$(".passwordSuc").show();
			$(".passConfirmSucc").show();
			$(".passwordDif").hide();
			$(".passConfirm").hide();
			confirmFlag =  true;
		}
	});
	return confirmFlag;
}

//input真实姓名提示
function checkRealName(){
	var oRealName=$("#realName");
	oRealName.focus(function(){
		$(".relName").show();
		$(".relNameNull").hide();
		$(".relNameSucc").hide();
		$(".cnName").hide();
		$(".lessFour").hide();
	});
	oRealName.blur(function(){
		if($(this).val()==""){
			$(".relNameNull").show();
			$(".relNameSucc").hide();
			$(".cnName").hide();
			$(".lessFour").hide();
			realNameFlag = false;
		}else{
			var reg = /^[\u4E00-\u9FA5]+$/; 
			if(!reg.test($(this).val())){
				$(".cnName").show();
				$(".relNameNull").hide();
				$(".relName").hide();
				$(".lessFour").hide();
				realNameFlag = false;
			}else if($(this).val().length<2){
				$(".lessFour").show();
				$(".relName").hide();
				$(".relNameNull").hide();
				$(".relNameSucc").hide();
				$(".cnName").hide();
				realNameFlag = false;
			}else{
				$(".lessFour").hide();
				$(".relName").hide();
				$(".relNameSucc").show();
				realNameFlag = true;	
			}
		}
	});
	return realNameFlag;
}

//input手机号码提示
function checkPhoneNum(){
	var oPhoneNumber=$("#phoneNumber");
	
	oPhoneNumber.focus(function(){
		var roleName = $("#roleBridge").val();
		$(".phoneNum").show();
		if(roleName == "学生"){
			$(".phoneNumTxt").html("请如实填写便于接受【验证码】和【来自网络导师的指导信息】");
		}else if(roleName == "老师" || roleName == "网络导师"){
			$(".phoneNumTxt").html("请如实填写便于接受【验证码】");
			$(".phoneNumTxt").css({"line-height":"33px"});
		}
		$(".rightPhoneNum").hide();
		$(".checkPhExsit").hide();
		$(".phoneNumSucc").hide();
	});
	oPhoneNumber.blur(function(){
		var v= $(this).val().replace(/ /g,"");
		if(v!='' && v.length == 11){
			var partten = /^1[3|4|5|7|8][0-9]\d{4,8}$/;
			if(partten.test(v)){
				//判断数据库中(mobileCode)有无该手机号被注册（status = 1）
				if(checkExistPhone(v,1)){
					//alert("该手机号码已经被注册，不能再进行注册");
					//getId("phoneNumber").focus();
					$(".checkPhExsit").show();
					$(".phoneNum").hide();
					$(".rightPhoneNum").hide();
					mobileFlag = false;
				}else{
					$(".phoneNumSucc").show();
					$(".phoneNum").hide();
					$(".checkPhExsit").hide();
					mobileFlag = true;
				}
			}else{
				$(".rightPhoneNum").show();
				$(".phoneNum").hide();
				$(".checkPhExsit").hide();
				//getId("phoneNumber").focus();
				mobileFlag = false;
			}
		}else{
			$(".rightPhoneNum").show();
			$(".phoneNum").hide();
			$(".checkPhExsit").hide();
			//getId("phoneNumber").focus();
			mobileFlag = false;
		}
	});
	return mobileFlag;
}
//input手机验证码的提示
function checkVerifyCodeBox(){
	var oCodeNumber = $("#codeNumber");
	oCodeNumber.focus(function(){
		$(".descriVerCon").show();
		$(".emptyCode").hide();
		$(".wrongCode").hide();
		$(".rightCode").hide();
	});
	oCodeNumber.blur(function(){
		if($(this).val()==""){
			$(".emptyCode").show();
			$(".descriVerCon").hide();
			$(".wrongCode").hide();
			$(".rightCode").hide();
		}else{
			if(checkPhoneCode()){
				$(".rightCode").show();
				$(".emptyCode").hide();
				$(".descriVerCon").hide();
				$(".wrongCode").hide();
			}else{
				$(".wrongCode").show();
				$(".rightCode").hide();
				$(".emptyCode").hide();
				$(".descriVerCon").hide();
			}
		}
	});
}
//检查数据库中有无该手机号记录
function checkExistPhone(phoneNumber,status){
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=checkMobileExist&phoneNum="+phoneNumber+"&status="+status+"&purpose=0",
        success:function (json){
        	if(json){
        		flag = true;
        	}else{
        		flag = false;
        	}
        }
    });
	return flag;
}
//检查手机验证码
function checkPhoneCode(){
	var phoneNumber = getId("phoneNumber").value;
	var code = getId("codeNumber").value;
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=checkMobileCode&phoneNum="+phoneNumber+"&code="+code+"&purpose=0",
        success:function (json){
        	if(json){
        		flag = true;
        	}else{
        		flag = false;
        	}
        }
    });
	return flag;
}
//注册页面里已有帐号现在登录的跳转
function showPage(){
	/*if($("#roleBridge").val()=='管理员'){
		window.location.href="../loginPage/login.html";
	}else{
		window.location.href="../../index.html";
	}*/
}

//一分钟认识助学网时登录
function easyLogin(){
	var flag = "";
	var userName = getId("userName").value;
	var password = getId("userPassword").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:'login.do?action=easyLogin&userName='+encodeURIComponent(userName)+"&password="+password,
        success:function (json){
        	flag = json;
        }
    });
	return flag;
}

//预览网站大概功能
function showWebFun(){
	//先执行登陆
	if(easyLogin() == "success"){
		var oRoleBridge=getId("roleBridge");
		var oRealName=getId("realName");
		var oReallyName=getId("reallyName");
		
		var oLayer=getId("layer");
		var oViewWebFunction=getId("viewWebFunction");
		var oViewCon=getId("viewCon");
		var oPrevPage=getId("prevPage");
		
		var oUl=oViewCon.getElementsByTagName("ul")[0];
		var aLi=oUl.getElementsByTagName("li");
		var aStclassLi=getByClass(oViewCon,'studentPart');
		var aTeaclassLi=getByClass(oViewCon,'teacherPart');
		//阻止tab键的函数
		tabKeyCode();
				
		oLayer.style.display="block";
		//根据选择不同身份让预览功能内容的相应部分给显示或者隐藏的判读
		if(oRoleBridge.value=="学生" || oRoleBridge.value=="管理员" || oRoleBridge.value=="家长" || oRoleBridge.value=="老师"){
			for(var i=0;i<aTeaclassLi.length;i++){
				oUl.removeChild(aTeaclassLi[i]);
			}
		}else if(oRoleBridge.value=="网络导师"){
			oReallyName.value=oRealName.value;
			for(var i=0;i<aStclassLi.length;i++){
				oUl.removeChild(aStclassLi[i]);
			}
		}
		//左侧运动left值
		oViewWebFunction.style.display="block";
		if(iNow==0){
			oPrevPage.style.display="none";
		}
		oUl.style.width=aLi[0].offsetWidth*aLi.length+'px';
	}
	
}
//预览知识典内容的运动---下一页
function showNextPage(){
	var roleName = getId("roleBridge").value;
	var oViewCon=getId("viewCon");
	var oNextPage=getId("nextPage");
	var oPrevPage=getId("prevPage");
	var oLoginButton=getId("loginButton");
	var oUl=oViewCon.getElementsByTagName("ul")[0];
	var aLi=oUl.getElementsByTagName("li");
	tabKeyCode();
	var flag = true;
	if(iNow == 0){
		flag = true;
	}else{
		oPrevPage.style.display="block";
		if(iNow==aLi.length-2){
			if(roleName == "网络导师"){
				var nickName = getId("netName").value;
				if(nickName == ""){
					alert("请输入网络姓名");
					getId("netName").focus();
					flag = false;
				}else{
					if(checkChinese(getId("netName"),"网络名字必须为中文!")){
						flag = true;
					}else{
						flag = false;
					}
				}
			}else{
				flag = true;
			}
		}else{
			flag = true;
		}
	}
	if(flag){		
		iNow++;
		startMove(oUl,{left:-iNow*aLi[0].offsetWidth});
		oPrevPage.style.display="block";
	}
	
	if(iNow==aLi.length-1){
		oNextPage.style.display="none";
		oLoginButton.style.display="block";		
	}
}
//预览知识典内容的运动---上一页
function showPrevPage(){
	
	var oViewCon=getId("viewCon");
	var oNextPage=getId("nextPage");
	var oPrevPage=getId("prevPage");
	var oLoginButton=getId("loginButton");
	var oUl=oViewCon.getElementsByTagName("ul")[0];
	var aLi=oUl.getElementsByTagName("li");
	tabKeyCode();
	iNow--;
	if(iNow==aLi.length-2){
		oNextPage.style.display="block";
		oLoginButton.style.display="none";
	}else if(iNow==0){
		oPrevPage.style.display="none";
	}
	startMove(oUl,{left:-iNow*aLi[0].offsetWidth});
}

// 预览网站大体功能一分钟了解知识点登录功能
function webFunLogin(){
	//登录之前先将设置的导师辅道价插入数据库中
	var roleName = getId("roleBridge").value;
	var flag = true;//当不是网络导师时不需要这些判断
	
	if(roleName == "网络导师"){
		var teachMoneyObj = getId("teachMoney");
		var teachMoney = teachMoneyObj.value;
		if(teachMoney == ""){
			alert("请输入导师价格");
			flag = false;
		}else{
			if(checkNumber(teachMoneyObj,"请输入正确的辅导价格!")){
				flag = true;
			}else{
				flag = false;
			}
		}
	}
	//登录
	if(flag){
		if(roleName == "网络导师"){
			//修改网络名称
			updateNickName();
			//修改指导价
			updateTeacherMoney();
		}
    	selectRole();
	}
	
}
//修改网络名称
function updateNickName(){
	var nickName = getId("netName").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"userManager.do?action=updateUserNickName&nickName="+encodeURIComponent(nickName),
        success:function (json){
        	
        }
    });
}
//修改网络导师指导价
function updateTeacherMoney(){
	var teachMoney = getId("teachMoney").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"userManager.do?action=updateNetTeacherServiceMoney&teachMoney="+teachMoney,
        success:function (json){
        	
        }
    });
}
//将信息插入数据库，完成注册
function checkAddInfo(){
	//第一步的信息
	var roleName = getId("roleBridge").value;
	//第二部的信息
	var inviteCode = getId("freeCode").value;//可能不填
	var classCode = getId("classCode").value;//可能不填
	var userName = getId("userName").value;
	var password = getId("userPassword").value;
	var realName = getId("realName").value;
	var mobile = getId("phoneNumber").value;
	//----------------老师和网络导师才会出现的数据-------------//
	var subjectIDObj = getId("subjectID");
	var subjectID = 0;
	var selectIndex = subjectIDObj.selectedIndex;
	var subjectName = subjectIDObj.options[selectIndex].text;
	if(subjectIDObj == null){
		subjectID = 0;
	}else{
		subjectID = subjectIDObj.value;
	}
	var schoolTypeName = getId("schoolTypeName").value;
	var eidtionID = getId("editionID").value;
	//----------------学生、老师、网络导师才会出现的数据-------------//
	//第三部的信息(可为空)
	var province = getId("prov").value;
	var city = getId("city").value;
	var county = getId("county").value;
	var townObj = getId("town");
	//alert(townObj);
	var town = 0;
	if(townObj == null){
		town = 0;
	}else{
		town = townObj.value;
	}
	var schoolTypeArray = getId("schoolType").value.split(":");
	var length = schoolTypeArray.length;
	var schoolType = schoolTypeArray[0];
	//学年制
	var yearSystem = "0";
	if(length == 2){
		yearSystem = schoolTypeArray[1];
	}
	var schoolObj = getId("schoolID");
	var schoolID = schoolObj.value;
	var selectSchoolIndex = schoolObj.selectedIndex;
	var schoolName = schoolObj.options[selectSchoolIndex].text;
	var selectGradeObj = getId("selectGradeWindowDiv");
	var selectGradeIndex = selectGradeObj.selectedIndex;
	var selectGradeName = selectGradeObj.options[selectGradeIndex].text;
	var gradeID = selectGradeObj.value;
	var className = getId("selectClassWindowDiv").value;
	var option = "allInfo";
	var newUrl_pub = "&roleName="+encodeURIComponent(roleName)+"&userName="+encodeURIComponent(userName)+"&password="+password+"&realName="+encodeURIComponent(realName)+"&mobile="+mobile;
	var newUrl_inviteCode = "&inviteCode="+inviteCode + "&classCode="+classCode;
	var newUrl_sub = "&subjectID="+subjectID+"&subjectName="+encodeURIComponent(subjectName)+"&schoolTypeName="+encodeURIComponent(schoolTypeName)+"&eidtionID="+eidtionID;
	var newUrl_school1 = "&province="+encodeURIComponent(province)+"&city="+encodeURIComponent(city)+"&county="+encodeURIComponent(county)+"&town="+encodeURIComponent(town)+"&schoolType="+encodeURIComponent(schoolType) + "&yearSystem="+yearSystem;
	var newUrl_school2 = "&schoolID="+schoolID+"&gradeID="+gradeID+"&gradeName="+encodeURIComponent(selectGradeName)+"&className="+encodeURIComponent(className);
	var newUrl = newUrl_pub + newUrl_inviteCode + newUrl_sub + newUrl_school1 + newUrl_school2;
	var flag = false;
	//县/乡镇可选可不选
	if(roleName == "网络导师"){
		flag = true;
	}else{
		if(classCode == ""){//没填邀请码
			if(roleName == "学生" || roleName == "老师"){
				//学生老师需要选择学校班级
				if(province == "0"){
					alert("请选择省份");
					flag = false;
				}else if(city == "0"){
					alert("请选择市");
					flag = false;
				}else if(schoolType == "-1"){
					alert("请选择学段");
					flag = false;
				}else if(schoolID == "0"){
					alert("请选择学校");
					flag = false;
				}else if(gradeID == "0"){
					alert("请选择年级");
					flag = false;
				}else if(className == "0"){
					alert("请选择班级");
					flag = false;
				}else{
					//执行插入动作（个人信息+学校信息）
					//老师[先查看数据库中有无此班级信息，没有者创建该班级，并且在user_invite中生成班级邀请码]
					flag = true;
				}
			}else{
				flag = true;
			}
			
		}else{
			flag = true;
		}
	}
	if(flag){
		flag = add(newUrl);
	}else{
		flag = false;
	}
	return flag;
}

function add(newUrl){
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"login.do?action=add"+newUrl,
        success:function (json){
        	 flag = json;     	
        	 if(json){
        		 alert("注册信息成功!");
        	 }else{
        		 alert("注册信息失败");
        	 }
        }
    });
	return flag;
}
//检查用户名是否存在
function checkExist(userName){
	var flag;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=checkUserName&userName="+encodeURIComponent(userName),
        success:function (json){
        	 flag = json;     	
        }
    });
	return flag;
}
//查询邀请码(包括班级邀请码)是否存在数据库
function checkDataBaseInviteCode(inviteType,inviteCode){
	var inviteMan;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=checkInviteCode&inviteType="+encodeURIComponent(inviteType)+"&inviteCode="+encodeURIComponent(inviteCode),
        success:function (json){
        	inviteMan = json;     	
        }
    });
	return inviteMan;
}
//根据班级编号获取该班级详细信息
function getClassInfo(classID){
	var classInfo;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getClassList&classID="+classID,
        success:function (json){
        	classInfo = json; 	
        }
    });
	return classInfo;
}
//根据网络导师编号获取该网络导师信息
function getNetTeacher(userID){
	var netTeacherInfo;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getNetTeacherInfo&userID="+userID,
        success:function (json){
        	netTeacherInfo = json; 	
        }
    });
	return netTeacherInfo;
}

