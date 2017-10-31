<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>知识典在线答题课程章节列表</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/chapterPage.css" type="text/css" rel="stylesheet" />
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/studyOnline/js/studyOnlineJs.js"></script>
	<script type="text/javascript">
		function showLoreQuestion(loreId,loreName,educationId,isFinish){
			//先判断该知识点当天完成几次（一个知识点一天只能完成一次）
			var loreName_new =  encodeURIComponent(encodeURIComponent(loreName));
			var url = "studyOnline.do?action=showLoreQuestionList&loreId="+loreId+"&loreName="+loreName_new+"&educationId="+educationId+"&isFinish="+isFinish;
			if(isFinish == 2){
				if(checkCurrentLore(loreId)){
					alert("您今天已经成功的完成一次了，请明天再来吧!");
				}else{
					window.top.location.href = url;
				}
			}else{
				window.top.location.href = url;
			} 
		}
		//判断当前知识点每天只能完成一次
		function checkCurrentLore(loreId){
			var flag = false;
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"studyOnline.do?action=checkCurrentLore&loreId="+loreId,
		        success:function (json){
		        	flag = json;
		        }
		    });
			return flag;
		}
	</script>
  </head>
  
  <body>
    <div class="chapterList">
		<div class="listHead"></div>
		<div class="listCon">
			<div class="chapterTitle">	
				<p class="Title">${requestScope.chapterName}</p>
			</div>
			<ul class="clearfix">
				<c:forEach items="${requestScope.result}" var="lore">
				<c:if test="${lore.answerFlag == 0}">
					<li id="<c:out value="${lore.id}"/>" class="status1" title="<c:out value="${lore.loreName}"/>">
						<a href="javascript:void(0)" onclick="showLoreQuestion(${lore.id},'${lore.loreName}','${requestScope.educationId}',0)"><c:out value="${lore.loreName}"/></a>
					</li>
				</c:if>
				<c:if test="${lore.answerFlag == 1}">
					<li id="<c:out value="${lore.id}"/>" class="status3">
						<a href="javascript:void(0)" onclick="showLoreQuestion(${lore.id},'${lore.loreName}','${requestScope.educationId}',1)"><c:out value="${lore.loreName}"/></a>
					</li>
				</c:if>
				<c:if test="${lore.answerFlag == 2}">
					<li id="<c:out value="${lore.id}"/>" class="status2">
						<a href="javascript:void(0)" onclick="showLoreQuestion(${lore.id},'${lore.loreName}','${requestScope.educationId}',2)"><c:out value="${lore.loreName}"/></a>
					</li>
				</c:if>	
						
				</c:forEach>
			</ul>			
		</div>
		<div class="decPic"></div>
	</div>
  </body>
</html>
