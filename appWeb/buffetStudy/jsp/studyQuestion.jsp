<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../../exception/exception.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>巴菲特自助餐五步学习</title>
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/appWeb/onlineStudy/css/studyQuestionList.css" type="text/css" rel="stylesheet" />
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		var buffetStudyDetailId = "${requestScope.buffetStudyDetailId}";
		var loreId = "${requestScope.loreId}";
		var buffetId = "${requestScope.buffetId}";
		var buffetName = "${requestScope.buffetName}";
		var studyLogId = "${requestScope.studyLogId}";
		var lastCommitNumber = 0;
		var questionLength = 0;
		var currentAllQuestionFlag = 1;
		var totalMoney = 0;
		var allLorePath = "${requestScope.path}";
		var currentLoreId = "${requestScope.nextLoreIdArray}";
		var studyType = "${requestScope.studyType}";
		var pathType = "${requestScope.pathType}";
		var loreTaskName = "${requestScope.loreTaskName}";
		var loreTypeName = "${requestScope.loreTypeName}";
		var access = "${requestScope.access}";
		var stepNumber = "${requestScope.stepNumber}";
		var option = "${requestScope.option}";
		var iNow = 0;
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
		var closeFlag = "${requestScope.closeFlag}";
		var basicLoreId = "${requestScope.basicLoreId}";
		var basicLoreName = "${requestScope.basicLoreName}";
		var buffetSendId = "${requestScope.buffetSendId}";
		var relateLoreIdStr = "${requestScope.relateLoreIdStr}";
		var cliHei = document.documentElement.clientHeight;
		var cliWid = document.documentElement.clientWidth;
		$(function(){
			$("#curr_lore_name").html(loreTaskName);
			$(".stepWrap").height(cliHei - $("#nowLoc").height());
			var tmpWid = cliWid - $(".midBlank").width() - 20;
			$(".stepFl").width(tmpWid/2);
			$(".stepFr").width(tmpWid/2);
			initBotHei();
		});
		document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
		//打开五步学习
		function goStepStudy(loreTypeName){
			var url = "&buffetStudyDetailId="+buffetStudyDetailId+"&buffetId="+buffetId+"&loreId="+basicLoreId+"&nextLoreIdArray="+nextLoreIdArray+"&studyLogId="+studyLogId;
			url += "&buffetName="+buffetName+"&studyType="+studyType+"&pathType="+pathType+"&loreTaskName="+loreTaskName;
			url += "&access="+access+"&loreTypeName="+loreTypeName;
			url += "&buffetSendId="+buffetSendId+"&basicLoreName="+basicLoreName+"&basicLoreId="+basicLoreId+"&relateLoreIdStr="+relateLoreIdStr;
			window.location.href = "buffetApp.do?action=goStepStudyPage"+url+"&cilentInfo=app";
		}
		function initBotHei(){
			$(".infoTxt").each(function(i){
				$(".infoTxt").eq(i).height($(".comDiv").eq(i).height() - $(".botStepNum").eq(i).height());
			});
		}
		//返回上一页
		function backPage(){
			var url = "&bsdId="+buffetStudyDetailId+"&relateLoreIdStr="+relateLoreIdStr+"&basicLoreId="+basicLoreId+"&basicLoreName="+encodeURIComponent(encodeURIComponent(basicLoreName))+"&buffetId="+buffetId+"&buffetName="+encodeURIComponent(encodeURIComponent(buffetName))+"&buffetSendId="+buffetSendId+"&closeFlag=mp";
			window.location.href = "buffetApp.do?action=showBuffetLoreDetailPage"+url+"&cilentInfo=app";
		}
	</script>
  </head>
  
  <body>
    <!-- 头部区域  -->
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage();"></span>
		<h2 id="curr_lore_name" class="ellip"></h2>
	</div>
	<div class="stepWrap">
		<div class="stepFl fl">
			<!-- 视频讲解  -->
			<div class="comDiv bgCol1">
				<p class="infoTxt pad1">一线老师精心制作，短小精悍、内容丰富。认真听讲、彻底掌握</p>
				<div class="botStepNum">
					<p class="modTit fl">视频讲解</p>
					<em class="numSpan fr">01</em>
				</div>
			</div>
			<!-- 点拨指导 -->
			<div class="comDiv bgCol2">
				<p class="infoTxt pad2">了解重点、难点、关键点、易混点</p>
				<div class="botStepNum">
					<p class="modTit fl">点拨指导</p>
					<em class="numSpan fr">02</em>
				</div>
			</div>
			<!-- 知识清单  -->
			<div class="comDiv bgCol3">
				<p class="infoTxt">背会定理、公理、概念、定义，抓牢基础是关键</p>
				<div class="botStepNum">
					<p class="modTit fl">知识清单</p>
					<em class="numSpan fr">03</em>
				</div>
			</div>
		</div>
		<div class="midBlank fl"></div>
		<div class="stepFr fr">
			<!-- 解题示范 -->
			<div class="comDiv bgCol4">
				<p class="infoTxt">跟着老师学习做题，掌握解题方法、学习解题思路，规范解题过程</p>
				<div class="botStepNum">
					<p class="modTit fl">解题示范</p>
					<em class="numSpan fr">04</em>
				</div>
			</div>
			<div class="bgCol5">
				<img class="goStudy" ontouchend="goStepStudy('video')" src="Module/appWeb/onlineStudy/images/goStudy.png" alt="开始学习"/>
			</div>
			<!-- 解题示范 -->
			<div class="comDiv bgCol6">
				<p class="infoTxt">通过习题巩固一下刚才通过视频讲解、点拨指导、知识清单、解题示范，学到的知识</p>
				<div class="botStepNum">
					<p class="modTit fl">巩固训练</p>
					<em class="numSpan fr">05</em>
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
