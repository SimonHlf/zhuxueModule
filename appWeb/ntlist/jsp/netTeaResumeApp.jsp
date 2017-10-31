<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>网络导师个人资料</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/appWeb/ntlist/css/netTeaResumeApp.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
<script type="text/javascript" src="Module/appWeb/ntlist/js/ntinfo.js"></script> 
<script type="text/javascript">
var ntUserID="${ntUserId}";
var cliHei = document.documentElement.clientHeight;
var cliWid = document.documentElement.clientWidth;
var gloryFlag = true;
var userId = "${sessionScope.userId}";
var roleId = "${sessionScope.roleId}";
var loginStatus = "${sessionScope.loginStatus}";
$(function(){
	$("body").height(cliHei);
	$(".comResumeDiv").height(cliHei - $(".resumeHead").height() - 30);
	$("#nusinfo").width(cliWid - $("#proSignP").width()-40);
	ntInfo(ntUserID);
	tabNav();
});
//个人信息iscroll
function perInfoScroll() {
	myScroll = new iScroll('perInfoWrap', {
		checkDOMchanges:true
	});		
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
function checkImg(){
	$("#boxPicUl img").each(function(i){
		var imgdefereds=[];
		$("#boxPicUl img").each(function(){
		  	var dfd=$.Deferred();
		  	$(this).bind('load',function(){
		   		dfd.resolve();
		  	}).bind('error',function(){
		  		//图片加载错误，加入错误处理
		  		// dfd.resolve();
		 	 });
		  	if(this.complete) setTimeout(function(){
		   		dfd.resolve();
		 	 },500);
		  		imgdefereds.push(dfd);
		 });
		 $.when.apply(null,imgdefereds).done(function(){
			 var imgWid = $("#boxPicUl img").eq(i).width();
			 var parHei = $("#boxPicUl img").eq(i).parent();
			 parHei.height(imgWid);
		 });
	});
}
//个人相册的iscroll
function gloryImgScroll() {
	myScroll = new iScroll('gloryImgWrap', {
		checkDOMchanges:true,
		onScrollMove:function(){
			gloryFlag = false;
		},
		onScrollEnd : function(){
			gloryFlag = true;
		}
	});		
}
//预览大图
function showOrigImgUrl(str){
	if(gloryFlag){
		$(".imgLayer").show();
		$(".closeOrigImg").show();
		$("#originImg").show().attr("src",str);
		var origWid = $("#originImg");
		origWid.css({
			"left":(cliWid - origWid.width())/2,
			"top":(cliHei - origWid.height())/2
		});
	}
}
//关闭预览大图窗口
function closeOrigImg(){
	$(".closeOrigImg").hide();
	$(".imgLayer").hide();
	$("#originImg").hide().attr("src","");
}
function tabNav(){
	$(".ulNav li").each(function(i){
		$(this).on("touchend",function(){
			$(".ulNav li").removeClass("active");
			$(this).addClass("active");
			$(".comResumeDiv").hide();
			$(".comResumeDiv").eq(i).show();
			if(i == 1){
				gloryImgScroll();
			}
			
		});
	});
}
function backPage(){
	window.location.href = "netTeacherApp.do?action=goNtList&userId="+userId+"&roleId="+roleId+"&loginStatus="+loginStatus+"&cilentInfo=appInit";
}
</script>
</head>
  
<body>
	<!-- 头部部分  -->
	<div class="resumeHead">
		<span class="backIcon" ontouchend="backPage();"></span>
		<input type="hidden" id="nuid">
		<div class="netTeaImg">
			<div class="shadowDiv"><span id="nuRname"></span></div>
			<img id="nutop" class="headPic" src=""/>
		</div>
		<div class="headTxt clearfix">
			<p class="txtp1 fl">学科：<span id="nuSub"></span></p>
			<p class="txtp2 fl">教龄：<span id="nusage"></span>年</p>
		</div>
	</div>	
	<!-- 导航  -->
	<ul class="ulNav">
		<li class="active"><span></span>个人简介</li>
		<li><span></span>个人相册</li>
	</ul>
	<!-- 个人简介  -->
	<div id="perInfoWrap" class="comResumeDiv" style="display:block;">
		<div class="perinfoScroll">
			<!-- 基本信息  -->
			<div class="proDiv">
				<h3 class="comH3"><span></span>个人简介</h3>
				<ul>
					<li class="comResLi">
						<p><span class="comProIcon gradIcon"></span>毕业院校：<span id="nugs" class="proSpan"></span></p>
					</li>
					<li class="comResLi">
						<p><span class="comProIcon proIcon"></span>所学专业：<span id="numajor" class="proSpan"></span></p>
					</li>
					<li class="comResLi">
						<p class="fl"><span class="comProIcon degIcon"></span>学<span class="oneBlank"></span>历：<span id="nuedu" class="proSpan"></span></p>
					</li>
					<li class="comResLi" style="display:none;">
						<p><span class="sexIcon"></span>性<span class="oneBlank"></span>别：<span id="nusex"></span></p>
					</li>
				
					<li class="comResLi">
						<p><span class="comProIcon emailIcon"></span>邮件地址：<span id="unEmail" class="proSpan"></span></p>
					</li>
					<li class="comResLi">
						<p><span class="comProIcon conIcon"></span>联系方式：<span id="unMobile" class="proSpan"></span></p>
					</li>
				</ul>
				<div class="perSignTxt clearfix">
					<p id="proSignP" class="fl"><span class="comProIcon editIcon"></span>个人签名：</p>
					<div id="nusinfo" class="proSpan lineBreak fl"></div>
				</div>
			</div>
			<!-- 教学经历  -->
			<div class="expDiv">
				<h3 class="comH3">教学经历</h3>
				<ul id="timeCon"></ul>
			</div>
			<!-- 成果分享  -->
			<div class="gloryShareDiv">
				<h3 class="comH3">成果分享</h3>
				<ul id="unShareCon"></ul>
			</div>
		</div>
	</div>
	<!-- 个人相册  -->
	<div id="gloryImgWrap" class="comResumeDiv">
		<div class="gloryScroll">
			<ul id="boxPicUl" class="clearfix"></ul>
			<div class="blankDiv"></div>
		</div>
	</div>
	<div class="imgLayer"></div>
	<a class="closeOrigImg removeAFocBg" href="javascript:void(0)" ontouchend="closeOrigImg()"></a>
	<img id="originImg" src=""/>
</body>
</html>
