<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>addPractice.jsp</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/addPracticeCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
    <link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/addPracticeJs.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript">
		var answerNumber = 4;
		$(function(){
			editTextBox();
			maxSelectList();
			inputNumberList();
			initInputTitle(loreTitle);
	    });
		window.top.onscroll = function(){
			moveQueryBox("moveWrap","top");
		};
		var loreId = ${requestScope.loreId};
		var loreTitle = "${requestScope.loreType}" + "第" + ${requestScope.loreNum} + "题";
		var editor_question;
		var editor_caution;
		var editor_answer;
		var editor_answer_select;
		var editor_tips;
		var answerSelectImg;
		var result_answer = "";//复选框value
		var result_answer_text = "";//复选框text
		//初始化标题内容
		function initInputTitle(value){
			getId("questionTitle").value = value;
		}
		//清空已选答案
		function clearAllAnswer(){
			getId("result_answer_tk_new").value = "";
			getId("content_answer").value = "";
			result_answer = "";//复选框value
			result_answer_text = "";//复选框text
		}
	</script>
  </head>
  
  <body>
  	<div class="addPracticeWrap">
  		<div class="comParentWrap">
		  	<h2 class="headTitle">知识典:${requestScope.loreName }</h2>
		  	<div id="questionDiv">
		  		<div class="choiceBox clearfix">
		  			<div class="queSty fl">
				  		题干类型:
					   	<select id="question_type_new" onchange="showAnswer(this);">
					   		<option value="0">题干类型</option>
					   		<option value="单选题">单选题</option>
					   		<option value="多选题">多选题</option>
					   		<option value="问答题">问答题</option>
					   		<option value="判断题">判断题</option>
					   		<option value="填空题">填空题</option>
					   		<option value="填空选择题">填空选择题</option>
					   	</select>
					   	<select id="question_type2_new">
					   		<option value="了解">了解</option>
					   		<option value="理解">理解</option>
					   		<option value="应用">应用</option>
					   		<option value="综合">综合</option>
					   	</select>
				   	</div>
				   	<div id="maxSelectDiv" class="fl" style="display:none">
					   	最大选项:
					   	<select id="maxSelect" onchange="showAnswer1(this)"></select>
				   	</div>
				   	<div id="inputNumberDiv" class="fl" style="display:none">
					   	填空数量:
					   	<select id="inputNumber"></select>
				   	</div>
				   	<div class="relateBox">
					   	关联词条:
					   	<input type="text" id="dic_new" value="0"/>&nbsp;(请输入关联词检索)
					   	<input type="button" class="seacrhBtn" value="查询"/>
				   	</div>
		  		</div>
		  		<div class="topTitle">
		  			<span>标题:</span><input type="text" id="questionTitle" class="comInput" disabled/>
		  		</div>
			   	<div class="contents">题干</div>
			   	<div id="myEditor_question"></div>
		   	</div>
		   	<!-- 问题选项 单选题、多选题  -->
		   	<div id="answerSelectDiv" class="selectBox clearfix" style="display:none;">
		   		<span class="ansSelect">问题选项</span>
	   				<input type="radio" name="answer_select_type" id="answer_select_type_1" checked="checked" value="1" onclick="radioOnclick();"><label for="answer_select_type_1">文字</label>
	   				<input type="radio" name="answer_select_type" id="answer_select_type_2" value="2" onclick="radioOnclick();"><label  for="answer_select_type_2">图片</label>	
					<span class="noticeIcon"></span>
	   				<span class="notice">[切换答案选项之前选择的答案将被清空]</span>
	   			<!-- 单选、多选题下对应图片类型的img  -->
		   		<div id="answerSelect" class="imgBox" style="display:none;">
		   			<div id="answerSelWrap1" class="comImgBox">
		   				<img id="answerSelect1" alt="" width="100" height="100" title="A" src="Module/loreManager/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>A</p>
		   			</div>
		   			<div id="answerSelWrap2" class="comImgBox">
		   				<img id="answerSelect2" alt="" width="100" height="100" title="B" src="Module/loreManager/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>B</p>
		   			</div>
		   			<div id="answerSelWrap3" class="comImgBox">
		   				<img id="answerSelect3" width="100" height="100" alt="" title="C" src="Module/loreManager/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>C</p>
		   			</div>
		   			<div id="answerSelWrap4" class="comImgBox">
		   				<img id="answerSelect4" width="100" height="100" alt="" title="D" src="Module/loreManager/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>D</p>
		   			</div>
		   			<div id="answerSelWrap5" class="comImgBox" style="display:none;" >
		   				<img id="answerSelect5" width="100" height="100"  alt="" title="E" src="Module/loreManager/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>E</p>
		   			</div>
		   			<div id="answerSelWrap6" class="comImgBox" style="display:none;" >
		   				<img id="answerSelect6" width="100" height="100" alt="" title="F" src="Module/loreManager/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>F</p>
		   			</div>
		   		</div>
		   		<!-- 单选、多选题下对应文字类型的input文字输入框  -->
		   		<div id="answerSelectInputText" class="textBox">
		   			<label id="inputText_answer_1"><span class="colors">A:</span><input type="text" id="answerSelectInputText1" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			<label id="inputText_answer_2"><span class="colors">B:</span><input type="text" id="answerSelectInputText2" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			<label id="inputText_answer_3"><span class="colors">C:</span><input type="text" id="answerSelectInputText3" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			<label id="inputText_answer_4"><span class="colors">D:</span><input type="text" id="answerSelectInputText4" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			<div class="otherChoice">
		   				<label id="inputText_answer_5" style="display:none;"><span class="colors">E:</span><input type="text" id="answerSelectInputText5" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   				<label id="inputText_answer_6" style="display:none;"><span class="colors">F:</span><input type="text" id="answerSelectInputText6" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			</div>
		   		</div>
		   		<!-- 单选、多选题下对应图片类型的图片上传窗口  -->
		   		<div id="answerSelectWindow" style="display:none">
		   			<div id="myEditor_answer_select"></div>
		   			<center><input type="button" value="确定" class="addAnsSelBtn" onclick="addAnswerSelect();"/></center>
		   		</div>
		   	</div>
		   	<!-- 填空题 、问答题 、单选题、多选题、判断题所对应的答案盒子 -->
		   	<div id="answerDiv">
			  	<!-- 文本框（填空题） -->
			  	<div id="inputText_anser" style="display:none;">
			  		<span class="ansText">答案：</span>
			  		<input type="text" size="20" id="answer_inputText"/>多个空之间使用英文‘,’分割
			  	</div>
			  	<!-- 编辑框（问答题） -->
			  	<div id="editorAns" class="contents" style="display:none;">答案</div>
			   	<div id="myEditor_answer" style="display:none;"></div>
			   	<!-- 单选框（radio） -->
			   	<div id="radio_answer" style="display:none;">
			   		<span class="ansText">答案：</span>
			   		<label id="answer_singel_1"><input type="radio" name="answer_singel" id="answer_singel_1" value="" onclick="selectSingelAnswer(this)"> A</label>
			   		<label id="answer_singel_2"><input type="radio" name="answer_singel" id="answer_singel_2" value="" onclick="selectSingelAnswer(this)"> B</label>
			   		<label id="answer_singel_3" style="display:none"><input type="radio" name="answer_singel" id="answer_singel_3" value="" onclick="selectSingelAnswer(this)"> C</label>
			   		<label id="answer_singel_4" style="display:none"><input type="radio" name="answer_singel" id="answer_singel_4" value="" onclick="selectSingelAnswer(this)"> D</label>
			   		<label id="answer_singel_5" style="display:none"><input type="radio" name="answer_singel" id="answer_singel_5" value="" onclick="selectSingelAnswer(this)"> E</label>
			   		<label id="answer_singel_6" style="display:none"><input type="radio" name="answer_singel" id="answer_singel_6" value="" onclick="selectSingelAnswer(this)"> F</label>
			   	</div>
			   	<!-- 多选题(checkbox) -->
			   	<div id="multi_answer" style="display:none;">
			   		<span class="ansText">答案：</span>
			   		<label id="answer_multi_1"><input type="checkbox" name="answer_multi" id="A" value="" onclick="addItem(this)"> A</label>
			   		<label id="answer_multi_2"><input type="checkbox" name="answer_multi" id="B" value="" onclick="addItem(this)"> B</label>
			   		<label id="answer_multi_3" style="display:none"><input type="checkbox" name="answer_multi" id="C" value="" onclick="addItem(this)"> C</label>
			   		<label id="answer_multi_4" style="display:none"><input type="checkbox" name="answer_multi" id="D" value="" onclick="addItem(this)"> D</label>
			   		<label id="answer_multi_5" style="display:none"><input type="checkbox" name="answer_multi" id="E" value="" onclick="addItem(this)"> E</label>
			   		<label id="answer_multi_6" style="display:none"><input type="checkbox" name="answer_multi" id="F" value="" onclick="addItem(this)"> F</label>
			   		您选择的答案是:<input type="text" id="result_answer_new" disabled/>
			   	</div>	
			   	<!-- 填空选择题 -->
			   	<div id="multi_answer_tk" style="display:none;">
			   		<span class="ansText">答案：</span>
			   		<label id="answer_multi_tk_1"><input type="button" name="answer_multi_tk" alt="" value="A"  onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_2"><input type="button" name="answer_multi_tk" value="B" alt="" onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_3" style="display:none"><input type="button" name="answer_multi_tk" value="C" alt="" onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_4" style="display:none"><input type="button" name="answer_multi_tk" value="D" alt="" onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_5" style="display:none"><input type="button" name="answer_multi_tk" value="E" alt="" onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_6" style="display:none"><input type="button" name="answer_multi_tk" value="F" alt="" onclick="addItemTk(this)"></label>
			   		您选择的答案是:<input type="text" id="result_answer_tk_new" disabled/>
			   		<input type="button" value="清除已选答案" onclick="clearAllAnswer()"/>
			   	</div>	
			   	<!-- 判断题 -->
			   	<div id="judge_answer" style="display:none;">
			   		<span class="ansText">答案：</span>
			   		<label id="judge_answer_1"><input type="radio" name="answer_judge" id="answer_judge_1" checked="checked" value="对"> 对</label>
			   		<label id="judge_answer_2"><input type="radio" name="answer_judge" id="answer_judge_2" value="错"> 错</label>
			   	</div>
			   	<!-- 答案匹配 -->
			   	<!--div id="answer_match_div" style="display:none;">
			   		<span class="ansText"><font color=red>答案匹配项：</font></span>
			   		<label id="judge_answer_1"  title="答案顺序完全匹配"><input type="radio" name="answer_match" id="answer_match_1" value="0"/>完全匹配</label>
			   		<label id="judge_answer_1"  title="答案顺序可以不一样"><input type="radio" name="answer_match" id="answer_match_2" value="1"/>顺序不匹配</label>
			   	</div-->
		   	</div>
		   	<div id="cautionDiv">
			  	<div class="contents">解析</div>
			   	<div id="myEditor_caution"></div>
		   	</div>
		   	<div id="tipsDiv">
		   		<div class="contents">提示</div>
			   	<div id="myEditor_tips"></div>
		   	</div>
	   	</div>
	   	
	   	<!-- 提交按钮  -->
	   	<html:form action="loreManager.do">
	   		<input type="hidden" id="action" name="action" value="addPractice" />
	   		<input type="hidden" id="loreId" name="loreId" value="${requestScope.loreId}"/>
	   		<input type="hidden" id="loreName" name="loreName" value="${requestScope.loreName }"/>
	   		<input type="hidden" id="title" name="title"/>
	   		<input type="hidden" id="dic" name="dic"/>
	   		<input type="hidden" id="loreNum" name="loreNum" value="${requestScope.loreNum}"/>
	   		<input type="hidden" id="loreType" name="loreType" value="${requestScope.loreType}"/>
	   		<input type="hidden" id="questionType" name="questionType"/>
	   		<input type="hidden" id="questionType2" name="questionType2"/>
	   		<input type="hidden" id="content_tips" name="content_tips"/>
	   		<input type="hidden" id="content_question" name="content_question"/>
	   		<input type="hidden" id="content_answer" name="content_answer"/>
	   		<!-- input type="hidden" id="answer_match" name="answer_match"/-->
	   		<input type="hidden" id="content_answer1" name="content_answer1"/>
	   		<input type="hidden" id="content_answer2" name="content_answer2"/>
	   		<input type="hidden" id="content_answer3" name="content_answer3"/>
	   		<input type="hidden" id="content_answer4" name="content_answer4"/>
	   		<input type="hidden" id="content_answer5" name="content_answer5"/>
	   		<input type="hidden" id="content_answer6" name="content_answer6"/>
	   		
	   		<input type="hidden" id="content_analysis" name="content_analysis"/>
	   		<div class="tijiao">
	   			<input type="submit" class="sub_btn" value="提交" onclick="return check()"/>
	   		</div>
	   	</html:form>
   	</div>
  </body>
</html>
