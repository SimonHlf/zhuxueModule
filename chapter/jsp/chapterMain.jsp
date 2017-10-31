<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>  
    <title>章节管理</title>
    <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
    <link href="Module/chapter/css/comSeleListCss.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/chapter/js/commonList.js"></script>
  	<script type="text/javascript">
		$(function load(){
			getSubjectList();
			showGradeList(null);
			//getBasicEditionList();
			getAllEditionList();
			showEducationList(null);
		});
		window.top.onscroll = function(){
			return false;
		};
		//根据条件查询章节信息
		function queryInfo(){
			var educationId = getId("educationId").value;
			if(educationId == "0"){
				alert("请选择教材!");
			}else{
				var mainWin = document.getElementById("chapterListFrame").contentWindow;
				mainWin.location.href = "chapterManager.do?action=queryChapter&educationId="+educationId;
			}
		}
	</script>
  </head>
  
  <body>
  	<div class="mainWrap">
  		<div class="top">
	  		 <div id="selectSubjectDiv" class="comNowSeleDiv comWiDiv Left"></div>
		     <div id="selectGradeDiv" class="comNowSeleDiv comWiDiv Left"></div>
		     <div id="selectEditionDiv" class="comNowSeleDiv comWiDiv Left1"></div>
		     <div id="selectEducationDiv" class="comNowSeleDiv comWiDiv Left"></div>
		     <span class="viewBtn" onclick="queryInfo()"><span class="searchIcon"></span>查询</span>
  		</div>
  		<div class="iframeWrap">
  			 <iframe id="chapterListFrame" name="chapterListFrame" allowTransparency="true" src="" width="100%" height="100%" frameBorder="0" scrolling="no"></iframe>
  		</div>
  	</div>
  </body>
</html>
