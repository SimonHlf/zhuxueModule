<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>编辑巴菲特题库</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/buffet/css/addBuffetCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
    <link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/buffet/js/buffetCommon.js"></script>
	<script type="text/javascript" src="Module/buffet/js/viewBuffet.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="Module/buffet/js/commonList.js"></script>
	<script type="text/javascript">
	var answerNumber = 0;
	var realAnswer = "";
	var questionType = "";
	var answerSelectImg;
	var result_answer = "";//复选框value
	var result_answer_text = "";//复选框text
	var answerType = "";
	var questionTitle = "";
	var loreNum = 0;
	var loreName = "";
	var orders = 0;
	var editor_question;
	var editor_caution;
	var editor_answer;
	var editor_tips;
	var editor_answer_select;
	var readyTimes = 1;//用处--编辑图片答案时用
	var buffetType = "";
	var buffetMind = "";
	var buffetAbility = "";
	var loreId = 0;
	var currentBuffetCount = 0;
	//替换
	$(function(){
		getBuffetType("类型","selectBuffetTypeDiv","modify");
		getBuffetType("思维","selectBuffetTypeMindDiv");
		getBuffetType("能力","selectBuffetTypeAbilityDiv");
		editTextBox();//初始化文本编辑器-数据库
		maxSelectList();//初始化最大选项
		inputNumberList();//初始化填空数量
		<c:forEach items="${requestScope.bList}" var="buffet">
			getId("buffetId").value = ${buffet.id};
			loreId = ${buffet.lore.id};
			getId("loreId").value = loreId;
			buffetType = ${buffet.buffetType.id};
			getId("buffetTypeId").value = buffetType;
			getId("buffetTypeName").value = "${buffet.buffetType.types}";
			setSingleSelection(document.getElementsByName("basicType"),buffetType);
			setMultSelecttion("buffetTypeMind","${requestScope.buffetMindArray}");
			getId("buffetTypeMindIdOld").value = "${requestScope.buffetMindArray}";
			setMultSelecttion("buffetTypeAbility","${requestScope.buffetAbilityArray}");
			getId("buffetTypeAbilityIdOld").value = "${requestScope.buffetAbilityArray}";
			questionType = "${buffet.questionType}";
			questionTitle = "${buffet.title}";
			getId("subTitle").value = "${buffet.title}";
			initUeditorContent("myEditor_question",'${buffet.subject}');
			realAnswer = '${buffet.answer}';
			initUeditorContent("myEditor_answer",realAnswer);
			initUeditorContent("myEditor_caution",'${buffet.resolution}');
			initUeditorContent("myEditor_tips",'${buffet.tips}');
			$('#headTitleName').html("知识点:"+"${buffet.lore.loreName}");
			getId("question_type_new").value = questionType;
			getId("questionType").value = questionType;
			getId("questionTitle").value = questionTitle;
			getId("buffetNum").value =  ${buffet.num};
			getId("loreDicId").value = ${buffet.dic};
			orders = ${buffet.orders};
			var answer1 = replaceChara("${buffet.a}");
			var answer2 = replaceChara("${buffet.b}");
			var answer3 = replaceChara("${buffet.c}");
			var answer4 = replaceChara("${buffet.d}");
			var answer5 = replaceChara("${buffet.e}");
			var answer6 = replaceChara("${buffet.f}");
			if(realAnswer != ""){
				realAnswer += ",";
			}
			if(questionType == "填空选择题" || questionType == "多选题"){
				getId("content_answer").value = '${buffet.answer}';
				result_answer = '${buffet.answer}';
				$("#changeTypeDiv").show();
				if(questionType == "填空选择题"){
					$("#changeTypeButton").attr("value","多选题");
				}else{
					$("#changeTypeButton").attr("value","填空选择题");
				}
			}else{
				getId("content_answer").value = '${buffet.answer}' + ",";
				result_answer = '${buffet.answer}' + ",";
			}
			if(answer1 != ""){
				answerNumber += 1;
			}
			if(answer2 != ""){
				answerNumber += 1;
			}
			if(answer3 != ""){
				answerNumber += 1;
			}
			if(answer4 != ""){
				answerNumber += 1;
			}
			if(answer5 != ""){
				answerNumber += 1;
			}
			if(answer6 != ""){
				answerNumber += 1;
			}
			getId("maxSelect").value = answerNumber;
			showAnswer("init",questionType);
			initAnswerOption(findAnserType(answer1),answer1,answer2,answer3,answer4,answer5,answer6);
			//当是多选题时显示答案是否完全顺序匹配DIV
			/**if(questionType == "多选题"){
				getId("answer_match_div").style.display = "block";
				var anserMatchOption = document.getElementsByName("answer_match");
				setSingleSelection(anserMatchOption,"${lq.answerMatch}");
			}else **/if(questionType == "填空题"){
				realAnswer = realAnswer.substring(0,realAnswer.length - 1);
				getId("answer_inputText").value = replaceChara(realAnswer);
			}else if(questionType == "填空选择题"){//需要定位有多少个填空数量
				var inputNumber = '${buffet.answer}'.split(",").length;
				getId("inputNumber").value = inputNumber;
			}
		</c:forEach>
    });
	
	</script>
  </head>
  
  <body>
    <div class="addPracticeWrap">
  		<div class="comParentWrap">
		  	<h2 id="headTitleName" class="headTitle"></h2>
		  	<div id="questionDiv">
		  		<div class="choiceBox clearfix">
		  			<div class="queSty fl">
				  		题干类型:
					   	<select id="question_type_new" onchange="showAnswer('select',this);" disabled>
					   		<option value="0">题干类型</option>
					   		<option value="单选题">单选题</option>
					   		<option value="多选题">多选题</option>
					   		<option value="问答题">问答题</option>
					   		<option value="判断题">判断题</option>
					   		<option value="填空题">填空题</option>
					   		<option value="填空选择题">填空选择题</option>
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
				   	<div class="relateBox" id="changeTypeDiv" style="display:none">
					   	切换问题类型:
					   	<input type="button" id="changeTypeButton" value="" onclick="changeType(this)"/>
					   	<input type="button"  value="恢复" id="resetBtn" onclick="reset()"/>
				   	</div>
				   	<div id="selectBuffetTypeDiv" class="comHei"></div>
				   	<div id="selectBuffetTypeMindDiv" class="comHei"></div>
				   	<div id="selectBuffetTypeAbilityDiv" class="comHei"></div>
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
	   				<input type="radio" name="answer_select_type" id="answer_select_type_1" disabled value="1" onclick="radioOnclick();"><label for="answer_select_type_1">文字</label>
	   				<input type="radio" name="answer_select_type" id="answer_select_type_2" disabled value="2" onclick="radioOnclick();"><label  for="answer_select_type_2">图片</label>	
	   			<!-- 单选、多选题下对应图片类型的img  -->
		   		<div id="answerSelect" class="imgBox" style="display:none;">
		   			<div id="answerSelWrap1" class="comImgBox">
		   				<img id="answerSelect1" alt="" width="100" height="100" title="A" src="Module/buffet/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>A</p>
		   			</div>
		   			<div id="answerSelWrap2" class="comImgBox">
		   				<img id="answerSelect2" alt="" width="100" height="100" title="B" src="Module/buffet/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>B</p>
		   			</div>
		   			<div id="answerSelWrap3" class="comImgBox">
		   				<img id="answerSelect3" width="100" height="100" alt="" title="C" src="Module/buffet/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>C</p>
		   			</div>
		   			<div id="answerSelWrap4" class="comImgBox">
		   				<img id="answerSelect4" width="100" height="100" alt="" title="D" src="Module/buffet/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>D</p>
		   			</div>
		   			<div id="answerSelWrap5" class="comImgBox" style="display:none;" >
		   				<img id="answerSelect5" width="100" height="100"  alt="" title="E" src="Module/buffet/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>E</p>
		   			</div>
		   			<div id="answerSelWrap6" class="comImgBox" style="display:none;" >
		   				<img id="answerSelect6" width="100" height="100" alt="" title="F" src="Module/buffet/images/answerImgUpload.png" onclick="showUploadAnswerSelect(this)"/>
		   				<p>F</p>
		   			</div>
		   		</div>
		   		<!-- 单选、多选题下对应文字类型的input文字输入框  -->
		   		<div id="answerSelectInputText" class="textBox">
		   			<label id="inputText_answer_1"><span class="colors">A:</span><input type="text" name="answerSelectInputText" id="answerSelectInputText1" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			<label id="inputText_answer_2"><span class="colors">B:</span><input type="text" name="answerSelectInputText" id="answerSelectInputText2" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			<label id="inputText_answer_3"><span class="colors">C:</span><input type="text" name="answerSelectInputText" id="answerSelectInputText3" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			<label id="inputText_answer_4"><span class="colors">D:</span><input type="text" name="answerSelectInputText" id="answerSelectInputText4" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   			<div class="otherChoice">
		   				<label id="inputText_answer_5" style="display:none;"><span class="colors" style="margin-left:3px;">E:</span><input type="text" id="answerSelectInputText5" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
		   				<label id="inputText_answer_6" style="display:none;"><span class="colors" style="margin-left:6px;">F:</span><input type="text" id="answerSelectInputText6" class="txtInput" onblur="inputOnblur(this)" title="禁止使用空格符!"/></label>
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
			  		<input type="text" size="20" id="answer_inputText" onblur="inputOnblur(this)"/>多个空之间使用英文‘,’分割
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
			   		<label id="answer_multi_tk_1"><input type="button" class="multiBtn" name="answer_multi_tk" alt="" value="A"  onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_2"><input type="button" class="multiBtn" name="answer_multi_tk" value="B" alt="" onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_3" style="display:none"><input type="button" class="multiBtn" name="answer_multi_tk" value="C" alt="" onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_4" style="display:none"><input type="button" class="multiBtn" name="answer_multi_tk" value="D" alt="" onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_5" style="display:none"><input type="button" class="multiBtn" name="answer_multi_tk" value="E" alt="" onclick="addItemTk(this)"></label>
			   		<label id="answer_multi_tk_6" style="display:none"><input type="button" class="multiBtn" name="answer_multi_tk" value="F" alt="" onclick="addItemTk(this)"></label>
			   		您选择的答案是:<input type="text" id="result_answer_tk_new" disabled/>
			   		<input type="button" class="clearBtn" value="清除已选答案" onclick="clearAllAnswer()"/>
			   	</div>	
			   	<!-- 判断题 -->
			   	<div id="judge_answer" style="display:none;">
			   		<span class="ansText">答案：</span>
			   		<label id="judge_answer_1"><input type="radio" name="answer_judge" id="answer_judge_1" checked="checked" value="对"> 对</label>
			   		<label id="judge_answer_2"><input type="radio" name="answer_judge" id="answer_judge_2" value="错"> 错</label>
			   	</div>
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
			<!-- 提交按钮  -->
	   	<html:form action="buffetManager.do">
	   		<input type="hidden" id="action" name="action" value="updateBuffet" />
	   		<input type="hidden" id="buffetId" name="buffetId"/>
	   		<input type="hidden" id="chapterId" name="chapterId" value="${requestScope.chapterId}"/>
	   		<input type="hidden" id="buffetTypeId" name="buffetTypeId"/>
	   		<input type="hidden" id="buffetTypeName" name="buffetTypeName"/>
	   		<input type="hidden" id="buffetTypeMindIdOld" name="buffetTypeMindIdOld"/>
	   		<input type="hidden" id="buffetTypeMindId" name="buffetTypeMindId"/>
	   		<input type="hidden" id="buffetTypeAbilityIdOld" name="buffetTypeAbilityIdOld"/>
	   		<input type="hidden" id="buffetTypeAbilityId" name="buffetTypeAbilityId"/>
	   		<input type="hidden" id="loreDicId" name="loreDicId"/>
	   		<input type="hidden" id="loreId" name="loreId"/>
	   		<input type="hidden" id="subTitle" name="subTitle"/>
	   		<input type="hidden" id="buffetNum" name="buffetNum"/>
	   		<input type="hidden" id="questionType" name="questionType"/>
	   		<input type="hidden" id="content_tips" name="content_tips"/>
	   		<input type="hidden" id="content_question" name="content_question"/>
	   		<input type="hidden" id="content_answer" name="content_answer"/>
	   		<input type="hidden" id="content_analysis" name="content_analysis"/>
	   		<input type="hidden" id="content_answer1" name="content_answer1"/>
	   		<input type="hidden" id="content_answer2" name="content_answer2"/>
	   		<input type="hidden" id="content_answer3" name="content_answer3"/>
	   		<input type="hidden" id="content_answer4" name="content_answer4"/>
	   		<input type="hidden" id="content_answer5" name="content_answer5"/>
	   		<input type="hidden" id="content_answer6" name="content_answer6"/>
	   		<div class="tijiao">
	   			<input type="submit" class="sub_btn" value="提交" onclick="return check()"/>
	   			<input type="button" class="backBtn" value="返回上一级" onclick="backPrevStep()">
	   		</div>
	   	</html:form>
	  </div>
  </body>
</html>
