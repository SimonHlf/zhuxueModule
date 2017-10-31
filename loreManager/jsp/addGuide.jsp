<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>addDetail.jsp</title>
    <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
    <link href="Module/loreManager/css/addGuideCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/addGuideJs.js"></script>
	<script type="text/javascript">
		$(function(){
			initUeditor("myEditor_zt");
			initUeditor("myEditor_zd");
			initUeditor("myEditor_nd");
			initUeditor("myEditor_gjd");
			initUeditor("myEditor_yhd");
			initContent_zt_Ueditor();
			fnTabNav($('.tabNav'),$('.tabCon'),'click');
			backTop("guidewrap","backtop");
			moveQueryBox("moveWrap","top");
	    });
		var loreId = ${requestScope.loreId};
		var content_zt_dataBase = '${requestScope.content_zt}';
		var existFlag = "${requestScope.existFlag}";
		var i = 2;

		//文本编辑器		
		function initUeditor(id){
			UE.getEditor(id,{
				initialFrameWidth : 750,
				initialFrameHeight : 240,
				wordCount:true,
				textarea : 'description'
			});
		}
		//初始化主题文本内容(从数据库中获取)
		function initContent_zt_Ueditor(){
			UE.getEditor("myEditor_zt").addListener("ready", function () {
		        // editor准备好之后才可以使用
		        UE.getEditor("myEditor_zt").setContent(content_zt_dataBase,null);
			});
		}
	</script>
  </head>
  
  <body>
  	<div id="guidewrap" class="guideWrap">
	  	<!-- 选项卡式  -->
	  	<div class="comParentWrap">
	  		<ul class="tabNav">
	  			<li class="active">主题</li>
	  			<li>重点</li>
	  			<li>难点</li>
	  			<li>关键点</li>
	  			<li>易混点</li>
	  		</ul>
	  		<!-- 主题  -->
	  		<div id="zhuti" class="tabCon" style="display:block">
		  		<div class="guideTop">
		  			<span class="headTitle">标题：</span><input type="text" class="comInput" id="loreListTitle_zt" value="${requestScope.loreName}"/>
		  		</div>
			  	<div id="ztDiv">
			  		<div class="contents">主题</div>
			  		<div id="myEditor_zt"></div>
			  		<div class="introInfo">
			  			<span class="warnIcon"></span>
			  			<p>如果不区分重点、难点、关键点、易混点，就把内容直接写入主题里面，重点、难点、关键点、易混点内容留空</p>
			  		</div>
		  		</div>
	  		</div>
	  		<!-- 重点  -->
	  		<div id="zdDiv" class="tabCon" style="display:none">
			   	<div id="myEditor_zd" class="userDefined">
			   		<div class="guideTop">
				  	 	<span class="headTitle">标题:</span><input type="text" class="comInput" id="loreListTitle_zd"/>
				   	</div>
				   	<div class="contents">
				   		内容
				   	</div>
			   	</div>
			   	<span class="newAddBtn1" onclick="createEditor('zd','zdDiv');">添加新重点</span>
	 	  	</div>
	   		<!-- 难点  -->
	   		<div id="ndDiv" class="tabCon" style="display:none;">
			   	<div id="myEditor_nd" class="userDefined">
			   		<div class="guideTop">
			   			<span class="headTitle">标题:</span><input type="text" class="comInput" id="loreListTitle_nd"/>
			   		</div>
			   		<div class="contents">
			   			内容
			   			<!--  input type="button" id="addNewNd" class="comCls addNewBtn" value="添加新难点" onclick="createEditor('nd','ndDiv');"/-->
			   		</div>
			   	</div>
			   	<span class="newAddBtn1" onclick="createEditor('nd','ndDiv');">添加新难点</span>
	 	  	</div>
	 	  	<!-- 关键点  -->
	 	  	<div id="gjdDiv" class="tabCon" style="display:none;">
			   	<div id="myEditor_gjd" class="userDefined">
			   		<div class="guideTop">	
			   			<span class="headTitle">标题:</span><input type="text" class="comInput" id="loreListTitle_gjd"/>
			   		</div>
			   		<div class="contents">
			   			内容
			   			<!--  input type="button" value="添加新关键点" id="addNewGjd" class="comCls addNewBtn" onclick="createEditor('gjd','gjdDiv');"-->
			   		</div>
			   	</div>
			   	<span class="newAddBtn1" onclick="createEditor('gjd','gjdDiv');">添加新关键点</span>
	   		</div>
	   		<!-- 易混点  -->
	   		<div id="yhdDiv" class="tabCon" style="display:none;">
			   	<div id="myEditor_yhd" class="userDefined">
			   		<div class="guideTop">	
			   			<span class="headTitle">标题:</span><input type="text" class="comInput" id="loreListTitle_yhd"/>
			   		</div>
			   		<div class="contents">
			   			内容
			   			<!--  input type="button" value="添加新易混点" id="addNewYhd" class="comCls addNewBtn" onclick="createEditor('yhd','yhdDiv');"/-->
			   		</div>
		   		</div>
		   		<span class="newAddBtn1" onclick="createEditor('yhd','yhdDiv');">添加新易混点</span>
	   		</div>
	  	</div>
	  	
	  	<!-- 提交按钮  -->
	   	<html:form action="loreManager.do">
	   		<input type="hidden" id="action" name="action" value="addGuideList" />
	   		<input type="hidden" id="loreId" name="loreId"/>
	   		<input type="hidden" id="loreName" name="loreName" value="${requestScope.loreName}"/>
	   		<input type="hidden" id="content_zt" name="content_zt"/>
	   		<input type="hidden" id="title_zd" name="title_zd"/>
	   		<input type="hidden" id="content_zd" name="content_zd"/>
	   		<input type="hidden" id="title_nd" name="title_nd"/>
	   		<input type="hidden" id="content_nd" name="content_nd"/>
	   		<input type="hidden" id="title_gjd" name="title_gjd"/>
	   		<input type="hidden" id="content_gjd" name="content_gjd"/>
	   		<input type="hidden" id="title_yhd" name="title_yhd"/>
	   		<input type="hidden" id="content_yhd" name="content_yhd"/>
	   		<div class="tijiao">
	   			<input type="submit" class="sub_btn" value="提交" onclick="return check()"/>
	   		</div>
	   	</html:form>
	   	
	   <!-- 返回顶部  -->
	   <a id="backtop" class="backTop" onclick="backTop()"></a>
   	</div>
  </body>
</html>
