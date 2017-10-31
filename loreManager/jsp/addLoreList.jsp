<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>addDetail.jsp</title>
    <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
    <link href="Module/loreManager/css/addLoreListCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/addLoreListJs.js"></script>
	<script type="text/javascript">
		$(function(){
			initUeditor("myEditor1");
			backTop("addlistWrap","backtop");
			moveQueryBox("moveWrap","top");
	    });
		var loreId = ${requestScope.loreId};
		var loreName = "${requestScope.loreName}";
		var i = 2;
	
		//文本编辑器		
		function initUeditor(id){
			UE.getEditor(id,{
				initialFrameWidth : 748,
				initialFrameHeight : 240,
				wordCount:true,
				textarea : 'description'
			});
		}

	</script>
  </head>
  
  <body>
  	<div id="addlistWrap" class="addListWrap">
  		<div class="comParentWrap">
	  		<div class="listTop">
	  			<span class="addNewBtn" onclick="createEditor()">新增一个清单</span>
	  		</div>
	  		<div id="listConWrap" class="listCon">
	  			<div id="ueditor" class="ueditorWrap">
			  		<input type="hidden" id="loreListTitle" size="30" value="${requestScope.loreTitle}" disabled/>
				  	<div id="myEditor_div1">
					   	<div id="myEditor1" class="userDefined">
					   		<span class="headTitle">标题:</span><input type="text" class="comInput" id="subTitle" value="${requestScope.loreName}"/>
					   		<div class="contents">内容</div>
					   	</div>
				   	</div> 
		 	  	</div>
  			</div>
  		</div>
	   	<html:form action="loreManager.do">
	   		<input type="hidden" id="action" name="action" value="addLoreList" />
	   		<input type="hidden" id="loreId" name="loreId" value="${requestScope.loreId}"/>
	   		<input type="hidden" id="loreName" name="loreName" value="${requestScope.loreName}"/>
	   		<input type="hidden" id="content" name="content"/>
	   		<div class="tijiao">
	   			<input type="submit" class="sub_btn" value="提交" onclick="return check()"/>
	   		</div>
	   	</html:form>
	   	<!-- 新增清单fixed  -->
	   	<span id="newAddList" class="newAddBtn" onclick="createEditor()">新增一个清单</span>
	    <!-- 返回顶部  -->
	    <a id="backtop" class="backTop" onclick="backTop()"></a>
  	</div>
  </body>
</html>
