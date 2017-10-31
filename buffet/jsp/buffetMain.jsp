<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>知识点管理</title>
    <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
    <link href="Module/chapter/css/comSeleListCss.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/buffet/js/buffetCommon.js"></script>
	<script type="text/javascript" src="Module/buffet/js/commonList.js"></script>
	<script type="text/javascript">
		$(function load(){
			getSubjectList();
			showGradeList(null);
			getAllEditionList();
			showEducationList(null);
			showChapterList(null);
		});
		window.top.onscroll = function(){
			return false;
		};
		//查询知识点信息
		function queryInfo(){
			var chapterObj = getId("chapterId");
			var selectChapterIndex = chapterObj.selectedIndex;
			var chapterId = chapterObj.options[selectChapterIndex].value;
			var chapterName = encodeURIComponent(chapterObj.options[selectChapterIndex].text);
			
			var editionObj = getId("editionId");
			var selectIndex = editionObj.selectedIndex;
			var editionId = editionObj.options[selectIndex].value;
			var editionName = editionObj.options[selectIndex].text;
			var option = "";
			window.top.$(".rightPart").height(window.top.$(".leftPart").height());
			$(".iframeWrap").height(704);
			if(chapterId > 0){
			    var mainWin = document.getElementById("buffetListFrame").contentWindow;
				mainWin.location.href = "buffetManager.do?action=queryLore&chapterId="+chapterId+"&chapterName="+chapterName+"&editionId="+editionId+"&editionName="+encodeURIComponent(editionName);
			}else{
				alert("请选择章节!");
			}
			
		}
		function showSimpleTree(){
			var chapterId = getId("chapterId").value;
			var editionId = getId("editionId").value;
			
		}
	</script>  
  </head>
  
  <body>
  	<div class="mainWrap">
  		<div class="top">
	  		 <div id="selectSubjectDiv" class="fl comWiDiv_5"></div>
		     <div id="selectGradeDiv" class="fl comWiDiv_5"></div>
		     <div id="selectEditionDiv" class="fl comWiDiv_5 spec"></div>
		     <div id="selectEducationDiv" class="fl comWiDiv_5"></div>
		     <div id="selectChapterDiv" class="fl comWiDiv_5"></div>
		     <a class="viewBtn" onclick="queryInfo()"><span class="searchIcon"></span>查询</a>
  		</div>
  		<div class="iframeWrap">
  			 <iframe id="buffetListFrame" src="" allowTransparency="true" scrolling="no" width="100%" height="100%" frameBorder="0"></iframe>
  		</div>
  	</div>
  </body>
</html>
