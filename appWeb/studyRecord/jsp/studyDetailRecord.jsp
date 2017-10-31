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
	<link href="Module/appWeb/studyRecord/css/studyDetailRecord.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/appWeb/commonJs/iscroll.js"></script>
	<script src="Module/appWeb/studyRecord/js/studyDetailRecord.js" type="text/javascript"></script>
	<!--script type="text/javascript" src="Module/appWeb/commonJs/ajaxCommon.js" charset="utf-8"></script-->
	<script src="Module/appWeb/commonJs/filter.js" type="text/javascript"></script>
	<script type="text/javascript">
	var studyLogId = "${requestScope.studyLogId}";
	var loreId = "${requestScope.loreId}";//当前知识点编号
	var isFinish = "${requestScope.isFinish}";
	var loreName = "${requestScope.loreName}";
	var subId = "${requestScope.subId}";
	var subName = "${requestScope.subName}";
	var startTime = "${requestScope.startTime}";
	var endTime = "${requestScope.endTime}";
	var stuId = "${requestScope.stuId}";
	var status = "${requestScope.guideStatus}";
	var roleName = "${requestScope.roleName}";
	var roleName_sess = "${sessionScope.roleName}";
	var ntId = "${requestScope.ntId}";
	var pageNo_zd = 1;
	var pageNo_zc = 1;
	var pageNo_gg = 1;
	var studyTypeName_a = "zdx";
	var wrapperObj = "zdWrapper";
	var options = 0;
	var myScroll,myScroll_1,pullUpEl, pullUpOffset;
	var cliWid = document.documentElement.clientWidth;
	var cliHei = document.documentElement.clientHeight;
	var noDataFlag = false;
	var noDataFlag_zd = false;
	var noDataFlag_zc = false;
	var noDataFlag_gg = false;
	var zcFlag = true;//防止滑动到当下重复创建iscrollBar
	var ggFlag = true;//防止滑动到当下重复创建iscrollBar
	var glFlag = true;//防止滑动到当下重复创建iscrollBar
	var viewFlag = true;
	$(function(){
		$("#loreNameSpan").html(loreName);
		initWidHei();
		getStudyDetailList_init();
		tabScroll();//左右滑动选项卡
	});
	function initWidHei(){
		$(".detailWrap").height(cliHei - 60 -$(".tabNav").height() - $("#detailTit").outerHeight());
		$(".comWrapper").height($(".detailWrap").height());
		$(".comWrapper_gl").height($(".detailWrap").height());
		$(".swiper-wrapper").width(cliWid*4);
		$(".swiper-slide").width(cliWid);
		$(".navBox").width(456);
		detailScroll();
	}
	//查看学习详情左右iscroll
	function detailScroll() {
		myScroll = new iScroll('innerTabNav', { 
			checkDOMChanges: true,
			hScrollbar : false,
			onScrollMove:function(){
				viewFlag = false;
			},
			onScrollEnd:function(){
				viewFlag = true;
			}
		});
		if($(".navBox").width() > cliWid){
			$(".shadowSpan").show();
		}else{
			$(".shadowSpan").hide();
		}
	}
	</script>
  </head>
  
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="goGuideManager()"></span>
		<p class="ellip"><span id="loreNameSpan"></span>学习详情</p>
	</div>   	
	<!-- 选项卡导航  -->
	<div class="tabNav">
		<div id="innerTabNav">
			<div class="navBox">
				<a href="javascript:void(0)" class="active"><span class="spanTri"></span>针对性诊断结果</a>
		        <a href="javascript:void(0)"><span class="spanTri"></span>再次诊断结果</a>
		        <a href="javascript:void(0)"><span class="spanTri"></span>巩固训练结果 </a>
		        <a href="javascript:void(0)"><span class="spanTri"></span>关联诊断结果</a>
	        </div>
	        <span class="shadowSpan"></span>
        </div>
	</div>
	<!-- 选项卡对应内容大标题  -->
	<!-- h2 id="detailTit">针对性诊断结果</h2 -->
	<!-- 选项卡内容 -->
	<div id="detailWrap" class="detailWrap">
		<div class="swiper-wrapper">
			<!-- 针对性诊断结果  -->
			<div class="swiper-slide" style="display:block;">
				<div id="zdWrapper" class="comWrapper">
					<div id="scroller_zd" class="sonScrollerAbso">
						<!-- 数据  -->
						<div id="studyDetailDiv_zdx" class="studyTypeName"></div>
						<div id="pullUp">
							<span class="pullup-icon"></span>
							<span class="pullUpLabel">上拉加载更多...</span>
						</div>
					</div>
				</div>
			</div>
			<!-- 再次诊断结果  -->
			<div class="swiper-slide">
				<div id="zcWrapper" class="comWrapper">
					<div id="scroller_zc" class="sonScrollerAbso">
						<!-- 数据  -->
						<div id="studyDetailDiv_zc" class="studyTypeName"></div>
					</div>
				</div>
			</div>
			<!-- 巩固训练结果  -->
			<div class="swiper-slide">
				<div id="ggWrapper" class="comWrapper">
					<div id="scroller_gg" class="sonScrollerAbso">
						<!-- 数据  -->
						<div id="studyDetailDiv_gg" class="studyTypeName"></div>
					</div>
				</div>
			</div>
			<!-- 关联诊断结果  -->
			<div class="swiper-slide">
				<div id="glWrapper" class="comWrapper_gl">
					<div id="scroller_gl" class="scroller">
						<!-- 数据  -->
						<div id="studyDetailDiv_gl" class="studyTypeName_gl"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
</body>
</html>
