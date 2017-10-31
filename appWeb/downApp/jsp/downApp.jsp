<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>助学网app下载</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/appWeb/downApp/css/downApp.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript">
	function init(){
		var mobileInfo = getSelfMobileInfo();
		if(mobileInfo == "andriodApp"){
			//window.location.href = "http://192.168.1.196:8080/Module/download/zhuxue.apk";
			window.location.href = "http://www.zhu-xue.cn/Module/download/zhuxue.apk";
		}else if(mobileInfo == "iphoneApp"){
			$("#warnPTxt").html("暂未发布，请等待");
			commonTipInfoFn($(".warnInfoDiv"));
			//alert("暂未发布,请等待!");
			//window.location.href = "https://itunes.apple.com/cn";
		}else{
			alert("暂未发布,请等待!");
			$("#warnPTxt").html("暂未发布，请等待");
			commonTipInfoFn($(".warnInfoDiv"));
		}
	}
	//获取自己绑定有效的学生列表（没过期，没取消，没清除）
	function getSelfMobileInfo(){
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
	function isWeiXin(){
	    var ua = window.navigator.userAgent.toLowerCase();
	    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
	        return true;
	    }else{
	        return false;
	    }
	}
	function checkUserAgent(){
		if(isWeiXin()){
	    	$(".layer").show();
	    	$(".tipDiv").show();
	    }else{
	    	init();
	    }
	}
	</script>
  </head>
  
<body>
	<div class="headDiv">
		<img width=100 class="fl" src="Module/appWeb/downApp/images/logo.png"/>
		<div class="headInfoDiv fl">
			<h2>助学网</h2>
			<p>大小：6.0MB</p>
			<p>版本：2.0</p>
			<p class="introP">
				<span>官方</span>
				<span>无广告</span>
				<span>免费</span>
			</p>
		</div>
	</div>
	<div class="downDiv">
		<a href="javascript:void(0)" ontouchend="checkUserAgent()">点击下载</a>
	</div>
	<!-- 介绍层  -->
	<div class="introDiv">
		<ul class="clearfix">
			<li><img src="Module/appWeb/downApp/images/01.png" alt="助学网app下载"/></li>
			<li><img src="Module/appWeb/downApp/images/02.png" alt="助学网app下载"/></li>
			<li><img src="Module/appWeb/downApp/images/03.png" alt="助学网app下载"/></li>
			<li><img src="Module/appWeb/downApp/images/04.png" alt="助学网app下载"/></li>
		</ul>
		<div class="introText">
			<strong>应用简介：</strong>
			<p>①&nbsp;采用异步导学法针对中小学数理化生1对1辅导</p>
			<p>②&nbsp;包括兴趣开发、方法归纳、思维训练、智力开发、能力培养与中高考涉猎六大类型</p>
			<p>③&nbsp;针对每个知识点溯源诊断，查找根源</p>
			<p>④&nbsp;采用听，看，背，学，固五步学习法</p>
		</div>
	</div>
	<div class="layer"></div>
	<div class="tipDiv">
		<p>微信用户戳这里并点击<span>在浏览器中打开</span><br>即可正常下载哦~</p>
	</div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
</body>
</html>
