//获取客户端信息
function getCilentInfo(){
	var mobileInfo = "";
	$.ajax({
		  type:"post",
		  async:false,//同步
		  dataType:"json",
		  url:"commApp.do?action=checkCilentInfo_1&cilentInfo=appInit",
		  success:function (json){ 
			  mobileInfo = json["result"];
		  }
	});
	return mobileInfo;
}
var creaFlag_other = true;
var cearFlag_60Min = true;
//页面初始化获取用户登录状态
function checkLoginStatus(){
	var result = false;
	var cilentInfo = getCilentInfo();
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  url:"commApp.do?action=checkUserLoginStatus&cilentInfo=app",
		  success:function (json){ 
			  if(json["result"] == "loginOut"){
				  var str_loginOut1 = "<div class='loginOutDiv'><span class='loginOutIcon'></span><p id='loginOutInfo' class='loginInfo1'></p></div>";
				  if(creaFlag_other){
					  $("body").append(str_loginOut1);
					  //alert("该账号已经在别处登录，系统已强制您下线，请重新登录！"+cilentInfo);
					  $("#loginOutInfo").html("该账号已经在别处登录，系统已强制您下线，请重新登录<span>"+cilentInfo+"</span>");
				  }
				  creaFlag_other = false;
				  if(cilentInfo == "andriodApp"){
					  setTimeout(function(){
						  comTipInfoLoginOut(1,function(){
							  contact.intentMain();
						  });
					  },500);
					  //contact.intentMain();
				  }else if(cilentInfo == "iphoneApp"){
					  setTimeout(function(){
						  comTipInfoLoginOut(2,function(){
							  
						  });
					  },500);
				  }
			  }else if(json["result"] == "sessionOut"){
				  var str_loginOut2 = "<div class='loginOutDiv'><span class='loginOutIcon2'></span><p id='loginOutInfo2' class='loginInfo2'></p></div>";
				  //alert("由于您60分钟内无操作，系统已强制您下线，请重新登录！");
				  if(cearFlag_60Min){
					  $("body").append(str_loginOut2);
					  $("#loginOutInfo2").html("由于您60分钟内无操作，系统已强制您下线，请重新登录<span>"+cilentInfo+"</span>");
				  }
				  cearFlag_60Min = false;
				  if(cilentInfo == "andriodApp"){
					  setTimeout(function(){
						  comTipInfoLoginOut(1,function(){
							  contact.intentMain();
						  });
					  },500);
					  //contact.intentMain();
				  }else if(cilentInfo == "iphoneApp"){
					  setTimeout(function(){
						  comTipInfoLoginOut(2,function(){
							  
						  });
					  },500);
				  }
			  }else{
				  result = true;
				  //alert("账号正常");
			  }
		  }
	});
	return result;
}
//显示提示信息模拟alert
function comTipInfoLoginOut(options,fnEnd){
	$(".loginOutDiv").css({
		"-webkit-transform":"translateY(0px)",
		"transform":"translateY(0px)"
	});
	setTimeout(function(){
		$(".loginOutDiv").css({
			"-webkit-transform":"translateY(-50px)",
			"transform":"translateY(-50px)"
		});
		$(".loginOutDiv").on("transitionend WebkitTransitionEnd",function(){
			if(options == 1){//andriodApp
				fnEnd();
			}else if(options == 2){//iphoneApp
				fnEnd();
			}
		});
	},2000);
}