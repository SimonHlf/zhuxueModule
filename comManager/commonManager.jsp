<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>助学网--知识点后台管理中心</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/comManager/css/comManagerCss.css" type="text/css" rel="stylesheet" />
<link href="Module/css/switchSys.css" type="text/css" rel="stylesheet" />
<link href="Module/superManager/css/calendar.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css"/>    
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script src="Module/comManager/js/comManagerJs.js" type="text/javascript"></script>
<script src="Module/superManager/js/superManagerJs.js" type="text/javascript"></script>
<script type="text/javascript" src="Module/loreManager/flashPlayer/images/swfobject.js"></script>
<script type="text/javascript" src="Module/loreManager/flowPlayer/flowplayer-3.2.13.min.js"></script>
<script src="Module/js/login.js"></script>
<script type="text/javascript">
$(function(){
	judgeTime();
	fnTab($('.tabNav'),'click');
	loadCalendar();
	showSelectRole(checkUserRoleLenght());
	//autoHeight('comManagerFrame');
	$(".rightPart").height($(".leftPart").height());
});
function loginOut(){
	if(confirm("确认退出系统么?")){
		window.location.href = "login.do?action=loginOut";
	}
}
function playFile(){
    var url = document.getElementById("fileUrl").value;
	 var so = new SWFObject("Module/loreManager/flashPlayer/PlayerLite.swf","CuPlayerV4","521","331","9","#000000");
	 so.addParam("allowfullscreen","true");
	 so.addParam("allowscriptaccess","always");
	 so.addParam("wmode","opaque");
	 so.addParam("quality","high");
	 so.addParam("salign","lt");
	 so.addVariable("videoDefault",url); //视频文件地址
	 so.addVariable("autoHide","true");
	 so.addVariable("hideType","fade");
	 so.addVariable("autoStart","false");
	 so.addVariable("holdImage","Module/loreManager/flashPlayer/start.jpg");
	 so.addVariable("startVol","100");
	 so.addVariable("hideDelay","60");
	 so.addVariable("bgAlpha","75");
	 so.write("viewerPlaceHolder");
}
//播放视频
function playFileNew(){
	var url = document.getElementById("fileUrl").value;
	flowplayer("viewerPlaceHolder", "Module/loreManager/flowPlayer/flowplayer-3.2.18.swf",{
		clip:{
			url: url,
			autoPlay:false,
			autoBuffering: true
		}
	});
}
</script>
</head>

<body>
	<!-- 头部 -->
	<div class="head">
		<div class="logo">
			<img src="Module/images/logo.png" width="97" height="67" alt="知识点--后台管理中心" />
		</div>
		<h2>知识点后台管理中心</h2>
		<div class="helloBox">
			<div class="userPic">
				<img src="Module/welcome/images/default-teacher.png" width="50" height="50" />
			</div>
			<p class="timeHello fl"></p>
			<p class="username fl">${sessionScope.realName}</p>
			<p class="helloSen fl"></p>
			<a href="javascript:void(0)" hidefocus="true" title="切换系统"  id="selectUserRole" class="switchBtn fl" style="display:none;" onclick="selectRole()"></a>
			<div title="查看天气" class="checkWeather fl" onclick="showWeaherBox()"></div>
			<div title="退出" class="exit fl" onclick="loginOut();"></div>
		</div>
		<!-- 天气插件盒子 -->
		<div class="weaherBox">
			<iframe allowtransparency="true" frameborder="0" width="290" height="96" scrolling="no" src="http://tianqi.2345.com/plugin/widget/index.htm?s=1&z=1&t=0&v=0&d=2&bd=0&k=000000&f=000000&q=1&e=0&a=1&c=54511&w=290&h=96&align=center"></iframe>
			<span title="关闭" class="closeWin" onclick="closeWeather()"></span>
		</div>
	</div>
	<!-- 主体内容架构 -->
	<div class="mainFrame">
		<!-- 左侧 -->
		<div id="partLeft" class="leftPart">
			<!-- 个人头像大图 -->
			<div class="bigPic">
				<img src="Module/welcome/images/default-teacher.png" width="100" height="100" />			
			</div>
			<div class="perIden">
				<p class="name">${sessionScope.realName}</p>
			</div>
			<!-- 各项模块列表 -->
			<div class="moduleList">
				<ul class="tabNav">
					<li><a hidefocus="true" href="javascript:void(0)" onclick="loadChapter();">章节管理</a></li>
					<li><a hidefocus="true" href="javascript:void(0)" onclick="loadLoreCatalog();">知识点目录管理</a></li>
					<li><a hidefocus="true" href="javascript:void(0)" onclick="loadLore();">知识点管理</a></li>
					<li><a hidefocus="true" href="javascript:void(0)" onclick="showLoreSimpleTree();">关联知识点</a></li>
					<li><a hidefocus="true" href="javascript:void(0)" onclick="newEditionLore();">生成其他版本知识点</a></li>
					<li><a hidefocus="true" href="javascript:void(0)" onclick="loadBuffet();">自助餐管理</a></li>
				</ul>
			</div>
			<!-- 日历控件 -->
			<div class="clover_calender">
				<!-- 上一月，下一月 -->
			    <div class="cal-hd">
			    	<div class="cal-seldate" id="cal_seldate"></div>
			    </div>
			    <div class="cal-bd">
			    	<!-- 星期 -->
			    	<ul class="cal-day clr">
			        	<li class="item1"><span>日</span></li>
			            <li class="item2"><span>一</span></li>
			            <li class="item3"><span>二</span></li>
			            <li class="item4"><span>三</span></li>
			            <li class="item5"><span>四</span></li>
			            <li class="item6"><span>五</span></li>
			            <li class="item7"><span>六</span></li>
			        </ul>
			        <!-- 月份对应的天数 -->
			        <ul class="cal-date clr" id="cal_date"></ul>
			        <!-- 背景的该月份，大字体 -->
			        <span class="cal-num" id="calnum"></span>
			    </div>
			</div>
		</div>
		<div id="onOffBtn" class="showBtn" title="打开/关闭左侧栏" onclick="showLeftMenu()"></div>
		<!-- 右侧 -->
		<div id="partRight" class="rightPart">
			<iframe id="comManagerFrame" allowTransparency="true" name="comManagerFrame" width="100%" height="100%" src="Module/comManager/indexPic.jsp" frameborder="0" scrolling="no"></iframe>
		</div>
	</div>
	<!-- 底部 -->
	<div class="footerWrap">
		<div class="footer w1000">
			<div class="footCon">
				<p>如有任何问题和建议，请<a href="mailto:sandy_wm@sohu.com">E-mail to me</a></p>
				<p>建议您使用1024*768以上分辨率，IE8.0以上版本浏览本站! </p>
				<p>版权所有 Copyright@2013 Sandy.wm All Rights Reserved.</p>
			</div>
		</div>
	</div>
	<input type="hidden" id="fileUrl"/>
		<div id="flexPaperDiv">
			<div id="viewerPlaceHolder"  style="width:586px; height:365px;display:none;"></div>
		</div>
		<!-- 遮罩层  -->
	<div id="layer"></div>
	
	<!-- 身份选择 -->
	<div id='selectRoleWindowDiv' class="roleChoice" >
		<p>请选择一个身份进入系统！</p>
		<div id='selectRole' class="choiceBox"></div>
		<span class="roleClose" onclick="closeRoleWin()"></span>
	</div>
	<html:form action="userManager.do?action=goPage" method="post">
   		<input type="hidden" id="roleID" name="roleID"/>
   		<input type="hidden" id="roleName" name="roleName"/>
    </html:form>
</body>
</html>
