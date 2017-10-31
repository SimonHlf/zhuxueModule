<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
<title>助学网</title>
<link href="Module/images/logo.ico" rel="shortcut icon"/>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/css/switchSys.css" type="text/css" rel="stylesheet" />
<link href="Module/welcome/css/welcome.css" type="text/css" rel="stylesheet" />
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<link href="Module/studyOnline/css/askAlertWin.css" type="text/css" rel="stylesheet" />
<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
<link href="Module/personalCen/css/personalInfo.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/welcome/js/welcome.js"></script>
<!--[if IE 8]> 
<style type="text/css">
.contents{filter:progid:DXImageTransform.Microsoft.gradient(enabled = 'true',startColorstr = '#60ffffff',endColorstr = '#60ffffff')}
</style>
<![endif]-->
<script type="text/javascript">
var roleName = "${sessionScope.roleName}";
var realName = "${sessionScope.realName}";
var roleId = "${sessionScope.roleID}";
var protrait = "${sessionScope.protrait}";
var showFlag =  "${sessionScope.showFlag}";
$(function(){
	showSelectRole(checkUserRoleLenght());
	showSelectMustInput(roleName,realName);
	fnTab($(".tabNav"),'click');
	LimitTextArea(getId("textareaBoxs"));
	choiceTypeVal();
	checkScreenWidth(".head");
	moveLeftRight(0);
	blockPerName();
	checkScreen();
	showDueWindow();
});
function backIndex(){
	getId("roleID").value = roleId;
	getId("roleName").value = roleName;
	getId("roleForm").submit();
}
//当前用户是学生用户下并且剩余学习天数<=5天时弹出提示窗口
function showDueWindow(){
	var diffDays = 0;
	var showFlag = false;
	var msg_title = "<strong class='dueTit'>使用期限到期提醒</strong>";
	var msg_content = "";
	var msg_button_1 = "<a href='javascript:void(0)' class='alertBtn knowBtn' onclick='closeWindow();'>知道了</a>";
	var msg_button_2 = "<a href='javascript:void(0)' class='alertBtn buyBtn' onclick='onlineBuy();'>去购买</a>";
	if(roleName == "学生"){
		diffDays = parseInt(getUserDiffDays());
		if(diffDays > 0){
			if(diffDays <= 5){
				msg_content = "<p class='dueCon'>系统检测到您的到期日已不足"+"<strong>"+diffDays+"</strong>"+"天,为了不影响您的使用，请及时充值!点击在线购买，完成充值!</p>";
				showDueWindow1(msg_title + "\n" + msg_content + "\n" +msg_button_1 + "&nbsp;" + msg_button_2);
			}else{
				closeWindow();
			}
		}else{
			msg_content = "<p class='dueCon'>系统检测到您的使用期限已过期，请及时续费购买以便继续使用!点击在线购买，完成充值!</p>";
			showDueWindow1(msg_title + msg_content + msg_button_1 + msg_button_2);
		}
	}else{
		closeWindow();
	}
}
//判断当前学生到期日期距当前日期天数
function getUserDiffDays(){
	var diffDays = 0;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:'commonManager.do?action=getUserDiffDays',
        success:function (json){
        	diffDays = json;
        }
    });
	return diffDays;
}
//显示弹出层
function showDueWindow1(msg){
	if("${sessionScope.showFlag}" != "1"){
		$(".alert_windows").show();
		$("#layer").show();
		$(".alert_windows").html(msg);
		var winWid = $(window).width()/2 - $('.alert_windows').width()/2;
		var winHig = $(window).height()/2 - $('.alert_windows').height()/2;
		$(".alert_windows").css({"left":winWid,"top":-winHig*2});	//自上而下
		$(".alert_windows").animate({"left":winWid,"top":winHig},1000);
		//给session中新建一个变量（表示窗口已经显示了）
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        url:'commonManager.do?action=setSession',
	        success:function (json){
	        	
	        }
	    });
	}else{
		closeWindow();
	}
}
//关闭提示框
function closeWindow(){
	var winWid = $(window).width()/2 - $('.alert_windows').width()/2;
	var winHig = $(window).height()/2 - $('.alert_windows').height()/2;
	$(".alert_windows").animate({"left":-winWid,"top":-winHig},1000,function(){
		$(".alert_windows").hide();
		$("#layer").hide();
	});
}


</script>

  </head>
  <body class="bg3">
	<!-- head头部部分 -->
	<div class="headWrap">
		<div class="head">
			<div class="logos">
				<img src="Module/images/logo.png" alt="助学网--中小学生课堂信息反馈系统" />
			</div>
			<div class="useImg">
				<img id="userImg" src="${sessionScope.protrait}" height="116" />
				<div class="layerName">
					<span class="imgLayer"></span>
					<span class="nameUser">${sessionScope.realName}</span>
				</div>
			</div>
			<div id="userCenter" class="userCenter">
				<span class="userChanel">${sessionScope.roleName}频道</span>
				|
				<a href="javascript:void(0)" onclick="loginOut()">退出</a>
				<span class="decTriangle"></span>
			</div>
			<div class="nav">
				<ul class="tabNav">
					<li id="markLayer" style="left:0;"></li>
					<li class="navList active"><a href="javascript:void(0)" onclick="backIndex()">首页</a></li>
					<c:if test="${sessionScope.roleName == '学生'}">
							<li class="navList"><a href="studyOnline.do?action=load">在线答题</a></li>
					</c:if>
					<li class="navList"><a href="personalCenter.do?action=welcome">个人中心</a></li>
					<c:if test="${sessionScope.roleName == '学生' }">
						<li class="navList"><a href="javascript:void(0)" onclick="ntList()">导师列表</a></li>
						<li class="navList"><a href="javascript:void(0)" onclick="onlineBuy()">在线购买</a></li>
						<li class="navList"><a href="shopManager.do?action=welcome">金币商城</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<div class="mainConWrap">
		 <div class="homePage w1000">
		 	<a title="切换系统" hidefocus="true" id="selectUserRole" class="switchBtn" style="display:none;" href="javascript:void(0)" onclick="selectRole()"></a>
			<div class="homeCon">
				<div class="contents clearfix">
					<ul id="moduleUl" class="clearfix">	
						<logic:present name="rList" scope="request">
					  	  <logic:iterate id="resource" name="rList" type="com.kpoint.vo.ResourceVO" scope="request" >
							    <li class="modulePart">
								    <logic:match name="resource" property="parId" value="1">
								    	<a href="personalCenter.do?action=welcome&moduleId=<bean:write name='resource' property='id'/>">
								    		  <img class="imgIcon" src="<bean:write name='resource' property='imgUrl'/>"/>
								        	  <span><bean:write name='resource' property='resName'/></span>
								         </a>
								    </logic:match>
								    <logic:notMatch name="resource" property="parId" value="1">
								    	<a href="<bean:write name='resource' property='resUrl'/>">
								    		  <img class="imgIcon" src="<bean:write name='resource' property='imgUrl'/>"/>
								        	  <span><bean:write name='resource' property='resName'/></span>
								         </a>
								    </logic:notMatch>							        
								</li>
						    </logic:iterate>
					   </logic:present>
					</ul>
				</div>
			</div>
		 </div>
	</div>
	

	
	<!-- 网络导师收费文本框是否填写的判断盒子 -->
	<div class="judgeNetTea">
		<div id="viewCon" class="viewCon">	
			<ul>
				<li class="teacherPart">
					<div class="introTitle">
						<h2>设置您申请的网络导师称谓</h2>
					</div>	
					<div class="introCon3">
						<div class="detail">
							<p>
								<span class="detailTitle">网络导师称谓：<em class="triangle"></em></span>
								<span class="margL">系统将以网络导师的名义智能化的与家长短信沟通，智能化的在网站上指导学生学习。请设置显现给家长和学生的网络导师称谓。</span>
							</p>
						</div>
						<div class="netTeaName">
							<div class="nameT clearfix">
								<div class="realName fl">
									<strong>真实姓名：</strong>
									<input type="text" id="reallyName" readonly="readonly"/>
								</div>
								<div class="note fl">
									<p>（请填写真实姓名，方便我们在审核及结算时，与您联系。我们将保证您的隐私安全！）</p>
								</div>
							</div>
							<div class="nameT clearfix">
								<div class="realName fl">
									<strong>网络姓名：</strong>
									<input type="text" id="netName" />
								</div>
								<div class="note fl">
									<p>（此处设置的称谓将显现给您的学生。您可以使用真实姓名，如果感觉不方便，也可以使用化名，如"张老师"。）</p>
								</div>
							</div>
						</div>
					</div>	
				</li>
				<li class="teacherPart">
					<div class="introTitle">
						<h2>设置您的导师指导费</h2>
					</div>	
					<div class="introCon3">
						<div class="detail1">
							<p>
								<span class="detailTitle">温馨提示：<em class="triangle"></em></span>
								<span class="c1">网络导师每学期收益=导师指导费 X 学生数</span>&nbsp;、<span class="c1">学生购买价=网站资源费298元+导师指导费</span>&nbsp;虽然此处的总价略高于辅导班的价格， 但是系统有丰富的学习资源、独特的溯源复习和预习、智能化跟踪指导，再加上您的一对一答疑，使用知识典，就能把最有效的一对一家教天天请到家！所以学习效果一定优于各类课后辅导班！
							</p>
						</div>
						<div class="netTeaName">
							<div class="nameT clearfix">
								<div class="realName fl">
									<strong>网站资源费：</strong>
									298元/半年（180天）
								</div>
								
							</div>
							<div class="nameT clearfix">
								<div class="realName fl">
									<strong>学生购买价：</strong>
									网站资源费298元+导师指导费
								</div>
								
							</div>
							<div class="nameT clearfix">
								<div class="realName fl">
									<strong>您的指导价：</strong>
									<input type="text" id="teachMoney"/>
								</div>
								
							</div>
						</div>
					</div>	
				</li>
			</ul>
			<a href="javascript:void(0)" id="prevPage" class="prevPage" onclick="showPrevPage()">上一页</a>
			<a href="javascript:void(0)" id="nextPage" class="nextPage" onclick="showNextPage()">下一页</a>
			<a href="javascript:void(0)" id="endButton" onclick="endSet()">结束</a>
		</div>
	</div>
	<!-- 遮罩层 -->
	<div id="layer"></div>
	
	<!-- 身份选择 -->
	<div id='selectRoleWindowDiv' class="roleChoice" >
		<p>请选择一个身份进入系统！</p>
		<div id='selectRole' class="choiceBox"></div>
		<span class="roleClose" onclick="closeRoleWin()"></span>
	</div>
	<form id="roleForm" name="roleForm"  action="userManager.do?action=goPage" method="post">
   		<input type="hidden" id="roleID" name="roleID"/>
   		<input type="hidden" id="roleName" name="roleName"/>
    </form>
    <!-- 充值入口  -->
    <c:if test="${sessionScope.roleName == '学生'}">
    	<a href="rcManager.do?action=recharge" class="chargeCardEnBtn classBtn1" target="_blank"></a>
    </c:if>
    <!-- 反馈窗口 -->
    <span class="feedback" onclick="showFeedbackWindow()"></span>
    <div id="feedbackBox">
    	<div class="topAsk topTiwen">
			<p class="myAsks">用户反馈</p>
			<span class="feedIcon"></span>
			<span class="closeAskBox" title="关闭" onclick="closeFeedox()"></span>
    	</div>
    	<div class="midFeed">
    		<input type="hidden" value="" id="typeVal"/>
    		<div class="feedStyle clearfix">
	    		<span class="txtfeed fl">反馈类型:</span>
	    		<div class="feedType">
	    			意见建议
	    			<input class="selBtn" type="radio" value="1" name="type">
	    		</div>
	    		<div class="feedType">
	    			错误提示
	    			<input class="selBtn" type="radio" value="2" name="type">
	    		</div>
    		</div>
    		<div class="feedTit clearfix">
    			<span class="txtTit fl">反馈标题:</span>
    			<input type="text" id="fbTitle" class="input_Tit" />
    		</div>
    		<div class="feedCon">
    			<textarea id="textareaBoxs" maxlength=500 onkeydown="LimitTextArea(this)" onkeypress="LimitTextArea(this)" onkeyup="LimitTextArea(this)"  onfocus="if(value=='请详细描述您的反馈信息，我们将据以改善现状，更好地为您服务...'){value='';} LimitTextArea(this)" onblur="if(value==''){value='请详细描述您的反馈信息，我们将据以改善现状，更好地为您服务...';} LimitTextArea(this)">请详细描述您的反馈信息，我们将据以改善现状，更好地为您服务...</textarea>
    			<div class="remainBox">
                    	<p>当前已输入<span id="nowNum"></span>个字符，还剩<span id="maxNum"></span>个字符</p>
                 </div>
    		</div>
    	</div>
    	<div class="botAsk">
			<div class="botAskR botTiwen"></div>
			<div class="botAskMid"></div>
			<!-- 提交  -->
			<input class="tijiaoBtn saveBtn1" type="submit" value="提交" onclick="feedback()"/>
		</div>
    </div>
    <div class="alert_windows"></div>
    <!-- 客服在线咨询  -->
    <%@include file="../../Module/kefu/kefu.jsp"%>
</body>
</html>
