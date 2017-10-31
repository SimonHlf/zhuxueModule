<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
<title>知识典--后台模块管理</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/myAsk.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/personalCen/js/personalJs.js"></script>
<script type="text/javascript">
$(function(){
	autoHeight('queListIframe');
	window.parent.getNetTeacherList();
	getNetTeacherStudent();
	//getClassList();
});
//显示问题列表
function showQuestionList(){
	   var subId = document.getElementById("subName").value;
	   var status = document.getElementById("status").value;
       if(subId=="0"&&status=="0"){
    	document.getElementById("queListIframe").src="questionManager.do?action=myQuestionList";
       }else{
	    document.getElementById("queListIframe").src="questionManager.do?action=getQuestionList&subId="+subId+"&status="+encodeURIComponent(status);
	    
   }
}

function listNTQuestion(){
	var studentId = document.getElementById("ntStu").value;
	var status = document.getElementById("status").value;
	if(studentId=="0"&&status=="0"){
		document.getElementById("queListIframe").src="questionManager.do?action=myQuestionList";
	}else{
		document.getElementById("queListIframe").src="questionManager.do?action=listQuestionByTSI&studentId="+studentId+"&status="+encodeURIComponent(status);
	}
}
//网络导师的学生列表
function getNetTeacherStudent(){
	var nID = "";
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=listBynID&nID="+nID,
		success:function(json){
			showStudentList(json);
		}
	});
}
function showStudentList(list){
	var f='<option value="0">请选择学生</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0;i<list.length;i++){
			options += "<option value='"+list[i].user.id+"'>"+list[i].user.realname+"</option>";
		}
	}
	$("#ntStu").html(f+options);
}



</script>
</head>

<body>
	<div class="nowPosition">
		<p><span>提</span>问列表</p>
	</div>
	<div class="myAskWrap">
		<div class="askHead">
			<div class="askIcon"></div>
			<c:if test="${sessionScope.roleName == '网络导师'}">
				<!-- 如果是老师  -->
				<p class="teacherTxt">您的学生共向您提问了<span class="totalAskNum"><c:out value="${requestScope.teaQCount}"/></span>个问题，
				其中有<span class="noAskNum"><c:out value="${requestScope.nQCount}"/></span>个未回答！</p>
			</c:if>
				<!-- 如果是学生  -->
				<c:if test="${sessionScope.roleName == '家长'}">
					<p class="studentTxt">以下是您的孩子在学习过程中向网络导师提的问题！</p>
				</c:if>
				<!-- 学生身份下的我要提问按钮  -->
				<c:if test="${sessionScope.roleName == '学生'}">
					<p class="studentTxt">如果在学习过程中遇到什么难题，就向老师提问吧！</p>
					<a class="askBtn" href="javascript:void(0)" onclick="showNoneBox('.myAskBox')">我要提问</a>
				</c:if>
			
		</div>
		<!-- 选择学科、回答状态 -->
		<div class="choiceSec clearfix">
			<c:if test="${sessionScope.roleName == '网络导师'}">
				<!-- 网络导师身份下的选择学生select下拉框  -->
				<div id="netTeacherSele" class="comDiv fl">
					<span class="choices">请选择学生：</span>
					<select id="ntStu"></select>
				</div>
			</c:if>
			
			<c:if test="${sessionScope.roleName == '学生' || sessionScope.roleName == '家长'}">
				<!-- 学生身份下的选择学科select下拉框  -->
				<div id="sutdentSele" class="comDiv fl">
					<span class="choices">请选择学科：</span>
					<select id="subName">
						<option value="0">全部</option>
						<c:forEach items="${requestScope.gVOList}" var="grade">
						<option value="${grade.subject.id}"><c:out value="${grade.subject.subName}"/></option>
						</c:forEach>
					</select>
				</div>
			</c:if>
			
			<div class="comDiv fl">
				<span class="choices1">回答状态：</span>
				<select id="status">
					<option value="0">状态</option>
					<option value="1">回答</option>
					<option value="2">未回答</option>
				</select>
			</div>
			<c:if test="${sessionScope.roleName=='学生' || sessionScope.roleName == '家长'}">
				<input class="lookBtn fl" type="button" id="lookBtn" value="查看" onclick="showQuestionList()"/>
			</c:if>
			<c:if test="${sessionScope.roleName=='网络导师'}">
				<input class="lookBtn fl" type="button" id="lookBtn" value="查看" onclick="listNTQuestion()"/>
			</c:if>
		</div>
		<!-- 问题列表中心 -->
		<div class="queCen">
			<ul class="queCenH">
				<li>提问标题</li>
				<li>提问时间</li>
				<li>回答状态</li>
			</ul>
		</div>
		<!-- 问题列表所对应的iframe  -->
		<div class="queCenMid" id="questionListDiv">
			<iframe id="queListIframe" src="questionManager.do?action=myQuestionList" width="100%" height="100%" name="queListIframe" scrolling="no" frameborder="0"></iframe>
		</div>
	</div>
</body>
</html>
