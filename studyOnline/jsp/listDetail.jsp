<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>助学网--学生在线答题</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/images/logo.ico" rel="shortcut icon"/>
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/studyOnline.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/listDetail.css" type="text/css" rel="stylesheet" />
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/studyOnline/js/listDetail.js"></script>
	<script type="text/javascript" src="Module/loreManager/flashPlayer/images/swfobject.js"></script>
	<script type="text/javascript" src="Module/loreManager/flowPlayer/flowplayer-3.2.13.min.js"></script>
	<script type="text/javascript" src="Module/studyOnline/js/studyOnlineJs.js"></script>
	<script type="text/javascript">
		var educationId = "${requestScope.educationId}";
		var subjectId = "${requestScope.subId}";
		var classId = "${requestScope.classId}";
		var roleName = "${sessionScope.roleName}";
		var roleId = "${sessionScope.roleID}";
		var nextLoreId = "${requestScope.nextLoreId}";
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
		var task = "${requestScope.task}";
		var loreId = "${requestScope.loreId}";
		var loreName = "${requestScope.loreName}";
		var path = "${requestScope.path}";
		var isFinish = "${requestScope.isFinish}";
		var loreTypeName = "${requestScope.loreTypeName}";
		var access = "${requestScope.access}";
		var status = "${requestScope.isFinish}";
		$(function(){
			fnTab($('.tabNav'),'click');
			fnTab($('.tabNav1'),'click');
			//fnTabNav($('.sourceNav'),$('.smallWrap'),'click');
			$("#li_"+subjectId).addClass("active");
			checkScreenWidth(".head");
			testHeight();
			moveLeftRight(91);
			checkSubLiLen();
			hoverImgMoveTop($(".tabNav1 li"),$(".subImgs"),0,-3);
		});
				
		function backIndex(){
			getId("roleID").value = roleId;
			getId("roleName").value = roleName;
			getId("roleForm").submit();
		}
		function showBook(subjectId){
			window.location.href = "studyOnline.do?action=load&classId="+classId+"&subId="+subjectId;
			
		}
		function backChapter(educationId){
			window.location.href = "studyOnline.do?action=load&classId="+classId+"&subId="+subjectId+"&educationId="+educationId;
		}
		function goLoreTree(loreId){
			var mainWin = document.getElementById("questionMainCon").contentWindow;
			mainWin.location.href = "studyOnline.do?action=showQuestionPage&loreId="+loreId;
		}
	</script>
  </head>
  
  <body>
    <!-- head头部部分 -->
	<div class="headWrap">
		<div class="head">
			<div class="logo">
				<img src="Module/images/logo.png" alt="助学网--中小学生课堂信息反馈系统" />
			</div>
			<div id="userCenter" class="userCenter">
				<span class="userChanel">${sessionScope.roleName}频道</span>
				|
				<a href="javascript:void(0)" onclick="loginOut()">退出</a>
				<span class="decTriangle"></span>
			</div>	
			<div class="nav">
				<ul class="tabNav">
					<li id="markLayer" style="left:91px;"></li>
					<li class="navList"><a href="javascript:void(0)" onclick="backIndex()">首页</a></li>
					<li class="navList active"><a href="studyOnline.do?action=load">在线答题</a></li>
					<li class="navList"><a href="personalCenter.do?action=welcome">个人中心</a></li>
					<c:if test="${sessionScope.roleName == '学生' }">
						<li class="navList"><a href="javascript:void(0)" onclick="ntList()">导师列表</a></li>
						<li class="navList"><a href="onlineBuy.do?action=load">在线购买</a></li>
						<li class="navList"><a href="shopManager.do?action=welcome">金币商城</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<div class="mainContent">
		<!-- 答题部分头部 -->
		<div class="mainHead clearfix" id="mainHead">
			<!-- 左侧  -->
			<div class="head_L"></div>
			<div class="tabNav1Wrap">
				<div class="tabNav1Box">
					<ul id="tabNav1" class="tabNav1 clearfix">
						<c:forEach items="${requestScope.gList}" var="grade">
							<li class="smallNavList" id="li_<c:out value="${grade.subject.id}"/>">
								<span class="bookMark"></span>
								<a onclick="showBook('${grade.subject.id}')"><img class="subImgs" src='${grade.subject.subImgUrl}'/></a>
							</li>
						</c:forEach>
					</ul>
					<span class="bookDec1"></span>
					<span class="bookDec2"></span>
				</div>
				<span id="prevBtns" class="prevBtn comBtns"></span>
				<span id="nextBtns" class="nextBtn comBtns"></span>
			</div>
		</div>
		<!-- 针对具体章节的溯源学习主体内容 -->
		<div class="detailListCon">
			<div class="listHead">
				<h2>${requestScope.loreName}</h2>
				<span class="backIcon"></span>
				<a href="javascript:void(0)" onclick="backChapter(${requestScope.educationId})">返回教材目录</a>
			</div>
			<!-- 核心 -->
			<div class="listMidCon">
				<!-- 课后复习部分 -->
				<div class="parentwWrap">
					<!-- div class="mainConHead">
						<span class="iconReview"></span>
						<p class="pReview">课后复习--检测你对知识点的掌握情况</p>
					</div -->
					<div class="mainCons clearfix">
						<!-- 左侧 -->
						<div class="mainConsL fl">
							<!-- 学习资源  -->
							<p class="readyLearn">学习资源</p>
							<div class="smallPoint clearfix">
								<ul class="sourceNav">
									<li onclick="showSourceBox(${requestScope.loreId},'知识讲解','popWinFlash')" class="active margR">
										<span class="sourceIcon sourceBg1"></span>
										视频讲解
									</li>
									<li onclick="showSourceBox(${requestScope.loreId},'点拨指导','popWinGuide')" >
										<span class="sourceBg2"></span>
										点拨指导
									</li>
									<li onclick="showSourceBox(${requestScope.loreId},'知识清单','popWinLore')" class="margR">
										<span class="sourceIcon sourceBg3"></span>
										知识清单
									</li>
									<li onclick="showSourceBox(${requestScope.loreId},'解题示范','popWinExa')">
										<span class="sourceIcon sourceBg4"></span>
										解题示范
									</li>
								</ul>
							</div>
							<!-- 任务奖励盒子  -->
							<div class="taskBox">
								<div class="topTask">
									<span class="taskDecIcon taskPosL"></span>
									<span class="taskDecIcon taskPosR"></span>
									<p>任务描述及奖励</p>
								</div>
								<div id="mainTaskCon" class="mainTaskCon">
									<c:if test="${empty stList}">
										<p class="noTask">点击开始挑战进行在线答题然后用赢取金币可以在金币商城兑换精美的礼品喔  *_*</p>
									</c:if>
									<div id="tasklist" class="taskListCon no_select" unselectable="none" onselectstart="return false">
										<c:forEach items="${requestScope.stList}" var="st">
											<ul class="stadus">
												<li class="taskListName fl" title="${st.taskName}">${st.taskName}</li>
												<li class="complete fl"><span class="completeIcon"></span></li>
												<li class="reword fr"><span title="金币">+${st.coin}</span></li>
											</ul>
										</c:forEach>
									</div>
									<div id="parentScroll" class="scrollParent">
										<div id="sonScroll" class="scrollSon"></div>
									</div>
								</div>
							</div>
						</div>
						<!-- 右侧-->
						<div class="mainConsM fl">
							<div class="midTitle">
								<span class="challangePic"></span>
								<p><span class="kehouColor">课后挑战</span>--检测你对该知识点的掌握情况</p>
								<c:if test="${requestScope.isFinish == 2}">
									<div class="taskComple"></div>
								</c:if>
							</div>
							<!-- 任务 第几个任务  -->
							<h2 class="taskNum">当前任务&nbsp;&nbsp;<span class="nowTask">${requestScope.loreTaskName}</span>&nbsp;<span class="numTask">(第${requestScope.task}个任务)</span></h2>
							<!-- 金币，溯源路线 任务名称  -->
							<div class="goldLineBox">
								<!-- 金币  -->
								<div class="jinbiBox clearfix">
									<span class="rewordIcon"></span>
									<span class="nowGolden fl">${requestScope.money}</span><span class="jinbiTxt fl">金币</span>
									<div class="goldenIcon fl"></div>
									
								</div>
								<!-- 溯源路线图 -->
								<div class="suyuanTxt">
									溯源路线图 ：共&nbsp;<span class="level color">${requestScope.stepCount}</span>&nbsp;级
									<span class="num color">&nbsp;${requestScope.loreCount}</span>&nbsp;个知识点
									<a class="showTree" href="javascript:void(0)" onclick="goChallenge('${requestScope.loreId}','${requestScope.nextLoreIdArray}','${requestScope.studyLogId}','traceback','review','2','${requestScope.subId}','${requestScope.pathType}','${requestScope.loreTaskName}','${requestScope.access}')">点击查看&gt;&gt;</a>
								</div>
								<!-- 任务描述  -->
								<div class="taskDetail">
									学习了&nbsp;<span class="loreName">${requestScope.loreName}</span>&nbsp;这个知识点，掌握的怎么样呢？检测一下吧,找出没有掌握的根源！
								</div>
								<!-- 开始挑战  -->
								<div id="taskBtn" class="">
									<input id="doBtn" type="button" class="comBtn" value="${requestScope.buttonValue}" onclick="goChallenge('${requestScope.loreId}','${requestScope.nextLoreIdArray}','${requestScope.studyLogId}','study','review','2','${requestScope.subId}','${requestScope.pathType}','${requestScope.loreTaskName}','${requestScope.access}')">
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
	<!-- --------准备的学习资源弹窗  ------------->
	<!--  知识讲解 -->
	<div id="popWinFlash" class="parPopWin">
		<span class="closePopWin" onclick="closePopWin()"></span>
		<div id="headSourFlash" class="headSources"></div>
		<div class="smallWrap resBoxFlash">
			<div id="viewerPlaceHolder" style="width:741px; height:529px"></div>
		</div>
	</div>
	<!-- 点拨指导  -->
	<div id="popWinGuide" class="parPopWin">
		<span class="closePopWin" onclick="closePopWin()"></span>
		<div id="headSourGuide" class="headSources"></div>
		<div class="smallWrap resBoxGuide">
			<span class="leftDecBg"></span>
			<span class="topDecBg"></span>
			<span class="bottomDecBg"></span>
			<span class="rightDecBg"></span>
			<div id="guideBox" class="guideDivBox">
				<div id="guideDiv" class="conDivGuide"></div>
			</div>
		</div>
	</div>
	<!-- 知识清单  -->
	<div id="popWinLore" class="parPopWin">
		<span class="closePopWin" onclick="closePopWin()"></span>
		<div id="headSourLore" class="headSources"></div>
		<div class="smallWrap resBoxLorelist">
			<span class="leftDecBg"></span>
			<span class="topDecBg"></span>
			<span class="bottomDecBg"></span>
			<span class="rightDecBg"></span>
			<div id="loreListBox" class="loreListDivBox">
				<div id="loreListDiv" class="conDivLoreList"></div>
			</div>
		</div>
	</div>
	<!-- 解题示范  -->
	<div id="popWinExa" class="parPopWin">
		<span class="closePopWin" onclick="closePopWin()"></span>
		<div id="headSourExa" class="headSources"></div>
		<div class="smallWrap resBoxExa">
			<span class="leftDecBg"></span>
			<span class="topDecBg"></span>
			<span class="bottomDecBg"></span>
			<span class="rightDecBg"></span>
			<div id="loreExaBox" class="loreExaDivBox">
				<div id="loreExampleDiv" class="conDivLoreExa"></div>
			</div>
		</div>
	</div>	
	<!-- 开始挑战弹窗 -->
	<div id="challengeWin" class="challengeBox">
		<span class="closeChallengeBtn" onclick="closeChallengeWin()"></span>
		<iframe id="questionMainCon" name="questionMainCon" src="" width="100%" height="100%" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
	</div>
	
	<form id="roleForm"  action="userManager.do?action=goPage" method="post">
   		<input type="hidden" id="roleID" name="roleID"/>
   		<input type="hidden" id="roleName" name="roleName"/>
    </form>
  </body>
</html>
