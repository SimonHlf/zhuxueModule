<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>知识典在线答题系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/studyOnline.css" type="text/css" rel="stylesheet" />
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/studyOnline/js/studyOnlineJs.js"></script>
	<script type="text/javascript">
	var gradeId_current = "${requestScope.gradeId_current}";
	var subId_current = "${requestScope.subId}";
	var classId = "${requestScope.classId}";
	var editionId = "${requestScope.editionId_old}";
	$(function(){
		getAllEditionList();
		getId("editionId").value = editionId;
		var educationName = $("#editionId").find("option:selected").text();
		if(editionId == 0){
			educationName = "";
		}
		$("#educationInfo").html("目前教材版本："+"<span class='nowPub'>"+ educationName +"</span>");
	});
	//获取教材版本列表
	function getAllEditionList(){
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        url:"commonManager.do?action=getEditionList",
	        success:function (json){
	        	showEditionList(json);
	        }
	    });
	}
	//显示教材版本列表
	function showEditionList(list){
		var t='<span>选择出版社&nbsp;</span><select id="editionId" onchange="getEducationList(this);">';
		var f='<option value="0">请选择出版社</option>';
		var options = '';
		if(list==null){
			
		}else{
			for(i=0; i<list.length; i++){
			  if(list[i].ediName == "通用版"){
				  continue;
			  }
			  options +=  "<option value='"+list[i].id+"'>"+list[i].ediName+"</option>";
			}
		}
		var h='</select>';
		$('#selectEditionDiv').html(t+f+options+h);
	}
	function getEducationList(obj){
		var editionId = obj.value;
		window.location.href = "studyOnline.do?action=queryEducationList&editionId="+editionId+"&gradeId="+gradeId_current+"&subId="+subId_current+"&classId="+classId;
	}
	//绑定导师
	function goBind(){
		window.top.location.href="netTeacher.do?action=netTeacherList&subId="+subId_current;
	}
	</script>
  </head>
  
  <body style="height:500px;">
    <div class="choiceCourse">
		<div class="parentWrap" style="height:500px;">
			<div class="choiceHead">
				<!-- 请选择您要学习的教材,目前教材版本  -->
				<p id="educationInfo"></p>
				<!-- 选择其他出版社进行学习  -->
				<div id="selectEditionDiv" class="choicePubBox"></div>
			</div>
			<div class="choiceCon">
				<ul>
					<c:forEach items="${requestScope.eList}" var="education">
						<li>
							<div class="bookCover">
									<img src="<c:out value='${education.imgUrl}'/>" width="196" height="179" />
								<p class="bookName">
									<c:out value='${education.grade.gradeName}'/><c:out value='${education.subject.subName}'/>(<c:out value='${education.volume}'/>)
								</p>
							</div>
							<!-- 网络导师父级 -->
							<div class="daoshiWrap">
								<c:forEach items="${requestScope.ntsList}" var="nts">
								  <c:if test="${nts!=null}">
									<div class="teaPic">
										<img src="<c:out value='${nts.teacher.user.portrait}'/>" width="120" height="120" />
										<div class="teaNamesLayer"></div>
										<p class="nameTeacher"><c:out value='${nts.teacher.user.nickname}'/></p>
									</div> 
									<!-- 向老师提问 -->
									<div class="askTea">
										<a href="javascript:void(0)" onclick="showAskWin('${education.grade.gradeName}','${nts.teacher.subject.id}','${nts.teacher.subject.subName}(${education.volume})','${nts.teacher.id}')">我要提问</a>
									</div>
								  </c:if>
								  <c:if test="${nts==null}">
								    <div class="teaPic">
								    	<img class="timerOverImg" src="Module/studyOnline/images/netTimeOver.png"/>
								        <p class="noNetTea left_1">导师已到期</p>
								    </div>
								     <a href="javascript:void(0)" class="goAttachBtn" onclick="goBind()">重新申请</a>
								  </c:if>
								</c:forEach>
								<c:if test="${requestScope.netTeacher == 'no'}">
									<div class="teaPic">
										<span class="tmpNoTeaDec">?</span>
										<p class="noNetTea left_2">暂无导师</p>
									</div>
									<a href="javascript:void(0)" class="goAttachBtn" onclick="goBind()">绑定导师</a>
								</c:if>
							</div>
							<!-- 购买年限 -->
							<div class="introInfo">
								<p class="nianxian">购买年限：免费试用</p>
								<p class="nianxian">已使用：<span class="dayTime">${requestScope.usedDays}</span>&nbsp;天 还剩：<span class="dayTime">${requestScope.remainDays}</span>&nbsp;天</p>
								<p class="nianxian">使用期限:<span id="useDate">${requestScope.signDate}至${requestScope.endDate}</span></p>
							</div>
							<!-- 去购买去学习 -->
							<a class="goLearning" onclick="goLearning(${education.id})" href="javascript:void(0)"></a>
						</li>
					</c:forEach>
				</ul>
			</div>
			
			<!-- 科目尚未添加下提示信息的盒子  -->
			<c:if test="${requestScope.noExists == 'noExists'}">
				<div class="noExit">
					<div class="exitPic">
						<img src="Module/studyOnline/images/noAddSubjectBg.png" alt="该科目尚未添加，请联系该科目任课老师">
					</div>
					<div class="infoBox"><p class="infos">该科目尚未添加，请联系该科目任课老师...</p></div>
					<p class="infos marg col">也可通过选择出版社选择该科目其他版本进行临时学习...</p>
				</div>
			</c:if>
		</div>
	</div>
  </body>
</html>
