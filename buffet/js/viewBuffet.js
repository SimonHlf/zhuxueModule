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
	//复选框默认选中状态
	function setMultSelecttion(typeName,value){
		if(value != ""){
			var valueArray = value.split(":");
			$.each(valueArray, function (index, item) {
				 $("input[name='"+typeName+"']").each(function () {
					 if ($(this).val() == item) {
						 $(this).attr("checked",true);
					 }
				 });
			});
		}
	}
	//复选框返回值（针对思维和能力类型使用）
	function returnCheckBoxValue(obj){
		var option =  document.getElementsByName(obj);
		var value = "";
		for(var i = 0 ; i < option.length ; i++){
			if(option[i].checked){
				value  +=  option[i].value + ":";
			}
		}
		if(value != ""){
			value = value.substring(0, value.length - 1);
		}
		return value;
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
	//在buffet表中获取该章节下该类型的题数量
	function getSubjectList(buffetTypeId){
		var buffetCount = 0;
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        url:"buffetManager.do?action=getLastNumByOption&loreId="+loreId+"&basicBuffetTypeId="+buffetTypeId,
	        success:function (json){
	        	buffetCount = json;
	        }
	    });
		return buffetCount;
	}
	//选择基础类型触发的动作【暂时不用】
	function getBasicBuffetType(buffetTypeId,buffetTypeName){
		if(buffetTypeId == 0){
			alert("请选择基础类型!");
		}else{
			//在buffet表中获取该章节下该类型的题数量
			if(buffetTypeId != buffetType){
				currentBuffetCount = getSubjectList(buffetTypeId) + 1;
			}else{
				currentBuffetCount = getSubjectList(buffetTypeId);
			}
			getId("questionTitle").value = buffetTypeName+"第"+currentBuffetCount+"题";
			getId("buffetNum").value = currentBuffetCount;
			getId("buffetTypeName").value = buffetTypeName;
			getId("buffetTypeId").value = buffetTypeId;
			
		}
	}
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
			}
			return "character";
		}else{
			if(questionType == "单选题" || questionType == "多选题" || questionType == "填空选择题"){
				answerType = "pic";
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
	//清空答案选项图像中内容（初始化为Module/buffet/images/answerImgUpload.png）
	function clearAnswerSelectImgSrc(startNumber){
		for(var i = startNumber; i < 7 ; i++){
			getId("answerSelect"+i).src = "Module/buffet/images/answerImgUpload.png";
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
			singleMutiChoiceHeiEdit();
		}else{//图片盒子的显示
			singleMutiChoiceHeiImgEidt();
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
				break;
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
			
		}
		//答案选项图片上传个数/答案选项文字输入框上传个数
		setAnswerSelect(obj);
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
			getId(answerSelectImg).src = "Module/buffet/images/answerImgUpload.png";
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
		//思维类型和能力类型返回值
		getId("buffetTypeMindId").value = returnCheckBoxValue("buffetTypeMind");
		getId("buffetTypeAbilityId").value = returnCheckBoxValue("buffetTypeAbility");
		getId("subTitle").value = getId("questionTitle").value;
		getId("questionType").value = questionType;
		getId("loreDicId").value = getId("dic_new").value;
		//getId("buffetNum").value = currentBuffetCount;
		getId("content_question").value = editor_question.getContent();
		getId("content_tips").value = editor_tips.getContent();
		getId("content_analysis").value = editor_caution.getContent();
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
			if(getId("loreDicId").value == ""){
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
			}else{
				changeHeightReset();
				return true;
			}
		}
	}
	//返回答案选项图片地址
	function getAnswerSelectImgSrc(obj){
		var currentAbsoluteImgSrc = $("#"+obj).attr("src");
		var oldImgSrc = "Module/buffet/images/answerImgUpload.png";
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
			singleMutiChoiceHeiEdit();
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
			singleMutiChoiceHeiEdit();
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
			judgeQueHei();
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
			AnsQuesHeight();
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
			judgeQueHei();
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
			singleMutiChoiceHeiEdit();
			radioOnclick();
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
		}
	}
	//修改类型按钮动作
	function changeType(obj){
		questionType = obj.value;
		getId("question_type_new").value = questionType;
		getId("questionType").value = questionType;
		showAnswer("init",questionType);
		if(obj.value == "填空选择题"){
			var inputNumber = '${buffet.answer}'.split(",").length;
			getId("inputNumber").value = inputNumber;
		}
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