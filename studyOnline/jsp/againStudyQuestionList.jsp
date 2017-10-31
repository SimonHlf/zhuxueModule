<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>questionList.jsp</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/questionListCss.css" type="text/css" rel="stylesheet" />
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript">
	var loreId = "${requestScope.loreId}";
	var studyLogId = "${requestScope.studyLogId}";
	var lastCommitNumber = 0;
	var questionLength = 0;
	var currentAllQuestionFlag = 1;
	var totalMoney = 0;
	var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
	var studyType = "${requestScope.studyType}";
	var pathType = "${requestScope.pathType}";
	var loreTaskName = "${requestScope.loreTaskName}";
	var loreTypeName = "";
	$(function(){
		loreTypeName = window.parent.loreTypeName;
		if(pathType == "study"){
			$("#studyInfo").attr("style","display:no-ne;");
			//显示6部学习法（视频讲解，点拨指导，知识清单，解题示范，巩固训练，再次诊断）
		}else{
			$("#diagnosisInfo").attr("style","display:no-ne;");
			initDiv();
			fnTabNav($('.tabNav'),$('.tabCon'),'click');
		}
	});
	function initDiv(){
		$.ajax({
			  type:"post",
			  async:false,
			  dataType:"json",
			  url:"studyOnline.do?action=loadQuestionList&loreId="+loreId+"&studyLogId="+studyLogId+"&nextLoreIdArray="+nextLoreIdArray+"&studyType="+studyType+"&loreTypeName="+encodeURIComponent(loreTypeName),
			  success:function (json){ 
				  showLoreQuestionList(json);
			  }
		});
	}
	</script>
</head>
<body>

</body>
</html>