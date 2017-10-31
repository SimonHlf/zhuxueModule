//文本编辑器		
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

//替换选项中存在单引号为自定义字符，双引号为中文状态下的双引号,并去除空格
function convertEngToChi(value){
	return value.replace(/,/g,"，").replace(/\s+/g,"").replace(/"/g,"”").replace(/'/g,"&#wmd;");
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
//清空答案匹配项
function initAnswerMatchOption(){
	var sl = document.getElementsByName("answer_match");
	for(var i = 0 ; i < sl.length ; i ++){
		sl[i].checked = "";
	}
}
//题干动作
function showAnswer(obj){
	initNumber("answer_singel");
	initNumber("answer_multi");
	initNumber("answer_multi_tk");
	if(obj.value == "0"){
		changeHeightPractice();
		getId("maxSelectDiv").style.display = "none";
		getId("multi_answer").style.display = "none";
		getId("multi_answer_tk").style.display = "none";
		getId("radio_answer").style.display = "none";
		getId("judge_answer").style.display = "none";	
		getId("inputNumberDiv").style.display = "none";
		getId("inputText_anser").style.display = "none";
		getId("editorAns").style.display="none";
		getId("myEditor_answer").style.display = "none";
		getId("answerSelectDiv").style.display = "none";
		//getId("answer_match_div").style.display = "none";
		initAnswerMatchOption();
	}else if(obj.value == "单选题"){
		getId("maxSelectDiv").style.display = "";
		initMaxSelect();
		radioOnclick();
		getId("multi_answer").style.display = "none";
		getId("multi_answer_tk").style.display = "none";
		getId("radio_answer").style.display = "";
		getId("judge_answer").style.display = "none";	
		getId("inputNumberDiv").style.display = "none";
		getId("inputText_anser").style.display = "none";
		getId("editorAns").style.display="none";
		getId("myEditor_answer").style.display = "none";
		getId("answerSelectDiv").style.display = "";
		//getId("answer_match_div").style.display = "none";
		initAnswerMatchOption();
	}else if(obj.value == "多选题"){
		getId("maxSelectDiv").style.display = "";
		initMaxSelect();
		radioOnclick();
		getId("multi_answer").style.display = "";
		getId("multi_answer_tk").style.display = "none";
		getId("radio_answer").style.display = "none";
		getId("judge_answer").style.display = "none";	
		getId("inputNumberDiv").style.display = "none";
		getId("inputText_anser").style.display = "none";
		getId("editorAns").style.display="none";
		getId("myEditor_answer").style.display = "none";
		getId("answerSelectDiv").style.display = "";
		//getId("answer_match_div").style.display = "block";
	}else if(obj.value == "判断题"){
		judgeQueHei();
		getId("maxSelectDiv").style.display = "none";
		getId("multi_answer").style.display = "none";
		getId("multi_answer_tk").style.display = "none";
		getId("radio_answer").style.display = "none";
		getId("judge_answer").style.display = "";	
		getId("inputNumberDiv").style.display = "none";
		getId("inputText_anser").style.display = "none";
		getId("editorAns").style.display="none";
		getId("myEditor_answer").style.display = "none";
		getId("answerSelectDiv").style.display = "none";
		//getId("answer_match_div").style.display = "none";
		initAnswerMatchOption();
	}else if(obj.value == "问答题"){
		AnsQuesHeight();
		getId("maxSelectDiv").style.display = "none";
		getId("multi_answer").style.display = "none";
		getId("multi_answer_tk").style.display = "none";
		getId("radio_answer").style.display = "none";
		getId("judge_answer").style.display = "none";	
		getId("inputNumberDiv").style.display = "none";
		getId("inputText_anser").style.display = "none";
		getId("editorAns").style.display="";
		getId("myEditor_answer").style.display = "";
		getId("answerSelectDiv").style.display = "none";
		//getId("answer_match_div").style.display = "none";
		initAnswerMatchOption();
	}else if(obj.value == "填空题"){
		judgeQueHei();
		getId("maxSelectDiv").style.display = "none";
		getId("multi_answer").style.display = "none";
		getId("multi_answer_tk").style.display = "none";
		getId("radio_answer").style.display = "none";
		getId("judge_answer").style.display = "none";
		getId("inputNumberDiv").style.display = "";
		getId("inputText_anser").style.display = "";
		getId("editorAns").style.display="none";
		getId("myEditor_answer").style.display = "none";
		getId("answerSelectDiv").style.display = "none";
		//getId("answer_match_div").style.display = "none";
		initAnswerMatchOption();
	}else if(obj.value == "填空选择题"){
		getId("maxSelectDiv").style.display = "";
		initMaxSelect();
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
	clearAll();
}
//初始化最大选项框
function initMaxSelect(){
	singleMutiChoiceHei();
	getId("maxSelect").options[2].selected = "selected";
}
//最大选项动作
function showAnswer1(obj){
	var question_type = getId("question_type_new").value;
	if(question_type == "单选题"){
		setAnswerType("answer_singel",obj);
		setAnswerSelect(obj);
	}else if(question_type == "多选题"){
		setAnswerType("answer_multi",obj);
		setAnswerSelect(obj);
	}else if(question_type == "填空选择题"){
		setAnswerType("answer_multi_tk",obj);
		setAnswerSelect(obj);
	}
	clearAll();
	
}
//清空所有数据
function clearAll(){
	//清空答案
	clearRadioValue(0);
	clearCheckBoxValue(0);
	//清空答案选项
	clearInputTextValue(1); 
	clearAnswerSelectImgSrc(1);
	//清空答案结果
	result_answer = "";
	result_answer_text = "";
	//清空选中状态
	clearSelectStatus("answer_multi");
	clearSelectStatus("answer_singel");
	//清空复选框选择答案结果
	getId("result_answer_new").value = "";
	getId("result_answer_tk_new").value = "";
	getId("content_answer").value = "";
}
//清空单选框复选框选中状态
function clearSelectStatus(obj){
	var selectOptions = document.getElementsByName(obj);
	for(var i = 0 ; i < selectOptions.length ; i++){
		selectOptions[i].checked = false;
	}
}
//单选多选框数量
function setAnswerType(name,obj){
	for(var j = 1 ; j <= parseInt(obj.value); j++){
		getId(name+"_"+j).style.display = "";
	}
	for(var i = parseInt(obj.value) + 1; i < 7;i++){
		getId(name+"_"+i).style.display = "none";
	}
}
//答案选项图片上传个数/答案选项文字输入框上传个数
function setAnswerSelect(obj){
	for(var j = 1 ; j <= parseInt(obj.value); j++){
		
		//getId("answerSelect"+j).style.display = "";
		getId("answerSelWrap"+j).style.display="";
		getId("inputText_answer_"+j).style.display = "";
	}
	for(var i = parseInt(obj.value) + 1; i < 7;i++){
		
		//getId("answerSelect"+i).style.display = "none";
		getId("answerSelWrap"+i).style.display="none";
		getId("inputText_answer_"+i).style.display = "none";
	}
	clearAll();
}
//单项框选中事件
function radioOnclick(){
	if(returnRadioValue("answer_select_type") == 1){//文字盒子的显示
		singleMutiChoiceHei();
		getId("answerSelect").style.display = "none";
		getId("answerSelectInputText").style.display = "";
	}else{//图片盒子的显示
		singleMutiChoiceHeiImg();
		getId("answerSelect").style.display = "";
		getId("answerSelectInputText").style.display = "none";
	}
	clearAll();
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
			alert("请先选择答案选项，然后再选择答案!");
			obj.checked = false;
		}
	}
}

//复选框答案返回值
function addItem(obj,number){
	var question_type = getId("question_type_new").value;
	if(obj.checked == true){
		if(obj.value == ""){
			alert("请先选择答案选项，然后再选择答案!");
			obj.checked = false;
		}else{
			if(question_type == "多选题"){
				if(result_answer_text.split(",").length < getId("maxSelect").value){
					result_answer += obj.value + ",";
					result_answer_text += obj.id + ",";
				}else{
					alert("该题型所选答案数量必须小于最大选项数量!");
					obj.checked = false;
				}
			}else{
				result_answer += obj.value + ",";
				result_answer_text += obj.id + ",";
			}
			
		}
	}else{
		result_answer = result_answer.replace(obj.value + ",","");
		result_answer_text = result_answer_text.replace(obj.id + ",","");
	}
	getId("result_answer_new").value = result_answer_text.substring(0,result_answer_text.length - 1);
	//getId("content_answer").value = result_answer.substring(0,result_answer.length - 1);
}
//检查填空数量是否大于/等于你选择的答案
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
//答案选择框返回值（填空选择题）
function addItemTk(obj,number){
	var selectMaxNum = $("#inputNumber").val();
	if(obj.alt == ""){
		alert("请先输入答案选项，然后再选择答案!");
	}else{
		if(checkSelectNum()){
			result_answer += obj.alt + ",";
			result_answer_text += obj.value + ",";
		}else{
			alert("当前所选答案累计数超过所选填空数量!");
		}
	}
	getId("result_answer_tk_new").value = result_answer_text.substring(0,result_answer_text.length - 1);
	getId("content_answer").value = result_answer.substring(0,result_answer.length - 1);
}
//初始化单选框多少框(默认4个框)
function initNumber(name){
	for(var j = 1 ; j <= 4; j++){
		getId(name+"_"+j).style.display = "";
		//getId("answerSelect"+j).style.display = "";
		getId("answerSelWrap"+j).style.display="";
		getId("inputText_answer_"+j).style.display = "";
	}
	for(var i = 5; i < 7;i++){
		
		getId(name+"_"+i).style.display = "none";
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
		UE.getEditor("myEditor_answer_select").setContent("",null);
	}else{
		UE.getEditor("myEditor_answer_select").setContent(content_img,null);
	}
	
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
			options2[i-1].alt = "";
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
		options[i-1].value = convertEngToChi(obj.value);
	}else if(question_type == "多选题"){
		var options1 = document.getElementsByName("answer_multi");
		options1[i-1].value = convertEngToChi(obj.value);
	}else if(question_type == "填空选择题"){
		$("input[name='answer_multi_tk']").eq(i-1).attr("alt",convertEngToChi(obj.value));
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
	}
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
//复选框返回值（多选题/填空选择题）（按照选择的先后顺序返回value值）
function getMutiRealAnswer(){
	var question_type = getId("question_type_new").value;
	var realAnswer = "";
	if(question_type == "多选题"){
		realAnswer = getId("result_answer_new").value;
	}else{
		realAnswer = getId("result_answer_tk_new").value;
	}
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
					realAnswerResult += convertEngToChi(getId(variateSuffix+number).value);
				}
			}else{
				if(variateSuffix == "answerSelect"){//图片
					var optionAnswerSrc = getId(variateSuffix+number).src;
					var answerLength = optionAnswerSrc.length;
					var simplification_answer_select = optionAnswerSrc.substring(optionAnswerSrc.indexOf("lore/")+5,answerLength);
					realAnswerResult += simplification_answer_select + ",";
				}else{
					realAnswerResult += convertEngToChi(getId(variateSuffix+number).value) + ",";
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


//提交清单
function check(){
	getId("title").value = getId("questionTitle").value;
	getId("questionType").value = getId("question_type_new").value;
	getId("questionType2").value = getId("question_type2_new").value;
	getId("dic").value = getId("dic_new").value;
	getId("content_question").value = editor_question.getContent();
	getId("content_tips").value = editor_tips.getContent();
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
				getId("content_answer1").value = convertEngToChi(getId("answerSelectInputText1").value);
				getId("content_answer2").value = convertEngToChi(getId("answerSelectInputText2").value);
				getId("content_answer3").value = convertEngToChi(getId("answerSelectInputText3").value);
				getId("content_answer4").value = convertEngToChi(getId("answerSelectInputText4").value);
				getId("content_answer5").value = convertEngToChi(getId("answerSelectInputText5").value);
				getId("content_answer6").value = convertEngToChi(getId("answerSelectInputText6").value);
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
		if(getId("questionType").value == "单选题"){
			getId("content_answer").value = returnRadioValue("answer_singel");
		}else if(getId("questionType").value == "多选题"){
			getMutiRealAnswer();
			//getId("content_answer").value = getId("content_answer").value.replace(/\s+/g,"");
		}else if(getId("questionType").value == "填空选择题"){
			var selectMaxNum_curr = $("#inputNumber").val();
			getMutiRealAnswer();
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
		getId("content_answer").value = convertEngToChi(getId("answer_inputText").value);
	}
	
	getId("content_analysis").value = editor_caution.getContent();
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
		}/**else if(getId("questionType").value == "多选题" && returnRadioValue("answer_match") == ""){
			alert("请选择答案匹配项!");
			return false;
		}**/else{
			changeHeightPractice();
			//getId("answer_match").value = returnRadioValue("answer_match");
			return true;
		}
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