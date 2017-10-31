<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>addDetail.jsp</title>
    <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
    <link href="Module/loreManager/css/newLoreDetailCss.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript">
		$(function(){
			addList();
			fnTab($(".tabNav"),'click');
	    });
		var loreId = ${requestScope.loreId};
		var loreName = encodeURIComponent("${requestScope.loreName}");
		//知识清单
		function addList(){
			var mainWin = document.getElementById("detailFrame").contentWindow;
			mainWin.location.href = "loreManager.do?action=showList&loreId="+loreId+"&loreName="+loreName;
			changeHeightReset();
		}
		function addGuide(){
			var mainWin = document.getElementById("detailFrame").contentWindow;
			mainWin.location.href = "loreManager.do?action=showGuide&loreId="+loreId+"&loreName="+loreName;
			changeHeightReset();
		}
		function addExample(){
			var mainWin = document.getElementById("detailFrame").contentWindow;
			mainWin.location.href = "loreManager.do?action=showExample&loreId="+loreId+"&loreName="+loreName;
			changeHeight();
		}
		function addPractice(loreType){
			var mainWin = document.getElementById("detailFrame").contentWindow;
			mainWin.location.href = "loreManager.do?action=showPractice&loreId="+loreId+"&loreName="+loreName+"&loreType="+encodeURIComponent(loreType);
			changeHeightPractice();
		}
		function addExplain(){
			var mainWin = document.getElementById("detailFrame").contentWindow;
			var loreType = encodeURIComponent("知识讲解");
			mainWin.location.href = "loreManager.do?action=showExplain&loreId="+loreId+"&loreName="+loreName+"&loreType="+loreType;
			changeHeightReset();
		}
	</script>
  </head>
  
  <body>
  	<div class="loreDetailWrap clearfix">
  		<div class="leftNav fl">
  			<ul class="tabNav">
  				<li class="active" onclick="addList()">知识清单</li>
  				<li onclick="addGuide()">点拨指导</li>
  				<li onclick="addExample()">解题示范</li>
  				<li onclick="addPractice('巩固训练')">巩固训练</li>
  				<li onclick="addPractice('针对性诊断')">针对性诊断</li>
  				<li onclick="addPractice('再次诊断')">再次诊断</li>
  				<li onclick="addExplain()">知识讲解</li>
  			</ul>
  		</div>
  		<div class="rightCon fl">
  		 	<iframe id="detailFrame" width="100%" height="100%" src="" frameborder="0" scrolling="no"></iframe>
  		</div>
  	</div>
  </body>
</html>
