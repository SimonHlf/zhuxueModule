//获取题库数据信息列表
function getQuestionList(){
	$.ajax({
		  type:"post",
		  async:true,
		  dataType:"json",
		  data:{loreId:loreId,studyLogId:studyLogId,nextLoreIdArray:nextLoreIdArray,loreTypeName:escape(loreTypeName),access:access},
		  url:"studyApp.do?action=loadQuestionList&cilentInfo=app",
		  beforeSend:function(){
        	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		  },
		  success:function (json){ 
			  showLoreQuestionList(json["lqList"]);
		  },
		  complete:function(){
        	$("#loadDataDiv").hide();
        	$(".loadingIcon").remove();
          }
	});
}

//显示题库数据列表
function showLoreQuestionList(list){
	if(list != null){
		questionLength = list.length;
		var index_ul = "<ul id='indexNumber' class='tabNav clearfix'></ul>";//题库序列号ul
		$("#botCard").append(index_ul);
		var question_ul = "<ul id='questionList'></ul>";//题库列表ul
		$("#questionInfo").html(question_ul);
		for(var i = 0 ; i < questionLength ; i++){
			var index = i + 1;
			//底部题号
			var li_index = "";
			if(index == 1){
				li_index =  "<li id='queIndex_"+index+"' class='quesNum active removeAFocBg' ontouchend='showQuestionByIndex("+index+")'>"+"<span>"+index+"</span></li>";//题库序列号li
			}else{
				li_index =  "<li id='queIndex_"+index+"' class='quesNum removeAFocBg' ontouchend='showQuestionByIndex("+index+")'>"+"<span>"+index+"</span></li>";//题库序列号li
			}
			$("#indexNumber").append(li_index);
			//核心区域内容
			var li_question = "";
			if(index == 1){
				li_question = "<li id='question_"+index+"' class='questionClass' style='opacity:1;'></li>";//题库列表li-显示
			}else{
				li_question = "<li id='question_"+index+"' class='questionClass'></li>";//题库列表li-隐藏
			}
			$("#questionList").append(li_question);
			//--------题库列表(问题)---------//
			var question_start_dl = "<div id='questionWrap_"+ index +"' class='questionWrap'><div class='scroller'>";
			//题号,题类型,题目标题
			var question_typeList_dd = "<div class='loreTypeTit clearfix'><span class='loreTypeNum fl'>"+index+"</span><span class='loreTypeTxt fl'>"+list[i].loreQuestion.questionType+"<em></em><i></i></span><div class='quesTit fl'>"+list[i].loreQuestion.subject+"</div></div>";
			var question_option_dd = "<div id='questionOption_"+index+"' class='optionDd'><div id='quesSonOption_"+index+"' class='queSonOpt'></div><div id='answerOption_"+index+"' class='answerOptions'></div><div id='ansQuesWrap_"+ index +"' style='display:none;'></div><div id='myAnsOpts_"+index+"' style='display:none;' class='myAnsOpt'><span id='myAnsOptsSpan_"+ index +"' class='iconStaeSpan'></span></div></div>";//题库答案选项
			var question_end_dl = "</div></div>";
			var question_submit_dd = "<div id='questionSubmit_"+index+"' class='submitOption'></div>";
			$("#question_"+index).append(question_start_dl + question_typeList_dd + question_option_dd  + question_end_dl + question_submit_dd);
			
			//生成随机答案选项数组(将随机答案选项添加到questionOption__index的dd标签中)
			var answerOptionArray = new Array();
			if(list[i].realAnser != ""){//如果是已经做过的题，就不需要在随机排列
				answerOptionArray = assignToArray(list[i].loreQuestion.a,list[i].loreQuestion.b,list[i].loreQuestion.c,list[i].loreQuestion.d,list[i].loreQuestion.e,list[i].loreQuestion.f);
			}else{//如果是没有做过的题，就需要将选项进行随机排列
				answerOptionArray = radomAnswerArray(assignToArray(list[i].loreQuestion.a,list[i].loreQuestion.b,list[i].loreQuestion.c,list[i].loreQuestion.d,list[i].loreQuestion.e,list[i].loreQuestion.f));
			}
			var j = 0;
			var answerA = "";
			var answerB = "";
			var answerC = "";
			var answerD = "";
			var answerE = "";
			var answerF = "";
			if(list[i].loreQuestion.a != ""){
				
				if(checkAnswerImg(list[i].loreQuestion.a)){
					answerA = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerA = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=1_"+index+" ids='nameSpan_"+index+"_A'>A</span><p class='optionDetailTxt lineBreak'>"+answerA + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].loreQuestion.b != ""){
				
				if(checkAnswerImg(list[i].loreQuestion.b)){
					answerB = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerB = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=2_"+index+" ids='nameSpan_"+index+"_B'>B</span><p class='optionDetailTxt lineBreak'>"+answerB + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].loreQuestion.c != ""){
				
				if(checkAnswerImg(list[i].loreQuestion.c)){
					answerC = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerC = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=3_"+index+" ids='nameSpan_"+index+"_C'>C</span><p class='optionDetailTxt lineBreak'>" + answerC + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].loreQuestion.d != ""){
				
				if(checkAnswerImg(list[i].loreQuestion.d)){
					answerD = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerD = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=4_"+index+" ids='nameSpan_"+index+"_D'>D</span><p class='optionDetailTxt lineBreak'>" + answerD + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].loreQuestion.e != ""){
				
				if(checkAnswerImg(list[i].loreQuestion.e)){
					answerE = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerE = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=5_"+index+" ids='nameSpan_"+index+"_E'>E</span><p class='optionDetailTxt lineBreak'>" + answerE + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].loreQuestion.f != ""){
				
				if(checkAnswerImg(list[i].loreQuestion.f)){
					answerF = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerF = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=6_"+index+" ids='nameSpan_"+index+"_F'>F</span><p class='optionDetailTxt lineBreak'>" + answerF + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			

			var answerNumber = 0;
			var questionType_flag = false;
			if(list[i].loreQuestion.questionType == "问答题" || list[i].loreQuestion.questionType == "填空题"){
				$("#ansQuesWrap_"+index).show();
				$("#questionOption_"+index).css({"padding-left":0,"padding-right":0});
				questionType_flag = true;
				answerNumber = 1;//只有错和对，所以赋值1;
				var ts_span = "<div id='tishi_"+index+"' class='tishiBox'><span class='tishiIcon'></span>请拿出纸和笔验算一下，这道题考察的是你的解题规范和解题步骤，要认真验算！得出结果后点击验算完成即可</div>";
				var realAsnwer_result_title_div = "<div id='realAnswer_result_"+index+"' style='display:none;' class='optionParent clearfix'>";
				realAsnwer_result_title_div += "<div class='relRightAnsBox lineBreak clearfix'><span class='relRightAnsTxt fl'>正确答案：</span><div class='fl'>"+replaceChara(list[i].loreQuestion.answer)+"</div></div>";
				realAsnwer_result_title_div += "<div class='myRealAnsBox'><span class='relRightAnsTxt fl'>我的答案：</span>";
				realAsnwer_result_title_div += "<div class='optionBox_Que'><input class='optionRadio_ques' type='radio' name='answer_option_radio_"+index+"1' value='1'/><span class='rightSpan'>对</span></div><div class='optionBox_Que'><input class='optionRadio_ques' type='radio' name='answer_option_radio_"+index+"1' value='0'/><span class='errorSpan'>错</span></div>";
				realAsnwer_result_title_div += "<span class='warnningIcon'></span><span class='choiceTxt'>请如实选择</span></div>";
				realAsnwer_result_title_div += "</div>";
				var realAnswer_div = "<div id='realAnswer_"+index+"' class='relAnsBox'>"+realAsnwer_result_title_div+"</div>";
				var myAnsResult_div = "<div id='myAnsResultBox_"+ index +"' class='myAnsRes clearfix'></div>";
				$("#ansQuesWrap_"+index).append(ts_span + realAnswer_div + myAnsResult_div);
			}else{
				questionType_flag = false;
				//(2016-04-06增加)
				if(list[i].loreQuestion.questionType == "多选题"){
					answerNumber = 1;
				}else{
					answerNumber = list[i].loreQuestion.answer.split(",").length;//得到有几个正确答案，确定有几组答案选项
				}
				for(var k = 1 ; k <= answerNumber ; k++){
					var number_new = index + "" + k;
					var option_div = "<div id='option_div_"+number_new+"' class='optionPar clearfix'></div>";
					var answer_span = "<span class='optionTxt fl'>选项"+k+":</span>"; 
					var answer_mainCon = "<div id='answer_optionPar_span_"+number_new+"' class='spanOptionPar fl'>";
					if(list[i].loreQuestion.questionType == "填空选择题"){//如果是填空选择题需要根据该题目有几个填空或者有几组选项来动态创建每组对应的父级div 类名：optionParent
						$("#answerOption_"+index).removeClass("answerOptions").addClass("answerOptions_space").append(option_div);
						$("#option_div_"+number_new).append(answer_span + answer_mainCon);
						$("#myAnsOpts_"+index).show();//如果是填空选择题将我的解答给显示出来
					}
					var jj = 0;
					for(var ii = 1 ; ii <= j ; ii++){
						var spanNumber = k + "" + ii + "_" + index;
						var answer_option_span = "<div id='answer_option_span_"+spanNumber+"' class='optionBox'></div>"; //填空选择题下使用
						var input_radio_value = answerOptionArray[jj++];
						var input_radio = "";
						
						if(list[i].loreQuestion.questionType == "多选题"){//(2016-04-06增加)
							input_radio = "<label class='comChoiceLabel removeAFocBg' name='comLabelName_"+ index +"' ontouchend=choiceOption('"+list[i].loreQuestion.questionType+"',"+ ii +","+index+")><input type='checkbox' class='optionCheckBox' id='answer_option_radio_"+ index +"_"+ii+"' name='answer_option_radio_"+number_new+"' value='"+input_radio_value+"'/></label>";
						}else if(list[i].loreQuestion.questionType == "填空选择题"){
							input_radio = "<input type='radio' id='answer_option_radio_"+ index +"_"+ii+"' class='spaceAnsRadio' name='answer_option_radio_"+number_new+"' value='"+input_radio_value+"'/>";
						}else{//单选题
							input_radio = "<label class='comChoiceLabel removeAFocBg' name='comLabelName_"+ index +"' ontouchend=choiceOption('"+list[i].loreQuestion.questionType+"',"+ ii +","+index+")><input type='radio' class='optionRadio_sigle' id='answer_option_radio_"+ index +"_"+ii+"' name='answer_option_radio_"+number_new+"' value='"+input_radio_value+"'/></label>";
						}
						
						if(list[i].loreQuestion.questionType == "填空选择题"){
							var input_lable_value_space = "<span id='answer_option_label_"+spanNumber+"' class='spacSpanLabel'>"+ transOption(ii) +"</span>";
						}else{
							var input_lable_value = "<span id='answer_option_label_"+spanNumber+"' style='display:none;'>"+ transOption(ii) +"</span>";
						}
						if(list[i].loreQuestion.questionType == "单选题" || list[i].loreQuestion.questionType == "多选题" || list[i].loreQuestion.questionType == "判断题"){
							$("#answerOption_"+index).removeClass("answerOptions_space").addClass("answerOptions").append(input_radio + input_lable_value);
						}else if(list[i].loreQuestion.questionType == "填空选择题"){
							//如果是填空选择题需要根据该题目有几个填空或者有几组选项来动态创建每组对应的父级div 类名：optionParent
							$("#answer_optionPar_span_"+number_new).append(answer_option_span);
							$("#answer_option_span_"+spanNumber).append(input_radio + input_lable_value_space);
						}
						
					}
					//多选题选择的答案(2016-04-06增加)
					var selectAnserValue = "<input type='hidden' id='selectMultAnsesr_"+index+"'/>";
					var selectLabelAnserValue = "<input type='hidden' id='selectLabelMultAnsesr_"+index+"'/>";
					if(list[i].loreQuestion.questionType == "多选题"){
						$("#answerOption_"+index).append(selectAnserValue+selectLabelAnserValue);
					}
				}
			}
			//提交动作和显示结果
			var loreQuestionId_input_value = "<input type='hidden' id='loreQuestionId_input_"+index+"' value='"+list[i].loreQuestion.id+"'/>";
			var mySelectAnswer_lable_value = "<input type='hidden' id='mySelectAnswer_lable_"+index+"'/>";//自己选择的答案lable
			var mySelectAnswer_input_value = "<input type='hidden' id='mySelectAnswer_input_"+index+"'/>";//自己选择的答案value
			var right_answer_lable_value = "<input type='hidden' id='right_answer_lable_"+index+"'/>";//正确的答案lable
			var right_answer_input_value = "<input type='hidden' id='right_answer_input_"+index+"'/>";//正确的答案value
			var submit_div = "<div id='tijiao_"+index+"' class='submitDiv' style='display:no-ne'>";
			var answer_dataBase = list[i].loreQuestion.answer.replace(",","-my-fen-ge-fu-");
			var answer_array = arrayToJson(answerOptionArray);
			var currentLoreId = list[i].loreQuestion.lore.id;
			submit_div += "<span class='goNextBtn' ontouchend=submitAnswer("+ currentLoreId +","+index+","+answerNumber+","+studyLogId+",'"+encodeURIComponent(encodeURIComponent(answer_array))+"','"+list[i].loreQuestion.questionType+"')>提交</span>";
			//我要纠错暂时不做
			//submit_div += "<a href='javascript:void(0)' class='submitErrorA' onclick=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")>我要纠错</a>";
			submit_div += "<a href='javascript:void(0)' class='submitErrorA' ontouchend=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")></a>";
			submit_div += "</div>";
			
			var showButton_div = "<div id='showResult_"+index+"' class='submitDiv' style='display:none;'>";
			//问答题填空题显示答案
			showButton_div += "<span class='goNextBtn removeAFocBg' ontouchend='showResult("+index+");'>验算完成</span>";
			//问答题填空题下验算完成对应的我要纠错
			showButton_div += "<a href='javascript:void(0)' class='submitErrorA' ontouchend=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")></a>";
			showButton_div += "</div>";
			var nextButton_div = "<div id='next_button_div_"+index+"' class='submitDiv' style='display:none;'>";
			var nextNumber = index+1;
			nextButton_div += "<span class='goNextBtn removeAFocBg' ontouchend='nextQuestion("+nextNumber+")'>进入下一题</span>";
			//我要纠错暂时不需
			//nextButton_div += "<a href='javascript:void(0)' class='submitErrorA' onclick=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")>我要纠错</a>";
			nextButton_div += "<a href='javascript:void(0)' class='submitErrorA' ontouchend=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")></a>";
			nextButton_div += "</div>";
			var resultButton_div = "";
			if(i == questionLength - 1){//表示是最后一题
				resultButton_div = "<div id='result_button_div'  class='submitDiv' style='display:none;'>";
				resultButton_div += "<span class='goNextBtn removeAFocBg' ontouchend='lastSubmitAnswer("+currentLoreId+")'>做完了</span>";
				//我要纠错暂时不需要
				//resultButton_div += "<a href='javascript:void(0)' class='submitErrorA' onclick=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")>我要纠错</a>";
				resultButton_div += "<a href='javascript:void(0)' class='submitErrorA' ontouchend=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")></a>";
				resultButton_div += "</div>";	
			}
			//提交答案
			$("#questionSubmit_"+index).append(loreQuestionId_input_value+mySelectAnswer_lable_value+submit_div+showButton_div+nextButton_div+resultButton_div);
			//计算提交按钮的宽度
			$(".submitDiv").width(cliWid - $(".showHideBtn").width() - 20);
			$(".goNextBtn").width($(".submitDiv").width() - $(".submitErrorA").width()-10);
			//$(".submitDiv").width(cliWid - 20);
			
			if(questionType_flag){//表示是问答和填空题
				//隐藏首次的提交按钮，并且需要自定义按钮
				$("#tijiao_"+index).hide();
				$("#showResult_"+index).show();
			}else{
				$("#tijiao_"+index).show();
				$("#showResult_"+index).hide();
			}
			if(list[i].realAnser != ""){//做过的题
				var questionType_temp = list[i].loreQuestion.questionType;
				completeNum++;
				//列出答案和我的答案
				if(list[i].result == 1){//正确
					if(questionType_temp == "填空选择题"){
						$("#myAnsOpts_"+index).prepend("<span class='myAnsTxt'>我的解答：" + list[i].myAnswer + "</span>");
						$("#myAnsOptsSpan_"+index).addClass("rightStateSpan").removeClass("errStateSpan");
						$("#answerOption_"+index).hide();//隐藏选项
					}else if(questionType_temp == "多选题"){
						var myAnswerArray = list[i].myAnswer.split(",");
						for(var kk = 1 ; kk <= myAnswerArray.length ; kk++){
							var optionIndex_new = transOption_1(myAnswerArray[kk - 1]);
							$("#"+optionIndex_new+"_"+index).addClass("rightState");
						}
					}else if(questionType_temp == "问答题" || questionType_temp == "填空题"){
						$("#realAnswer_"+index).hide();
						$("#tishi_"+index).hide();
						$("#myAnsResultBox_"+index).css({"padding":10}).append("<span class='fl'>我的解答："+list[i].myAnswer +"</span><span class='iconState_suc'></span>");
					}else{
						var optionIndex = transOption_1(list[i].myAnswer);
						$("#"+optionIndex+"_"+index).removeClass("choice_act").addClass("rightState");
					}
					currentAllQuestionFlag *= 1;
					totalMoney++;
					$(".quesNum").eq(i).css("border-color","#64ccf2");
					$(".quesNum span").eq(i).addClass("rightState_queNum");
				}else{//错误
					if(questionType_temp == "填空选择题"){
						 $("#myAnsOpts_"+index).prepend("<span class='myAnsTxt'>我的解答：" + list[i].myAnswer + "</span>");
						 $("#myAnsOptsSpan_"+index).addClass("errStateSpan").removeClass("rightStateSpan");
						 $("#answerOption_"+index).hide();//隐藏选项
					}else if(questionType_temp == "多选题"){
						var myAnswerArray = list[i].myAnswer.split(",");
						for(var kk = 1 ; kk <= myAnswerArray.length ; kk++){
							var optionIndex_new = transOption_1(myAnswerArray[kk - 1]);
							$("#"+optionIndex_new+"_"+index).addClass("errorState");
						}
					}else if(questionType_temp == "问答题" || questionType_temp == "填空题"){
						$("#realAnswer_"+index).hide();
						$("#tishi_"+index).hide();
					   	$("#myAnsResultBox_"+index).css({"padding":10}).append("<span class='fl'>我的解答："+list[i].myAnswer +"</span><span class='iconState_err'></span>");
					}else{
						var optionIndex = transOption_1(list[i].myAnswer);
						$("#"+optionIndex+"_"+index).removeClass("choice_act").addClass("errorState");
					}
					currentAllQuestionFlag *= 0;
					$(".quesNum").eq(i).css("border-color","#fb5151");
					$(".quesNum span").eq(i).addClass("errorState_queNum");
				}
				$("label[name='comLabelName_"+index+"']").removeAttr("ontouchend");
				$("#tijiao_"+index).hide();//隐藏提交按钮DIV
				$("#showResult_"+index).hide();//隐藏提交(显示答案)按钮DIV
				if(i == questionLength - 1){//表示是最后一题
					$("#result_button_div").show();//显示最后总提交按钮DIV
				}else{
					$("#next_button_div_"+index).show();//显示下一题按钮DIV
				}
				lastCommitNumber++;
			}
			
		}
	}	
	quesScroll(1); //初始化对默认第一个li列表加载isroll
	$(".queNumSpan").html(completeNum + "/"+questionLength);
	$(".proBarDiv").width($("#innerProBarDiv").width() - $(".queNumSpan").width() - 19);
	$("#botCard").css({"width":cliWid - $(".closeBot").width()});
	$("#indexNumber").width($(".quesNum").eq(0).outerWidth() * questionLength + questionLength*10 + 2);
	if($("#indexNumber").width() > $("#botCard").width()){
		$(".shadow").show();
	}else{
		$(".shadow").hide();
	}
	perScale = completeNum / questionLength;
	$(".rateLine").css({"width":perScale*$(".proBarDiv").width()});
	if(completeNum == questionLength){ //把做题进度条最后的旗帜给点亮
		$(".finalDiv").removeClass("finalCol").addClass("finalCol_open");
		$(".finalFlag").css({"opacity":1});
	}
	$("#botCardBox").css({"bottom":-$("#botCardBox").height()});
	$(".questionClass").width(cliWid);
	$("#questionList").css({
		"width":cliWid * questionLength,
		"height":($("#mainQuesWrap").height() - $("#proBarWrap").height())
	});
	$(".questionWrap").height($("#questionList").height() - $(".submitOption").height());
	//动态设置每个选项的高度和ABCDEF对应的行高
	setOptionHei();
	choiceOptionAns($(".spaceAnsRadio"),"current");
}
//防止重复做题
//防止重复提交
function checkStudyStatus(loreTaskName,studyLogId,loreQuestionId){
	 var flag = false;
	 $.ajax({
			type : "post",
			async:false,
			dataType : "json",
			data:{loreTaskName:loreTaskName,studyLogId:studyLogId,loreQuestionId:loreQuestionId},
			url : "studyOnline.do?action=checkStudyStatus",
			success : function(json) {
				flag = json["success"];
			}
		});
	 return flag;
}

//提交做题
function submitAnswer(currentLoreId,value,answerNumber,studyLogId,answerOptionArray,questionType){
	//向答案结果DIV中添加元素
	//先判断有误选择答案
	//var real_answer = answer_dataBase.replace("-my-fen-ge-fu-",",");
	if(checkLoginStatus()){
		var loreQuestionId = $("#loreQuestionId_input_"+value).val();
		var selectAnserValue_result = "";
		var selectAnserLableValue_result = "";
		var flag = false;
		var studyFlag = checkStudyStatus(loreTaskName,studyLogId,loreQuestionId);
		if(studyFlag == "true"){
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("做题太快<br/>休息一下再做");
			commonTipInfoFn($(".warnInfoDiv"));
	}else{
			//(2016-04-06增加)
			var regS = new RegExp("\\Module/commonJs/ueditor/jsp/lore/","g");//替换所有带特殊符号的字符串
			if(questionType == "多选题"){
				var selectMultAnserValue = $("#selectMultAnsesr_"+value).val();
				if(selectMultAnserValue == ""){
					//清空数据
					$(".succImg").hide();
					$(".tipImg").show();
					$("#warnPTxt").html("请选择答案");
					commonTipInfoFn($(".warnInfoDiv"));
					selectAnserValue_result = "";
					selectAnserLableValue_result = "";
					flag = false;
				}else{
					if(checkAnswerImg(selectMultAnserValue)){
						//替换所有
						selectAnserValue_result += selectMultAnserValue.replace(regS,"") + ",";
					}else{
						selectAnserValue_result += selectMultAnserValue + ",";
					}								 
					selectAnserLableValue_result = $("#selectLabelMultAnsesr_"+value).val() + ",";
					
					flag = true;
				}
			}else{
				for(var i = 1 ; i <= answerNumber ; i++){
					var selectAnserValue = $("input[name='answer_option_radio_"+value+i+"']:checked").val();
					if(selectAnserValue == undefined){
						$(".succImg").hide();
						$(".tipImg").show();
						$("#warnPTxt").html("请选择答案");
						commonTipInfoFn($(".warnInfoDiv"));
						//清空数据
						selectAnserValue_result = "";
						selectAnserLableValue_result = "";
						flag = false;
						break;
					}else{
						if(checkAnswerImg(selectAnserValue)){
							selectAnserValue_result += selectAnserValue.replace(regS,"") + ",";
						}else{
							selectAnserValue_result += selectAnserValue + ",";
						}
						//12-28新修改6
						if(questionType == "问答题" || questionType == "填空题"){
							if(selectAnserValue_result == "1,"){
								selectAnserLableValue_result = "回答正确,";
							}else{
								selectAnserLableValue_result = "回答错误,";	
							}
						}else{
							var selectAnserRadioId = $("input[name='answer_option_radio_"+value+i+"']:checked").attr("id");
							var number1 = i;
							var number2 = selectAnserRadioId.replace("answer_option_radio_"+value+"_","");
							selectAnserLableValue_result += $("#answer_option_label_"+number1 + "" + number2+"_"+value).html() + ",";
						}
						flag = true;
					}
				}
				
			}
		}
		if(flag){
			$("#tijiao_"+value).hide();//隐藏提交按钮DIV
			selectAnserValue_result = delLastSeparator(selectAnserValue_result);
			selectAnserLableValue_result = delLastSeparator(selectAnserLableValue_result);				
			//将答案插入数据库
			$("#mySelectAnswer_lable_"+value).val(selectAnserLableValue_result);
			excuteInsertData(loreId,currentLoreId,studyLogId,"针对性诊断",loreQuestionId,value,selectAnserLableValue_result,answerOptionArray,questionType);
			if(value == questionLength){//表示最后一题
				$("#result_button_div").show(); //显示最后提交按钮DIV
				$("#next_button_div_"+value).hide(); //隐藏下一题按钮DIV
			}else{
				$("#next_button_div_"+value).show(); //显示下一题按钮DIV
			}
			lastCommitNumber++;
		}
	}
}

//将答题的答案插入数据库
function excuteInsertData(loreId,currentLoreId,studyLogId,loreType,questionId,questionStep,myAnswer,answerOptionArray,questionType){
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{loreId:loreId,currentLoreId:currentLoreId,studyLogId:studyLogId,loreType:loreType,subjectId:subjectId,loreQuestionId:questionId,questionStep:questionStep,myAnswer:escape(myAnswer),loreTaskName:escape(loreTaskName)},
		  url:"studyApp.do?action=insertStudyInfo&answerOptionArray="+answerOptionArray+"&cilentInfo=app",
		  success:function (json){
			  if(json["success"] == 0){//错
				  if(questionType == "填空选择题"){
					  $("#myAnsOpts_"+questionStep).prepend("<span class='myAnsTxt'>我的解答：" + myAnswer + "</span>");
					  $("#answerOption_"+questionStep).slideUp();
					  $("#myAnsOptsSpan_"+questionStep).addClass("errStateSpan").removeClass("rightStateSpan");
				  }else if(questionType == "多选题"){
					var myAnswerArray = myAnswer.split(",");
					for(var kk = 1 ; kk <= myAnswerArray.length ; kk++){
						var optionIndex_new = transOption_1(myAnswerArray[kk - 1]);
						$("#"+optionIndex_new+"_"+questionStep).addClass("errorState");
					}
				   }else if(questionType == "问答题" || questionType == "填空题"){
						$("#realAnswer_"+questionStep).hide();
					   	$("#myAnsResultBox_"+questionStep).css({"padding":10}).append("<span class='fl'>我的解答："+ myAnswer +"</span><span class='iconState_err'></span>");
					}else{//单选题，判断题
					   var optionIndex = transOption_1(myAnswer);
					   $("#"+optionIndex+"_"+questionStep).removeClass("choice_act").addClass("errorState");
				   }
				  $("#tipInfoBox").addClass("errorInfo").removeClass("rightInfo");
				  $("#tipFace").addClass("errFace").removeClass("rigFace");
				  $("#facePic").addClass("errFacePic").removeClass("rigFacePic");
				  $("#infoTxt").html("哎呀，答错了！").css({"padding-top":15});
				  $("#goldenTxt").html("");
				  /**if(questionType == "问答题" || questionType == "填空题"){
					  $("#relAnsTxt").html("");
				  }else{
					  $("#relAnsTxt").html("正确答案：B");
				  }**/						  
				  currentAllQuestionFlag *= 0;  
				  $(".quesNum").eq(questionStep - 1).css("border-color","#fb5151");
				  $(".quesNum span").eq(questionStep - 1).addClass("errorState_queNum");
			  }else{//对
				  if(questionType == "填空选择题"){
					  $("#myAnsOpts_"+questionStep).prepend("<span class='myAnsTxt'>我的解答：" + myAnswer + "</span>");
					  $("#myAnsOptsSpan_"+questionStep).addClass("rightStateSpan").removeClass("errStateSpan");
					  $("#answerOption_"+questionStep).slideUp();
				  }else if(questionType == "多选题"){ 
					var myAnswerArray = myAnswer.split(",");
					for(var kk = 1 ; kk <= myAnswerArray.length ; kk++){
						var optionIndex_new = transOption_1(myAnswerArray[kk - 1]);
						$("#"+optionIndex_new+"_"+questionStep).addClass("rightState");
					}
				  }else if(questionType == "问答题" || questionType == "填空题"){
					  $("#realAnswer_"+questionStep).hide();
					  $("#myAnsResultBox_"+questionStep).css({"padding":10}).append("<span class='fl'>我的解答："+ myAnswer +"</span><span class='iconState_suc'></span>");
				  }else{//单选题，判断题
					   var optionIndex = transOption_1(myAnswer);
					   $("#"+optionIndex+"_"+questionStep).removeClass("choice_act").addClass("rightState");
				  }
			  
				  $("#tipInfoBox").addClass("rightInfo").removeClass("errorInfo");
				  $("#tipFace").addClass("rigFace").removeClass("errFace");;
				  $("#facePic").addClass("rigFacePic").removeClass("errFacePic");
				  $("#infoTxt").html("恭喜你，回答正确！").css({"padding-top":0});;
				  $("#goldenTxt").html("+10金币");
				  //$("#relAnsTxt").html("");
		 		  currentAllQuestionFlag *= 1;
				  totalMoney++;
				  $(".quesNum").eq(questionStep - 1).css("border-color","#64ccf2");
				  $(".quesNum span").eq(questionStep - 1).addClass("rightState_queNum");
			  }
			  $("label[name='comLabelName_"+questionStep+"']").removeAttr("ontouchend");
			  comTipInfo();
		  }
	});
	completeNum++;
	$(".queNumSpan").html(completeNum + "/"+questionLength);
	perScale = completeNum / questionLength;
	$(".rateLine").animate({"width":perScale*$(".proBarDiv").width()},500,function(){
		if(completeNum == questionLength){ //把做题进度条最后的旗帜给点亮
			$(".finalDiv").removeClass("finalCol").addClass("finalCol_open");
			$(".finalFlag").animate({"opacity":1},600);
		}
	});
}

//最后提交
function lastSubmitAnswer(currentLoreId){
	var flag = false;
	var studyLogId_curr = 0;
	var step_new = 0;
	if(lastCommitNumber == questionLength){
		if(checkLoginStatus()){
			if(loreTypeName == "再次诊断"){
				if(currentLoreId == loreId){
					step_new = 4;
				}else{
					step_new = 3;
				}
				if(currentAllQuestionFlag == 1){//表示当前题型全部正确
					//step:stepComplete:isFinish:access
					studyLogId_curr = updateLogStatus(step_new,0,1,1,currentLoreId);
				}else{
					studyLogId_curr = updateLogStatus(step_new,0,1,2,currentLoreId);//部分正确，需要进入5部学习法
				}
				window.location.href = "studyApp.do?action=showTracebackPage&loreId="+loreId+"&tracebackType=review&studyLogId="+studyLogId_curr+"&flag=1&loreName="+loreName+"&chapterId="+chapterId+"&educationId="+educationId+"&cilentInfo=app"
			}else{
				if(currentAllQuestionFlag == 1){//表示当前题型全部正确
					//access:1--当前级全部正确，2:当前级部分正确或者无正确
					//step1:诊断时如果是本知识典直接全部正确，那么修改isfinish为2，stepComplete为1，access为1
					//step2:诊断时如果是关联知识点当前级全部正确。（转向学习状态）isfinish为1，stepComplete为1，access为1
					//step=0:表示不修改step的值
					if(currentLoreId == loreId){//本知识点全部正确
						studyLogId_curr = updateLogStatus(0,1,2,1,currentLoreId);	
					}else{//是关联知识点当前级全部正确，需要走到第三阶段，关联性诊断的学习阶段
						studyLogId_curr = updateLogStatus(0,1,1,1,currentLoreId);	
					}
				}else{//表示当前题型没有全部正确(继续往下级子知识点)
					if(checkLoreId(currentLoreId)){
						//表示返钱知识点的关联性诊断已经完成，需要走到第三阶段，关联性诊断的学习阶段
						studyLogId_curr = updateLogStatus(0,1,1,2,currentLoreId);
					}else{//第1个参数表示：当前知识点的关联性诊断还未完成
						studyLogId_curr = updateLogStatus(0,0,1,2,currentLoreId);
					}
				}
				window.location.href = "studyApp.do?action=showTracebackPage&loreId="+loreId+"&tracebackType=review&studyLogId="+studyLogId_curr+"&loreName="+loreName+"&chapterId="+chapterId+"&educationId="+educationId+"&cilentInfo=app";
			}
		}
	}else{
		//alert("您还有没做完的题,不能进行提交!");
		$(".succImg").hide();
		$(".tipImg").show();
		$("#warnPTxt").html("请先做完其他试题<br/>再提交");
		commonTipInfoFn($(".warnInfoDiv"));
		
	}
}

//判断当前知识点是否是第一个或者最后一个知识点
function checkLoreId(currentLoreId){
	var pathArray = lorePath.split(":");
	for(var i = 0 ; i < pathArray.length; i++){
		var pathDetailArray = pathArray[i].split("|");
		for(j = 0 ; j < pathDetailArray.length ; j++){
			if(currentLoreId == pathDetailArray[j]){
				if(i == 0 && j == pathDetailArray.length - 1){//本知识点--stepComplete = 1
					return true;
				}else if(i > 0 && i < pathArray.length - 1){//中间知识点--stepComplete = 0
					return false;
				}else if(i == pathArray.length - 1){//溯源最后一个知识点--stepComplete = 1
					return true;
				}
			}
		}
	}
	
}

/**
当前阶段完成，修改指定logId的isFinish状态、stepComplete状态，access状态
stepComplete:该阶段完成状态0：未完成，1：完成
isFinish:该知识点完成状态1：未完成，2：完成
access：该阶段关联知识点完成状态0：未完成，1：完成
**/
function updateLogStatus(step,stepComplete,isFinish,access,currentLoreId){
	var studyLogId_curr = 0;
	var currentStepLoreArray = nextLoreIdArray;
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{studyLogId:studyLogId,loreId:loreId,step:step,stepComplete:stepComplete,isFinish:isFinish,access:access,currentLoreId:currentLoreId,currentStepLoreArray:currentStepLoreArray},
		  url:"studyApp.do?action=updateLogStatus&cilentInfo=app",
		  success:function (json){ //jsonstudyLogId，目的是将studyLogId传递出来
			  if(json["result"] != 0){
				  if(studyLogId != 0){
					  studyLogId_curr = studyLogId; 
				  }else{
					  studyLogId_curr = json["result"];
				  } 
			  }
		  }
	});
	return studyLogId_curr;
}