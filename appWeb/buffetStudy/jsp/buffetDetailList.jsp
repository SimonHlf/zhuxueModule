<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>助学网--巴菲特查看溯源</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link href="Module/appWeb/buffetStudy/css/buffetDetailList.css" type="text/css" rel="stylesheet"/>
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/buffetStudy/js/buffetDetailListJs.js"></script>
	<script type="text/javascript">
		var buffetSendId = "${requestScope.buffetSendId}";
		var buffetStudyDetailId = "${requestScope.bsdId}";
		var buffetLoreStudyLogId = "${requestScope.studyLogId}";
		var buffetId = "${requestScope.buffetId}";
		var buffetName = "${requestScope.buffetName}";
		var task = "${requestScope.task}";
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
		var studyLogId = "${requestScope.studyLogId}";
		var loreTaskName = "${requestScope.loreTaskName}";
		var pathType = "${requestScope.pathType}";
		var access = "${requestScope.access}";
		var basicLoreId = "${requestScope.basicLoreId}";
		var basicLoreName = "${requestScope.basicLoreName}";
		var loreTypeName = "${requestScope.loreTypeName}";
		var path = "${requestScope.path}";
		var closeFlag = "${requestScope.closeFlag}";
		var relateLoreIdStr = "${requestScope.relateLoreIdStr}";
		
		var stime = "${sessionScope.stime}";
		var etime = "${sessionScope.etime}";
		var subId = "${sessionScope.subId}";
		var result = "${sessionScope.result}";
		$(function(){
			$(".goldenBox").height($(".goldenWrap").height());
			$(".goldenWrap").css({"left":($(".goldenBox").width() - $(".goldenWrap").width())/2});
		});
		//optionType:操作类型（学习，溯源）
		//pathType:学习路径类型
		//loreTaskName:当前任务
		//access:该阶段完成状况
		function goChallenge(buffetId,basicLoreId,nextLoreIdArray,studyLogId,optionType,tracebackType,studyType,pathType,loreTaskName,access){
			if(optionType == "study"){
				var url = "&buffetStudyDetailId="+buffetStudyDetailId+"&buffetId="+buffetId+"&loreId="+basicLoreId+"&nextLoreIdArray="+nextLoreIdArray+"&studyLogId="+studyLogId+"&task="+task;
				url += "&buffetName="+buffetName+"&studyType="+studyType+"&pathType="+pathType+"&loreTaskName="+loreTaskName;
				url += "&access="+access+"&loreTypeName="+loreTypeName;
				url += "&buffetSendId="+buffetSendId+"&basicLoreName="+basicLoreName+"&basicLoreId="+basicLoreId+"&relateLoreIdStr="+relateLoreIdStr;
				window.location.href = "buffetApp.do?action=showBuffetLoreQuestionPage"+url+"&closeFlag=tp&cilentInfo=app";
			}else if(optionType == "traceback"){
				var url = "&bsdId="+buffetStudyDetailId+"&buffetId="+buffetId+"&basicLoreId="+basicLoreId+"&nextLoreIdArray="+nextLoreIdArray;
				url += "&tracebackType="+tracebackType+"&buffetName="+buffetName+"&studyLogId="+studyLogId+"&studyType="+studyType+"&closeFlag=tp";
				url += "&buffetSendId="+buffetSendId+"&basicLoreName="+basicLoreName+"&relateLoreIdStr="+relateLoreIdStr;
				window.location.href = "buffetApp.do?action=showBuffetTracebackPage"+url+"&cilentInfo=app";
			}	
		}
		//返回上一页
		function backPage(){
			var url = "&buffetSendId="+buffetSendId+"&loreName="+basicLoreName+"&closeFlag="+closeFlag;
			url += "&stime="+stime+"&etime="+etime+"&subId="+subId+"&result="+result;
			window.location.href = "buffetApp.do?action=showBuffetQuestionPage"+url+"&cilentInfo=app";
		}
	</script>	
  </head>
  
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage()"></span>
		<p class="bigTit ellip">${requestScope.buffetName}</p>
		<p class="smallTit">兴趣激发--检测你对该知识点的掌握情况</p>
	</div>
	<div class="buffetDetailDiv">
		<h2 class="nowTask"><span class="taskNum fl">任务${requestScope.task}</span><span class="taskTxt fl">${requestScope.loreTaskName}</span></h2>
		<div class="goldenBox">
			<div class="goldenWrap">
				<div class="goldNum fl">${requestScope.money}<span class="rewordPic">奖励</span></div>
				<div class="goldenPic fl"></div>
			</div>
		</div>
		<a class="backKnBtn" href="javascript:void(0)">
			<span class="tracTit">溯源路线图:</span>共<i>${requestScope.stepCount}</i>级<i>${requestScope.loreCount}</i>个知识点
			<em class="checkBtn" ontouchend="goChallenge('${requestScope.buffetId}','${requestScope.basicLoreId}','${requestScope.nextLoreIdArray}','${requestScope.studyLogId}','traceback','review','2','${requestScope.pathType}','${requestScope.loreTaskName}','${requestScope.access}')">查看&gt;&gt;</em>
		</a>
		<div class="taskDescri">
			<p>您对<span class="loreName">${requestScope.buffetName}</span>这道题掌握的不太好，系统将指引您进行溯源学习,找出没有掌握的根源！</p>
		</div>
		<div class="btnDiv">
			<a id="doBtn" href="javascript:void(0)" ontouchend="goChallenge('${requestScope.buffetId}','${requestScope.basicLoreId}','${requestScope.nextLoreIdArray}','${requestScope.studyLogId}','study','review','2','${requestScope.pathType}','${requestScope.loreTaskName}','${requestScope.access}')">${requestScope.buttonValue}</a>
		</div>
	</div>
</body>
</html>
