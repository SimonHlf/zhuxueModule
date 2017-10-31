<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>addExample.jsp</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/addExampleCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript">
		$(function(){
			editTextBox();
			initInputTitle(loreTitle);
		});
		window.top.onscroll = function(){
			moveQueryBox("moveWrap","top");
		};	
		var loreId = ${requestScope.loreId};
		var loreTitle = "${requestScope.loreType}" + "第" + ${requestScope.loreNum} + "题";
		var editor_question;
		var editor_answer;
		var editor_analysis;
		//初始化标题内容
		function initInputTitle(value){
			getId("questionTitle").value = value;
		}
		//文本编辑器		
		function editTextBox(){
			editor_question = new baidu.editor.ui.Editor( {
				initialFrameWidth : 750,
				initialFrameHeight : 240,
				wordCount:true,
				textarea : 'description'
			});
			editor_answer = new baidu.editor.ui.Editor( {
				initialFrameWidth : 750,
				initialFrameHeight : 240,
				wordCount:true,
				textarea : 'description'
			});
			editor_analysis = new baidu.editor.ui.Editor( {
				initialFrameWidth : 750,
				initialFrameHeight : 240,
				wordCount:true,
				textarea : 'description'
			});
			editor_question.render("myEditor_question");
			editor_answer.render("myEditor_answer");
			editor_analysis.render("myEditor_analysis");
		}
		//提交清单
		function check(){
			getId("loreId").value = loreId;
			getId("subTitle").value = getId("questionTitle").value;
			getId("loreName").value = "${requestScope.loreName }";
			getId("content_question").value = editor_question.getContent();
			getId("content_answer").value = editor_answer.getContent();
			getId("content_analysis").value = editor_analysis.getContent();
			//执行插入动作
			if(getId("content_question").value == ""){
				alert("题干不能为空!");
				UE.getEditor("myEditor_question").focus();
				return false;
			}else if(getId("content_answer").value == ""){
				alert("答案不能为空!");
				UE.getEditor("myEditor_answer").focus();
				return false;
			}else if(getId("content_analysis").value == ""){
				alert("解析不能为空!");
				UE.getEditor("myEditor_analysis").focus();
				return false;
			}else{
				return true;
			}
		}
	</script>
  </head>
  
  <body>
  	<div class="addExampleWrap">
  		<div class="comParentWrap">
  			<!-- 题干盒子  -->
		  	<div id="questionDiv">
		  		<h2 class="headTitle">知识典:${requestScope.loreName }</h2>
			   	<div class="title">
			   		<span>标题:</span>
			   		<input type="text" class="comInput col" id="questionTitle"  disabled/>
			   	</div>
			   	<div class="contents">
			   		题干
			   	</div>
			   	<div id="myEditor_question"></div>
		   	</div>
		   	<!-- 答案盒子  -->
		   	<div id="answerDiv">
		   		<div class="contents">
		   			答案
		   		</div>
			   	<div id="myEditor_answer"></div>
		   	</div>
		   	<!-- 解析盒子  -->
		   	<div id="analysisDiv">
		   		<div class="contents">
			  		解析
			  	</div>
			   	<div id="myEditor_analysis"></div>
		   	</div>
	   	</div>
	   	<html:form action="loreManager.do">
	   		<input type="hidden" id="action" name="action" value="addExampleList" />
	   		<input type="hidden" id="loreId" name="loreId"/>
	   		<input type="hidden" id="loreName" name="loreName"/>
	   		<input type="hidden" id="loreType" name="loreType" value="${requestScope.loreType}"/>
	   		<input type="hidden" id="subTitle" name="subTitle"/>
	   		<input type="hidden" id="content_question" name="content_question"/>
	   		<input type="hidden" id="content_answer" name="content_answer"/>
	   		<input type="hidden" id="content_analysis" name="content_analysis"/>
	   		<div class="tijiao">
	   			<input type="submit" class="sub_btn" value="提交" onclick="return check()"/>
	   		</div>
	   	</html:form>
   	</div>
  </body>
</html>
