<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@include file="../taglibs/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/css/switchSys.css" type="text/css" rel="stylesheet" />
<link href="Module/superManager/css/superManagerCss.css" type="text/css" rel="stylesheet" />
<link href="Module/superManager/css/calendar.css" type="text/css" rel="stylesheet" />
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script src="Module/superManager/js/superManagerJs.js" type="text/javascript"></script>
<script src="Module/js/login.js"></script>
<script type="text/javascript">
$(function(){
	fnTab($('.tabNav'),'click');
	loadCalendar();
	autoHeight("superManFrame");
	showSelectRole(checkUserRoleLenght());
	//$(".rightFrame").height($(".leftFrame").height());
});
</script>
<title>助学网--后台超级管理员管理中心</title>

</head>

<body>
	<!-- 头部 -->
	<div class="headWrap">
		<div class="logo">
			<img src="Module/images/logo.png" width="97" height="57" />
		</div>
		<h2>知识点后台超级管理中心</h2>
		<div class="personalInfo">
			<div class="perPic">
				<img src="Module/welcome/images/default-teacher.png" width="54" height="54" />
			</div>
			<div class="infoText">
				管理员：<span class="managerName">${sessionScope.realName}</span>
			</div>
			<a href="javascript:void(0)" id="selectUserRole" class="switchBtn" style="display:none;" title="切换" onclick="selectRole()"></a>
			<a class="exitSys" hidefocus="true" href="javascript:void(0)" onclick="loginOut();" title="退出"></a>
		</div>
		<!-- 天气 -->
		<div class="weatherWrap">
			<iframe allowtransparency="true" frameborder="0" width="290" height="96" scrolling="no" src="http://tianqi.2345.com/plugin/widget/index.htm?s=2&z=2&t=0&v=0&d=2&bd=0&k=000000&f=c0c0c0&q=0&e=0&a=1&c=54511&w=290&h=96&align=center"></iframe>
		</div>
		
	</div>
	<!-- 中间主要内容 -->
	<div class="mainFrame">
		<!-- 左侧导航模块列表内容 -->
		<div class="leftFrame">
			<!-- 个人头像大图 -->
			<div class="bigPic">
				<img src="Module/welcome/images/default-teacher.png" width="100" height="100" />			
			</div>
			<div class="perIden">
				<p class="name">${sessionScope.realName}</p>
			</div>
			
			<!-- 各项模块列表 -->
			<ul class="tabNav">
				<li>
			         <a hidefocus="true" onclick='showRightFrame("userManager.do?action=showUserInfo")' >
			         	 个人信息修改
			         </a>
		        </li>
				<logic:present name="rList" scope="request">
				    <logic:iterate id="resource" name="rList" type="com.kpoint.vo.ResourceVO" scope="request" >
				        <li>
					         <a hidefocus="true" onclick='showRightFrame("<bean:write name='resource' property='resUrl'/>")' >
					         	 <bean:write name='resource' property='resName'/>
					         </a>
				        </li>
				    </logic:iterate>
			 	</logic:present>				
			</ul>
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
		<!-- 右侧模块对应的主要内容 -->
		<div class="rightFrame">
			<iframe id="superManFrame" name="superManFrame" src=""  width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
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
