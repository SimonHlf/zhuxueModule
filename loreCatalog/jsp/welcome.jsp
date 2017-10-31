<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
  <head>
    
    <title>welcome.jsp</title>
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/chapter/css/comSeleListCss.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/commonList.js"></script>
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
		//根据条件查询章节信息
		function queryInfo(){
			var chapterId = getId("chapterId").value;
			var editionObj = getId("editionId");
			var selectIndex = editionObj.selectedIndex;
			var editionName = editionObj.options[selectIndex].text;
			if(chapterId == "0"){
				alert("请选择章节!");
			}else{
				var mainWin = getId("loreCatalogListFrame").contentWindow;
				mainWin.location.href = "loreCatalogManager.do?action=queryLoreCatalog&chapterId="+chapterId+"&editionName="+encodeURIComponent(editionName);
			}
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
  			 <iframe id="loreCatalogListFrame" name="loreCatalogListFrame" src="" width="100%" height="100%" frameBorder="0" scrolling="no"></iframe>
  		</div>
  	</div>
  </body>
</html>
