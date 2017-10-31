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
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/commonList.js"></script>
	<script type="text/javascript">
		$(function load(){
			getSubjectList();
			showGradeList(null);
			getAllEditionList();
			showEducationList(null);
			showChapterList(null);
			textFocusCheck(getId("loreName_query"),"请输入您要搜索的知识点");
			moveQueryBox("moveWrap","");
		});
		
		//查询知识点信息
		function queryInfo(){
			var chapterId = getId("chapterId").value;
			var editionObj = getId("editionId");
			var selectIndex = editionObj.selectedIndex;
			var editionName = editionObj.options[selectIndex].text;
			var option = "";
			window.top.$(".rightPart").height(window.top.$(".leftPart").height());
			$(".iframeWrap").height(669);
			//if(editionName == "通用版"){
				option = "basic";
			//}
			if(chapterId > 0){
			    var mainWin = document.getElementById("loreListFrame").contentWindow;
				mainWin.location.href = "loreManager.do?action=queryLore&chapterId="+chapterId+"&option="+option+"&editionName="+encodeURIComponent(editionName);
			}else{
				alert("请选择章节!");
			}
			
		}
		//根据知识点名称查询知识点信息
		function queryInfoByName(){
			var loreName = getId("loreName_query").value;
			if(loreName == "请输入您要搜索的知识点"){
				alert("请输入知识点名称");
				getId("loreName_query").focus();
			}else{
				if(loreName.length >= 2){
		  			window.top.$(".rightPart").height(window.top.$(".leftPart").height());
		  			$(".iframeWrap").height(667);
					var mainWin = document.getElementById("loreListFrame").contentWindow;
					mainWin.location.href = "loreManager.do?action=queryLoreByName&loreName="+encodeURIComponent(loreName);
				}else{
					alert("为了不影响查询速度，请至少输入两个或以上的关键字!");
					getId("loreName_query").focus();
				}
			}
		}
		//回车事件
	  	function enterPress(e){
	 		var e = e || window.event;
	  		if(e.keyCode == 13){
	  			queryInfoByName();
	  		}
	  	}
		function showSimpleTree(){
			var chapterId = getId("chapterId").value;
			var editionId = getId("editionId").value;
			
		}
		//查询知识点盒子的打开和关闭
		function showQueryBox(){
			$(".queryInfoWrap").show(300);
		}
		function closeQueryWin(){
			$(".queryInfoWrap").hide(300);
		}
	</script>  
  </head>
  
  <body>
  	<div class="mainWrap">
  		<div id="moveWrap" class="moveQueryWrap">
	  		<div class="queryInfoWrap">
	  			<input type="text" id="loreName_query" value="请输入您要搜索的知识点" onkeypress="enterPress(event)"/>
	  			<input type="button" value="查询" class="queryBtn" onclick="queryInfoByName()"/>
	  			<span class="triangle"></span>
	  			<span class="closeQuery" onclick="closeQueryWin()"></span>
	  		</div>
	  		<a href="javascript:void(0)" class="queryBtnIcon" onclick="showQueryBox()"></a>
  		</div>
  		<div class="top">
	  		 <div id="selectSubjectDiv" class="fl comWiDiv_5"></div>
		     <div id="selectGradeDiv" class="fl comWiDiv_5"></div>
		     <div id="selectEditionDiv" class="fl comWiDiv_5 spec"></div>
		     <div id="selectEducationDiv" class="fl comWiDiv_5"></div>
		     <div id="selectChapterDiv" class="fl comWiDiv_5"></div>
		     <a class="viewBtn" onclick="queryInfo()"><span class="searchIcon"></span>查询</a>
  		</div>
  		<div class="iframeWrap">
  			 <iframe id="loreListFrame" src="" allowTransparency="true" scrolling="no" width="100%" height="100%" frameBorder="0"></iframe>
  		</div>
  	</div>
  </body>
</html>
