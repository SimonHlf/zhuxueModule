<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title></title>

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
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
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
	
	//单选多选默认选中状态
	function setSingleSelection(sl,value)
	{
		for(var i = 0 ; i < sl.length ; i ++)
		{
			if(sl[i].value == value)
			{
				sl[i].checked = "checked";
				break;
			}
		}
	}
	//替换所有的单引号为自定义字符
	function replaceChara(value){
		return value.replace(/&#wmd;/g,"'");
	}
	
	//替换选项中存在单引号为自定义字符，双引号为中文状态下的双引号
	function replaceQuote(value){
		var result = value.replace(/,/g,"，").replace(/\s+/g,"").replace(/"/g,"”").replace(/'/g,"&#wmd;");
		return result;
	}
	//替换
	$(function(){
		editTextBox();//初始化文本编辑器-数据库
		maxSelectList();//初始化最大选项
		inputNumberList();//初始化填空数量
		<c:forEach items="${requestScope.lqList_practice}" var="lq">
			questionType = "${lq.questionType}";
			initUeditorContent("myEditor_question",'${lq.subject}');
			realAnswer = '${lq.answer}';
			initUeditorContent("myEditor_answer",realAnswer);
			initUeditorContent("myEditor_caution",'${lq.resolution}');
			initUeditorContent("myEditor_tips",'${lq.tips}');
			$('#headTitleName').html("知识典:"+"${lq.lore.loreName}");
			
			var questionType2 = "${lq.questionType2}";
			getId("question_type_new").value = questionType;
			getId("question_type2_new").value = questionType2;
			questionTitle = "${lq.title}";
			getId("questionTitle").value = questionTitle;
			loreNum = ${lq.loreNum};
			getId("loreNum").value = loreNum;
			orders = ${lq.orders};
			loreName = "${lq.lore.loreName}";
			getId("loreName").value = loreName;
			var answer1 = replaceChara("${lq.a}");
			var answer2 = replaceChara("${lq.b}");
			var answer3 = replaceChara("${lq.c}");
			var answer4 = replaceChara("${lq.d}");
			var answer5 = replaceChara("${lq.e}");
			var answer6 = replaceChara("${lq.f}");
			if(realAnswer != ""){
				realAnswer += ",";
			}
			if(questionType == "填空选择题" || questionType == "多选题"){
				getId("content_answer").value = '${lq.answer}';
				result_answer = '${lq.answer}';
				$("#changeTypeDiv").show();
				if(questionType == "填空选择题"){
					$("#changeTypeButton").attr("value","多选题");
				}else{
					$("#changeTypeButton").attr("value","填空选择题");
				}
			}else{
				getId("content_answer").value = '${lq.answer}' + ",";
				result_answer = '${lq.answer}' + ",";
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
				var inputNumber = '${lq.answer}'.split(",").length;
				getId("inputNumber").value = inputNumber;
			}
		</c:forEach>
    });
	window.top.onscroll = function(){
		moveQueryBox("moveWrap","parent");
	};
	function editTextBox(){
		editor_question = new baidu.editor.ui.Editor( {
			initialFrameWidth : 750,
			initialFrameHeight : 240,
			wordCount:true,
			textarea : 'description'
		});
		editor_caution = new baidu.editor.ui.Editor( {
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
		editor_tips = new baidu.editor.ui.Editor( {
			initialFrameWidth : 750,
			initialFrameHeight : 240,
			wordCount:true,
			textarea : 'description'
		});
		editor_answer_select = new baidu.editor.ui.Editor( {
			//这里可以选择自己需要的工具按钮名称,此处仅选择如下五个  
	        toolbars:[['Source', 'italic','bold', 'underline',
	                   'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify','|',
	                   'snapscreen']], 
			initialFrameWidth : 400,
			initialFrameHeight : 250,
			wordCount:false,
			textarea : 'description'
		});
		//禁止粘贴
		editor_answer_select.addListener('beforepaste', myEditor_answer_select); 
	    function myEditor_answer_select(o, html) {
	        html.html = "";
	   } 
		editor_question.render("myEditor_question");
		editor_caution.render("myEditor_caution");
		editor_answer.render("myEditor_answer");
		editor_answer_select.render("myEditor_answer_select");
		editor_tips.render("myEditor_tips");
	}
	//判断答案是文字还是图片
	function findAnserType(answerA){
		if(answerA.indexOf("Module/commonJs/ueditor/jsp/lore") < 0){
			if(questionType == "单选题" || questionType == "多选题" || questionType == "填空选择题"){
				answerType = "character";
				window.top.$(".rightPart").height(1410);
				window.parent.$(".iframeWrap").height(1390);
			}
			return "character";
		}else{
			if(questionType == "单选题" || questionType == "多选题" || questionType == "填空选择题"){
				answerType = "pic";
				window.top.$(".rightPart").height(1455);
				window.parent.$(".iframeWrap").height(1435);
			}
			return "pic";
		}
	}
	//初始化问题选项选择状态
	function initAnswerSelectType(answer1){
		var optionAnswerTypeSelectStatus = document.getElementsByName("answer_select_type");
		if(findAnserType(answer1) == "character"){
			
			optionAnswerTypeSelectStatus[0].checked = true;
			getId("answerSelect").style.display = "none";
			getId("answerSelectInputText").style.display = "";
		}else{
			
			optionAnswerTypeSelectStatus[1].checked = true;
			getId("answerSelect").style.display = "";
			getId("answerSelectInputText").style.display = "none";
		}
	}
	//检查填空数量是否大于你选择的答案
	function checkSelectNum(){
		var selectMaxNum = $("#inputNumber").val();
		if(getId("result_answer_tk_new").value != ""){
			if(getId("result_answer_tk_new").value.split(",").length < selectMaxNum){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}
	//检查选择答案数量不能大于等于所选择的答案项，及多选题不能全选
	function checkSelectNum1(){
		var currMaxNum = getId("maxSelect").value;
		if(getId("result_answer_tk_new").value != ""){
			if(getId("result_answer_tk_new").value.split(",").length < currMaxNum - 1){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}
	//清空已选答案
	function clearAllAnswer(){
		getId("result_answer_tk_new").value = "";
		getId("content_answer").value = "";
		result_answer = "";//复选框value
		result_answer_text = "";//复选框text
	}
	//答案选择框返回值（填空选择题）
	function addItemTk(obj,number){
		var selectMaxNum = $("#inputNumber").val();
		var questionType = getId("question_type_new").value;
		
		if(obj.alt == ""){
			alert("请先输入答案选项，然后再选择答案!");
		}else{
			if(questionType == "填空选择题"){
				if(checkSelectNum()){
					if(result_answer_text == ""){
						result_answer += obj.alt + ",";
						result_answer_text += obj.value + ",";
					}else{
						if(result_answer_text.substring(result_answer_text.length - 1,result_answer_text.length) == ","){
							result_answer += obj.alt + ",";
							result_answer_text += obj.value + ",";
						}else{
							result_answer += "," + obj.alt + ",";
							result_answer_text += "," + obj.value + ",";
						}
					}
				}else{
					alert("当前所选答案累计数超过所选填空数量!");
				}
			}else{
				if(checkSelectNum1()){
					if(result_answer_text == ""){
						result_answer += obj.alt + ",";
						result_answer_text += obj.value + ",";
					}else{
						if(result_answer_text.indexOf(obj.value) >= 0){
							alert("此类体型不能出现相同答案!");
						}else{
							if(result_answer_text.substring(result_answer_text.length - 1,result_answer_text.length) == ","){
								result_answer += obj.alt + ",";
								result_answer_text += obj.value + ",";
							}else{
								result_answer += "," + obj.alt + ",";
								result_answer_text += "," + obj.value + ",";
							}
						}
					}
				}else{
					alert("多选题的答案不能为全选!");
				}
			}
			
		}
		if(result_answer_text.substring(result_answer_text.length - 1,result_answer_text.length) == ","){
			getId("result_answer_tk_new").value = result_answer_text.substring(0,result_answer_text.length - 1);
			getId("content_answer").value = result_answer.substring(0,result_answer.length - 1);
		}else{
			getId("result_answer_tk_new").value = result_answer_text;
			getId("content_answer").value = result_answer;
		}
	}
	//初始化答案选项
	function initAnswerOption(answerType,answer1,answer2,answer3,answer4,answer5,answer6){
		//初始化问题选项选择状态
		initAnswerSelectType(answer1);
		var options;
		if(questionType == "单选题"){
			if(findAnserType(answer1) == "pic"){
				realAnswer = "Module/commonJs/ueditor/jsp/lore/"+realAnswer;
			}
			options = document.getElementsByName("answer_singel");
		}else if(questionType == "判断题"){
			options = document.getElementsByName("answer_judge");
		}else if(questionType == "填空选择题" || questionType == "多选题"){
			options = document.getElementsByName("answer_multi_tk");
		}
		if(answerType == "character"){
			if(answer1 != ""){
				getId("answerSelectInputText1").value = answer1;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[0].alt = replaceQuote(answer1);
				}else{
					options[0].value = replaceQuote(answer1);
				}
			}
			if(answer2 != ""){
				getId("answerSelectInputText2").value = answer2;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[1].alt = replaceQuote(answer2);
				}else{
					options[1].value = replaceQuote(answer2);
				}
			}
			if(answer3 != ""){
				getId("answerSelectInputText3").value = answer3;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[2].alt = replaceQuote(answer3);
				}else{
					options[2].value = replaceQuote(answer3);
				}
			}
			if(answer4 != ""){
				getId("answerSelectInputText4").value = answer4;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[3].alt = replaceQuote(answer4);
				}else{
					options[3].value = replaceQuote(answer4);
				}
			}
			if(answer5 != ""){
				getId("answerSelectInputText5").value = answer5;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[4].alt = replaceQuote(answer5);
				}else{
					options[4].value = replaceQuote(answer5);
				}
			}
			if(answer6 != ""){
				getId("answerSelectInputText6").value = answer6;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[5].alt = replaceQuote(answer6);
				}else{
					options[5].value = replaceQuote(answer6);
				}
			}
		}else{
			if(answer1 != ""){
				getId("answerSelect1").src = answer1;
				var newAnswer = answer1.split("/");
				var newAnswerLength = newAnswer.length;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[0].alt = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}else{
					options[0].value = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}
				
			}
			if(answer2 != ""){
				getId("answerSelect2").src = answer2;
				var newAnswer = answer2.split("/");
				var newAnswerLength = newAnswer.length;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[1].alt = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}else{
					options[1].value = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}
			}
			if(answer3 != ""){
				getId("answerSelect3").src = answer3;
				var newAnswer = answer3.split("/");
				var newAnswerLength = newAnswer.length;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[2].alt = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}else{
					options[2].value = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}
			}
			if(answer4 != ""){
				getId("answerSelect4").src = answer4;
				var newAnswer = answer4.split("/");
				var newAnswerLength = newAnswer.length;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[3].alt = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}else{
					options[3].value = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}
			}
			if(answer5 != ""){
				getId("answerSelect5").src = answer5;
				var newAnswer = answer5.split("/");
				var newAnswerLength = newAnswer.length;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[4].alt = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}else{
					options[4].value = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}
			}
			if(answer6 != ""){
				getId("answerSelect6").src = answer6;
				var newAnswer = answer6.split("/");
				var newAnswerLength = newAnswer.length;
				if(questionType == "填空选择题" || questionType == "多选题"){
					options[5].alt = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}else{
					options[5].value = newAnswer[newAnswerLength-2]+"/"+newAnswer[newAnswerLength-1];
				}
			}
		}
		//初始化单选多选框选择状态
		if(questionType == "单选题"){
			if(realAnswer == replaceQuote(answer1) + ","){
				options[0].checked = "checked";
			}
			if(realAnswer == replaceQuote(answer2) + ","){
				options[1].checked = "checked";
			}
			if(realAnswer == replaceQuote(answer3) + ","){
				options[2].checked = "checked";
			}
			if(realAnswer == replaceQuote(answer4) + ","){
				options[3].checked = "checked";
			}
			if(realAnswer == replaceQuote(answer5) + ","){
				options[4].checked = "checked";
			}
			if(realAnswer == replaceQuote(answer6) + ","){
				options[5].checked = "checked";
			}	
		}else if(questionType == "填空选择题"  || questionType == "多选题"){
			var realAnswerArray = realAnswer.split(",");
			for(var i = 0 ; i < realAnswerArray.length; i++){
				for(var j = 0 ; j < options.length; j++){
					if(realAnswerArray[i] == options[j].alt && options[j].alt != ""){
						result_answer_text += options[j].value + ",";
						break;
					}
				}
			}
			result_answer_text = result_answer_text.substring(0,result_answer_text.length - 1);
			getId("result_answer_tk_new").value = result_answer_text;
		}else if(questionType == "判断题"){
			if(realAnswer == "对,"){
				options[0].checked = "checked";
			}else{
				options[1].checked = "checked";
			}
		}
	}
	//清空单选中value值(startNumber为起始number)
	function clearRadioValue(startNumber){
		var options = document.getElementsByName("answer_singel");
		for(var i = startNumber; i < options.length ; i++){
			options[i].value = "";
		}
	}
	//清空复选框中value值(startNumber为起始number)
	function clearCheckBoxValue(startNumber){
		var options = document.getElementsByName("answer_multi");
		for(var i = startNumber; i < options.length ; i++){
			options[i].value = "";
			result_answer_text = result_answer_text.replace(options[i].id + ",","");
			result_answer_text = result_answer_text.replace(options[i].id,"");
			getId("result_answer_new").value = result_answer_text;
		}
	}
	//清空填空选择题中最后答案（A,B....）的value值
	function clearMultAlt(startNumber){
		var options = document.getElementsByName("answer_multi_tk");
		for(var i = startNumber; i < options.length ; i++){
			options[i].alt = "";
			result_answer_text = result_answer_text.replace(new RegExp(options[i].value + ",", 'g'),"");
			result_answer_text = result_answer_text.replace(new RegExp(options[i].value, 'g'),"");
		}
		if(result_answer_text.substring(result_answer_text.length - 1,result_answer_text.length) == ","){
			result_answer_text = result_answer_text.substring(0,result_answer_text.length - 1);
		}
		getId("result_answer_tk_new").value = result_answer_text;
	}
	//清空答案选项文本框中内容
	function clearInputTextValue(startNumber){
		for(var i = startNumber; i < 7 ; i++){
			getId("answerSelectInputText"+i).value = "";
		}
	}
	//清空答案选项图像中内容（初始化为Module/loreManager/images/answerImgUpload.png）
	function clearAnswerSelectImgSrc(startNumber){
		for(var i = startNumber; i < 7 ; i++){
			getId("answerSelect"+i).src = "Module/loreManager/images/answerImgUpload.png";
		}
	}
	//清空单选框复选框选中状态
	function clearSelectStatus(obj){
		var selectOptions = document.getElementsByName(obj);
		for(var i = 0 ; i < selectOptions.length ; i++){
			selectOptions[i].checked = false;
		}
	}
	//初始化文本编辑器内容（内容通过数据库获取）
	function initUeditorContent(obj,content){
		UE.getEditor(obj).addListener("ready", function () {
	        UE.getEditor(obj).setContent(content,null);
		});
	}
	//最大选项列表
	function maxSelectList(){
		var maxSelectObj = getId("maxSelect");
		for(var i = 2 ; i < 7; i++){
			maxSelectObj.options.add(new Option(i+"个选项",i));
		}
	}
	//填空数量列表
	function inputNumberList(){
		var inputNumberObj = getId("inputNumber");
		for(var i = 2 ; i <= 20; i++){
			inputNumberObj.options.add(new Option(i+"空",i));
		}
	}
	
	//初始化单选框多少框
	function initNumber(name){
		for(var j = 1 ; j <= answerNumber; j++){
			getId(name+"_"+j).style.display = "";
			getId("answerSelWrap"+j).style.display="";
			getId("inputText_answer_"+j).style.display = "";
		}
		for(var i = answerNumber + 1; i < 7;i++){
			getId(name+"_"+i).style.display = "none";
			getId("answerSelWrap"+i).style.display="none";
			getId("inputText_answer_"+i).style.display = "none";
		}
	}
	
	//单项框选中事件
	function radioOnclick(){
		if(returnRadioValue("answer_select_type") == 1){//文字盒子的显示
			getId("answerSelect").style.display = "none";
			getId("answerSelectInputText").style.display = "";
		}else{//图片盒子的显示
			getId("answerSelect").style.display = "";
			getId("answerSelectInputText").style.display = "none";
		}
	}
	//单选框返回值
	function returnRadioValue(obj){
		var option =  document.getElementsByName(obj);
		var value = "";
		for(var i = 0 ; i < option.length ; i++){
			if(option[i].checked){
				value =  option[i].value;
			}
		}
		return value;
	}
	//单选框答案单击事件
	function selectSingelAnswer(obj){
		if(obj.checked == true){
			if(obj.value == ""){
				alert("请先填写答案选项，然后再选择答案!");
				obj.checked = false;
			}
		}
	}
	//复选框答案返回值
	function addItem(obj){
		if(obj.checked == true){
			if(obj.value == ""){
				alert("请先填写答案选项，然后再选择答案!");
				obj.checked = false;
			}else{	
				if(result_answer_text == ""){
					result_answer_text += obj.id;
				}else if(result_answer_text.substring(result_answer_text.length - 1,result_answer_text.length) == ","){
					result_answer_text += obj.id;
				}else{
					result_answer_text += "," + obj.id;
				}
			}
		}else{
			result_answer_text = result_answer_text.replace(obj.id + ",","");
			result_answer_text = result_answer_text.replace(obj.id,"");
		}
		getId("result_answer_new").value = result_answer_text;
	}
	
	//最大选项动作
	function showAnswer1(obj){
		var question_type = getId("question_type_new").value;
		if(question_type == "单选题"){
			setAnswerType("answer_singel",obj);
		}else if(question_type == "填空选择题" || question_type == "多选题"){
			setAnswerType("answer_multi_tk",obj);
		}
		answerNumber = getId("maxSelect").value;
	}
	//单选多选框数量
	function setAnswerType(name,obj){		
		var msg = "当前选择的最大选项小于原数据库中最大选项，少出去的那部分数据将被清空!是否继续?";
		if(obj.value < answerNumber){//当前选择的最大数量小于数据库中答案的数量时
			if(questionType == "填空选择题"){
				msg = "当前选择的最大选项小于原数据库中最大选项，之前选择的答案将被全部清空!是否继续?";	
			}
			if(confirm(msg)){
				clearAnswerSelect(name,obj.value);
				//答案选项图片上传个数/答案选项文字输入框上传个数
				setAnswerSelect(obj);
			}else{
				getId("maxSelect").value = answerNumber;
			}
		}else{
			for(var j = 1 ; j <= parseInt(obj.value); j++){
				getId(name+"_"+j).style.display = "";
			}
			for(var k = parseInt(obj.value) + 1; k <= 6 ; k++){
				getId(name+"_"+k).style.display = "none";
				document.getElementsByName("answer_singel")[k - 1].checked = false;;
			}
			//答案选项图片上传个数/答案选项文字输入框上传个数
			setAnswerSelect(obj);
		}
	}
	
	//当前选择的最大选项引起的动作
	//少出去的部分将被清空，状态，数据将被清空
	function clearAnswerSelect(name,newMaxNumber){
		//设置少出去的那部分为隐藏
		for(var j = 1 ; j <= parseInt(newMaxNumber); j++){
			getId(name+"_"+j).style.display = "";
		}
		for(var i = parseInt(newMaxNumber) + 1; i < 7;i++){
			getId(name+"_"+i).style.display = "none";
		}
		//从最终答案中清除少出去的那部分选项的值
		var selectOptions = document.getElementsByName(name);
		if(questionType == "填空选择题"){
			result_answer = "";
			result_answer_text = "";
			getId("content_answer").value = result_answer;
		}else{
			for(var k = parseInt(newMaxNumber) ; k < selectOptions.length ; k++){
				if(selectOptions[k].value != ""){
					//清空少出去的那部分选项的值
					result_answer = result_answer.replace(new RegExp(selectOptions[k].alt + ",", 'g'),"").replace(new RegExp(selectOptions[k].alt, 'g'),"");
					if(result_answer.substring(result_answer.length - 1,result_answer.length) == ","){
						result_answer = result_answer.substring(0,result_answer.length - 1);
					}
					getId("content_answer").value = result_answer;
				}
			}
		}
		if(answerType == "pic"){
			//清空图片答案的src
			clearAnswerSelectImgSrc(parseInt(newMaxNumber)+1);
		}else{
			//清空文字答案的value
			clearInputTextValue(parseInt(newMaxNumber)+1);
		}
		//清空少出去的那部分单选按框/多选框中的value值
		if(questionType == "单选题"){
			clearRadioValue(newMaxNumber);
		}else if(questionType == "填空选择题"  || questionType == "多选题"){
			clearMultAlt(newMaxNumber);
		}
	}
	
	
	//答案选项图片上传个数/答案选项文字输入框上传个数
	function setAnswerSelect(obj){
		for(var j = 1 ; j <= parseInt(obj.value); j++){
			getId("answerSelWrap"+j).style.display="";
			getId("inputText_answer_"+j).style.display = "";
		}
		for(var i = parseInt(obj.value) + 1; i < 7;i++){
			getId("answerSelWrap"+i).style.display="none";
			getId("inputText_answer_"+i).style.display = "none";
		}
	}
	
	//显示上传答案选项窗口
	function showUploadAnswerSelect(obj){
		getId("answerSelectWindow").style.display="";
		$('#answerSelectWindow').window({  
		   title:"答案选项上传", 
		   width:417,   
		   height:355, 
		   collapsible:false,
		   minimizable:false,
		   maximizable:false,
		   resizable:false,
		   closable:true,
		   modal:true  
		});
		answerSelectImg = obj.id;
		var oldImgSrc = "answerImgUpload.png";
		var currentImgSrc = getId(answerSelectImg).src;
		var currentImgSrcArray = currentImgSrc.split("/");
		var currentImgEndSrc = currentImgSrcArray[currentImgSrcArray.length - 1];
		var content_img = "<p><img src='"+ currentImgSrc +"'></p>";
		if(currentImgEndSrc == oldImgSrc){
			//清空编辑器内容
			if(readyTimes == 1){
				initUeditorContent("myEditor_answer_select","");
			}else{
				editor_answer_select.setContent("",null);
			}
		}else{
			/**
			if(readyTimes == 1){
				initUeditorContent("myEditor_answer_select",content_img);
			}else{
				editor_answer_select.setContent(content_img,null);
			}**/
			initUeditorContent("myEditor_answer_select",content_img);
			editor_answer_select.setContent(content_img,null);
		}
		readyTimes++;
	}
	function closeWindow(){
		$("#answerSelectWindow").window("close");
	}
	function addAnswerSelect(){//答案选项为图片
		//只获取图片地址（不带格式）
		var answerSelectImgContent = editor_answer_select.getContent();
		var hasContents = editor_answer_select.hasContents();
		var startIndex = answerSelectImgContent.indexOf("Module");
		var endIndex = answerSelectImgContent.indexOf(".jpg")+4;
		var endIndex_new = answerSelectImgContent.lastIndexOf(".jpg")+4;
		var realEndIndex = 0;
		if(endIndex > startIndex){
			realEndIndex = endIndex;
		}else{
			realEndIndex = endIndex_new;
		}
		var answerSelectImgSrc = answerSelectImgContent.substring(startIndex,realEndIndex);
		var successFlag = answerSelectImgContent.indexOf("img") > 0;
		var simplification_answer_select = answerSelectImgSrc.substring(answerSelectImgSrc.indexOf("lore/")+5,realEndIndex);
		var question_type = getId("question_type_new").value;
		var i = answerSelectImg.substring(answerSelectImg.length - 1,answerSelectImg.length);
		if(hasContents && successFlag){
			//替换src地址
			getId(answerSelectImg).src = answerSelectImgSrc;
			//修改答案的value值
			//判断答案是单选框还是复选框
			if(question_type == "单选题"){
				var options = document.getElementsByName("answer_singel");
				options[i-1].value = simplification_answer_select;
			}else if(question_type == "多选题"){
				var options1 = document.getElementsByName("answer_multi");
				options1[i-1].value = simplification_answer_select;
			}else if(question_type == "填空选择题"){
				var options2 = document.getElementsByName("answer_multi_tk");
				options2[i-1].alt = simplification_answer_select;
			}
		}else{
			getId(answerSelectImg).src = "Module/loreManager/images/answerImgUpload.png";
			if(question_type == "单选题"){
				var options = document.getElementsByName("answer_singel");
				options[i-1].value = "";
			}else if(question_type == "多选题"){
				var options1 = document.getElementsByName("answer_multi");
				options1[i-1].value = "";
			}else if(question_type == "填空选择题"){
				var options2 = document.getElementsByName("answer_multi_tk");
				options2[i-1].alt = simplification_answer_select;
			}
			
		}
		closeWindow();
	}
	//答案选项文本输入框事件
	function inputOnblur(obj){
		var i = obj.id.substring(obj.id.length-1,obj.id.length);
		var question_type = getId("question_type_new").value;
		if(question_type == "单选题"){
			var options = document.getElementsByName("answer_singel");
			options[i-1].value = replaceQuote(obj.value);
		}else if(question_type == "多选题" || question_type == "填空选择题"){
			var options1 = document.getElementsByName("answer_multi_tk");
			options1[i-1].alt = replaceQuote(obj.value);
		}else if(question_type == "填空题"){
			getId("content_answer").value = replaceQuote(obj.value);
		}
	}
	//获取最终的答案（需要插入数据库）
	function getRealAnswer(){
		var question_type = getId("question_type_new").value;
		if(question_type == "单选题"){
			var radioReturnValue = returnRadioValue("answer_singel");
			var radioReturnValueLength = radioReturnValue.length;
			var radioReturnValue_last = radioReturnValue.substring(radioReturnValueLength - 1,radioReturnValueLength);
			if(radioReturnValue_last == ","){
				getId("content_answer").value = radioReturnValue.substring(0,radioReturnValueLength - 1);
			}else{
				getId("content_answer").value = radioReturnValue;
			}
		}else{//多选题/填空选择题
			getMutiRealAnswer();
		}
	}
	
	//复选框返回值（多选题）（按照选择的先后顺序返回value值）
	function getMutiRealAnswer(){
		var question_type = getId("question_type_new").value;
		var realAnswer = getId("result_answer_tk_new").value;
		var variateSuffix = "";
		var realAnswerResult = "";
		if(realAnswer != ""){
			var lastRealAnswerCharacter =  realAnswer.substring(realAnswer.length - 1, realAnswer.length);
			if(lastRealAnswerCharacter == ","){
				realAnswer = realAnswer.substring(0,realAnswer.length - 1);
			}
			if(returnRadioValue("answer_select_type") == 1){//文字盒子的显示
				variateSuffix = "answerSelectInputText";
			}else{//图片答案
				variateSuffix = "answerSelect";
			}
			var realAsnwerArray = realAnswer.split(",");
			for(var i = 0 ; i < realAsnwerArray.length ; i++){
				var number = 0;
				number = returnNumberByBigCharacter(realAsnwerArray[i]);
				if(i == realAsnwerArray.length - 1){
					if(variateSuffix == "answerSelect"){//图片
						var optionAnswerSrc = getId(variateSuffix+number).src;
						var answerLength = optionAnswerSrc.length;
						var simplification_answer_select = optionAnswerSrc.substring(optionAnswerSrc.indexOf("lore/")+5,answerLength);
						realAnswerResult += simplification_answer_select;
					}else{
						realAnswerResult += replaceQuote(getId(variateSuffix+number).value);
					}
				}else{
					if(variateSuffix == "answerSelect"){//图片
						var optionAnswerSrc = getId(variateSuffix+number).src;
						var answerLength = optionAnswerSrc.length;
						var simplification_answer_select = optionAnswerSrc.substring(optionAnswerSrc.indexOf("lore/")+5,answerLength);
						realAnswerResult += simplification_answer_select + ",";
					}else{
						realAnswerResult += replaceQuote(getId(variateSuffix+number).value) + ",";
					}
				}
			}
		}
		getId("content_answer").value = realAnswerResult;
	}
	
	//通过A-F的字母返回对应1-6的数字
	function returnNumberByBigCharacter(bigChara){
		if(bigChara == "A"){
			return 1;
		}else if(bigChara == "B"){
			return 2;
		}else if(bigChara == "C"){
			return 3;
		}else if(bigChara == "D"){
			return 4;
		}else if(bigChara == "E"){
			return 5;
		}else if(bigChara == "F"){
			return 6;
		}
	}
	
	//检查文本答案选项输入框有无填写完整
	function checkInputTextAnswer(answer_select_type,questionType){
		var flag = false;
		var maxOption = parseInt(getId("maxSelect").value);
		if(questionType == "单选题" || questionType == "多选题"){
			if(answer_select_type == 1){//文字答案
				for(var i = 1 ; i <= maxOption ; i++){
					if(getId("answerSelectInputText"+i).value == ""){
						alert("请将答案选项填写完整!");
						getId("answerSelectInputText"+i).focus();
						flag = false;
						break;
					}else{
						flag = true;
					}
				}
			}else{//图片答案
				for(var i = 1 ; i <= maxOption ; i++){
					if(getId("answerSelect"+i).src.indexOf("answerImgUpload.png") > 0){
						alert("请将答案选项填写完整!");
						flag = false;
						break;
					}else{
						flag = true;
					}
				}
			}
		}else{
			flag = true;
		}
		return flag;
	}
	
	//修改清单
	function check(){
		getId("title").value = questionTitle;
		getId("questionType").value = questionType;
		getId("questionType2").value = getId("question_type2_new").value;;
		getId("dic").value = getId("dic_new").value;
		getId("loreNum").value = loreNum;
		getId("content_question").value = editor_question.getContent();
		getId("content_tips").value = editor_tips.getContent();
		getId("content_analysis").value = editor_caution.getContent();
		getId("orders").value = orders;
		var currSelectNum = $("#maxSelect").val();
		if(getId("questionType").value == "单选题" || getId("questionType").value == "多选题" || getId("questionType").value == "填空选择题"){
			var answer_select_type = returnRadioValue("answer_select_type");
			if(answer_select_type == 1){//文字
				var flag = false;
				var maxNumber = getId("maxSelect").value;
				for(var i = 1 ; i < maxNumber ; i++){
					for(var j = i + 1; j <= maxNumber ; j++){
						if(getId("answerSelectInputText"+i).value.replace(/,/g,"，").replace(/\s+/g,"") == getId("answerSelectInputText"+j).value.replace(/,/g,"，").replace(/\s+/g,"")){
							alert("存在相同答案选项!");
							flag = true;
							break;
						}
					}
					if(flag){
						break;
					}
				}
				if(!flag){
					getId("content_answer1").value = replaceQuote(getId("answerSelectInputText1").value);
					getId("content_answer2").value = replaceQuote(getId("answerSelectInputText2").value);
					getId("content_answer3").value = replaceQuote(getId("answerSelectInputText3").value);
					getId("content_answer4").value = replaceQuote(getId("answerSelectInputText4").value);
					getId("content_answer5").value = replaceQuote(getId("answerSelectInputText5").value);
					getId("content_answer6").value = replaceQuote(getId("answerSelectInputText6").value);
				}else{
					return false;
				}
				
			}else{//图片
				getId("content_answer1").value = getAnswerSelectImgSrc("answerSelect1");
				getId("content_answer2").value = getAnswerSelectImgSrc("answerSelect2");
				getId("content_answer3").value = getAnswerSelectImgSrc("answerSelect3");
				getId("content_answer4").value = getAnswerSelectImgSrc("answerSelect4");
				getId("content_answer5").value = getAnswerSelectImgSrc("answerSelect5");
				getId("content_answer6").value = getAnswerSelectImgSrc("answerSelect6");
			}
			//赋值最终答案到content_answer
			getRealAnswer();
			if(getId("questionType").value == "填空选择题"){
				var selectMaxNum_curr = $("#inputNumber").val();
				if(getId("content_answer").value == ""){
					alert("答案不能为空!");
					return false;
				}else if(getId("content_answer").value.split(",").length != selectMaxNum_curr){
					alert("当前你选择的答案数量和填空数量不匹配!");
					return false;
				}
			}
		}else if(getId("questionType").value == "问答题"){
			getId("content_answer").value = editor_answer.getContent();
		}else if(getId("questionType").value == "判断题"){
			getId("content_answer").value = returnRadioValue("answer_judge");
			getId("content_answer1").value = "对";
			getId("content_answer2").value = "错";
		}else if(getId("questionType").value == "填空题"){
			getId("content_answer").value = replaceQuote(getId("answer_inputText").value);
		}
		
		var contentAnswer = getId("content_answer").value;
		if(getId("questionType").value == "0"){
			alert("请选择题干类型");
			return false;
		}else{
			if(getId("dic").value == ""){
				alert("请输入关联词条!");
				getId("dic_new").focus();
				return false;
			}else if(getId("content_question").value == ""){
				alert("题干不能为空!");
				editor_question.focus();
				return false;
			}else if(checkInputTextAnswer(answer_select_type,getId("questionType").value) == false){
				return false;
			}else if(contentAnswer == ""){
				alert("答案不能为空!");
				return false;
			}else if(getId("questionType").value == "多选题" && contentAnswer.split(",").length == 1){
				alert("该体型为多选题，需要至少选择2个或2个以上的答案!");
				return false;
			}else if(getId("questionType").value == "多选题" && contentAnswer.split(",").length >= currSelectNum){
				alert("该体型为多选题，所选正确答案数必须小于你选择的最大选项数!");
				return false;
			}else if(getId("questionType").value == "多选题" && checkExistAnswer()){
				alert("多选题不能出现相同答案!");
				return false;
			}/**else if(getId("questionType").value == "多选题" && returnRadioValue("answer_match") == ""){
				alert("请选择答案匹配项!");
				return false;
			}**/else{
				changeHeightReset();
				//getId("answer_match").value = returnRadioValue("answer_match");
				return true;
			}
		}
	}
	//返回答案选项图片地址
	function getAnswerSelectImgSrc(obj){
		var currentAbsoluteImgSrc = $("#"+obj).attr("src");
		var oldImgSrc = "Module/loreManager/images/answerImgUpload.png";
		if(currentAbsoluteImgSrc == oldImgSrc){
			return "";
		}else{
			return currentAbsoluteImgSrc;
		}
	}
	//题干动作
	function showAnswer(option,obj){
		initNumber("answer_singel");
		initNumber("answer_multi");
		initNumber("answer_multi_tk");
		var questionType = "";
		if(option == "init"){
			questionType = obj;
		}else{
			questionType = obj.value;
		}
		if(questionType == "0"){
			//changeHeightPractice();
			getId("maxSelectDiv").style.display = "none";
			getId("multi_answer").style.display = "none";
			getId("radio_answer").style.display = "none";
			getId("judge_answer").style.display = "none";	
			getId("inputNumberDiv").style.display = "none";
			getId("inputText_anser").style.display = "none";
			getId("editorAns").style.display="none";
			getId("myEditor_answer").style.display = "none";
			getId("answerSelectDiv").style.display = "none";
		}else if(questionType == "单选题"){
			getId("maxSelectDiv").style.display = "";
			getId("multi_answer").style.display = "none";
			getId("radio_answer").style.display = "";
			getId("judge_answer").style.display = "none";	
			getId("inputNumberDiv").style.display = "none";
			getId("inputText_anser").style.display = "none";
			getId("editorAns").style.display="none";
			getId("myEditor_answer").style.display = "none";
			getId("answerSelectDiv").style.display = "";
		}else if(questionType == "多选题"){
			getId("maxSelectDiv").style.display = "";
			getId("multi_answer").style.display = "none";
			getId("multi_answer_tk").style.display = "";
			getId("radio_answer").style.display = "none";
			getId("judge_answer").style.display = "none";	
			getId("inputNumberDiv").style.display = "none";
			getId("inputText_anser").style.display = "none";
			getId("editorAns").style.display="none";
			getId("myEditor_answer").style.display = "none";
			getId("answerSelectDiv").style.display = "";
		}else if(questionType == "判断题"){
			window.top.$(".rightPart").height(1285);
			window.parent.$(".iframeWrap").height(1255);
			
			getId("maxSelectDiv").style.display = "none";
			getId("multi_answer").style.display = "none";
			getId("radio_answer").style.display = "none";
			getId("judge_answer").style.display = "";	
			getId("inputNumberDiv").style.display = "none";
			getId("inputText_anser").style.display = "none";
			getId("editorAns").style.display="none";
			getId("myEditor_answer").style.display = "none";
			getId("answerSelectDiv").style.display = "none";
		}else if(questionType == "问答题"){
			window.top.$(".rightPart").height(1605);
			window.parent.$(".iframeWrap").height(1565);
			
			getId("maxSelectDiv").style.display = "none";
			getId("multi_answer").style.display = "none";
			getId("radio_answer").style.display = "none";
			getId("judge_answer").style.display = "none";	
			getId("inputNumberDiv").style.display = "none";
			getId("inputText_anser").style.display = "none";
			getId("editorAns").style.display="";
			getId("myEditor_answer").style.display = "";
			getId("answerSelectDiv").style.display = "none";
		}else if(questionType == "填空题"){
			window.top.$(".rightPart").height(1285);
			window.parent.$(".iframeWrap").height(1255);
			
			getId("maxSelectDiv").style.display = "none";
			getId("multi_answer").style.display = "none";
			getId("radio_answer").style.display = "none";
			getId("judge_answer").style.display = "none";
			getId("inputNumberDiv").style.display = "";
			getId("inputText_anser").style.display = "";
			getId("editorAns").style.display="none";
			getId("myEditor_answer").style.display = "none";
			getId("answerSelectDiv").style.display = "none";
		}else if(questionType == "填空选择题"){
			getId("maxSelectDiv").style.display = "";
			getId("multi_answer").style.display = "none";
			getId("multi_answer_tk").style.display = "";
			getId("radio_answer").style.display = "none";
			getId("judge_answer").style.display = "none";	
			getId("inputNumberDiv").style.display = "";
			getId("inputText_anser").style.display = "none";
			getId("editorAns").style.display="none";
			getId("myEditor_answer").style.display = "none";
			getId("answerSelectDiv").style.display = "";
			//getId("answer_match_div").style.display = "none";
		}
	}
	//修改类型按钮动作
	function changeType(obj){
		questionType = obj.value;
		getId("question_type_new").value = questionType;
		getId("questionType").value = questionType;
		showAnswer("init",questionType);
		if(obj.value == "填空选择题"){
			var inputNumber = '${lq.answer}'.split(",").length;
			getId("inputNumber").value = inputNumber;
		}/**else{
			getId("answer_match_div").style.display = "block";
			var anserMatchOption = document.getElementsByName("answer_match");
			setSingleSelection(anserMatchOption,"1");
		}**/
	}
	//重置
	function reset(){
		window.location.reload();
	}
	//判断答案是否重复
	function checkExistAnswer(){
		var contentAnswer = getId("result_answer_tk_new").value;
		var answerArray = contentAnswer.split(",");
		var flag = false;
		for(var i = 0 ; i < answerArray.length; i++){
			for(var j = 0 ;j < answerArray.length ; j++){
				if(i == j){
					continue;
				}else{
					if(answerArray[i] == answerArray[j]){
						flag = true;
						break;
					}
				}
			}
			if(flag){
				break;
			}
		}
		return flag;
	}
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
				   	<div class="relateBox" id="changeTypeDiv" style="display:none">
					   	切换问题类型:
					   	<input type="button" id="changeTypeButton" value="" onclick="changeType(this)"/>
					   	<input type="button" id="resetBtn" value="恢复" onclick="reset()"/>
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
	   				<input type="radio" name="answer_select_type" id="answer_select_type_1" disabled value="1" onclick="radioOnclick();"><label for="answer_select_type_1">文字</label>
	   				<input type="radio" name="answer_select_type" id="answer_select_type_2" disabled value="2" onclick="radioOnclick();"><label  for="answer_select_type_2">图片</label>	
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
			   	<!-- 答案匹配 -->
			   	<!--div id="answer_match_div" style="display:none;">
			   		<span class="ansText"><font color=red>答案匹配项：</font></span>
			   		<label id="judge_answer_1" title="答案顺序完全匹配"><input type="radio" name="answer_match" id="answer_match_1" value="0" />完全匹配</label>
			   		<label id="judge_answer_1" title="答案顺序可以不一样"><input type="radio" name="answer_match" id="answer_match_2" value="1"/>顺序不匹配</label>
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
	   		<input type="hidden" id="action" name="action" value="updatePractice" />
	   		<input type="hidden" id="loreQuestionId" name="loreQuestionId" value="${requestScope.loreQuestionId}"/>
	   		<input type="hidden" id="loreId" name="loreId" value="${requestScope.loreId}"/>
	   		<input type="hidden" id="loreName" name="loreName" value="${requestScope.loreName }"/>
	   		<input type="hidden" id="title" name="title"/>
	   		<input type="hidden" id="dic" name="dic"/>
	   		<input type="hidden" id="orders" name="orders"/>
	   		<input type="hidden" id="loreNum" name="loreNum"/>
	   		<input type="hidden" id="loreType" name="loreType" value="${requestScope.loreTypeName}"/>
	   		<input type="hidden" id="questionType" name="questionType"/>
	   		<input type="hidden" id="questionType2" name="questionType2"/>
	   		<input type="hidden" id="content_tips" name="content_tips"/>
	   		<input type="hidden" id="content_question" name="content_question"/>
	   		<input type="hidden" id="content_answer" name="content_answer"/>
	   		<input type="hidden" id="answer_match" name="answer_match"/>
	   		<input type="hidden" id="content_answer1" name="content_answer1"/>
	   		<input type="hidden" id="content_answer2" name="content_answer2"/>
	   		<input type="hidden" id="content_answer3" name="content_answer3"/>
	   		<input type="hidden" id="content_answer4" name="content_answer4"/>
	   		<input type="hidden" id="content_answer5" name="content_answer5"/>
	   		<input type="hidden" id="content_answer6" name="content_answer6"/>
	   		
	   		<input type="hidden" id="content_analysis" name="content_analysis"/>
	   		<div class="tijiao">
	   			<input type="submit" value="提交" class="sub_btn" onclick="return check()"/>
	   			<input type="button" class="backBtn" value="返回上一级" onclick="backMain(${requestScope.loreId})"/>
	   		</div>
	   	</html:form>
   	</div>
  </body>
</html>