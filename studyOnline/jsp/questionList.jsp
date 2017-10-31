<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>助学网在线答题</title>
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/questionListCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/comOnlineStudyCss.css" type="text/css" rel="stylesheet"/>
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript">
		var loreId = "${requestScope.loreId}";
		var loreName = "${requestScope.loreName}";
		var studyLogId = "${requestScope.studyLogId}";
		var lastCommitNumber = 0;
		var questionLength = 0;
		var currentAllQuestionFlag = 1;
		var totalMoney = 0;
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
		var studyType = "${requestScope.studyType}";
		var pathType = "${requestScope.pathType}";
		var loreTaskName = "${requestScope.loreTaskName}";
		var loreTypeName = "";
		var access = "${requestScope.access}";
		var task = window.parent.task;
		var stepNumber = "${requestScope.stepNumber}";
		var iNow = 0;
		//替换所有的单引号为自定义字符
		function replaceChara(value){
			return value.replace(/&#wmd;/g,"'");
		}
		$(function(){
			loreTypeName = window.parent.loreTypeName;
			if(pathType == "study"){
				$("#studyInfo").attr("style","display:no-ne;");
				//显示6部学习法（视频讲解，点拨指导，知识清单，解题示范，巩固训练，再次诊断）
			}else{
				$("#diagnosisInfo").attr("style","display:no-ne;");
				
				initDiv();
				fnTab();
			}
			if(stepNumber == "0"){//表示是本知识点的诊断
				$("#info").html("针对<span class='strongCol'>${requestScope.loreName}</span>而设定的诊断题目");
			}
			//动态计算questionListDiv的高度
			$("#questionListDiv").height($(window).height() - $(".listTop").height());
			choiceOptionAns();
			setTimerBox();
			timename=setInterval("setTimerBox();",1000);
		});
		function fnTab(){
			var oneBigLiWid = $("#ulMainConBox").width();
			$("#questionList").css("width",oneBigLiWid * $("#questionList li").length);
			$(".tabNav li").each(function(i){
				$(this).click(function(){
					iNow = i;
					tabs();
				});
			});
			function tabs(){
				$("#questionList").height($(".tabCon").eq(iNow).height());//以后每一次点击都将对应索引值的li的高度给ul
				$(".tabNav li").each(function(i){
					var nowLeft = -iNow*oneBigLiWid; 
					$("#questionList").stop().animate({"left":nowLeft},500);
					
					$(".tabNav li").removeClass("active");
					$(".tabNav li").eq(iNow).addClass("active");
					
				});
				if(tmp == 1){
					//alert("开始执行题号点击")
					createQueScroll();
					
				}else{
					//alert("表示此时处于隐藏底部答题卡的状态");
					crWhoScreenScroll();
				}

				clearAll();
				setTimerBox();
				timename=setInterval("setTimerBox();",1000);
			}
			$(".nextPage").click(function(){
				iNow++;
				if(iNow == $(".tabNav li").length){
					iNow = $(".tabNav li").length - 1;
					alert("已经是最后一题了！");
				}
				tabs();
			});
			$(".prevPage").click(function(){
				iNow--;
				if(iNow == -1){
					iNow = 0;
					alert("已经是第一题了！");				}
				tabs();
			});
		}
		function choiceOptionAns(){
			$(".optionRadio").each(function(){
				$(this).click(function(){
					$(this).parent("div").addClass("current").append("<b></b>").siblings().removeClass("current").find('b').remove();
					
				});
			});
		}
		function getRealCurrentLoreId(currentLoreId){
			var realCurrentLoreId = 0;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"studyOnline.do?action=getRealCurrentLoreId&currentLoreId="+currentLoreId,
				  success:function (json){ 
					  realCurrentLoreId = json;
				  }
			});
			return realCurrentLoreId;
			/**
			var path = window.parent.path;
			for(var i = 0 ; i < path.split(":").length; i++){
				var pathArray = path.split(":").split("|");
				for(var j = 0 ; j < pathArray.length; j++){
					if(pathArray[j] == currentLoreId){
						$.ajax({
							  type:"post",
							  async:false,
							  dataType:"json",
							  url:"studyOnline.do?action=getRealCurrentLoreId&currentLoreId="+currentLoreId,
							  success:function (json){ 
								  realCurrentLoreId = json;
							  }
						});
						break;
					}
				}
			}
			**/
			
		}
		function initDiv(){
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"studyOnline.do?action=loadQuestionList&loreId="+loreId+"&studyLogId="+studyLogId+"&nextLoreIdArray="+nextLoreIdArray+"&studyType="+studyType+"&loreTypeName="+encodeURIComponent(loreTypeName)+"&access="+access,
				  success:function (json){ 
					  showLoreQuestionList(json);
				  }
			});
		}
		//检查答案是否为图片
		function checkAnswerImg(answer){
			if(answer.indexOf("jpg") > 0 || answer.indexOf("gif") > 0 || answer.indexOf("bmp") > 0 || answer.indexOf("png") > 0){
				return true;
			}
			return false;
		}
		//数组答案选项随机排序
		function radomAnswerArray(array){
			var array_new = array;
			array_new.sort(function(){
					return Math.random() > 0.5 ? -1 : 1;
			});
			return array_new;
		}
		//将选项赋值到数组中
		function assignToArray(optionA,optionB,optionC,optionD,optionE,optionF){
			var array = new Array();
			var i = 0;
			if(optionA != ""){
				array[i++] = optionA;
			}
			if(optionB != ""){
				array[i++] = optionB;
			}
			if(optionC != ""){
				array[i++] = optionC;
			}
			if(optionD != ""){
				array[i++] = optionD;
			}
			if(optionE != ""){
				array[i++] = optionE;
			}
			if(optionF != ""){
				array[i++] = optionF;
			}
			return array;
		}
		
		var noUsedQuestionIndexArray = new Array();
		function showLoreQuestionList(list){
			questionLength = list.length;
			$("#questionLength").html(questionLength);
			//var head = "诊断共"+questionLength+"题,点击题号即可查看该题";
			var index_ul = "<ul id='indexNumber' class='tabNav clearfix'></ul>";//题库序列号ul
			var question_ul = "<div class='queListWrap'><div id='ulMainConBox' class='mainUlConBox'><ul id='questionList'></ul></div></div>";//题库列表ul
			$(".botMainCon").append(index_ul);
			
			$("#questionListDiv").append(question_ul);
			if(list != null){
				for(var i = 0 ; i < questionLength; i++){
					var index = i + 1;
					var li_index = "";
					if(index == 1){
						li_index =  "<li id='queIndex_"+index+"' class='quesNum active mls' onclick='showQuestionByIndex("+index+")'>"+"<span></span>"+index+"</li>";//题库序列号li
					}else{
						li_index =  "<li id='queIndex_"+index+"' class='quesNum' onclick='showQuestionByIndex("+index+")'>"+"<span></span>"+index+"</li>";//题库序列号li
					}
					$("#indexNumber").append(li_index);
					
					
					var li_question = "";
					if(index == 1){
						li_question = "<li id='question_"+index+"' name='question_"+index+"' class='tabCon'></li>";//题库列表li-显示
					}else{
						li_question = "<li id='question_"+index+"' name='question_"+index+"' class='tabCon'></li>";//题库列表li-隐藏
					}
					$("#questionList").append(li_question);
					//--------题库列表(问题)---------//
					var question_start_dl = "<dl>";
					var question_type_dd = "<dt class='optionSty' id='loreType_"+index+"'>"+index+"、"+list[i].loreQuestion.questionType+"</dt>";//题库类型
					var question_list_dd = "<dd class='optionTit' id='loreQuestion_"+index+"'>"+list[i].loreQuestion.subject+"</dd>";//题库标题
					var question_option_dd = "<dd id='questionOption_"+index+"'></dd>";//题库答案选项
					var answer_option_dd = "<dd id='answerOption_"+index+"'></dd>";//最后答案选项
					var question_end_dl = "</dl>";
					$("#question_"+index).append(question_start_dl+question_type_dd+question_list_dd+question_option_dd+answer_option_dd+question_end_dl);
					//--------题库列表(问题)---------//
					
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
						var divOption = "<div class='optionDiv'>A、"+answerA + "</div>";
						$("#questionOption_"+index).append(divOption);
					}
					if(list[i].loreQuestion.b != ""){
						
						if(checkAnswerImg(list[i].loreQuestion.b)){
							answerB = "<img src='"+ answerOptionArray[j++] +"'/>";
						}else{
							answerB = replaceChara(answerOptionArray[j++]).replace("<","&lt");
						}
						var divOption = "<div class='optionDiv'>B、"+answerB + "</div>";
						$("#questionOption_"+index).append(divOption);
					}
					if(list[i].loreQuestion.c != ""){
						
						if(checkAnswerImg(list[i].loreQuestion.c)){
							answerC = "<img src='"+ answerOptionArray[j++] +"'/>";
						}else{
							answerC = replaceChara(answerOptionArray[j++]).replace("<","&lt");
						}
						var divOption = "<div class='optionDiv'>C、" + answerC + "</div>";
						$("#questionOption_"+index).append(divOption);
					}
					if(list[i].loreQuestion.d != ""){
						
						if(checkAnswerImg(list[i].loreQuestion.d)){
							answerD = "<img src='"+ answerOptionArray[j++] +"'/>";
						}else{
							answerD = replaceChara(answerOptionArray[j++]).replace("<","&lt");
						}
						var divOption = "<div class='optionDiv'>D、" + answerD + "</div>";
						$("#questionOption_"+index).append(divOption);
					}
					if(list[i].loreQuestion.e != ""){
						
						if(checkAnswerImg(list[i].loreQuestion.e)){
							answerE = "<img src='"+ answerOptionArray[j++] +"'/>";
						}else{
							answerE = replaceChara(answerOptionArray[j++]).replace("<","&lt");
						}
						var divOption = "<div class='optionDiv'>E、" + answerE + "</div>";
						$("#questionOption_"+index).append(divOption);
					}
					if(list[i].loreQuestion.f != ""){
						
						if(checkAnswerImg(list[i].loreQuestion.f)){
							answerF = "<img src='"+ answerOptionArray[j++] +"'/>";
						}else{
							answerF = replaceChara(answerOptionArray[j++]).replace("<","&lt");
						}
						var divOption = "<div class='optionDiv'>F、" + answerF + "</div>";
						$("#questionOption_"+index).append(divOption);
					}	
					//选择答案
					var answer_option_dd = "<dd class='ansMargT' id='answer_option_dd_"+index+"' style='display:no-ne;'></dd>";//最后答案选项DIV
					var result_anwer_dd = "<dd class='myAnsBox clearfix' id='result_answer_dd_"+index+"' style='display:none;'></dd>";//最后结果DIV
					var result_button_dd = "<dd id='result_button_dd_"+index+"' style='display:no-ne;'></dd>";//按钮DIV
					
					$("#answerOption_"+index).append(answer_option_dd+result_anwer_dd+result_button_dd);
					
					var span_my_answer_text = "<div class='myAns fl'><span>我的解答:&nbsp;</span>";
					var span_my_answer_value = "<span class='ans' id='span_my_answer_value_"+index+"'></span></div>";
					var div_my_answer_flag = "<div class='fl' id='div_my_answer_flag_"+index+"'></span>";
					$("#result_answer_dd_"+index).append(span_my_answer_text+span_my_answer_value+div_my_answer_flag);
					
					var answerNumber = 0;
					var questionType_flag = false;
					if(list[i].loreQuestion.questionType == "问答题" || list[i].loreQuestion.questionType == "填空题"){
						questionType_flag = true;
						answerNumber = 1;//只有错和对，所以赋值1;
						var ts_span = "<div id='tishi_"+index+"' class='tishiBox' style='display:no-ne;'><span class='tishiIcon'></span><span>请拿出纸和笔验算一下，这道题有考察解题规范和解题步骤，要认真验算！得出结果后点击提交即可。</span></div>";
						$("#answer_option_dd_"+index).append(ts_span);
						var realAsnwer_result_title_div = "<div id='realAnswer_result_"+index+"' style='display:none;' class='optionParent clearfix'>";
						realAsnwer_result_title_div += "<div class='relRightAnsBox'><span class='relRightAns'>正确答案:</span>&nbsp;"+replaceChara(list[i].loreQuestion.answer)+"</div>";
						realAsnwer_result_title_div += "<span class='optionTxt relRightAns fl'>我的答案</span>";
						realAsnwer_result_title_div += "<div class='optionBox'><input class='optionRadio' type='radio' name='answer_option_radio_"+index+"1' value='1'/><span class='rightSpan'>对</span></div><div class='optionBox'><input class='optionRadio' type='radio' name='answer_option_radio_"+index+"1' value='0'/><span class='errorSpan'>错</span></div>";
						realAsnwer_result_title_div += "<div class='warnningTxt'><span class='warnningIcon'></span>请如实选择，这个非常重要!</div>";
						realAsnwer_result_title_div += "</div>";
						var realAnswer_div = "<div id='realAnswer_"+index+"' style='display:no-ne;'>"+realAsnwer_result_title_div+"</div>";
						$("#answer_option_dd_"+index).append(realAnswer_div);
					}else{
						questionType_flag = false;
						answerNumber = list[i].loreQuestion.answer.split(",").length;//得到有几个正确答案，确定有几组答案选项
						for(var k = 1 ; k <= answerNumber ; k++){
							var number_new = index + "" + k;
							var option_div = "<div id='option_div_"+number_new+"' class='optionParent clearfix'></div>";
							$("#answer_option_dd_"+index).append(option_div);
							var answer_span = "<span class='optionTxt fl'>选项"+k+"</span>"; 
							$("#option_div_"+number_new).append(answer_span);
							var jj = 0;
							for(var ii = 1 ; ii <= j ; ii++){
								var spanNumber = k + "" + ii;
								var answer_option_span_start = "<div id='answer_option_span_"+spanNumber+"' class='optionBox'>";
								//var input_radio_value = answerOptionArray[jj++].replace(/'/g,"‘");
								var input_radio_value = answerOptionArray[jj++];
								var input_radio = "<input type='radio' class='optionRadio' id='answer_option_radio_"+ii+"' name='answer_option_radio_"+number_new+"' value='"+input_radio_value+"'/>";
								var input_lable_value = "<span id='answer_option_label_"+spanNumber+"'>"+ transOption(ii) +"</span>";
								var answer_option_span_end = "</div>";
								$("#option_div_"+number_new).append(answer_option_span_start + "&nbsp;" + input_lable_value + "&nbsp;" + input_radio + "&nbsp;" + answer_option_span_end);
							}
						}
					}
					//提交动作和显示结果
					var loreQuestionId_input_value = "<input type='hidden' id='loreQuestionId_input_"+index+"' value='"+list[i].loreQuestion.id+"'/>";
					var mySelectAnswer_lable_value = "<input type='hidden' id='mySelectAnswer_lable_"+index+"'/>";//自己选择的答案lable
					var mySelectAnswer_input_value = "<input type='hidden' id='mySelectAnswer_input_"+index+"'/>";//自己选择的答案value
					var right_answer_lable_value = "<input type='hidden' id='right_answer_lable_"+index+"'/>";//正确的答案lable
					var right_answer_input_value = "<input type='hidden' id='right_answer_input_"+index+"'/>";//正确的答案value
					//var result_div = "<div id='result_div_"+index+"'>";
					var submit_div = "<div id='tijiao_"+index+"' style='display:no-ne'>";
					var answer_dataBase = list[i].loreQuestion.answer.replace(",","-my-fen-ge-fu-");
					var answer_array = arrayToJson(answerOptionArray);
					var currentLoreId = list[i].loreQuestion.lore.id;
					submit_div += "<span class='goNextBtn'onclick=submitAnswer("+ currentLoreId +","+index+","+answerNumber+","+studyLogId+",'"+encodeURIComponent(encodeURIComponent(answer_array))+"','"+list[i].loreQuestion.questionType+"')>提交</span>";
					submit_div += "</div>";
					var showButton_div = "<div id='showResult_"+index+"' style='display:none;'>";
					showButton_div += "<span class='goNextBtn' onclick='showResult("+index+");'>提交</span>";
					showButton_div += "</div>";
					//result_div = "</div>";
					var nextButton_div = "<div id='next_button_div_"+index+"' style='display:none;'>";
					var nextNumber = index+1;
					nextButton_div += "<span class='goNextBtn' onclick='nextQuestion("+nextNumber+")'>进入下一题</span>";
					nextButton_div += "</div>";
					var resultButton_div = "";
					if(i == questionLength - 1){//表示是最后一题
						resultButton_div = "<div id='result_button_div' style='display:none;'>";
						resultButton_div += "<span class='goNextBtn' onclick='lastSubmitAnswer("+currentLoreId+")'>提交</span>";
						resultButton_div += "</div>";	
					}
					$("#result_button_dd_"+index).append(loreQuestionId_input_value+mySelectAnswer_lable_value+submit_div+showButton_div+nextButton_div+resultButton_div);
					if(questionType_flag){//表示是问答和填空题
						//隐藏首次的提交按钮，并且需要自定义按钮
						$("#tijiao_"+index).hide();
						$("#showResult_"+index).show();
					}else{
						$("#tijiao_"+index).show();
						$("#showResult_"+index).hide();
					}
					if(list[i].realAnser != ""){//做过的题
						getId("answer_option_dd_"+index).style.display = "none";//隐藏答案选项
						getId("result_answer_dd_"+index).style.display = "";//显示我的解答
						//列出答案和我的答案
						$("#span_my_answer_value_"+index).append(list[i].myAnswer);
						var resultFlag;
						if(list[i].result == 1){
							resultFlag = "<span class='finalStateAns posR' title='正确'></span>";
							currentAllQuestionFlag *= 1;
							totalMoney++;
							$(".quesNum span").eq(i).addClass("rightState");
						}else{
							resultFlag = "<span class='finalStateAns posE' title='错误'></span>";
							currentAllQuestionFlag *= 0;
							$(".quesNum span").eq(i).addClass("errorState");
						}
						$("#div_my_answer_flag_"+index).append(resultFlag);
						
						getId("result_button_dd_"+index).style.display = "";//显示按钮DIV
						getId("tijiao_"+index).style.display = "none";//隐藏提交按钮DIV
						getId("showResult_"+index).style.display = "none";//隐藏提交(显示答案)按钮DIV
						if(i == questionLength - 1){//表示是最后一题
							getId("result_button_div").style.display = "";//显示最后总提交按钮DIV
						}else{
							getId("next_button_div_"+index).style.display = "";//显示下一题按钮DIV
						}
						lastCommitNumber++;
					}	
				}
				
				
				
				//在这来执行判断底部答题卡盒子是否需要创建模拟滚动条的方法
				setTimeout(function(){
					$("#questionList").height($(".tabCon").eq(0).height());//初始化将第一个Li的高度给ul
					createQueScroll();
					
				},100);		
				createScrolls();
			}
		}
		//创建底部答题卡的模拟滚动条
		function createScrolls(){
			var oScroll = "<div id='scrollParent' class='parentScroll parScroHei2'><div id='scrollSon' class='sonScrollBar'></div></div>";
			if($(".tabNav").height() > $(".botMainCon").height()){
				$(".botMainCon").append(oScroll);
				scrollBar("botCardBox","indexNumber","scrollParent","scrollSon",10);
			}
		}
		//创建初始化加载第一道题、答题卡题号点击、以及进入下一题下的高度大于父级高度时的模拟滚动条
		var queScrollFlag = true;
		function createQueScroll(){
			$(".queListWrap").height($("#questionListDiv").height() - $(".botCardNumBox").height());
			var oScroll = "<div id='scrollParent1' class='parentScroll parScroHei1'><div id='scrollSon1' class='sonScrollBar'></div></div>";
			if($("#questionList").height() > $(".queListWrap").height()){
				if(queScrollFlag){
					$(".queListWrap").append(oScroll);
					$(".parScroHei1").height($(".queListWrap").height());
				}
				//alert("开始执行当前函数")
				
				scrollBar("ulMainConBox","questionList","scrollParent1","scrollSon1",25);
				if(getId("questionList").offsetTop != 0){
					$("#questionList").animate({"top":0});
					$("#scrollSon1").animate({"top":0});	
				}
				queScrollFlag = false; //之所以变成false防止下次条件满足时再回从新创建滚动条！
			}else{
				//一种情况当前内容不需要创建滚动条。另一种情况是当前提上一题已经创建了滚动条时，当前题应该需要移出该滚动条
				queScrollFlag = true;//变成true是为了执行当下一题的高度不足以创建滚动条时，便于把当前的滚动条给移出了！也问了下次从新创建提供了条件
				if(queScrollFlag){
					$("#scrollParent1").remove();
					$("#questionList").animate({"top":0});
					getId("ulMainConBox").onmousewheel = function(){
						return false;
					};
				}else{
					//
				}
			}
		}
		var wholeScreFlag = true;
		//创建答题卡隐藏后的滚动条
		function crWhoScreenScroll(){
			var oScrollHide = "<div id='scrollParent3' class='parentScroll parScroHei3'><div id='scrollSon3' class='sonScrollBar'></div></div>";
			if($("#questionList").height() > $(".queListWrap").height()){
				if(wholeScreFlag){
					$(".queListWrap").append(oScrollHide);
					$(".parScroHei3").height($(".queListWrap").height());	
				}
				scrollBar("ulMainConBox","questionList","scrollParent3","scrollSon3",25);
				$("#questionList").animate({"top":0});
				$("#scrollSon3").animate({"top":0});
				wholeScreFlag = false;
			}else{
				wholeScreFlag = true;
				if(wholeScreFlag){
					$("#scrollParent3").remove();
					$("#questionList").animate({"top":0});
					getId("ulMainConBox").onmousewheel = function(){
						return false;
					};
				}
			}
		}
		//底部答题卡的隐藏和显示
		var tmp = 1;
		function showHidBotCardBox(){
			if(tmp){//展开答题卡
				$("#scrollParent1").remove();
				$("#questionList").animate({"top":0});
				$(".showHideBtn").removeClass("hideBtn");
				$(".queListWrap").animate({"height":$("#questionListDiv").height() - 10},200);
				$(".botCardNumBox").animate({"bottom":-74},function(){
					crWhoScreenScroll();
					$(".showHideBtn").addClass("showBtn");
				});
				tmp = 0;
			}else{//隐藏答题卡
				$("#scrollParent3").remove();
				$("#questionList").animate({"top":0});
				
				$(".showHideBtn").removeClass("showBtn");
				$(".botCardNumBox").animate({"bottom":10},function(){
					$(".showHideBtn").addClass("hideBtn");
					//变成true为了执行创建模拟滚动条的条件
					queScrollFlag = true;
					wholeScreFlag = true;
					createQueScroll();
				});
				tmp = 1;
			}
		}
		//问答题和填空题时显示答案
		function showResult(index){
			$("#tishi_"+index).hide();//隐藏提示
			$("#showResult_"+index).hide();//隐藏提交按钮(显示正确答案)
			$("#realAnswer_result_"+index).show();//显示正确答案和结果
			$("#tijiao_"+index).show();//显示最后提交按钮
			
		}
		function submitAnswer(currentLoreId,value,answerNumber,studyLogId,answerOptionArray,questionType){
			//向答案结果DIV中添加元素
			//先判断有误选择答案
			//var real_answer = answer_dataBase.replace("-my-fen-ge-fu-",",");
			
			var loreQuestionId = getId("loreQuestionId_input_"+value).value;
			var selectAnserValue_result = "";
			var selectAnserLableValue_result = "";
			var flag = false;
			for(var i = 1 ; i <= answerNumber ; i++){
				var selectAnserValue = $("input[name='answer_option_radio_"+value+i+"']:checked").val();
				if(selectAnserValue == undefined){
					alert("您还没有选择答案!");
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
						var number2 = selectAnserRadioId.replace("answer_option_radio_","");
						selectAnserLableValue_result += $("#answer_option_label_"+number1 + "" + number2).html() + ",";
					}
					flag = true;
				}
			}
			
			if(flag){
				getId("answer_option_dd_"+value).style.display = "none";//隐藏答案选项DIV
				getId("tijiao_"+value).style.display = "none";//隐藏提交按钮DIV
				getId("result_answer_dd_"+value).style.display = ""; //显示答案结果DIV
				
				selectAnserValue_result = delLastSeparator(selectAnserValue_result);
				
				selectAnserLableValue_result = delLastSeparator(selectAnserLableValue_result);
				
				//向答案结果DIV中添加元素
				$("#span_my_answer_value_"+value).append(selectAnserLableValue_result);
				
				//将答案插入数据库
				getId("mySelectAnswer_lable_"+value).value = selectAnserLableValue_result;
				excuteInsertData(loreId,currentLoreId,studyLogId,"针对性诊断",loreQuestionId,value,selectAnserLableValue_result,answerOptionArray);
				if(value == questionLength){//表示最后一题
					getId("result_button_div").style.display = ""; //显示最后提交按钮DIV
					getId("next_button_div_"+value).style.display = "none"; //隐藏下一题按钮DIV
				}else{
					getId("next_button_div_"+value).style.display = ""; //显示下一题按钮DIV
				}
				lastCommitNumber++;
			}else{
				
			}
		}
		//最后提交
		function lastSubmitAnswer(currentLoreId){
			var flag = false;
			var studyLogId_curr = 0;
			var step_new = 0;
			if(lastCommitNumber == questionLength){
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
					window.location.href = "studyOnline.do?action=showTracebackPage&loreId="+loreId+"&tracebackType=review&studyLogId="+studyLogId_curr+"&flag=1&loreName="+encodeURIComponent(loreName);
				}else{
					if(currentAllQuestionFlag == 1){//表示当前题型全部正确
						//access:1--当前级全部正确，2:当前级部分正确或者无正确
						//step1:诊断时如果是本知识典直接全部正确，那么修改isfinish为2，stepComplete为1，access为1
						//step2:诊断时如果是关联知识点当前级全部正确。（转向学习状态）isfinish为1，stepComplete为1，access为1
						//step=0:表示不修改step的值
						if(currentLoreId == loreId){//本知识典全部正确
							studyLogId_curr = updateLogStatus(0,1,2,1,currentLoreId);	
						}else{//是关联知识点当前级全部正确，需要走到第三阶段，关联性诊断的学习阶段
							studyLogId_curr = updateLogStatus(0,1,1,1,currentLoreId);	
						}
					}else{//表示当前题型没有全部正确(继续往下级子知识点)
						if(checkLoreId(window.top.path,currentLoreId)){
							//表示返钱知识点的关联性诊断已经完成，需要走到第三阶段，关联性诊断的学习阶段
							studyLogId_curr = updateLogStatus(0,1,1,2,currentLoreId);
						}else{//第1个参数表示：当前知识点的关联性诊断还未完成
							studyLogId_curr = updateLogStatus(0,0,1,2,currentLoreId);
						}
					}
					window.location.href = "studyOnline.do?action=showTracebackPage&loreId="+loreId+"&tracebackType=review&studyLogId="+studyLogId_curr+"&flag=1&loreName="+encodeURIComponent(loreName);
				}
				
			}else{
				alert("您还有没做完的题,不能进行提交!");
			}
		}
		//判断当前知识点是否是第一个或者最后一个知识点
		function checkLoreId(lorePath,currentLoreId){
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
				  url:"studyOnline.do?action=updateLogStatus&studyLogId="+studyLogId+"&loreId="+loreId+"&step="+step+"&stepComplete="+stepComplete+"&isFinish="+isFinish+"&access="+access+"&loreTaskName="+encodeURIComponent(loreTaskName)+"&currentLoreId="+currentLoreId+"&currentStepLoreArray="+currentStepLoreArray,
				  success:function (json){ //jsonstudyLogId，目的是将studyLogId传递出来
					  if(json != false){
						  if(studyLogId != "0"){
							  studyLogId_curr = studyLogId; 
						  }else{
							  studyLogId_curr = json;
						  } 
					  }
				  }
			});
			return studyLogId_curr;
		}
		//将答题的答案插入数据库
		function excuteInsertData(loreId,currentLoreId,studyLogId,loreType,questionId,questionStep,myAnswer,answerOptionArray){
			var subjectId = "${requestScope.subjectId}";
			var newUrlLog = "&loreId="+loreId+"&currentLoreId="+currentLoreId+"&studyLogId="+studyLogId+"&loreType="+encodeURIComponent(loreType)+"&subjectId="+subjectId;
			var newUrlDetail = "&loreQuestionId="+questionId+"&questionStep="+questionStep;
			newUrlDetail += "&myAnswer="+myAnswer+"&answerOptionArray="+answerOptionArray;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"studyOnline.do?action=insertStudyInfo"+newUrlLog+newUrlDetail+"&loreTaskName="+encodeURIComponent(loreTaskName),
				  success:function (json){
					  if(json == 0){//错
						  $("#div_my_answer_flag_"+questionStep).append("<span class='finalStateAns posE' title='错误'></span>");
						  currentAllQuestionFlag *= 0;
						  $(".quesNum span").eq(questionStep - 1).addClass("errorState");
					  }else{//对
						  $("#div_my_answer_flag_"+questionStep).append("<span class='finalStateAns posR' title='正确'></span>");
						  animatePic("#goldCoinBox",93);
						  currentAllQuestionFlag *= 1;
						  totalMoney++;
						  $(".quesNum span").eq(questionStep - 1).addClass("rightState");
						  
					  }
				  }
			});
		}
		//数组转json
		function arrayToJson(o) {   
		    var r = [];   
		    if (typeof o == "string") 
		    	return "\"" + o.replace(/([\'\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";   
		    if (typeof o == "object") {   
		    	if (!o.sort) {   
		    		for (var i in o)   
					    r.push(i + ":" + arrayToJson(o[i]));   
				    if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)){   
				    	r.push("toString:" + o.toString.toString());   
				    }   
				    r = "{" + r.join() + "}";   
				} else {   
				    for (var i = 0; i < o.length; i++) {   
				    	r.push(arrayToJson(o[i]));   
				    }   
				    r = "[" + r.join() + "]";   
				}   
				return r;   
			}   
		    return o.toString();   
		}  
		function nextQuestion(number){
			if(number <= questionLength){
				for(var i = 1 ; i <= questionLength ; i++){
					if(i != number){
						$("#queIndex_"+i).removeClass('active');//题号
						//$("#question_"+i).hide();//题号对应的题
					}else{
						$("#queIndex_"+i).addClass('active');
						//$("#question_"+i).show();
						
						var oneBigLiWid = $("#ulMainConBox").width();
						var nowLeft = iNow*oneBigLiWid + oneBigLiWid; 
						iNow++;
						$("#questionList").height($(".tabCon").eq(iNow).height());
					 	$("#questionList").stop().animate({"left":-(nowLeft)},500);
						if(tmp == 1){
							createQueScroll();
						}else{
							//alert("表示此时处于隐藏底部答题卡的状态");
							crWhoScreenScroll();
						}
						clearAll();
						setTimerBox();
						timename=setInterval("setTimerBox();",1000);
					}
				}
			}
		}
		//去掉末尾分隔符（","）
		function delLastSeparator(result){
			if(result != ""){
				return result.substring(0,result.length - 1);
			}else{
				return "";
			}
		}
		//将数字转化成字母选项（1,2--A,B）
		function transOption(number){
			if(number == 1){
				return "A";
			}else if(number == 2){
				return "B";
			}else if(number == 3){
				return "C";
			}else if(number == 4){
				return "D";
			}else if(number == 5){
				return "E";
			}else if(number == 6){
				return "F";
			}
		}
		function showQuestionByIndex(index){
			var liObj = "question_"+index;
			
		}
		//计时器
		var m=0,h=0,s=0;
		var use_time = 0;
		function setTimerBox(){
		
			if(s>0 && (s%60)==0){m+=1;s=0;}
			if(m>0 && (m%60)==0){h+=1;m=0;}
			var zsd_str_s = s;
			var zsd_str_m = m;
			var zsd_str_h = h;
			if(zsd_str_s<10) {
				zsd_str_s = '0'+zsd_str_s.toString();
			}
			if(zsd_str_m<10) {
				zsd_str_m = '0'+zsd_str_m.toString();
			}
			if(zsd_str_h<10) {
				zsd_str_h = '0'+zsd_str_h.toString();
			}
			str_t=zsd_str_h+":"+zsd_str_m+":"+zsd_str_s;
			
			$("#usetime_minute").html(zsd_str_m);
			$("#usetime_second").html(zsd_str_s);
			s+=1;
			use_time += 1;
		}
		function clearAll(){
			m=0,h=0,s=0;
			use_time = 0;
			clearInterval(timename);
		}
	</script>
	<style>

	</style>
  </head>
  
  <body>
  <div class="quesListWrap">
  	<div class="listTop">
  		<h2>${requestScope.loreName}</h2>
  		<p class="clearfix">
  			<span id="info" class="forTit fl">针对<span class="strongCol">${requestScope.loreTaskName}</span>而设定的题目</span>
  			<span class="totalNum fl">诊断共<span id="questionLength"></span>题,点击题号即可查看该题</span>
  		</p>
  		<span class="topDec"></span>
  	</div>
  	<div id="diagnosisInfo" style="display:none;">
	  <div id="questionListDiv">
		  <!-- 底部答题卡盒子  -->
		  <div class="botCardNumBox botWid1">
		  	<span class='showHideBtn hideBtn' onclick="showHidBotCardBox()"></span>
		  	<div class="timerLayer">
		  		<span class="timerFont minFont" id="usetime_minute"></span>
		  		<span class="fen">分</span>
    			<span class="timerFont secFont" id="usetime_second"></span>
    			<span class="miao">秒</span>
		  	</div>
		  	<div id="botCardBox" class="botMainCon quesBot"></div>
		  </div>
	  </div>
 	</div>
  	<div id="studyInfo" style="display:none;"></div>
  	 <div id="goldCoinBox">
 		<img src="Module/studyOnline/images/jinbipic.png" width="91" height="93" />
 	</div>
 	<div class="coms">
 		<span class="comsBtn prevPage" title="上一题"></span>
  		<span class="comsBtn nextPage" title="下一题"></span>
 	</div>
  </div>
  </body>
</html>
