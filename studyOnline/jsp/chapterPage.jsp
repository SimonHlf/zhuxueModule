<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>助学网--学科单元章节列表</title>

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
		$(function(){
			fnTab($('.tabNav'),'click');
			testLeftHeight();
			$("#infoText").html("当前教材："+"<span class='nowPub'>"+"${requestScope.infoText}"+"</span>");
			var chapterLiObj = $("#chapterM").find("ul li:first-child");
			$("#chapterM").find("ul li:first-child").addClass("active");
			chapterId = $("#chapterM").find("ul li:first-child").attr("id");
			if(chapterId == undefined){
				
			}else{
				showLore(chapterId,"${requestScope.educationId}");
			}
		});
		function showLore(chapterId,educationId){
			var mainWin = document.getElementById("chapterList").contentWindow;
			mainWin.location.href = "studyOnline.do?action=getLoreListByChapterId&chapterId="+chapterId+"&educationId="+educationId;
		}
		//左侧单元列表高度的检测来判断是否执行自定义滚动条
		function testLeftHeight(){
			if($(".tabNav").height() > $(".chapterM").height()){
				scrollBar("chapterM","tabNavBox","boxScroll","scrollBar",10);
			}else{
				$(".scrollBox").hide();
			}
		}
	</script>
  </head>
  
  <body>
    <div class="chapterWrap">	
		<div class="chapterParent">
			<div class="chapterHead">
				<p id="infoText"></p>
			</div>
			<div class="chapterCon clearfix">
				<!-- 左侧单元导航  -->
				<div class="chapterConL">
					<div class="dec top1"></div>
					<div class="dec top2"></div>
					<!-- 章节 -->
					<div class="chapterM" id="chapterM">
						<ul id="tabNavBox" class="tabNav">
							<c:forEach items="${requestScope.cList}" var="chapter">
								<li id="<c:out value="${chapter.id}"/>">
									<a href="javascript:void(0)" onclick="showLore(${chapter.id},${requestScope.educationId})" title="<c:out value="${chapter.chapterName}"/>"><c:out value="${chapter.chapterName}"/></a>
								</li>
							</c:forEach>
						</ul>
						<div id="boxScroll" class="scrollBox">
  							<div id="scrollBar" class="scrollBar"></div>
						</div>
					</div>
					<div class="dec top3"></div>
					<div class="dec top4"></div>
				</div>
				<!-- 右侧对应章节知识点  -->
				<div class="chapterConR">
					<iframe id="chapterList" name="chapterList" width="100%" height="100%" src="" scrolling="no" frameborder="0"></iframe>
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
