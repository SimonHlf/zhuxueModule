//初始化巴菲特题库列表
function initBuffetQuestionListDiv(){
	$.ajax({
		  type:"post",
		  async:true,
		  dataType:"json",
		  data:{buffetSendId:buffetSendId},
		  url:"buffetApp.do?action=loadBuffetQuestionList&cilentInfo=app",
		  beforeSend:function(){
			  $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		  },
		  success:function (json){ 
			  showBuffetQuestionList(json["bqList"]);
		  },
		  complete:function(){
	          $("#loadDataDiv").hide();
	          $(".loadingIcon").remove();
	         //显示当前定位的题列表
	      	 $(".questionClass").hide();
	      	 $("#question_"+currBuffetNumber).show().css({"opacity":1});
	      	 quesScroll(currBuffetNumber); //初始化对默认第一个li列表加载isroll
	      }
	});
	
}
//显示巴菲特题库列表
function showBuffetQuestionList(list){
	questionLength = list.length;
	$("#questionLength").html(questionLength);
	var index_ul = "<ul id='indexNumber' class='tabNav clearfix'></ul>";//题库序列号ul
	var question_ul = "<ul id='questionList'></ul>";//题库列表ul
	$("#botCard").append(index_ul);
	$("#questionInfo").append(question_ul);
	if(list != null){
		for(var i = 0 ; i < questionLength ; i++){
			var index = i + 1;
			//底部题号
			var li_index = "";
			if(index == 1){
				li_index =  "<li id='queIndex_"+index+"' class='quesNum active removeAFocBg' ontouchend='showQuestionByIndex_1("+index+")'>"+"<span>"+index+"</span></li>";//题库序列号li
			}else{
				li_index =  "<li id='queIndex_"+index+"' class='quesNum removeAFocBg' ontouchend='showQuestionByIndex_1("+index+")'>"+"<span>"+index+"</span></li>";//题库序列号li
			}
			$("#indexNumber").append(li_index);
			//核心区域内容
			var li_question = "";
			if(index == 1){
				li_question = "<li id='question_"+index+"' name='question_"+index+"' class='questionClass' style='opacity:1;'></li>";//题库列表li-显示
			}else{
				li_question = "<li id='question_"+index+"' name='question_"+index+"' class='questionClass'></li>";//题库列表li-隐藏
			}
			$("#questionList").append(li_question);
			//--------题库列表(问题)---------//
			var question_start_dl = "<div id='questionWrap_"+ index +"' class='questionWrap'><div class='scroller'>";
			//题号,题类型,题目标题
			var question_typeList_dd = "<div id='loreType_"+index+"' class='loreTypeTit clearfix'><span class='loreTypeNum fl'>"+index+"</span><span class='loreTypeTxt fl'>"+list[i].buffet.questionType+"<em></em><i></i></span><div class='quesTit fl'>"+list[i].buffet.subject+"</div></div>";
			var question_option_dd = "<div id='questionOption_"+index+"' class='optionDd'><div id='quesSonOption_"+index+"' class='queSonOpt'></div><div id='answerOption_"+index+"' class='answerOptions'></div><div id='ansQuesWrap_"+ index +"' style='display:none;'></div><div id='myAnsOpts_"+index+"' style='display:none;' class='myAnsOpt'><span id='myAnsOpts_"+index+"' class='iconStaeSpan'></span></div></div>";//题库答案选项
			var question_analysis_dd = "<div id='questionAnalysis_"+index+"'>";
			var question_end_dl = "</div></div></div>";
			var question_submit_dd = "<div id='questionSubmit_"+index+"' class='submitOption'></div>";
			$("#question_"+index).append(question_start_dl + question_typeList_dd + question_option_dd + question_analysis_dd + question_end_dl + question_submit_dd);
			//--------题库列表(问题)---------//
			
			
			//生成随机答案选项数组(将随机答案选项添加到questionOption__index的dd标签中)
			var answerOptionArray = new Array();
			if(list[i].myAnswer != ""){//如果是已经做过的题，就不需要在随机排列
				answerOptionArray = assignToArray(list[i].a,list[i].b,list[i].c,list[i].d,list[i].e,list[i].f);
			}else{//如果是没有做过的题，就需要将选项进行随机排列
				answerOptionArray = radomAnswerArray(assignToArray(list[i].buffet.a,list[i].buffet.b,list[i].buffet.c,list[i].buffet.d,list[i].buffet.e,list[i].buffet.f));
			}
			var j = 0;
			var answerA = "";
			var answerB = "";
			var answerC = "";
			var answerD = "";
			var answerE = "";
			var answerF = "";
			if(list[i].buffet.a != ""){
				
				if(checkAnswerImg(list[i].buffet.a)){
					answerA = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerA = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=1_"+index+" ids='nameSpan_"+index+"_A'>A</span><p class='optionDetailTxt lineBreak'>"+answerA + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].buffet.b != ""){
				
				if(checkAnswerImg(list[i].buffet.b)){
					answerB = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerB = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=2_"+index+" ids='nameSpan_"+index+"_B'>B</span><p class='optionDetailTxt lineBreak'>"+answerB + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].buffet.c != ""){
				
				if(checkAnswerImg(list[i].buffet.c)){
					answerC = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerC = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=3_"+index+" ids='nameSpan_"+index+"_C'>C</span><p class='optionDetailTxt lineBreak'>" + answerC + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].buffet.d != ""){
				
				if(checkAnswerImg(list[i].buffet.d)){
					answerD = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerD = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=4_"+index+" ids='nameSpan_"+index+"_D'>D</span><p class='optionDetailTxt lineBreak'>" + answerD + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].buffet.e != ""){
				
				if(checkAnswerImg(list[i].buffet.e)){
					answerE = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerE = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=5_"+index+" ids='nameSpan_"+index+"_E'>E</span><p class='optionDetailTxt lineBreak'>" + answerE + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}
			if(list[i].buffet.f != ""){
				
				if(checkAnswerImg(list[i].buffet.f)){
					answerF = "<img src='"+ answerOptionArray[j++] +"'/>";
				}else{
					answerF = replaceChara(answerOptionArray[j++]).replace("<","&lt");
				}
				var divOption = "<div class='optionDiv clearfix'><span class='optionWrod' name='nameSpan_"+ index +"' id=6_"+index+" ids='nameSpan_"+index+"_F'>F</span><p class='optionDetailTxt lineBreak'>" + answerF + "</p></div>";
				$("#quesSonOption_"+index).append(divOption);
			}	
			//选择答案
			var analysisDiv = "<div id='analysis_div_"+list[i].id+"' class='analysis_div'>";
			analysisDiv += "<strong class='analysisTit'>解析：</strong>";
			analysisDiv += list[i].buffet.resolution;
			analysisDiv += "</div>";
			$("#questionAnalysis_"+index).append(analysisDiv);
			
			var answerNumber = 0;
			var questionType_flag = false;
			if(list[i].buffet.questionType == "问答题" || list[i].buffet.questionType == "填空题"){
				$("#ansQuesWrap_"+index).show();
				$("#questionOption_"+index).css({"padding-left":0,"padding-right":0});
				questionType_flag = true;
				answerNumber = 1;//只有错和对，所以赋值1;
				var ts_span = "<div id='tishi_"+index+"' class='tishiBox'><span class='tishiIcon'></span>请拿出纸和笔验算一下，这道题考察的是你的解题规范和解题步骤，要认真验算！得出结果后点击验算完成即可</div>";
				var realAsnwer_result_title_div = "<div id='realAnswer_result_"+index+"' style='display:none;' class='optionParent clearfix'>";
				realAsnwer_result_title_div += "<div class='relRightAnsBox lineBreak clearfix'><span class='relRightAnsTxt fl'>正确答案：</span><div class='fl'>"+replaceChara(list[i].realAnswer)+"</div></div>";
				realAsnwer_result_title_div += "<div class='myRealAnsBox'><span class='relRightAnsTxt fl'>我的答案：</span>";
				realAsnwer_result_title_div += "<div class='optionBox_Que'><input class='optionRadio_ques' type='radio' name='answer_option_radio_"+index+"1' value='1'/><span class='rightSpan'>对</span></div><div class='optionBox_Que'><input class='optionRadio_ques' type='radio' name='answer_option_radio_"+index+"1' value='0'/><span class='errorSpan'>错</span></div>";
				realAsnwer_result_title_div += "<span class='warnningIcon'></span><span class='choiceTxt'>请如实选择</span></div>";
				realAsnwer_result_title_div += "</div>";
				var realAnswer_div = "<div id='realAnswer_"+index+"' class='relAnsBox'>"+realAsnwer_result_title_div+"</div>";
				var myAnsResult_div = "<div id='myAnsResultBox_"+ index +"' class='myAnsRes clearfix'></div>";
				$("#ansQuesWrap_"+index).append(ts_span + realAnswer_div + myAnsResult_div);
			}else{
				questionType_flag = false;
				if(list[i].buffet.questionType == "多选题"){
					answerNumber = 1;
				}else{
					answerNumber = list[i].buffet.answer.split(",").length;//得到有几个正确答案，确定有几组答案选项
				}
				for(var k = 1 ; k <= answerNumber ; k++){	
					var number_new = index + "" + k;
					var option_div = "<div id='option_div_"+number_new+"' class='optionPar clearfix'></div>";
					var answer_span = "<span class='optionTxt fl'>选项"+k+":</span>"; 
					var answer_mainCon = "<div id='answer_optionPar_span_"+number_new+"' class='spanOptionPar fl'>";
					if(list[i].buffet.questionType == "填空选择题"){//如果是填空选择题需要根据该题目有几个填空或者有几组选项来动态创建每组对应的父级div 类名：optionParent
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
						
						if(list[i].buffet.questionType == "多选题"){//(2016-04-06增加)
							input_radio = "<label class='comChoiceLabel removeAFocBg' name='comLabelName_"+ index +"' ontouchend=choiceOption('"+list[i].buffet.questionType+"',"+ ii +","+index+")><input type='checkbox' class='optionCheckBox' id='answer_option_radio_"+ index +"_"+ii+"' name='answer_option_radio_"+number_new+"' value='"+input_radio_value+"'/></label>";
						}else if(list[i].buffet.questionType == "填空选择题"){
							input_radio = "<input type='radio' id='answer_option_radio_"+ index +"_"+ii+"' class='spaceAnsRadio' name='answer_option_radio_"+number_new+"' value='"+input_radio_value+"'/>";
						}else{//单选题
							input_radio = "<label class='comChoiceLabel removeAFocBg' name='comLabelName_"+ index +"' ontouchend=choiceOption('"+list[i].buffet.questionType+"',"+ ii +","+index+")><input type='radio' class='optionRadio_sigle' id='answer_option_radio_"+ index +"_"+ii+"' name='answer_option_radio_"+number_new+"' value='"+input_radio_value+"'/></label>";
						}
						
						if(list[i].buffet.questionType == "填空选择题"){
							var input_lable_value_space = "<span id='answer_option_label_"+spanNumber+"' class='spacSpanLabel'>"+ transOption(ii) +"</span>";
						}else{
							var input_lable_value = "<span id='answer_option_label_"+spanNumber+"' style='display:none;'>"+ transOption(ii) +"</span>";
						}
						if(list[i].buffet.questionType == "单选题" || list[i].buffet.questionType == "多选题" || list[i].buffet.questionType == "判断题"){
							$("#answerOption_"+index).removeClass("answerOptions_space").addClass("answerOptions").append(input_radio + input_lable_value);
						}else if(list[i].buffet.questionType == "填空选择题"){
							//如果是填空选择题需要根据该题目有几个填空或者有几组选项来动态创建每组对应的父级div 类名：optionParent
							$("#answer_optionPar_span_"+number_new).append(answer_option_span);
							$("#answer_option_span_"+spanNumber).append(input_radio + input_lable_value_space);
						}
					}
				}
			}
			//提交动作和显示结果
			var loreQuestionId_input_value = "<input type='hidden' id='loreQuestionId_input_"+index+"' value='"+list[i].buffet.id+"'/>";
			var mySelectAnswer_lable_value = "<input type='hidden' id='mySelectAnswer_lable_"+index+"'/>";//自己选择的答案lable
			var mySelectAnswer_input_value = "<input type='hidden' id='mySelectAnswer_input_"+index+"'/>";//自己选择的答案value
			var right_answer_lable_value = "<input type='hidden' id='right_answer_lable_"+index+"'/>";//正确的答案lable
			var right_answer_input_value = "<input type='hidden' id='right_answer_input_"+index+"'/>";//正确的答案value
			var submit_div = "<div id='tijiao_"+index+"' class='submitDiv' style='display:no-ne'>";
			var answer_dataBase = list[i].buffet.answer.replace(",","-my-fen-ge-fu-");
			var answer_array = arrayToJson(answerOptionArray);
			var currentBuffetId = list[i].buffet.id;
			submit_div += "<span class='goNextBtn removeAFocBg' ontouchend=submitAnswer("+ list[i].id + ","+list[i].buffetSend.studyLog.lore.id+","+list[i].buffet.lore.id+ "," + currentBuffetId +","+index+","+answerNumber+","+buffetSendId+",'"+encodeURIComponent(encodeURIComponent(answer_array))+"','"+list[i].buffet.questionType+"','"+list[i].buffet.buffetType.types+"')>提交</span>";
			submit_div += "</div>";
			var showButton_div = "<div id='showResult_"+index+"' class='submitDiv' style='display:none;'>";
			//问答题填空题显示答案
			showButton_div += "<span class='goNextBtn removeAFocBg' ontouchend='showResult("+index+");'>验算完成</span>";
			showButton_div += "</div>";
			var nextButton_div = "<div id='next_button_div_"+index+"' class='submitDiv' style='display:none;'>";
			var nextNumber = index+1;
			nextButton_div += "<span class='goNextBtn' ontouchend=nextQuestion_1("+list[i].id+","+nextNumber+","+list[i].currCompleteFlag+",'"+list[i].buffet.buffetType.types+"')>进入下一题</span>";
			nextButton_div += "</div>";
			
			//溯源
			var traceButton_div = "<div id='trace_button_div_"+index+"'  class='submitDiv' style='display:none;'>";
			traceButton_div += "<span class='goNextBtn removeAFocBg' ontouchend=goTrace("+ list[i].id +","+ list[i].buffet.lore.id +","+list[i].buffetSend.studyLog.lore.id+",'"+encodeURIComponent(encodeURIComponent(list[i].buffetSend.studyLog.lore.loreName))+"',"+list[i].buffet.id+",'"+encodeURIComponent(encodeURIComponent(list[i].buffet.title))+"',"+buffetSendId+")>溯源</span>";
			traceButton_div += "</div>";
			
			//看解析
			var analysisButton_div = "<div id='analysis_button_div_"+index+"' class='submitDiv' style='display:none;'>";
			analysisButton_div += "<span class='goNextBtn removeAFocBg' ontouchend=showAnalysis("+list[i].id+","+list[i].traceCompleteFlag+","+index+","+ currentBuffetId +","+list[i].buffetSend.studyLog.lore.id+",'"+list[i].buffet.buffetType.types+"');>看解析</span>";
			analysisButton_div += "</div>";
			
			var resultButton_div = "";
			if(i == questionLength - 1){//表示是最后一题
				resultButton_div = "<div id='result_button_div' class='submitDiv' style='display:none;'>";
				resultButton_div += "<span class='goNextBtn removeAFocBg' ontouchend=lastSubmitAnswer("+list[i].id+","+list[i].currCompleteFlag+",'"+list[i].buffet.buffetType.types+"')>做完了</span>";
				resultButton_div += "</div>";	
			}
			//提交答案
			$("#questionSubmit_"+index).append(loreQuestionId_input_value+mySelectAnswer_lable_value+submit_div+showButton_div+nextButton_div+traceButton_div+analysisButton_div+resultButton_div);
			//计算提交按钮的宽度
			$(".submitDiv").width(cliWid - $(".showHideBtn").width() - 20);
			
			if(questionType_flag){//表示是问答和填空题
				//隐藏首次的提交按钮，并且需要自定义按钮
				$("#tijiao_"+index).hide();
				$("#showResult_"+index).show();
			}else{
				$("#tijiao_"+index).show();
				$("#showResult_"+index).hide();
			}
			if(list[i].result != -1){//做过的题
				var buffetType_temp = list[i].buffet.questionType;
				completeNum++;
				//列出答案和我的答案
				if(list[i].result == 1){//正确
					if(buffetType_temp == "填空选择题"){
						$("#myAnsOpts_"+index).prepend("<span class='myAnsTxt'>我的解答：" + list[i].myAnswer + "</span>");
						$("#myAnsOptsSpan_"+index).addClass("rightStateSpan").removeClass("errStateSpan");
						$("#answerOption_"+index).hide();//隐藏选项
					}else if(buffetType_temp == "多选题"){
						var myAnswerArray = list[i].myAnswer.split(",");
						for(var kk = 1 ; kk <= myAnswerArray.length ; kk++){
							var optionIndex_new = transOption_1(myAnswerArray[kk - 1]);
							$("#"+optionIndex_new+"_"+index).addClass("rightState");
						}
					}else if(buffetType_temp == "问答题" || buffetType_temp == "填空题"){
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
					if(i == questionLength - 1){//表示是最后一题
						currBuffetNumber = i + 1;
					}else{
						currBuffetNumber = i + 2;
					}
					$("#analysis_button_div_"+index).show();//显示看解析按钮DIV
				}else{//错误
					if(list[i].currCompleteFlag == 1){
						if(i == questionLength - 1){//表示是最后一题
							//表示最后一题，并且状态为完成
							currBuffetNumber = i + 1;
						}else{
							//不是最后一题，并且状态完成
							currBuffetNumber += 1;
						}
					}else{
						currBuffetNumber = i + 1;
					}
					if(buffetType_temp == "填空选择题"){
						$("#myAnsOpts_"+index).prepend("<span class='myAnsTxt'>我的解答：" + list[i].myAnswer + "</span>");
						$("#myAnsOptsSpan_"+index).addClass("errStateSpan").removeClass("rightStateSpan");
						 $("#answerOption_"+index).hide();//隐藏选项
					}else if(buffetType_temp == "多选题"){
						var myAnswerArray = list[i].myAnswer.split(",");
						for(var kk = 1 ; kk <= myAnswerArray.length ; kk++){
							var optionIndex_new = transOption_1(myAnswerArray[kk - 1]);
							$("#"+optionIndex_new+"_"+index).addClass("errorState");
						}
					}else if(buffetType_temp == "问答题" || buffetType_temp == "填空题"){
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
					//需要--------------
					var currBuffetType = list[i].buffet.buffetType.types;
					var basicLoreId_curr = list[i].buffet.lore.id;//通用版知识点编号
					var basicLoreId = list[i].buffetSend.studyLog.lore.id;//当前知识点编号（其他版本）
					if(currBuffetType == "兴趣激发" || currBuffetType == "方法归纳"){
						//需要判断当前巴菲特有无关联知识点，如过没有-显示看解析，否则显示溯源按钮
						var relateLoreIdArray_1 = getBuffetLoreRelateList(basicLoreId,basicLoreId_curr,currentBuffetId);
						if(relateLoreIdArray_1 != ""){
							if(list[i].traceCompleteFlag == 1){
								//看解析
								$("#analysis_button_div_"+index).show();//显示看解析按钮DIV
							}else{
								//显示溯源按钮
								$("#trace_button_div_"+index).show();//显示溯源按钮DIV	
							}
						}else{
							//看解析
							$("#analysis_button_div_"+index).show();//显示看解析按钮DIV
						}
					}else{
						if(list[i].traceCompleteFlag == 1){
							$("#analysis_button_div_"+index).show();//显示看解析按钮DIV
						}else{
							$("#trace_button_div_"+index).show();//显示溯源按钮DIV
						}
					}
				}
				$("label[name='comLabelName_"+index+"']").removeAttr("ontouchend");
				//$("#div_my_answer_flag_"+index).append(resultFlag);
				$("#result_button_dd_"+index).show();//显示按钮DIV
				$("#tijiao_"+index).hide();//隐藏提交按钮DIV
				$("#showResult_"+index).hide();//隐藏提交(显示答案)按钮DIV
				
				lastCommitNumber++;
			}
		}
	}
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
/**
* 提交答案动作
* basicLoreId:当前知识点编号（某出版社下的知识点）
* quoteLoreId_curr:被引用的通用版下的知识点编号
**/
function submitAnswer(buffetStudyDetailId,basicLoreId,quoteLoreId_curr,currentBuffetId,value,answerNumber,buffetSendId,answerOptionArray,questionType,buffetType){
	//向答案结果DIV中添加元素
	//先判断有误选择答案
	var loreQuestionId = $("#loreQuestionId_input_"+value).val();
	var selectAnserValue_result = "";
	var selectAnserLableValue_result = "";
	var flag = false;
	for(var i = 1 ; i <= answerNumber ; i++){
		var selectAnserValue = $("input[name='answer_option_radio_"+value+i+"']:checked").val();
		if(selectAnserValue == undefined){
			$("#warnPTxt").html("请选择答案");
			commonTipInfoFn($(".warnInfoDiv"));
			//清空数据
			selectAnserValue_result = "";
			selectAnserLableValue_result = "";
			flag = false;
			break;
		}else{
			if(checkAnswerImg(selectAnserValue)){
				selectAnserValue_result += selectAnserValue.replace("Module/commonJs/ueditor/jsp/lore/","") + ",";
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
				//selectAnserLableValue_result += $("#answer_option_label_"+number1 + "" + number2).html() + ",";
				selectAnserLableValue_result += $("#answer_option_label_"+number1 + "" + number2+"_"+value).html() + ",";
			}
			flag = true;
		}
	}
	if(flag){
		$("#tijiao_"+value).hide();//隐藏提交按钮DIV
		selectAnserValue_result = delLastSeparator(selectAnserValue_result);
		selectAnserLableValue_result = delLastSeparator(selectAnserLableValue_result);
		$("#mySelectAnswer_lable_"+value).val(selectAnserLableValue_result);
		var flag = excuteInsertData(buffetStudyDetailId,value,currentBuffetId,answerNumber,selectAnserLableValue_result,answerOptionArray,questionType);
		if(value == questionLength){//表示最后一题
			if(flag){//正确
				showHiddenButton(value,"","none","none","none");
				//updateBuffetSendStatus();
			}else{
				if(buffetType == "兴趣激发" || buffetType == "方法归纳"){
					//需要判断当前巴菲特有无关联知识点，如过没有-显示看解析，否则显示溯源按钮
					var relateLoreIdArray = getBuffetLoreRelateList(basicLoreId,quoteLoreId_curr,currentBuffetId);
					if(relateLoreIdArray != ""){//显示溯源按钮
						showHiddenButton(value,"none","none","","none");
					}else{
						//看解析
						showHiddenButton(value,"none","none","none","");
					}
				}else{
					//显示溯源按钮
					showHiddenButton(value,"none","none","","none");
				}
			}
		}else{
			if(flag){//正确
				showHiddenButton(value,"none","","none","none");
			}else{//错误
				if(buffetType == "兴趣激发" || buffetType == "方法归纳"){
					//需要判断当前巴菲特有无关联知识点，如过没有-显示看解析，否则显示溯源按钮
					var relateLoreIdArray = getBuffetLoreRelateList(basicLoreId,quoteLoreId_curr,currentBuffetId);
					if(relateLoreIdArray != ""){//显示溯源按钮
						showHiddenButton(value,"none","none","","none");
					}else{
						//看解析
						showHiddenButton(value,"none","none","none","");
					}
				}else{
					//显示溯源按钮
					showHiddenButton(value,"none","none","","none");
				}
			}
		}
		lastCommitNumber++;
	}else{
		
	}
}
//显示隐藏按钮
function showHiddenButton(value,resultDisplayFlag1,nextDisplayFlag2,traceDisplayFlag3,jiexiDisplayFlag4){
	getId("result_button_div").style.display = resultDisplayFlag1;
	getId("next_button_div_"+value).style.display = nextDisplayFlag2;
	getId("trace_button_div_"+value).style.display = traceDisplayFlag3;
	getId("analysis_button_div_"+value).style.display = jiexiDisplayFlag4;
}
//根据当前知识点编号获取通用版知识点获取与当前巴菲特关联的的知识点（关联知识点在通用版中）
function getBuffetLoreRelateList(currLoreId,currBasicLoreId,buffetId){
	var relateLoreIdStr = "";
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{buffetId:buffetId,currLoreId:currLoreId,currBasicLoreId:currBasicLoreId},
		  url:"blrManager.do?action=showRelationByBuffetAndLore&cilentInfo=app",
		  success:function (json){ 
			  relateLoreIdStr = json["result"];
		  }
	});
	return relateLoreIdStr;
}
//将答题的答案插入数据库
function excuteInsertData(bsdId,questionStep,buffetId,answerNumber,myAnswer,answerOptionArray,questionType){
	//var newUrl = "&bsdId="+bsdId+"&buffetId="+buffetId+"&myAnswer="+myAnswer+"&answerOptionArray="+answerOptionArray+"&buffetType="+questionType+"&buffetSendId="+buffetSendId;
	//alert(bsdId+"::::"+questionStep+"::::"+buffetId+"::::"+answerNumber+"::::"+myAnswer+"::::"+answerOptionArray+"::::"+questionType);
	var flag = false;//对错标记
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{bsdId:bsdId,buffetId:buffetId,myAnswer:escape(myAnswer),buffetType:escape(questionType),buffetSendId:buffetSendId},
		  url:"buffetApp.do?action=insertBuffetStudyDetailInfo&answerOptionArray="+answerOptionArray+"&cilentInfo=app",
		  success:function (json){
			  if(json["result"] == 0){//错
				  currBuffetNumber = questionStep;
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
				  currentAllQuestionFlag *= 0;
				  $(".quesNum").eq(questionStep - 1).css("border-color","#fb5151");
				  $(".quesNum span").eq(questionStep - 1).addClass("errorState_queNum");
			  }else{//对
				  currBuffetNumber = questionStep + 1;
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
				  currentAllQuestionFlag *= 1;
				  totalMoney++;
				  flag = true;
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
	return flag;
}
//显示查看解析动作
function showAnalysis(buffetQuestionId,traceCompleteFlag,index,currentBuffetId,basicLoreId,buffetType){//显示当前巴菲特题的解析
	var traceCompleteFlag_temp = traceCompleteFlag;
	if(buffetType == "兴趣激发" || buffetType == "方法归纳"){
		//不考虑溯源标签(已经出现解析的时候，肯定溯源已经完成或者没有关联知识点)
		traceCompleteFlag_temp = 1;
	}
	if(traceCompleteFlag_temp == 1){
		$("#analysis_div_"+buffetQuestionId).show();
		//隐藏看解析按钮
		$("#analysis_button_div_"+index).hide();
		//显示下一题按钮，并激活下一题的标签按钮动作
		if(index == questionLength){//表示是最后一题
			$("#result_button_div").show();//显示最后提交按钮DIV
		}else{
			$("#next_button_div_"+index).show();//显示下一题按钮DIV
		}
	}
}

//进入下一题按钮动作
function nextQuestion_1(bsdId,number,currCompleteFlag,buffetType){
	var flag = false;
	if(buffetType == "兴趣激发" || buffetType == "方法归纳"){
		flag = false;//这两项可以不需要关联
	}else{
		flag = checkCurrBuffetCompleteFlag(bsdId);
	}
	if(flag){
		$("#warnPTxt").html("操作有误<br/>请立即停止当前操作");
		commonTipInfoFn($(".warnInfoDiv"));
	}else{
		//根据当前bsdId获取当前巴菲特题的完成状态
		if(number <= questionLength){
			if(getCurrCompelteFlag(bsdId) == 0){//未完成
				
				//if(use_time >= 10){//点开解析后，必须停留5秒或者以上才能点击下一步的动作
					//执行修改buffetStudyDetail中的currCompleteFlag值为1,表示该题已完成
				var flag = updateCurrCompleteFlag(bsdId);
				if(flag){
					currBuffetNumber += 1;
					for(var i = 1 ; i <= questionLength ; i++){
						if(i != number){
							$("#queIndex_"+i).removeClass('active');//题号
							//$("#question_"+i).hide();
							$("#question_"+i).hide().css({"opacity":0});//全部题隐藏
						}else{
							$("#queIndex_"+i).addClass('active');
							$("#question_"+number).show().animate({"opacity":1},200);
							quesScroll(number);
						}
					}
				}
				/**}else{
					alert("请仔细看完解析后再进行下一步!");
				}**/
			}else{//表示该巴菲特已经完成
				for(var i = 1 ; i <= questionLength ; i++){
					if(i != number){
						$("#queIndex_"+i).removeClass('active');
						$("#question_"+i).hide().css({"opacity":0});
					}else{
						$("#queIndex_"+i).addClass('active');
						$("#question_"+number).show().animate({"opacity":1},200);
						quesScroll(number);
					}
				}
				$("#analysis_div_"+bsdId).hide();
				$("#next_button_div_"+(parseInt(number) - 1)).hide();
				$("#analysis_button_div_"+(parseInt(number) - 1)).show();
			}
		}
	}
}
//获取当前巴菲特发布记录的详细完成情况（必须traceFlag要完成，防止恶意提交）
function checkCurrBuffetCompleteFlag(bsdId){
	var flag = false;
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{bsdId:bsdId},
		  url:"buffetApp.do?action=checkCurrBuffetCompleteFlag&cilentInfo=app",
		  success:function (json){ 
				flag = json["result"];
		  }
	});
	return flag;
}
//获取当前巴菲特答题记录的完成情况（currCompleteFlag）
function getCurrCompelteFlag(bsdId){
	var currCompleteFlag = 0;
	if(bsdId > 0){
		$.ajax({
			  type:"post",
			  async:false,
			  dataType:"json",
			  data:{bsdId:bsdId},
			  url:"buffetApp.do?action=showBuffetStudyDetailById&cilentInfo=app",
			  success:function (json){ 
				  currCompleteFlag = json["result"];
			  }
		});
	}
	return currCompleteFlag;
}
//修改当前巴菲特的学习完成标记currCompleteFlag=1菱形的判定方法之三
function updateCurrCompleteFlag(bsdId){
	var flag = false;
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{bsdId:bsdId},
		  url:"buffetApp.do?action=updateCurrCompleteFlag&&cilentInfo=app",
		  success:function (json){ 
			 flag = json["result"];
		  }
	});
	return flag;
}
//根据当前知识点编号和巴菲特编号获取与当前巴菲特关联的知识点(存在巴菲特题的知识点编号)
function getLoreId(currLoreId,buffetId){
	var relateLoreIdStr = "";
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{buffetId:buffetId,currLoreId:currLoreId},
		  url:"buffetApp.do?action=showRelationLoreIdByBuffetAndLore&cilentInfo=app",
		  success:function (json){ 
			  relateLoreIdStr = json["result"]; 
		  }
	});
	return relateLoreIdStr;
}
//溯源
function goTrace(buffetStudyDetailId,basicLoreId_curr,currLoreId,currLoreName,buffetId,buffetName,buffetSendId){
	//根据当前知识点编号和巴菲特编号获取与当前巴菲特关联的知识点
	var relateLoreIdStr = getLoreId(currLoreId,buffetId);
	//关联知识点（V1.1）
	//var relateLoreIdStr = getBuffetLoreRelateList_1(currLoreId,basicLoreId_curr,buffetId);
	if(relateLoreIdStr != 0){
		window.location.href = "buffetApp.do?action=showBuffetLoreDetailPage&bsdId="+buffetStudyDetailId+"&relateLoreIdStr="+relateLoreIdStr+"&basicLoreId="+currLoreId+"&basicLoreName="+currLoreName+"&buffetId="+buffetId+"&buffetName="+buffetName+"&buffetSendId="+buffetSendId+"&closeFlag=mp&cilentInfo=app";				
	}else{
		$("#warnPTxt").html("没设置关联知识点<br/>请联系管理员");
		commonTipInfoFn($(".warnInfoDiv"));
	}
}
//最后提交按钮
function lastSubmitAnswer(bsdId,currCompleteFlag,currBuffetType){
	var flag_all = false;
	if(currBuffetType == "兴趣激发" || currBuffetType == "方法归纳"){
		//兴趣激发和方法归纳可以不需要溯源
		falg_all = false;
	}else{
		flag_all = checkAllBuffetCompleteFlag();
	}
	if(flag_all){
		//alert("系统检测到您正在进行危险操作,请立即停止当前操作!");
		$("#warnPTxt").html("操作有误<br/>请立即停止当前操作");
		commonTipInfoFn($(".warnInfoDiv"));
	}else{
		if(currCompleteFlag == 0){
			var flag = updateCurrCompleteFlag(bsdId);
			if(flag){
				//修改buffetSend表中的result=1表示该巴菲特发布记录完成
				updateBuffetSendStatus();
				$("#warnPTxt").html("恭喜你完成任务");
				$(".tipImg").attr("src","Module/appWeb/onlineStudy/images/succIcon.png");
				commonTipInfoFn($(".warnInfoDiv"));
			}
		}
		backPage();
	}
}
//获取巴菲特发布记录的详细完成情况（所有题必须traceFlag都要完成，防止恶意提交）
function checkAllBuffetCompleteFlag(){
	var flag = false;
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{buffetSendId:buffetSendId},
		  url:"buffetApp.do?action=checkAllBuffetCompleteFlag&cilentInfo=app",
		  success:function (json){ 
				flag = json["result"];
		  }
	});
	return flag;
}
//修改巴菲特发布记录完成状态
function updateBuffetSendStatus(){
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{buffetSendId:buffetSendId},
		  url:"buffetApp.do?action=updateBuffetSendCompleteFlag&cilentInfo=app",
		  success:function (json){ 

		  }
	});
}

//点击题号显示相应题信息
function showQuestionByIndex_1(number){
	if(botCardFlag){
		if(number <= currBuffetNumber){
			$(".questionClass").hide().css({"opacity":0});
			$("#question_"+number).show().animate({"opacity":1},200);
			$(".quesNum").removeClass("active");
			$("#queIndex_"+number).addClass("active");
			quesScroll(number);
			$("#botCardBox").stop().animate({"bottom":-$("#botCardBox").height()});
		}else{
			$("#warnPTxt").html("前面题没做<br/>后面的题不能点击");
			commonTipInfoFn($(".warnInfoDiv"));
		}

	}else{
		botCardFlag = false;
	}
}	
//返回
function backPage(){
	var url = "&userId="+userId+"&roleId="+roleId+"&loginStatus="+loginStatus;
	url += "&stime="+stime+"&etime="+etime+"&subId="+subId+"&result="+result+"&backStatus=back";
	window.parent.location.href = "buffetApp.do?action=init"+url+"&cilentInfo=app";
}