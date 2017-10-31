<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
<title>助学网个人中心</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/personal.css" type="text/css" rel="stylesheet" />
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<link href="Module/studyOnline/css/askAlertWin.css" type="text/css" rel="stylesheet" />
<link href="Module/userManager/css/myGrade.css" type="text/css" rel="stylesheet" />
<link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
<link href="Module/personalCen/css/personalInfo.css" type="text/css" rel="stylesheet"/>
<link href="Module/netTeacherList/css/comPayWinCss.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="Module/personalCen/js/personalJs.js"></script>
<script type="text/javascript" src="Module/userManager/js/myGrade.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/myNetTeacherJs.js"></script>
<script type="text/javascript" src="Module/personalCen/js/pay.js"></script>
<script type="text/javascript" src="Module/personalCen/js/payJs_1.js"></script>
<script type="text/javascript" src="Module/loreManager/flashPlayer/images/swfobject.js"></script>
<script type="text/javascript">
var moduleId = "${requestScope.moduleId}";
var roleName = "${sessionScope.roleName}";
var roleId = "${sessionScope.roleID}";
$(function(){
	checkScreenWidth(".head");
	autoHeight('personalModu');
	autoHeight("perResumeFrame");
	goBackTop();
	checkStatus();
	//导师论坛里面图片展现后滚轮的放大或缩小
	wheelImg("img_old");
	if(roleName == "学生"){
		showHideBox();
		showLevel();
		showRank();
		moveLeftRight(182);
	}else if(roleName == "网络导师" || roleName == "家长"){
		moveLeftRight(91);
	}
	showLeftTab();
	//个人荣誉相册展现的鼠标滚动放大或者缩小
	wheelImg("originPic");
	blockPerName();
});
function getNetTeacherList(){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getSubjectAndNT",
        success:function (json){
        	showNetTeacherList(json);
        }
    });
}
function showNetTeacherList(list){
  	var f='<option value="0">请选择网络导师</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].subId+"/"+list[i].netTeacherId+"'>"+list[i].subName+"("+ list[i].netTeacherName +")</option>";
		}
	}
	$('#netTName').html(f+options);
}
function goBind(){
	var subId = document.getElementById("netTName").value;
	if(subId=="0"){
		alert("请选择未绑定导师科目！");
	}else{
	window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
	}
}

//根据传的模块值让该模块为激活状态
function checkStatus(){
	var mainWin = getId("personalModu").contentWindow;
	if(moduleId >0){
		$("#li"+moduleId).attr("class","active");
		$("#span"+moduleId).show();
		//mainWin.location.href = $("#"+moduleId).attr("href");
		mainWin.location.href = $("#currentUrl_"+moduleId).val();
	}else{
		mainWin.location.href = "userManager.do?action=showUserInfo";
	}
}
function backIndex(){
	getId("roleID").value = roleId;
	getId("roleName").value = roleName;
	getId("roleForm").submit();
}

//提交问题	
function submitQuestion(){
	var question = editor1.getPlainTxt();
	var subId = document.getElementById("netTName").value;
	var qTitle = document.getElementById("qTitle").value;
	var headUrl = document.getElementById("headUrl").value;
	var moduleId = document.getElementById("moduleId").value;
	if(qTitle==""){
		alert("请填写提问标题");
	}else if(question.length==1){
		alert("请编辑问题内容！");
	}else if(subId=="0"){
		alert("请选择网络导师！");
    }else{
	  $.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"questionManager.do?action=addQuestion&question="+encodeURIComponent(question)+"&subId="+subId
				+"&qTitle="+encodeURIComponent(qTitle),
		success:function(json){
			if(json){
				alert("您的问题已成功提交，请等待老师答复！");
				window.location.href = headUrl + moduleId;
				//window.location.reload();
			}else{
				alert("问题提交失败，请重试！");
			}
		}
	});
  }
}

//判断网络导师是否到期
function checkDuration(){
	var subId = document.getElementById("netTName").value;
	var netTName = $("#netTName option:selected").text();
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=checkDuration&subId="+subId+"&netTName="+encodeURIComponent(netTName),
		success:function(json){
			if(json==true){
				alert("您对该网络导师的绑定已到期，不能继续提问！如有需要，请重新绑定！");
				window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
			}else if(json==1){
				alert("您申请成功的未付款绑定已到期！如有需要，请重新申请！");
				window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
			}else if(json==0){
				alert("您申请的导师绑定尚未付款，不能向该导师提问，请尽快付款！");
				window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
			}else if(json==2){
				alert("您的免费试用已到期！如有需要，请绑定网络导师！");
				window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
			}
		}
	});
}
function showHideBox(){
	$(".comDivBox").each(function(i){
		$(this).hover(function(){
			$(".hideLayer").eq(i).stop().animate({top:0},function(){
					experienceBox();
			});
			

		},function(){
			$(".hideLayer").eq(i).stop().animate({top:-128});
		});
			
	});
}
function showLeftTab(){
	$(".tabNav2 li").each(function(i){
		$(this).click(function(){
			$(".tabNav2 li").removeClass("active");
			$(".tabNav2 li a .triangles").hide();
			//$(".tabNav2 li .iconBox img").attr("src","");
			$(this).addClass("active");
			$(".tabNav2 li a .triangles").eq(i).show();
			//alert($(".tabNav2 li .iconBox img").eq(i).attr("src"));
			//var nowSrc = $(".tabNav2 li .iconBox img").eq(i).attr("src");
			//var nowSrcArray = nowSrc.split("/");
			//var lastSrc = nowSrcArray[nowSrcArray.length - 1];
			//var newSrcName = lastSrc.split(".")[0] + "_1.png"; 
			//var newSrc = "Module/images/resourceImages/"+newSrcName;
			//$(".tabNav2 li .iconBox img").eq(i).attr("src",newSrc);
		});
	});
}
//关闭开始挑战窗口
function closeChallengeWin(){
	$(".layer").remove();
	$(".challengeBox").hide();
	$(".challengeBox").css('height',0);
	$("html").removeClass('cancelScroll');
}
function showModule(url,moduleId){
	var subFrame = getId("personalModu").contentWindow;
	var finalUrl = "/"+url+"&moduleId=";
	subFrame.location.href = finalUrl+moduleId;
	document.getElementById("moduleId").value = moduleId;
	if(window.parent.$("#personalModu").attr("flag") == "true"){
		$("#personalModu").height($("#personalModu").height() - 114);
		$("#personalModu").removeAttr("style");
		$("#personalModu").attr("flag","false");
		autoHeight("personalModu");
	}	
	
}
</script>
</head>
<body>
    <input type="hidden" id="moduleId" value="${requestScope.moduleId}"/>
    <input type="hidden" id="headUrl" value="/personalCenter.do?action=welcome&moduleId="/>
	<!-- 头部 -->
	<div class="headWrap">
		<div class="head">
			<div class="logos">
				<img src="Module/images/logo.png" alt="助学网--中小学生课堂信息反馈系统" />
			</div>
			<div class="homeTitle">
				<div id="userImgBox" class="userImg fl">
					<img id="userImg" src="Module/personalCen/images/perCenBg.gif" width="102" height="102" />
					<span class="imgDec"></span>
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
					<c:if test="${sessionScope.roleName == '学生'}">
						<li id="markLayer" style="left:182px;"></li>
					</c:if>
					<c:if test="${sessionScope.roleName == '网络导师'}">
						<li id="markLayer" style="left:91px;"></li>
					</c:if>
					<c:if test="${sessionScope.roleName == '家长'}">
						<li id="markLayer" style="left:91px;"></li>
					</c:if>
					<li class="navList"><a href="javascript:void(0)" onclick="backIndex()">首页</a></li>
					<c:if test="${sessionScope.roleName == '学生'}">
						<li class="navList"><a href="studyOnline.do?action=load">在线答题</a></li>
					</c:if>
					<li class="navList active"><a href="personalCenter.do?action=welcome">个人中心</a></li>
					<c:if test="${sessionScope.roleName == '学生'}">
						<li class="navList"><a href="javascript:void(0)" onclick="ntList()">导师列表</a></li>
						<li class="navList"><a href="onlineBuy.do?action=load">在线购买</a></li>
						<li class="navList"><a href="shopManager.do?action=welcome">金币商城</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 个人中心中间主要内容 -->
	<div class="personCon w1000">
		<div class="userHead clearfix">	
			<input id="id" type="hidden" value="${sessionScope.userId}"/>
			<c:forEach items="${requestScope.ulist}" var="user">
				<div class="useImg fl">
					<img src="${pageContext.request.contextPath}/<c:out value="${user.portrait}"/>" height="160" />
					<div class="layerName">
						<span class="imgLayer"></span>
						<span class="nameUser"><c:out value="${user.realname}"></c:out></span>
					</div>
				</div>
			</c:forEach>
			<c:if test="${sessionScope.roleName == '网络导师' || sessionScope.roleName == '老师'}">
				<div class="welBox">欢迎来到教师工作中心！</div>
			</c:if>
			<c:if test="${sessionScope.roleName == '家长'}">
				<div class="welBox1">欢迎来到家长个人中心！</div>
			</c:if>
			<c:if test="${sessionScope.roleName == '学生'}">
			<!-- 当前等级 -->
			<div class="level comDivBox">
				<div class="comLayer">
					<span class="layerWhite"></span>
					<span class="comTxt">Lv<span class="levelNum"  id="LClevel"></span>级</span>

				</div>
				<div class="hideLayer bgLevel">
					<!-- 最外层  -->
					<div class="proValueBox">
						<!-- 第二层  -->
						<div class="innerProBox">
							<!-- 第三层  -->
							<div id="layerExp" class="perLayer"></div>
							<div id="expValueBox" class="expValue fl">
									<!-- span class="val_triangle"></span -->
									<span class="nowValue" id="LCbeginScore"></span>&nbsp;/
									<span class="totalValue" id="LCendScore"></span>
							</div>
						</div>
					</div>

					<p class="expTxt">距离下一级还有<span class="disExp"></span>经验值</p>
				</div>
			</div>	
			<!-- 当前头衔 -->
			<div class="touxian comDivBox">
			   <div class="comLayer">
					<span class="layerWhite"></span>
					<span class="comTxt" id="LChonorStyle"></span>
				</div>
				<div class="hideLayer bgTou">
					<img src="" id="headImg"/>
				</div>
			</div>
			<!-- 当前金币  -->
			<div class="jinbiBox comDivBox">
				<div class="comLayer">
					<span class="layerWhite"></span>
					<span class="comTxt">${requestScope.coin}</span>
				</div>
				<div class="hideLayer bgGolden">
					<a href="shopManager.do?action=welcome" class="exchangeBtn">立即兑换</a>
				</div>
			</div>
			<!-- 个人资料设置  -->
			<div class="setPerInfo comDivBox" onclick="fixPerInfo()">
				<div class="comLayer">
					<span class="layerWhite"></span>
					<span class="comTxt">资料设置</span>
				</div>
				<div class="hideLayer bgInfo">
					<span class="fixPerInfo"></span>
				</div>
			</div>
			</c:if>
		</div>
		<!-- 个人中心中间主要核心内容 -->
		<div class="userMid">
			<div class="midT"></div>
			<div class="midMiddle clearfix">
				<!-- 左侧模块列表 -->
				<div class="midLeft fl">
					<ul class="tabNav2">
						<c:if test="${sessionScope.roleName == '网络导师' || sessionScope.roleName == '老师' || sessionScope.roleName == '家长'}">
							<li id="li_tea'/>">
								<div class="iconBox">
									 <img class="imgIcons" src="Module/personalCen/images/fixIcon.png" width="66" height="55"/>
								</div>
								<a href="javascript:void(0)" onclick="fixPerInfo();" target="personalModu">个人资料修改
									<span class="triangles"></span>
								</a>
							</li>
						</c:if>
						<c:forEach items="${requestScope.rList}" var="resource">
							<li id="li<c:out value='${resource.id}'/>" class="ceshi">
								<div class="iconBox">
									 <img class="imgIcons" src="<c:out value='${resource.smallImgUrl}'/>" width="66" height="55"/>
								</div>
								<input type="hidden" id="currentUrl_${resource.id}" value="${resource.resUrl}"/>
								<a class="linkABox" id="<c:out value='${resource.id}'/>" onclick="showModule('${resource.resUrl}',${resource.id})"><c:out value="${resource.resName}"/>
									<span id="span<c:out value='${resource.id}'/>" class="triangles"></span>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- 右侧模块内容 -->
				<div class="midRight fl">
					<iframe id="personalModu" name="personalModu" src="" flag="false" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
				</div>
			</div>
		</div>
	</div>
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
	
	<!-- 我的提问窗口  -->
	<div class="myAskBox">
		<div class="topAsk topTiwen">
			<p class="myAsks">我的提问</p>
			<span class="askIcon"></span>
			<span class="closeAskBox" title="关闭" onclick="closeNoneBox('.myAskBox')"></span>
		</div>
		<div class="midAsk">
			<!-- 选择科目老师的盒子 -->
			<div class="subjectBox bor1">
				<span class="daoshiIcon"></span>
				<span class="choiceText comFontCol font2">选择科目老师</span>
				<select id="netTName" onchange="checkDuration()"></select>
				
				<!-- 未绑定网络导师的盒子  -->
				<div class="noNetTeaBox">
					<span class="warningIcon"></span>
					<p>请绑定该科目的网络导师&nbsp;</p>
					   <a href="javascript:void(0)" class="goAttachBtn" onclick="goBind()">
					   	<span class="goAttachIcon"></span>
					   	<span class="fl">现在去绑定</span>
					   </a>
				</div>
			</div> 
			<!-- 提问标题  -->
			<div class="askTitle bor1">
				<span class="comFontCol font2">标题：</span><input type="text" id="qTitle" class="askHeadCon" maxlength="40"/>
			</div>
			<!-- 提问内容  -->
			<div class="askCon">
				<div class="mainAskCon" id="question">
					<div id="myEditor"></div>	
					<script type="text/javascript">						
						var editor1;
						editor1 = new baidu.editor.ui.Editor( {
							//这里可以选择自己需要的工具按钮名称,此处仅选择如下五个  
					        toolbars:[['Source', 'italic','bold', 'underline',
					                   'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify','|',
					                   'insertimage']], 
							initialFrameWidth : 548,
							initialFrameHeight : 235,
							wordCount:true,
							textarea : 'description'
						});
						editor1.render("myEditor");
					</script>					
				</div>
			</div>
		</div>
		<div class="botAsk">
			<div class="botAskR botTiwen"></div>
			<div class="botAskMid"></div>
			<!-- 提交  -->
			<input class="tijiaoBtn saveBtn1" type="submit" value="提交" onclick="submitQuestion()"/>
		</div>
		
	</div>
	<!-- 我的提问答疑列表查看后弹出的窗口iframe -->
	<div id="iframeWrap" class="ifrmaAskWrap">
		<iframe id="iframeAskQueList" name="iframeAskQueList" src="" width="100%" height="100%" frameborder="0" scrolling="no" allowTransparency="true"></iframe>
	</div>
	
	<!-- 网络导师论坛发帖弹窗窗口  -->
	<div class="pubTopicWin">
		<!-- 发帖弹窗头部  -->
		<div class="topAsk topFatie">
			<p class="myAsks">我的发帖</p>
			<span class="pubIcon"></span>
			<span class="closeAskBox" title="关闭" onclick="closeNoneBox('.pubTopicWin')"></span>
		</div>
		<!-- 发帖弹窗中间内容  -->
		<div class="pubTopicMid">
			<div class="pubTit bor3">
				<span>主题：</span><input type="text" id="topicName" class="titCon" maxlength="40"/>
			</div>
			<div class="pubConBox">
				<div id="myEditor1"></div>	
				<script type="text/javascript">
					var editor;
					editor = new baidu.editor.ui.Editor( {
						//这里可以选择自己需要的工具按钮名称,此处仅选择如下五个  
				        toolbars:[['Source', 'italic','bold', 'underline',
				                   'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify','|',
				                   'insertimage']], 
						initialFrameWidth : 548,
						initialFrameHeight : 240,
						wordCount:true,
						textarea : 'description'
					});
					editor.render("myEditor1");
				</script>	
			</div>
		</div>
		<!-- 发帖弹窗底部  -->
		<div class="botAsk">
			<div class="botAskR botFaTie"></div>
			<div class="botAskMid"></div>
			<!-- 提交  -->
			<input class="tijiaoBtn saveBtn3" type="button" value="提交" onclick="addTopic()"/>
		</div>
	</div>
	<!-- 论坛里面点击图片显示原来尺寸的盒子  -->
	<div id="img_oldBox" class="orginalImgBox no_select" unselectable="none" onselectstart="return false">
		<div class="tipBox">
			<p class="tipInfo fl">滚动鼠标滚轮用以缩放图片</p>
		</div>
		<img id="img_old" class="oldImgs" src="" alt=""/>
		<span class="closeOldBox" title="关闭" onclick="closeImgOldBox()"></span>
	</div>
	<!-- 回复 返回顶部盒子 -->
	<div class="askBackTop">
		<a id="backtop" class="backTop" href="javascript:scroll(0,0)" title="返回顶部" hidefocus="true"></a>
	</div>
	<!-- 遮罩层  -->
	<div id="bg_div" class="layer"></div>
	
	<!-- 我的班级我要邀请的弹窗盒子  -->
	<div id="notice">
       	 <span class="closeMyInvite" onclick="CloseDiv('notice','bg_div')" title="关闭窗口"></span>
		 <div class="message">
		    <c:forEach items="${requestScope.uiCode}" var="ui" end="0"><input id="ivc" type="hidden" value="${ui.inviteCode }"></c:forEach>
          	<div class="message_send_l_title" style="padding:10px 0;">1、请设置发短信的后缀署名：&nbsp;&nbsp;<c:forEach items="${requestScope.ulist}" var="ul"><input type="text" style="width:120px;padding:3px; color:#444;" maxlength="6" id="shuming" value="${ul.realname }"></c:forEach>&nbsp;&nbsp;<font color="#FF7D29">为了保证好的邀请效果，请用真实姓名向家长推荐。</font></div>
          	<div class="message_send_l_title" style="padding:10px 0;">2、添加学生的姓名和手机号，通过我们平台的短信系统进行邀请。</div>
          </div>
          <div class="message_send clearfix">
            <div class="message_send_l">
              <div class="message_send_l_con" id="listdiv">
                <table id="list" cellspacing="0" cellpadding="0">
	                <tbody>
	                	<tr>
	                		<th align="left" width="70">
	                			<input id="allcheck" type="checkbox" value="0" onclick="AllCheck()">
	                		</th>
	                		<th align="left" width="100">姓名</th>
	                		<th align="left" width="100">手机</th>
	                		<th width="40" align="center">操作</th>
	                		<th width="130" align="center">状态</th>
	                	</tr>
					</tbody>
					<tbody id="bodylist">
						<tr id="tr0">
							<td style="padding:50px;" colspan="5" align="center">
								<font color="#FF6633">暂无邀请记录，请先添加！</font>
							</td>
						</tr>
					</tbody>
                </table>
                <div class="addBox"><input id="addbtn" type="button" value="+ 开始添加" onclick="AddTr();"></div>
              </div>
              <div class="message_send_l_button">
              <div class="message_send_l_button_r" style="margin:25px auto;width:480px;text-align:center;">
              	<font color="#FF6633">（本月只能发100条，已经发送<span id="yifa"></span>条）</font>
              	<input id="sendbtn" type="button" value="立即发送" onclick="SendPhone()"></div>
              </div>
            </div>
            <div class="message_send_r">
            	<div class="message_send_r_t">短信预览内容</div>
                <div class="message_send_r_con">
                	<p>XX家长，我是孩子的XX老师，向您推荐一个很适合您孩子的学习网站，可以快速提高孩子的数学成绩。网址http://，免费使用码是XXXXXX，通过免费使用码登陆就可免费使用。建议您和孩子一起使用一下。来自XXX</p>
                </div>
            </div>
		</div>
	</div>
	
	<!-- 网络导师个人简介的弹窗 -->
    <div id="parentTeaBox" class="teaResumeBox">
    	<iframe id="perResumeFrame" name="perResumeFrame" src="" width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="true"></iframe>
    </div>
    <!-- 新遮罩层呈现点击个人荣誉图片的时候出现大图下的遮罩层 -->
    <div id="newlayer" class="newLayer"></div>
    <!-- 呈现个人荣誉头像的原图的弹窗 -->
    <div id="bigImgBox" class="perGloryBigImgBox">
    	<img id="originPic" alt="" src=""/>
    	<div class="tipBox">
			<p class="tipInfo fl">滚动鼠标滚轮用以缩放图片</p>
		</div>
		<span id="closeBox" class="closeBigBox" title="关闭" onclick="closeImgOrgBox_1()"></span>
    </div> 
    <!-- 我的导师评分窗口  -->
    <div class="myNetTeaScore">
    	<!-- 关闭窗口  -->
    	<span class="cloJudgeWin" onclick="closeJudgeWin()"></span>
    	<div class="scoreBoxCon">
    	    <input type="hidden" id="ntId">
    		<!-- 评分  -->
    		<div id="scoreStar" class="judgeBox com_DivBox">
    			<p class="fl"><span>*</span>评分：</p>
    			<ul class="clearfix fl">
    				<li title="1分"></li>
    				<li title="2分"></li>
    				<li title="3分"></li>
    				<li title="4分"></li>
    				<li title="5分"></li>
    			</ul>
    			<span class="scoreTxt"></span>
    		</div>
    		<!-- 网络导师标签  -->
    		<div class="netTagBox com_DivBox">
    			<p class="fl"><span>*</span>标签：</p>
    			<ul>
    				<li>
    					回复速度及时
    					<input id="1" type="radio" class="tagRadio wid1" name="tags" value="回复速度及时"/>
    				</li>
    				<li>
    					回复速度一般
    					<input id="2" type="radio" class="tagRadio wid1" name="tags" value="回复速度一般"/>
    				</li>
    				<li>
    					回复速度慢
    					<input id="3" type="radio" class="tagRadio wid1" name="tags" value="回复速度慢"/>
    				</li>
    				<li>
    					回复重点明确易懂
    					<input id="4" type="radio" class="tagRadio wid1" name="tags" value="回复重点明确易懂"/>
    				</li>
    				<li>
    					回复问题认真仔细
    					<input id="5" type="radio" class="tagRadio wid1" name="tags" value="回复问题认真仔细"/>
    				</li>
    				<li>
    					回复问题草草了事
    					<input id="6" type="radio" class="tagRadio wid1" name="tags" value="回复问题草草了事"/>
    				</li>
    				<li class="diyLi">
    					<div class="bgDec"></div>
    					<strong class="diyIcon"></strong>
    					<p class="diyTxt">自定义</p>
    					<input id="0" type="radio" class="tagRadio wid2" name="tags" value="0"/>
    					
    					<input id="diyTag" class="diyInpTxt" type="text" maxlength=10/>
    				</li>
    			</ul>
    		</div>
    		<!-- 评价  -->
    		<div class="judgeTxtWrap com_DivBox">
    			<p class="fl"><span>*</span>评价：</p>
    			<div class="textArea fl">
    				<textarea id="assessment" class="judgeTxarea areaCol" maxlength="280" onfocus="if(value=='导师回答问题是否给力？快来分享你的心得吧...'){value='';}" onblur="if(value==''){value='导师回答问题是否给力？快来分享你的心得吧...';}">导师回答问题是否给力？快来分享你的心得吧...</textarea>
    			</div>
    		</div>
    		<!--  提交  -->
    		<input type="button" class="sumbitBtn" value="提交" onclick="subJudgeScore()"/>
    	</div>
    </div>
    
    
    <!-- 支付窗口对应的遮罩层  -->
    <div class="payLayer"></div>
    <!-- 支付窗口 -->
    <div id="showPayDiv" class="showPayDiv">
    	<div class="payParent">
    		<div class="payHeadTit">
	    		<span class="payWinIcon"></span>
	    		<h2>支付窗口</h2>
	    	</div>	
	    	<span class="closePayWin" onclick="closeWindow()"></span>
	    	<div class="navTop">
			    <ul id="payTab" class="tab clearfix">
			       <li id="payTab1">
			       		<span>1</span>
			       		<em></em>
			       </li>
			       <li id="payTab2">
			       		<span>2</span>
			       		<em></em>
			       </li>
			       <li id="payTab3">
			       		<span>3</span>
			       		<em></em>
				   </li>
			    </ul>
			    <div class="line"></div>
			    <div id="smallLine" class="smallLine"></div>
			    <div id="movebox" class="moveBox">1</div>
			    <p class="detachInfo" id="sureInfo">确定绑定信息</p>
			    <p class="choicePayWay" id="choiceStyle">选择支付方式</p>
			    <p class="detachSuc" id="succ">绑定成功</p>
		    </div>
	      <!--01 确认绑定信息 -->
	     <div class="tabCon mt" style="display:block" id="pay1">
	      <!--  <div class="comInfos bg0">导师学生关系编号：<input type="hidden" class="inpCons" id="ntsId" readonly></div> --> 
	     	 <input type="hidden" class="inpCons" id="ntsId">
	         <div class="comInfos bg1">您要绑定的网络导师：<input type="text" class="inpCons" id="ntName" name="ntName" readonly></div>
	         <div class="comInfos bg2">绑定科目：<input type="text" class="inpCons" id="subName" name="subName" readonly></div>
	         <div class="comInfos bg3">导师价格：<input type="text" class="inpCons" id="baseMoney" name="baseMoney" readonly><span class="yuan">元</span></div>
	        <c:forEach items="${requestScope.stuVOList}" var="student">
	        	<div class="comInfos bg1">您的姓名：<c:out value="${student.username}"/></div>
	        	<div class="comInfos bg4">您的联系方式：<c:out value="${student.mobile}"/></div>
	        </c:forEach>
	        <span class="nowNum">01</span>
	       <input type="hidden" id="neteaId">
	       <input type="hidden" id="subId">
	       <input class="bindBtn" type="button" id="bind" name="bind" value="绑定" onclick="bindNetTeacher()">
	     </div>
	     
	     <!--02 选择支付方式 -->
	     <div class="tabCon mt" id="pay2" style="display:none">
	     	<div class="payFastBox clearfix">
	     		<div class="payStyeNav fl" id="payType" >
     			  <ul class="payWayTab">
	     				<li class="mR active" title="支付宝快捷支付">
	     					<img class="imgIcon" src="Module/netTeacherList/images/payFast1.png"/>
	     					<input type="radio"  name="payType" class="inpRadio" value="快捷支付" checked="checked">
	     					<span class="triangle"></span>
	     				</li>
	     				<li title="银行汇款">
	     					<img class="imgIcon1" src="Module/netTeacherList/images/payFast2.png"/>
	     					<input type="radio"  name="payType" class="inpRadio" value="银联支付">
	     				</li>
	     			</ul>
	     		</div>
	      		<!-- div class="payFastCon fl">
	      			1122
	      		</div -->
			</div>
	      <!-- 账号提示窗口 -->
	      <!--  div id="account" style="display:none">
  				<span class="warnIcon"></span>
   				注意：绑定截至日期为：<span id="dueDate">${requestScope.endDate}</span>,请在<span id="remainDay">${requestScope.remainDays-1}</span>天内付款,否则，您将需要重新申请！
	  	  </div-->	
	      <div id="account" style="display:none">
	       <span class="warnIcon"></span>
	       	注意:
	       <font size="2">绑定截至：<input type="text" id="dueDate" name="dueDate"  style="border:0px;width:80px;text-align:center;color:#ff0000" readonly>，
	                  请在<input id="remainDays" name="remainDays" style="border:0px;width:20px;text-align:center;color:#ff0000" readonly>天内付款。否则，您将需要重新申请！
	       </font>
	      </div>
	      <input type="hidden" id="bindFlag">
	      <input class="payCon" type="button" id="pay" name="pay" value="去支付" onclick="pay()">
		  <span class="nowNum">02</span>
	    </div>
	    
	    <!-- 03支付成功 -->
	    <div class="tabCon" id="pay3" style="display:none">
	      <center>
	      <br><span><font size="3">绑定费用支付成功！请<a href="userManager.do?action=goPage">点击这里</a>继续学习！</font></span></center>
	      <br><br>
	      <input class="successPay" type="button" id="success" name="success" value="确定" onclick="closeWindow()">
	      <span class="nowNum mb">03</span>
	    </div>
    </div>
   </div>
	
	<!-- 五步学习弹窗 -->
	<div id="challengeWin" class="challengeBox">
		<span class="closeChallengeBtn" onclick="closeChallengeWin()"></span>
		<iframe id="questionMainCon" name="questionMainCon" src="" width="100%" height="100%" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
	</div>

	<!--  角色的跳转  -->
	<form id="roleForm"  action="userManager.do?action=goPage" method="post">
   		<input type="hidden" id="roleID" name="roleID"/>
   		<input type="hidden" id="roleName" name="roleName"/>
    </form>
    
</body>
</html>

