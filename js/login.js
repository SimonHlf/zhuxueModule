 var count = 60;//60秒
 
//登录注册表单上input文本框的移入和移出提示文字的显示和隐藏
function textFoucsChecks(){
	inpTipFocBlur("userName","请输入用户名","#b5b4b4","#363636");
	passwordDisplay("passTxt","password","请输入密码");
	inpTipFocBlur("vercode","请输入验证码","#b5b4b4","#363636");
}
//登录窗口的登录检测
function loginCheck(){
	var ouserName=getId("userName");
	var oPassTxt=getId("passTxt");
	var oPassword=getId("password");
	var oVercode = getId("vercode");
	//判断是否填写用户名
	if(ouserName.value=="请输入用户名" || ouserName.value == ""){
		alert("请输入用户名");
		ouserName.focus();
		return false;
	}else if(oPassword.value==""  || oPassword.value == ""){
		alert("请输入密码");
		oPassTxt.style.display = "none";
		oPassword.style.display = "";
		oPassword.focus();
		return false;
	}else if(oVercode.value=="请输入验证码" || oVercode.value == ""){
		alert("请输入验证码");
		oVercode.focus();
		return false;
	}else{
		return true;
	}
}
//检查是否存在该用户
function checkUserNameExist(userName){
	var flag = false;
	$.ajax({
	type:"post",
	async:false,
	dataType:"json",
	url:"login.do?action=checkUserNameExist&username="+encodeURIComponent(userName),
	success:function(json){
		flag = json;
	}
});
	return flag;
}
//忘记密码之找回密码
function findPassword(){
    var username=document.getElementById("userName").value;
    if(username=="请输入用户名"||username==""){
    	alert("请先输入用户名！");
    	getId("userName").value="";
    	getId("userName").focus();
    }else{
    	if(checkUserNameExist(username)){
    		showBtnCodeStyle();
	    	$.ajax({
	    		type:"post",
	    		async:false,
	    		dataType:"json",
	    		url:"login.do?action=findPassword&username="+encodeURIComponent(username),
	    		success:function(json){
	    			if(json==true){
	    				alert("您的用户名密码信息已发送至您的安全邮箱，请查收！");
	    			}else if(json=="1"){
	    				alert("您的用户名密码信息已发送至您手机，请查收！");
	    			}else if(json=="0"){
	    				alert("信息发送失败，请重新获取！");
	    			}else if(json == "-1"){
	    				alert("获取密码失败，请重试！");
	    			}
	    		}
	    	});
    	}else{
    		alert("该用户不存在!");
    	}
	}
}
//获取按钮禁止动作
function showBtnCodeStyle(){
	$("#forgetPass").attr("disabled", "disabled");
	$("#forgetPass").removeClass().addClass("forgetDis");
    $("#forgetPass").val(count + "秒后获取");
	count--;
	if(count > 0){
		setTimeout(showBtnCodeStyle, 1000);
	}else{
		$("#forgetPass").removeClass().addClass("noDis");
		$("#forgetPass").val("找回密码");
        $("#forgetPass").removeAttr("disabled");
        count = 60;
	}
}
//验证码
function verCode(){
	var obj = document.getElementById("sessCode");
	obj.src = "authImg?code="+Math.random()+100;
}
//登录
function login(){
	var userName = document.getElementById("userName").value;
	var password = document.getElementById("password").value;
	var vercode = document.getElementById("vercode").value;
	var oVercode = getId("vercode");
	if(loginCheck()){
		$.ajax({
            cache: true,
            type: "POST",
            url:'login.do?action=processLogin&userName='+encodeURIComponent(userName)+'&password='+password+'&vercode='+vercode,
            async: false,
            success: function(json) {
            	if(json == "vercodeFail"){ 
            	  document.getElementById("vercode").value = '';
            	  verCode();
                  alert('验证码不匹配,请重新输入');
                  oVercode.focus();
                }else if(json == "fail"){
                  alert('用户名和密码不匹配，请重试');
                  document.getElementById("userName").focus();
                }else{
                	selectRole();
                }
            }
        });
	}
}
//选择角色登录
function selectRole(){
	var roleList;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:'userManager.do?action=selectRole',
        success:function (json){
        	roleList = json;
        }
    });
	if(roleList.length == 1){
		document.roleForm.roleID.value = roleList[0].id;
		document.roleForm.roleName.value = roleList[0].roleName;
		document.roleForm.submit();
	}else{
		var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
		$('#selectRoleWindowDiv').show();
		getId("selectRoleWindowDiv").style.top = (document.documentElement.clientHeight - 180)/2 + scrollTop + 'px';
		$('#layer').show();
		listRole(roleList);
	}
}
//角色判断的关闭窗口
function closeRoleWin(){
	$(".roleChoice").hide();
	$('#layer').hide();
	
}
//显示角色
function listRole(list){
  	var t='<span>身份选择</span><select id="roleID" style="width:100px;">';
  	var f='<option value="-1">---请选择---</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].roleName+"</option>";
		}
	}
	var h='</select> ';
	var btn='<a href="javascript:void(0)" class="enterSys" id="groupLoginButton" onclick="goPage();">进入系统</a>';
	$('#selectRole').html(t+f+options+h+btn);
}
//成功导向
function goPage(){
	   var obj=document.getElementById('roleID');
	   var roleName = obj.options[obj.selectedIndex].text;
	   var roleID = obj.value;
	   if(roleID == -1){
		   alert("请选择一个身份进入系统");
	   }else{
			document.roleForm.roleID.value = roleID;
			document.roleForm.roleName.value = roleName;
			document.roleForm.submit();
	   }
}
//回车事件
function enterPress(e){
	var e = e || window.event;
	if(e.keyCode == 13){
		login();
	}
}