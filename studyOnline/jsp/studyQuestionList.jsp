<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>questionList.jsp</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/studyQuestionList.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/comOnlineStudyCss.css" type="text/css" rel="stylesheet"/>
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/loreManager/flashPlayer/images/swfobject.js"></script>
	<script type="text/javascript" src="Module/loreManager/flowPlayer/flowplayer-3.2.13.min.js"></script>
	<script src="Module/studyOnline/js/beginStudy.js" type="text/javascript"></script>
	<script type="text/javascript">
		var loreId = "${requestScope.loreId}";
		var currentLoreId = "${requestScope.nextLoreIdArray}";
		var studyLogId = "${requestScope.studyLogId}";
		var questionLength = 0;
		var totalMoney = 0;
		var lastCommitNumber = 0;
		var currentAllQuestionFlag = 1;
		var loreTaskName = "${requestScope.loreTaskName}";
		var option = "${requestScope.option}";
		var loreName = "${requestScope.loreName}";
		var iNow = 0;
		//替换所有的单引号为自定义字符
		function replaceChara(value){
			return value.replace(/&#wmd;/g,"'");
		}
		$(function(){
			checkFlashHei();
			$(".studBigWrap").height($(window).height() - $(".quesListTop").height());
			$(".comHeight").height($(".studBigWrap").height()-$(".leaStepNavBox").height() - 50);
			$("#curr_lore_name").html(loreName+"<span class='taskSpan'>" + loreTaskName + "</span>");
		});
		


		//点拨指导
		function showGuideList(list){
			$("#guideParentBox").show();
			$("#guideInfo").show();
			
			var head = "<h2 class='headFont posLGuide'>点拨指导，重点、难点、关键点、易混点，认真掌握每一点</h2>";
			var loreType = "";
			var div_zd = "";
			var div_nd = "";
			var title = "";
			var content = "";
			var content_result = "";
			var option = "";
			var firstDivS = "";
			//var fisetDivE = "</div>";
			var div_id = "";
			if(list != null){
				$('#guideParentBox').append(head);
				for(var i = 0 ; i < list.length; i++){
					if(list[i].subType == "重点"){
						div_id = "div_zd";
					}else if(list[i].subType == "难点"){
						div_id = "div_nd";
					}else if(list[i].subType == "关键点"){
						div_id = "div_gjd";
					}else if(list[i].subType == "易混点"){
						div_id = "div_yhd";
					}else{
						
					}
					if(i == 0){//重点
						loreType = "<div class='guideNav'><span class='titIcon fl' title='"+list[i].id+"'></span>"+"<h3 class='headTitle fl'>"+list[i].subType+"</h3></div>";
						title = "<div class='createDiv'><span class='createTit'>标题：</span>"+"<span class='titDetail'>"+list[i].subTitle+"</span>";
						content = "<div class='createCon clearfix'><span class='conTit fl'>内容：</span>"+"<p>"+list[i].subContent+"</p>"+"</div></div>";
						$('#guideInfo').append(loreType + title + content);
					}else{//新增的重点，难点，关键点，易混点
						if(list[i - 1].subType == list[i].subType){
							loreType = "";
							title = "<div class='createDiv'><span class='createTit'>标题：</span>"+"<span class='titDetail'>"+list[i].subTitle+"</span>";
							content = "<div class='createCon clearfix'><span class='conTit fl'>内容：</span>"+list[i].subContent+"</div></div>";
							$('#guideInfo').append(title + content);
						}else{//难点，关键点，易混点
							//firstDivS = "<div id='"+div_id+"'>'"+list[i].id+"'</div>";
							firstDivS = "<div id='"+div_id+"' class='botShadow'></div>";
							loreType = "<div class='guideNav'><span class='titIcon fl' title='"+list[i].id+"'></span>"+"<h3 class='headTitle fl'>"+list[i].subType+"</h3></div>";
							title = "<div class='createDiv'><span class='createTit'>标题：</span>"+"<span class='titDetail'>"+list[i].subTitle+"</span>";
							content = "<div class='createCon clearfix'><span class='conTit fl'>内容：</span>"+list[i].subContent+"</div></div>";
							$('#guideInfo').append(firstDivS + loreType + title + content);
						}
					}
					
					//content_result += firstDivS + loreType + title + content + fisetDivE;
				}
			}
			var buttonHtml = "<input type='button' class='begLeaBtn' id='comLook' value='我看完了' disabled onclick=getSourceList('${requestScope.nextLoreIdArray}','知识清单')></input>";
			//$('#guideInfo').html(head + content_result + buttonHtml);
			$('#guideInfo').append(buttonHtml);
		}
		
		//显示知识清单列表
		function showLoreList(list){
			$("#listParentBox").show();
			$("#listInfo").show();
			
			var head = "<h2 class='headFont posLoreList'>知识清单，本节知识点需要背诵的内容</h2>";
			var title = "";
			var content = "";
			var content_result = "";
			if(list != null){
				$("#listParentBox").append(head);
				for(var i = 0 ; i < list.length; i++){
					title = "<div class='createDivList'><span class='listTitIcon'></span><span class='createTitList'>标题：</span>"+"<span class='titDetail'>"+list[i].subTitle+"</span>";
					content = "<div class='createConList clearfix'><span class='conTitList fl'>内容：</span>"+"<div class='listConP'>"+list[i].subContent+"</div>"+"</div><div class='decLine'></div></div>";
					content_result += title + content;
				}
			}
			
			var buttonHtml = "<input type='button' class='begLeaBtn' id='comBei' value='我背完了' disabled onclick=getSourceList('${requestScope.nextLoreIdArray}','解题示范')>";
			$('#listInfo').html(content_result + buttonHtml);
		}
		
		//显示解题示范列表
		function showExampleList(list){
			$("#exaParentBox").show();
			$("#exampleInfo").show();
			
			var head = "<h2 class='headFont posExa'>解题示范，学习解题方法，规范解题步骤</h2>";
			var subject = "";
			var selfAnswerButton = "";
			var showAnswerButton = "";
			var answer = "";
			var resolution = "";
			var content_result = "";
			var answerDiv = "";
			var selfAnswerInfo = "";
			var realAnwerInfo = "";
			var number = "";
			if(list != null){
				$('#exaParentBox').append(head);
				for(var i = 0 ; i < list.length; i++){
					subject = "<div class='createDivExamp' id='"+list[i].id+"'><div class='clearfix'><span class='listTitIcon'></span><span class='exaTit'>题干：</span>"+"<div class='exaTitCon'>"+list[i].subject+"</div></div>";
					selfAnswerButton = "<div id='bt_"+list[i].id+"' class='exampleBtnBox' onclick=showSelfAnswerInfo('"+list[i].id+"')><span id='bt_selfSpan"+list[i].id+"' class='exaComIcon'></span><span class='exaText'>自己解题</span></div>";
					showAnswerButton = "<div class='exampleBtnBox' onclick=showRealAnswerInfo('"+list[i].id+"')><span id='bt_showAnsSpan"+list[i].id+"' class='exaComIcon'></span><span class='exaText'>查看答案</span></div>";
					//answerDiv = "<div id='answer_"+list[i].id+"' style='display:n-one;'>";
					selfAnswerInfo = "<div id='selfAnswer_"+list[i].id+"' style='display:none;'>";
					selfAnswerInfo += "<p class='selfDoInfos'>请拿出纸和笔写下你的解题过程</p><p class='selfDoInfos'>请注意规范步骤与书写格式</p><p class='selfDoInfos'>请像对待考试一样。解完题，请选择“看答案”</p>";
					selfAnswerInfo += "</div>";
					realAnwerInfo = "<div id='realAnswer_"+list[i].id+"' class='checkAnsBox' style='display:none;'>";
					realAnwerInfo += "<span class='lookAns'>答案：</span> "+list[i].answer+"";
					realAnwerInfo += "<span class='explainTit'>解析：</span> "+list[i].resolution;
					realAnwerInfo += "</div>";
					//answerDiv += selfAnswerInfo + realAnwerInfo + "</div>";
					number += list[i].id + ",";
					content_result = subject + selfAnswerButton + selfAnswerInfo + showAnswerButton +  realAnwerInfo + "<div class='decLine'></div></div>";
					$('#exampleInfo').append(content_result);
				}
			}
			var flag = "<input type='hidden' id='number_jtsf' value='"+number+"'/>";
			var buttonHtml = "<input type='button' class='begLeaBtn' value='我学会了' onclick=getSourceList('${requestScope.nextLoreIdArray}','巩固训练')>";
			$('#exampleInfo').append(flag+buttonHtml);
		}
		
		//自己解题
		function showSelfAnswerInfo(divObj){
			var allNumber = getId("number_jtsf").value;
			getId("number_jtsf").value = allNumber.replace(divObj+",","");
			$("#answer_"+divObj).slideDown();
			$("#selfAnswer_"+divObj).slideDown();
			$("#realAnswer_"+divObj).slideUp();
			
			//$("#bt_selfjiajian"+divObj).html("-");	
			//$("#bt_showAnsjiajian"+divObj).html("+");
			//$("#bt_"+divObj).attr("class","complete");
			$("#bt_"+divObj).attr("class","exampleBtnBox");
			
			$("#bt_selfSpan"+divObj).removeClass("exaComIcon");
			$("#bt_selfSpan"+divObj).addClass("hasOpenIcon");
			
			$("#bt_showAnsSpan"+divObj).removeClass("hasOpenIcon");
			$("#bt_showAnsSpan"+divObj).addClass("exaComIcon");
		}
		//看答案
		function showRealAnswerInfo(divObj){
			$("#answer_"+divObj).slideDown();
			$("#realAnswer_"+divObj).slideDown();
			$("#selfAnswer_"+divObj).slideUp();
			//$("#bt_showAnsjiajian"+divObj).html("-");
			//$("#bt_selfjiajian"+divObj).html("+");	
			
			$("#bt_selfSpan"+divObj).removeClass("hasOpenIcon");
			$("#bt_selfSpan"+divObj).addClass("exaComIcon");
			
			$("#bt_showAnsSpan"+divObj).removeClass("exaComIcon");
			$("#bt_showAnsSpan"+divObj).addClass("hasOpenIcon");
		}

		//巩固训练
		function showConsolidationList(list){
			$("#consolidationInfo").show();
			$(".gongguBtns").show();
			setTimerBox();
			timename=setInterval("setTimerBox();",1000);
			questionLength = list.length;
			var head = "<h2 class='headFont_1'>巩固训练共"+questionLength+"题,点击题号即可查看该题</h2>";
			var index_ul = "<ul id='indexNumber' class='tabNav clearfix'></ul>";//题库序列号ul
			var question_ul = "<div id='ulMainConBox' class='mainUlConBox'><ul id='questionList'></ul></div>";//题库列表ul
			$(".botMainCon").append(index_ul);
			$("#consolidationInfo").append(head+question_ul);
			$("#ulMainConBox").height($("#consolidationInfo").height() - 30);
			if(list != null){
				for(var i = 0 ; i < questionLength; i++){
					var index = i + 1;
					var li_index = "";
					if(index == 1){
						li_index =  "<li id='queIndex_"+index+"' class='quesNum active' onclick='showQuestionByIndex("+index+")'>"+"<span></span>"+index+"</li>";//题库序列号li
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
					var question_type_dd = "<dd class='optionSty' id='loreType_"+index+"'>"+index+"、"+list[i].loreQuestion.questionType+"</dd>";//题库类型
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
					if(list[i].loreQuestion.loreTypeName == "巩固训练"){
						var real_answer = "<input type='hidden' id='real_answer_"+index+"' value='"+replaceChara(list[i].loreQuestion.answer)+"'>";//正确答案
						$("#answerOption_"+index).append(answer_option_dd+real_answer+result_anwer_dd+result_button_dd);
					}else{
						$("#answerOption_"+index).append(answer_option_dd+result_anwer_dd+result_button_dd);
					}
					var span_my_answer_text = "<div class='myAns fl'><span>我的解答:&nbsp;</span>";
					var span_my_answer_value = "<span class='ans' id='span_my_answer_value_"+index+"'></span></div>";
					var div_my_answer_flag = "<div class='fl' id='div_my_answer_flag_"+index+"'></span>";
					$("#result_answer_dd_"+index).append(span_my_answer_text+span_my_answer_value+div_my_answer_flag);
					//12-28新增加1
					var answerNumber = 0;
					var questionType_flag = false;
					if(list[i].loreQuestion.questionType == "问答题" || list[i].loreQuestion.questionType == "填空题"){
						questionType_flag = true;
						answerNumber = 1;//只有错和对，所以赋值1;
						var ts_span = "<div id='tishi_"+index+"' class='tishiBox' style='display:no-ne;'><span class='tishiIcon'></span><b>请拿出纸和笔验算一下，这道题有考察解题规范和解题步骤，要认真验算！得出结果后点击提交即可。</b></div>";
						$("#answer_option_dd_"+index).append(ts_span);
						var realAsnwer_result_title_div = "<div id='realAnswer_result_"+index+"' style='display:none;' class='optionParent clearfix'>";
						realAsnwer_result_title_div += "<div class='relRightAnsBox'><span class='relRightAns'>正确答案:</span>&nbsp;"+replaceChara(list[i].loreQuestion.answer)+"</div>";
						realAsnwer_result_title_div += "<span class='optionTxt relRightAns fl'>我的答案</span>";
						realAsnwer_result_title_div += "<div class='optionBox'><input class='optionRadio' type='radio' name='answer_option_radio_"+index+"1' value='1'/><span>对</span></div><div class='optionBox'><input class='optionRadio' type='radio' name='answer_option_radio_"+index+"1' value='0'/><span>错</span></div>";
						realAsnwer_result_title_div += "<div class='warnningTxt'><span class='warnningIcon'></span>请如实选择，这个非常重要!</div>";
						realAsnwer_result_title_div += "</div>";
						var realAnswer_div = "<div id='realAnswer_"+index+"' style='display:no-ne;'>"+realAsnwer_result_title_div+"</div>";
						$("#answer_option_dd_"+index).append(realAnswer_div);
					//12-28新增加1
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
								var input_radio_value = answerOptionArray[jj++];
								var input_radio = "<input type='radio' id='answer_option_radio_"+ii+"' class='optionRadio' name='answer_option_radio_"+number_new+"' value='"+input_radio_value+"'/>";
								var input_lable_value = "<span id='answer_option_label_"+spanNumber+"'>"+ transOption(ii) +"</span>";
								var answer_option_span_end = "</div>";
								$("#option_div_"+number_new).append(answer_option_span_start + "&nbsp;" + input_lable_value + "&nbsp;" + input_radio + "&nbsp;" + answer_option_span_end);
							}
						}
					}
					choiceOptionAns();
					//提交动作和显示结果
					var loreQuestionId_input_value = "<input type='hidden' id='loreQuestionId_input_"+index+"' value='"+list[i].loreQuestion.id+"'/>";
					var mySelectAnswer_lable_value = "<input type='hidden' id='mySelectAnswer_lable_"+index+"'/>";//自己选择的答案lable
					var mySelectAnswer_input_value = "<input type='hidden' id='mySelectAnswer_input_"+index+"'/>";//自己选择的答案value
					var right_answer_lable_value = "<input type='hidden' id='right_answer_lable_"+index+"'/>";//正确的答案lable
					var right_answer_input_value = "<input type='hidden' id='right_answer_input_"+index+"'/>";//正确的答案value
					var submit_div = "<div id='tijiao_"+index+"' style='display:no-ne'>";
					var answer_dataBase = list[i].loreQuestion.answer.replace(",","-my-fen-ge-fu-");
					var answer_array = arrayToJson(answerOptionArray);
					var currentLoreId = list[i].loreQuestion.lore.id;
					submit_div += "<span class='goNextBtn' onclick=submitAnswer("+ currentLoreId +","+index+","+answerNumber+","+studyLogId+",'"+encodeURIComponent(encodeURIComponent(answer_array))+"','"+list[i].loreQuestion.loreTypeName+"','"+list[i].loreQuestion.questionType+"')>提交</span>";
					submit_div += "</div>";
					//12-28新增加2
					var showButton_div = "<div id='showResult_"+index+"' style='display:none;'>";
					showButton_div += "<span class='goNextBtn' onclick='showResult("+index+");'>提交</span>";
					showButton_div += "</div>";
					//12-28新增加2
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
					//12-28新修改3
					if(option == "relationStudy"){
						//学习记录关联结果里面不需要最后提交
						$("#result_button_dd_"+index).append(loreQuestionId_input_value+mySelectAnswer_lable_value+submit_div+showButton_div+nextButton_div);
					}else{
						$("#result_button_dd_"+index).append(loreQuestionId_input_value+mySelectAnswer_lable_value+submit_div+showButton_div+nextButton_div+resultButton_div);
					}
					
					//12-28新修改3
					//12-28新增加4
					if(questionType_flag){//表示是问答和填空题
						//隐藏首次的提交按钮，并且需要自定义按钮
						$("#tijiao_"+index).hide();
						$("#showResult_"+index).show();
					}else{
						$("#tijiao_"+index).show();
						$("#showResult_"+index).hide();
					}
					//12-28新增加4
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
						if(i == questionLength - 1){//表示是最后一题
							getId("result_button_div").style.display = "";//显示最后总提交按钮DIV
						}else{
							getId("next_button_div_"+index).style.display = "";//显示下一题按钮DIV
						}
						lastCommitNumber++;
					}				
				}
				setTimeout(function(){
					$("#questionList").height($(".tabCon").eq(0).height());//初始化将第一个Li的高度给ul
					createQueScroll();
				},150);
			}
		}
		//创建初始化加载第一道题、答题卡题号点击、以及进入下一题下的高度大于父级高度时的模拟滚动条
		var queScrollFlag = true;
		function createQueScroll(){
			//$(".queListWrap").height($("#questionListDiv").height() - $(".botCardNumBox").height());
			var oScroll = "<div id='scrollParent' class='parentScroll'><div id='scrollSon' class='sonScroll'></div></div>";
			if($("#questionList").height() > $(".mainUlConBox").height()){
				if(queScrollFlag){
					$("#consolidationInfo").append(oScroll);
					$(".parentScroll").height($(".studBigWrap").height() - 11);
				}
				scrollBar("ulMainConBox","questionList","scrollParent","scrollSon",25);
				if(getId("questionList").offsetTop != 0){
					$("#questionList").animate({"top":0});
					$("#scrollSon").animate({"top":0});	
				}
				queScrollFlag = false; //之所以变成false防止下次条件满足时再回从新创建滚动条！
			}else{
				//一种情况当前内容不需要创建滚动条。另一种情况是当前提上一题已经创建了滚动条时，当前题应该需要移出该滚动条
				queScrollFlag = true;//变成true是为了执行当下一题的高度不足以创建滚动条时，便于把当前的滚动条给移出了！也问了下次从新创建提供了条件
				if(queScrollFlag){
					$("#scrollParent").remove();
					$("#questionList").animate({"top":0});
					getId("ulMainConBox").onmousewheel = function(){
						return false;
					};
				}else{
					//
				}
			}
		}
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
				createQueScroll();
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
					alert("已经是第一题了！");
				}
				tabs();
			});
		}
		//12-28新增加5
		//问答题和填空题时显示答案
		function showResult(index){
			$("#tishi_"+index).hide();//隐藏提示
			$("#showResult_"+index).hide();//隐藏提交按钮(显示正确答案)
			$("#realAnswer_result_"+index).show();//显示正确答案和结果
			$("#tijiao_"+index).show();//显示最后提交按钮
			
		}
		//12-28新增加5
		function submitAnswer(currentLoreId,value,answerNumber,studyLogId,answerOptionArray,loreTypeName,questionType){
			//向答案结果DIV中添加元素
			//先判断有误选择答案
			
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
					//12-28新修改6
					flag = true;
				}
			}
			
			if(flag){
				getId("answer_option_dd_"+value).style.display = "none";//隐藏答案选项DIV
				getId("tijiao_"+value).style.display = "none";//隐藏提交按钮DIV
				getId("result_answer_dd_"+value).style.display = ""; //显示答案结果DIV
				
				selectAnserValue_result = delLastSeparator(selectAnserValue_result);
				selectAnserLableValue_result = delLastSeparator(selectAnserLableValue_result);
				//12-28新修改7
				//向答案结果DIV中添加元素

				$("#span_my_answer_value_"+value).append(selectAnserLableValue_result);
				
				//将答案插入数据库
				getId("mySelectAnswer_lable_"+value).value = selectAnserLableValue_result;
				/**
				if(loreTypeName == "巩固训练"){
					var real_answer = getId("real_answer_"+value).value;
					if(real_answer == selectAnserValue_result){
						$("#div_my_answer_flag_"+value).append("<span class='finalStateAns posR' title='正确'></span>");
						 $(".quesNum span").eq(value - 1).addClass("rightState");
					}else{
						$("#div_my_answer_flag_"+value).append("<span class='finalStateAns posE' title='错误'></span>");
						 $(".quesNum span").eq(value - 1).addClass("errorState");
					}
				}else{
					excuteInsertData(loreId,currentLoreId,studyLogId,"巩固训练",loreQuestionId,value,selectAnserLableValue_result,answerOptionArray);
				}
				**/
				excuteInsertData(loreId,currentLoreId,studyLogId,"巩固训练",loreQuestionId,value,selectAnserLableValue_result,answerOptionArray);
				
				if(value == questionLength){//表示最后一题
					if(option == "relationStudy"){
						//学习记录关联结果
					}else{
						getId("result_button_div").style.display = ""; //显示最后提交按钮DIV
					}
					getId("next_button_div_"+value).style.display = "none"; //隐藏下一题按钮DIV
				}else{
					getId("next_button_div_"+value).style.display = ""; //显示下一题按钮DIV
				}
				lastCommitNumber++;
			}
		}
		//将答题的答案插入数据库
		function excuteInsertData(loreId,currentLoreId,studyLogId,loreType,questionId,questionStep,myAnswer,answerOptionArray){
			var newUrl = "";
			if(option == "relationStudy"){
				//学习记录关联结果
				newUrl = "studyOnline.do?action=checkStudyQuestuionList&loreQuestionId="+questionId+"&myAnswer="+myAnswer+"&answerOptionArray="+answerOptionArray;
			}else{
				var subjectId = "${requestScope.subjectId}";
				var newUrlLog = "&loreId="+loreId+"&currentLoreId="+currentLoreId+"&studyLogId="+studyLogId+"&loreType="+encodeURIComponent(loreType)+"&subjectId="+subjectId;
				var newUrlDetail = "&loreQuestionId="+questionId+"&questionStep="+questionStep;
				newUrlDetail += "&myAnswer="+myAnswer+"&answerOptionArray="+answerOptionArray;
				newUrl = "studyOnline.do?action=insertStudyInfo"+newUrlLog+newUrlDetail+"&loreTaskName="+encodeURIComponent(loreTaskName);
			}
			
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:newUrl,
				  success:function (json){
					  if(json == 0){//错
						  $("#div_my_answer_flag_"+questionStep).append("<span class='finalStateAns posE' title='错误'></span>");
						  currentAllQuestionFlag *= 0;
						  animatePic("#errPicBox",128);
						  $(".quesNum span").eq(questionStep - 1).addClass("errorState");
					  }else{//对
						  $("#div_my_answer_flag_"+questionStep).append("<span class='finalStateAns posR' title='正确'></span>");
						  currentAllQuestionFlag *= 1;
						  totalMoney++;
						  animatePic("#rigPicBox",128);
						  $(".quesNum span").eq(questionStep - 1).addClass("rightState");
					  }
				  }
			});
		}
		//最后提交
		function lastSubmitAnswer(currentLoreId){
			var flag = false;
			var studyLogId_curr = 0;
			var step_new = 0;
			if(lastCommitNumber == questionLength){
				//表示巩固训练做完，修改step的值为3，stepComplete=0,,isFinish=0,access=3
				//access:2--巩固训练完成（需要进入该阶段的再次诊断）
				//access:1--该阶段的再次诊断完成（需要进入下一个知识典的5步学习法）
				//access:0--5部学习法未完成
				//step默认为3--学习关联知识典阶段
				//只要巩固训练做完后就修改状态
				//先查询有无再次诊断的记录
				if(currentLoreId == loreId){
					step_new = 4;
				}else{
					step_new = 3;
				}
				studyLogId_curr = updateLogStatus(step_new,0,1,3);	
				window.location.href = "studyOnline.do?action=showTracebackPage&loreId="+loreId+"&tracebackType=review&studyLogId="+studyLogId_curr+"&flag=1&currentLoreId="+currentLoreId+"&loreName="+encodeURIComponent(loreName);
			}else{
				alert("您还有没做完的题,不能进行提交!");
			}
		}
		/**
		当前阶段完成，修改指定logId的isFinish状态、stepComplete状态，access状态
		stepComplete:该阶段完成状态0：未完成，1：完成
		isFinish:该知识点完成状态1：未完成，2：完成
		access：该阶段关联知识点完成状态0：未完成，1：完成
		**/
		function updateLogStatus(step,stepComplete,isFinish,access){
			var studyLogId_curr = 0;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"studyOnline.do?action=updateLogStatus&studyLogId="+studyLogId+"&loreId="+loreId+"&step="+step+"&stepComplete="+stepComplete+"&isFinish="+isFinish+"&access="+access+"&currentLoreId="+currentLoreId+"&type=study",
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
		//检查答案是否为图片
		function checkAnswerImg(answer){
			if(answer.indexOf("jpg") > 0 || answer.indexOf("gif") > 0 || answer.indexOf("bmp") > 0 || answer.indexOf("png") > 0){
				return true;
			}
			return false;
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
						$("#queIndex_"+i).removeClass('active');
						//$("#question_"+i).hide();
					}else{
						$("#queIndex_"+i).addClass('active');
						//$("#question_"+i).show();
						var oneBigLiWid = $("#ulMainConBox").width();
						var nowLeft = iNow*oneBigLiWid + oneBigLiWid; 
						iNow++;
						$("#questionList").height($(".tabCon").eq(iNow).height());
					 	$("#questionList").stop().animate({"left":-(nowLeft)},500);
					 	
						createQueScroll();
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
		function showQuestionByIndex(index){
			var liObj = "question_"+index;
			
		}
		//选择项鼠标按上去后激活的状态
		function choiceOptionAns(){
			$(".optionRadio").each(function(){
				$(this).click(function(){
					$(this).parent("div").addClass("current").append("<b></b>").siblings().removeClass("current").find('b').remove();	
				});
			});
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
		function checkFlashHei(){
			var oHeight = $(window).height();
			if(oHeight < 650){
				$(".viewPlaceBox").css({
					"width":600,
					"height":300
				});
			}
		}
	</script>
</head>
<body>
<div class="studyQuestionListWrap">
	
	<span class="bottomDec"></span>
	<div class="quesListTop">
		<h2 id="curr_lore_name">${requestScope.loreName}</h2>
		<span class="topDec"></span>
	</div>
	<!--  div class="quesListTop">
		<h2>${requestScope.loreName}</h2>
		
	</div-->
	<div class="studBigWrap">
		<!--  五步学习法的学前顺序大盒子  -->
		<div class="emptyDiv"></div>
		<div id="explainInfo" class="explainBox">
			<!--  五步的顺序进行学习的盒子 -->
			<div class="topGuiBox clearfix">
				<!-- 听  -->
				<div class="comGuideBox listenBox mr fl">
					<span class="comBor bgCol1"></span>
					<h3 class="guideTit col1">视频讲解</h3>
					<span class="guideNum">01</span>
					<p class="guideExplain">一线老师精心制作,短小精悍、内容丰富。认真听讲、彻底掌握！</p>
				</div>
				<!--  看  -->
				<div class="comGuideBox lookBox mr fl">
					<span class="comBor bgCol2"></span>
					<h3 class="guideTit col2">点拨指导</h3>
					<span class="guideNum">02</span>
					<p class="guideExplain">了解重点、难点、关键点、易混点。</p>
				</div>		
				<!--  背  -->
				<div class="comGuideBox memoryBox fl">
					<span class="comBor bgCol3"></span>
					<h3 class="guideTit col3">知识清单</h3>
					<span class="guideNum">03</span>
					<p class="guideExplain">背会定理、公理、概念、定义，抓牢基础是关键。</p>
				</div>
			</div>
			<div class="botGuiBox clearfix">
				<!--  学  -->
				<div class="comGuideBox learnBox fr">
					<span class="comBor bgCol4"></span>
					<h3 class="guideTit col4">解题示范</h3>
					<span class="guideNum">04</span>
					<p class="guideExplain">跟着老师学习做题，掌握解题方法、学习解题思路，规范解题过程。</p>
				</div>
				<!--  固  -->
				<div class="comGuideBox1 strengthBox fr mr">
					<span class="comBor bgCol5"></span>
					<span class="targentIcon"></span>
					<h3 class="guideTit col5">巩固训练</h3>
					<span class="guideNum posR">05</span>
					<p class="guideExplain">巩固一下刚才学的知识。</p>
				</div>
			</div>
			<input type="button" class="begLeaBtn" value="开始学习" onclick="goStudy()"/>
		</div>
		
		<!-- 点击开始学习后进入的顺序学习盒子  -->
		<div class="leaStepNavBox"  style="display:none;">
			<ul class="tabNavs clearfix">
				<li class="active">
					<span class="iconStep"><i>听</i></span>
					<p class="expInfo L">视频讲解</p>
				</li>
				<li id="guidePoint">
					<span class="iconStep"><i>看</i></span>
					<p class="expInfo L1">点拨指导</p>
				</li>
				<li id="loreListBox">
					<span class="iconStep"><i>背</i></span>
					<p class="expInfo L2">知识清单</p>
				</li>
				<li id="exampleKpBox">
					<span class="iconStep"><i>学</i></span>
					<p class="expInfo L3">解题示范</p>
				</li>
				<li id="consolidKpBox">
					<span class="iconStep"><i>固</i></span>
				</li>
			</ul>
			<div class="throwLine"></div>
			<div id="colorBox" class="colorLine"></div>
			<div id="moveBox" class="moveIcon"></div>
			<p class="expInfo1">巩固训练</p>
		</div>
		<!--  视频讲解  -->
		<div id="videoInfo" class="flahsBoxs" style="display:none;">
			<h2 class='headFont posFlash'>视频讲解，一线老师为您精心制作的视频</h2>
			<div id="viewerPlaceHolder" class="viewPlaceBox" style="width:600px; height:385px"></div>
			<input type="button" class="begLeaBtn" value="我听完了" onclick="getSourceList('${requestScope.nextLoreIdArray}','点拨指导')"/>
		</div>	
		
		<!--  点拨指导  -->
		<div id="guideParentBox" style="display:none;">
			<div id="guideInParent" class="innerWrapBox comHeight">
				<div id="guideInfo" class="comPosBox" style="display:none;"></div>
			</div>
		</div>
			
		<!--  知识清单  -->
		<div id="listParentBox" style="display:none;">
			<div id="listInParent" class="innerWrapBox comHeight" >
				<div id="listInfo" class="comPosBox" style="display:none;"></div>
			</div>
		</div>	
			
		<!--  解题示范  -->
		<div id="exaParentBox" style="display:none;">
			<div id="exaInParent" class="innerWrapBox comHeight">
				<div id="exampleInfo" class="comPosBox" style="display:none;"></div>
			</div>
		</div>		
		<!--  巩固训练  -->
		<div id="consolidationInfo" class="comHeight"  style="display:none;">
			<div class="botCardNumBox botWid2">
			  	<span class="showHideBtn queNums"></span>
			  	<div id="botCardBox" class="botMainCon conSolidBot"></div>
			  	<div class="timerLayer">
			  		<span class="timerFont minFont" id="usetime_minute"></span>
			  		<span class="fen">分</span>
	    			<span class="timerFont secFont" id="usetime_second"></span>
	    			<span class="miao">秒</span>
		  		</div>
			</div>
		</div>
	</div>
 	
 	<!--  巩固训练页面下呈现的答题正确与否的图片效果展示 盒子 -->
 	<div id="rigPicBox">
 		<img src="Module/studyOnline/images/rigStatePic.png" width="128" height="128" />
 	</div>
 	
 	<div id="errPicBox">
 		<img src="Module/studyOnline/images/errStatePic.png" width="128" height="128" />
 	</div>
 	<div class="coms gongguBtns">
 		<span class="comsBtn prevPage" title="上一题"></span>
  		<span class="comsBtn nextPage" title="下一题"></span>
 	</div>
</div>
</body>
</html>