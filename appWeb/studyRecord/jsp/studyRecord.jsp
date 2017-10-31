<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>学习记录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/appWeb/studyRecord/css/studyRecord.css" rel="stylesheet" type="text/css" />
	<link href="Module/appWeb/mobiscroll/css/mobiscroll.custom-2.5.0.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/mobiscroll/js/jquery.mobile-1.3.0.min.js"></script>	
	<script src="Module/appWeb/mobiscroll/js/mobiscroll.custom-2.5.0.min.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script src="Module/appWeb/studyRecord/js/studyRecord.js" type="text/javascript"></script>
	<!--script type="text/javascript" src="Module/appWeb/commonJs/ajaxCommon.js" charset="utf-8"></script-->
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
	var studyLogId = "${requestScope.studyLogId}";
	var isFinish_a = "${requestScope.isFinish}";
	var subId = "${requestScope.subId}";
	var subName = "${requestScope.subName}";
	var startTime = "${requestScope.startTime}";
	var endTime = "${requestScope.endTime}";
	var roleName = "${requestScope.roleName}";
	var status = "${requestScope.guideStatus}";//指导状态--nt
	var ntId = "${requestScope.ntId}";//导师编号--nt
	var stuId = "${requestScope.stuId}";//学生编号--nt
	var studyNum = "${requestScope.allStudyNumber}";			
	var stuName = "";
	var cliWid = document.documentElement.clientWidth;
	var cliHei = document.documentElement.clientHeight;
	var recordFlag = true;
	var loadStFlag = true;
	$(function(){
		$("#startTime").val(startTime);
		$("#endTime").val(endTime);
		initDateSel("startTime",2020);
		initDateSel("endTime",2020);		
		if(roleName == "nt"){//导师
			$("#stuOption").hide();
			$("#ntOption").show();
			$(".showStBtn").show();
			$(".txtSpan").show();
			$(".subBox").css({"width":70});
			$(".comDataUl").css({"width":68});
			getSelfBindStuList();//获取学生列表
			$("#stNaInpVal").val(stuId);
			$("#guidInpVal").val(status);
			if(status == 0){
				$("#guideStaSpan").html("未指导");
			}else if(status == 1){
				$("#guideStaSpan").html("已指导");
			}else if(status == -1){
				$("#guideStaSpan").html("全部");
			}
			getGuideStatus();
		}else if(roleName == "stu"){//学生
			$("#ntOption").hide();
			$("#stuOption").show();
			$(".subBox").css({"width":65});
			$("#subInpVal").val(subId);
			$("#subNameSpan").html("数学");
			getSelfSubjectList();
		}else if(roleName == "family"){//家长
			$("#ntOption").hide();
			$("#stuOption").show();
			$(".subBox").css({"width":65});
			$("#subInpVal").val(subId);
			$("#subNameSpan").html("数学");
			getSelfSubjectList();
		}
		initWid();
		getSRList("init");
	});
	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	//退出返回到首页
	function goHome(module){
		//contact.goHome(module);
	}
	</script>
  </head>
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="goHome('确定退出学习记录？');"></span>
		<p><input id="stNaInpVal" type="hidden"/><span id="stNameSpan"></span><span class="txtSpan">的</span>学习记录</p>
		<span class="showStBtn">更换学生<span id="spanTri"><span class="triSpan topTri"></span></span></span>
	</div>
	<div id="stuWrapper">
		<div class="stScroller">
			<ul id="stuDataUl" class="clearfix"></ul>
		</div>
	</div>
	<div class="searchBox">
		<div class="searInner clearfix">
			<!-- 学生身份下选择学科  -->
			<div id="stuOption" class="subBox fl" style="display:none;">
				<input id="subInpVal" type="hidden"/>
				<span class="triIcon"></span>
				<span id="subNameSpan" class="ellip"></span>
				<div id="subDataUlDiv" class="comDataUl">
					<span class="stuTriSpan"></span>
					<ul id="subDataUl"></ul>
				</div>
			</div>
			<div id="ntOption" class="subBox fl" style="display:none;">
				<input id="guidInpVal" type="hidden"/>
				<span class="triIcon"></span>
				<span id="guideStaSpan" class="ellip"></span>
				<div id="statusDiv" class="comDataUl">
					<span class="stuTriSpan"></span>
					<ul id="guideStatus">
						<li value="-1">全部</li>
						<li value="1">已指导</li>
						<li value="0">未指导</li>
					</ul>
				</div>
    		</div>
			<div class="timeBox fl">
				<input id="startTime"/><span class="fl">至</span><input id="endTime"/>
			</div>
			<a class="searBtn fl" href="javascript:void(0)"  ontouchend="getSRList('manu')"></a>
		</div>
	</div>
	<div id="recordWrap">
		<!-- 学习记录列表  -->
		<div class="recListWrap">
			<div class="recListPar">
				<div class="recordTit ellip">
					最近<strong id="days"></strong>天<span id="stuName">你</span>学习过的<strong id="sname">subName</strong>知识点如下:
				</div>
				<div id="innerRecoWrap"><div id="recordInfo" class="recordCon"></div></div>
				<div class="recordBot">
					<div id="totalInfo" class="totalDiv fl"></div>
					<div class="statusP fr">
						<p class="completeP"><span></span>已完成</p>
						<p class="noCompleteP"><span></span>未完成</p>
					</div>
				</div>
			</div>
		</div>	
	</div>
	<div id="studyRelaDivWin" class="detailInfoBox">
		<div class="detailTit">
			<a class="goBackBtn fl" href="javascript:void(0)" ontouchend="goBack()"><span></span>返回</a>
			<p class="loreNameP ellip fl"><span id="loreName"></span></p>
		</div>
		<div id="wrapper">
			<div id="wrapScoller" class="scroller">
				<div class="detailInfo clearfix">
					<h3 class="titH3">学习明细</h3>
					<p><span class='dec'></span>针对性诊断：<span id="curStep1"></span></p>
					<p><span class='dec'></span>关联性诊断：<span id="curStep2"></span></p>
					<p><span class='dec'></span>关联知识点诊断：<span id="curStep3"></span></p>
					<p><span class='dec'></span>本知识点学习：<span id="curStep4"></span></p>
					<p><span class='dec'></span>再次诊断：<span id="curStep5"></span></p>
					<p><span class='dec'></span>完成情况：<span id="completeInfo"></span></p>
					<p><span class='dec'></span>成绩：<span id="scoreInfo"></span></p>
				</div>
				<div class="btnBox clearfix">
					<div id="showStudyButt" class="fl"></div>
					<div id="showRecordButt" class="fl"></div>
				</div>
				<!-- 系统评价  -->
				<div id="sysAdvice" class="comAdvBox">
					<h3 class="titH3">系统评价</h3>
					<p id="sysAdviceCon" class="lineBreak"></p>
				</div>
				<!-- 导师建议  -->
				<div id="ntAdvice" class="comAdvBox">
					<h3 class="titH3">导师建议</h3>
					<p id="ntAdviceCon" class="lineBreak"></p>
				</div>
			</div>
		</div>
	</div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
	<div class="recordLayer"></div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
  </body>
</html>
