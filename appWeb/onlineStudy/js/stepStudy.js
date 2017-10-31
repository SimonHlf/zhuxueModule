//初始化五步学习导航的每个li的宽度
function initLiWid(){
	$(".studyNav li").each(function(i){
		$(".studyNav li").eq(i).width(parseInt($(".studyNav").width()/5)-1);
	});
	$("#moveDiv").width($("#guidePoint").width());
	$(".errorDivWrap").height(cliHei - $("#nowLoc").height());
	$(".comErrRigDiv").width($(".comErrDiv").width() - $(".errTitSpan").width());
}
//听、说、读、写数据
function getStepStudyInfo(){
	if(checkLoginStatus()){
		var flag_async = true;//异步
		if(loreTypeName == "practice"){
			var allNumber = $("#number_jtsf").val();
			if(allNumber == ""){
				flag_async = true;
			}else{
				flag_async = false;
			}
		}
		$.ajax({
			  type:"post",
			  async:flag_async,//同步
			  dataType:"json",
			  data:{loreId:loreId,loreTypeName:loreTypeName,currentLoreId:currentLoreId,studyLogId:studyLogId,nextLoreIdArray:currentLoreId},
			  url:"studyApp.do?action=getStepStudyJson&cilentInfo=app",
			  beforeSend:function(){
	        	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
			  },
			  success:function (json){ 
				  showStepStudyInfo(json["result"]);
			  },
			  complete:function(){
	        	$("#loadDataDiv").hide();
	        	$(".loadingIcon").remove();
	          }
		});
	}
}	
//显示数据
function showStepStudyInfo(list){
	var buttonValue = "";
	var content = "";
	$("#studyInfo").removeAttr("style");
	if(list.length > 0){
		if(loreTypeName == "video"){
			loreTypeName = "guide";
			var videoPath = list[0].answer;
			buttonValue = "我听完了";
			if(videoPath.indexOf("flv") > 0){
				videoPath = videoPath.replace(".flv",".mp4");
				$("#studyInfo").height(cliHei - 165);
				showH5Video(videoPath,"videoBox","100%","95%");
			}else{
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("暂不支持<br/>该视频播放格式");
				commonTipInfoFn($(".warnInfoDiv"));
			}
		}else if(loreTypeName == "guide"){
			loreTypeName = "loreList";
			buttonValue = "我看完了";
			showGuideList(list);
		}else if(loreTypeName == "loreList"){
			loreTypeName = "example";
			buttonValue = "我背完了";
			showLoreList(list);
		}else if(loreTypeName == "example"){
			loreTypeName = "practice";
			buttonValue = "我学会了";
			showExampleList(list);
		}else if(loreTypeName == "practice"){
			var allNumber = $("#number_jtsf").val();
			if(allNumber == ""){
				//newUrl = "studyOnline.do?action=loadQuestionList&loreId="+loreId+"&studyLogId="+studyLogId+"&nextLoreIdArray="+currentLoreId+"&loreTypeName="+encodeURIComponent(loreType);
				//开始巩固训练
				showConsolidationList(list);
				$("#buttonInfo").hide();//隐藏前几步的底部button
			}else{
				var number = allNumber.split(",").length - 1;
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html(number+"题尚未解答<br/>请继续答题");
				commonTipInfoFn($(".warnInfoDiv"));
				buttonValue = "我学会了";
			}
		}
		$("#buttonInfo").html(buttonValue);
	}
}

//点拨指导
function showGuideList(list){
	$('#studyInfo').html("");
	var loreType = "";
	var div_zd = "";
	var div_nd = "";
	var title = "";
	var content = "";
	var content_result = "";
	var option = "";
	var firstDivS = "";
	var div_id = "";
	var comMoveWid = Math.ceil(($("#guidePoint").width() - $("#moveBox").width())/2);
	if(list != null){
		$("#studyInfo").height(cliHei - 175);
		var guideBox = "<div id='guideCon' class='guideWrap'><div id='guideScroll'></div></div>";
		$("#studyInfo").append(guideBox);
		$("#guideCon").height($("#studyInfo").height());
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
				loreType = "<h3 class='headTitle'><i class='targetIcon'></i>"+list[i].subType+"</h3>";
				title = "<div class='createDiv'><p class='titP clearfix'><span class='comSpanTit fl'>标题： </span>"+"<span class='comSpanTitCon fl'>"+list[i].subTitle+"</span></p>";
				content = "<div class='clearfix'><span class='comSpanTit conTit fl'>内容：</span>"+"<div class='conWrap fl'><p>" +list[i].subContent + "</p></div>" +"</div></div>";
				$('#guideScroll').append(loreType + title + content);
			}else{//新增的重点，难点，关键点，易混点
				if(list[i - 1].subType == list[i].subType){
					loreType = "";
					title = "<div class='createDiv'><p class='titP clearfix'><span class='comSpanTit fl'>标题： </span>"+"<span class='comSpanTitCon fl'>"+list[i].subTitle+"</span></p>";
					content = "<div class='clearfix'><span class='comSpanTit conTit fl'>内容：</span>"+"<div class='conWrap fl'><p>" +list[i].subContent + "</p></div>" +"</div></div>";
					$('#guideScroll').append(title + content);
				}else{//难点，关键点，易混点
					//firstDivS = "<div id='"+div_id+"' class='botShadow'></div>";
					loreType = "<h3 class='headTitle'><i class='targetIcon'></i>"+list[i].subType+"</h3>";
					title = "<div class='createDiv'><p class='titP clearfix'><span class='comSpanTit fl'>标题： </span>"+"<span class='comSpanTitCon fl'>"+list[i].subTitle+"</span></p>";
					content = "<div class='clearfix'><span class='comSpanTit conTit fl'>内容：</span>"+ "<div class='conWrap fl'><p>" +list[i].subContent + "</p></div>" +"</div></div>";
					$('#guideScroll').append(loreType + title + content);
				}
			}
			
		}
		calComWid();
		$("#moveBox").css({"margin-left":0});
		$("#moveBox").animate({"left":getId("guidePoint").offsetLeft + comMoveWid},function(){$("#guidePoint").addClass("active");});
		$("#moveLineDiv").animate({"width":$("#guidePoint").width()});
		function loaded_Guide() {
			myScroll = new iScroll('guideCon', { 
				checkDOMChanges: true,
				vScrollbar:false,
				hScrollbar : false
			});
			
		}
		loaded_Guide();
	}
}
//点拨指导知识清单公共计算宽度
function calComWid(){
	$(".comSpanTitCon").each(function(i){
		$(".comSpanTitCon").eq(i).width($(".createDiv").eq(i).width() - $(".comSpanTit").eq(i).width());
		$(".conWrap").eq(i).addClass("fl").width($(".comSpanTitCon").eq(i).width());
	});
}
//显示知识清单列表
function showLoreList(list){
	$('#studyInfo').html("");
	var title = "";
	var content = "";
	var content_result = "";
	var comMoveWid = Math.ceil(($("#guidePoint").width() - $("#moveBox").width())/2);
	if(list != null){
		$("#studyInfo").height(cliHei - 175);
		var knowledgeCon = "<div id='knowledgeCon' class='comDetailCon'><div id='knowledgeScroll'></div></div>";
		$("#studyInfo").append(knowledgeCon);
		$("#knowledgeCon").height($("#studyInfo").height());
		for(var i = 0 ; i < list.length; i++){
			listTit = "<h3 class='headTitle'><i class='targetIcon'></i>知识清单"+ (i+1) +"</h3>";
			title = "<div class='createDiv'><p class='titP clearfix'><span class='comSpanTit fl'>标题：</span>"+"<span class='comSpanTitCon fl'>"+list[i].subTitle+"</span></p>";
			content = "<div class='clearfix'><span class='comSpanTit conTit fl'>内容：</span><div class='conWrap fl'><p>" + list[i].subContent +"</p></div></div></div>";
			content_result += listTit + title + content;
		}
	}
	$('#knowledgeScroll').html(content_result);
	//calComWid();
	$("#moveBox").animate({"left":getId("loreListBox").offsetLeft + comMoveWid},function(){$("#loreListBox").addClass("active");});
	$("#moveLineDiv").animate({"width":$("#guidePoint").width()*2});
	function loaded_Guide() {
		myScroll = new iScroll('knowledgeCon', { 
			checkDOMChanges: true,
			vScrollBar:false,
			hScrollBar:false
		});
	}
	loaded_Guide();
}

//显示解题示范列表
function showExampleList(list){
	$('#studyInfo').html("");
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
	var comMoveWid = Math.ceil(($("#guidePoint").width() - $("#moveBox").width())/2);
	if(list != null){
		$("#studyInfo").height(cliHei - 175);
		var solveExampleCon = "<div id='solveExampleCon' class='comDetailCon'><div id='solveExampleScroll'></div></div>";
		$("#studyInfo").append(solveExampleCon);
		$("#solveExampleCon").height($("#studyInfo").height());
		for(var i = 0 ; i < list.length; i++){
			subject = "<div id='"+list[i].id+"' class='exampleQues'><p class='typeTit'><i class='subTitIcon'></i>题干</p>"+"<div class='subQuesCon'>"+list[i].subject+"</div></div>";
			selfAnswerButton = "<div id='bt_"+list[i].id+"' class='selfSoloveBox' ontouchend=showSelfAnswerInfo('"+list[i].id+"')>自己解题<span id='bt_selfSpan"+list[i].id+"' class='triSpan leftTri '></span></div>";
			showAnswerButton = "<div class='selfSoloveBox noBorTop' ontouchend=showRealAnswerInfo('"+list[i].id+"')>查看答案<span id='bt_showAnsSpan"+list[i].id+"' class='triSpan leftTri'></span></div>";
			selfAnswerInfo = "<div id='selfAnswer_"+list[i].id+"' class='selAns' style='display:none;'>";
			selfAnswerInfo += "<p><span class='cirSpan'></span>请拿出纸和笔写下你的解题过程</p><p><span class='cirSpan'></span>请注意规范步骤与书写格式</p><p><span class='cirSpan'></span>请像对待考试一样解完题，请选择“看答案”</p>";
			selfAnswerInfo += "</div>";
			realAnwerInfo = "<div id='realAnswer_"+list[i].id+"' class='relAns' style='display:none;'>";
			realAnwerInfo += "<div class='relAns_answ clearfix'><i class='cirSpan_1'></i><span class='ansTxt fl'>答案：</span><div class='ansWrap fl'>"+list[i].answer+"</div></div>";
			realAnwerInfo += "<div class='relAns_answ clearfix'><i class='cirSpan_1'></i><span class='ansTxt fl'>解析：</span><div class='ansWrap fl'>"+list[i].resolution+"</div></div>";
			realAnwerInfo += "</div>";
			number += list[i].id + ",";
			$("#solveExampleScroll").append(subject + selfAnswerButton + selfAnswerInfo + showAnswerButton + realAnwerInfo);
		}
	}
	
	$("#moveBox").animate({"left":getId("exampleKpBox").offsetLeft + comMoveWid},function(){$("#exampleKpBox").addClass("active");});
	$("#moveLineDiv").animate({"width":$("#guidePoint").width()*3});
	function loaded_example() {
		myScroll = new iScroll('solveExampleCon', { 
			checkDOMChanges: true,
			vScrollbar:false,
			hScrollbar : false,
			onScrollMove:function(){
				exampleFlag = false;
			},
			onScrollEnd:function(){
				exampleFlag = true;
			}
		});
	}
	loaded_example();
	
	var flag = "<input type='hidden' id='number_jtsf' value='"+number+"'/>";
	$('#studyInfo').append(flag);
}

//自己解题
function showSelfAnswerInfo(divObj){
	var allNumber = $("#number_jtsf").val();
	if(exampleFlag){
		$("#number_jtsf").val(allNumber.replace(divObj+",",""));
		$("#selfAnswer_"+divObj).slideDown();
		$("#realAnswer_"+divObj).slideUp();
		$("#bt_selfSpan"+divObj).removeClass("leftTri").addClass("topTri");
		$("#bt_showAnsSpan"+divObj).removeClass("topTri").addClass("leftTri");	
	}else{
		exampleFlag = false;
	}
}
//看答案
function showRealAnswerInfo(divObj){
	if(exampleFlag){
		$("#selfAnswer_"+divObj).slideUp();
		$("#realAnswer_"+divObj).slideDown();
		$("#bt_selfSpan"+divObj).removeClass("topTri").addClass("leftTri");
		$("#bt_showAnsSpan"+divObj).removeClass("leftTri").addClass("topTri");
	}else{
		exampleFlag = false;
	}
}

//巩固训练
function showConsolidationList(list){
	questionLength = list.length;
	var index_ul = "<ul id='indexNumber' class='tabNav clearfix'></ul>";//题库序列号ul
	var question_ul = "<ul id='questionList'></ul>";//题库列表ul
	var comMoveWid = Math.ceil(($("#guidePoint").width() - $("#moveBox").width())/2);
	$("#studyInfo").height(cliHei - 125);
	//$("#botCardBox").html(index_ul);
	$("#botCard").append(index_ul);
	$("#studyInfo").html(question_ul);
	if(list != null){
		
		for(var i = 0 ; i < questionLength; i++){
			var index = i + 1;
			var li_index = "";
			if(index == 1){
				li_index =  "<li id='queIndex_"+index+"' class='quesNum active' onclick='showQuestionByIndex("+index+")'>"+"<span>"+index+"</span></li>";//题库序列号li
			}else{
				li_index =  "<li id='queIndex_"+index+"' class='quesNum' onclick='showQuestionByIndex("+index+")'>"+"<span>"+index+"</span></li>";//题库序列号li
			}
			$("#indexNumber").append(li_index);
			
			var li_question = "";
			if(index == 1){
				li_question = "<li id='question_"+index+"' name='question_"+index+"' class='questionClass' style='opacity:1'></li>";//题库列表li-显示
			}else{
				li_question = "<li id='question_"+index+"' name='question_"+index+"' class='questionClass'></li>";//题库列表li-隐藏
			}
			$("#questionList").append(li_question);
			//--------题库列表(问题)---------//
			var question_start_dl = "<div id='questionWrap_"+ index +"' class='questionWrap'><div class='scroller'>";
			var question_typeList_dd = "<div class='loreTypeTit clearfix'><span class='loreTypeNum fl'>"+index+"</span><span class='loreTypeTxt fl'>"+list[i].loreQuestion.questionType+"<em></em><i></i></span><div class='quesTit fl'>"+list[i].loreQuestion.subject+"</div></div>";
			var question_option_dd = "<div id='questionOption_"+index+"' class='optionDd'><div id='quesSonOption_"+index+"' class='queSonOpt'></div><div id='answerOption_"+index+"' class='answerOptions'></div><div id='ansQuesWrap_"+ index +"' style='display:none;'></div><div id='myAnsOpts_"+index+"' style='display:none;' class='myAnsOpt'><span id='myAnsOptsSpan_"+ index +"' class='iconStaeSpan'></span></div></div>";//题库答案选项
			var question_end_dl = "</div></div>";
			var question_submit_dd = "<div id='questionSubmit_"+index+"' class='submitOption'></div>";
			$("#question_"+index).append(question_start_dl + question_typeList_dd + question_option_dd  + question_end_dl + question_submit_dd);

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
			
			
			//选择答案
			
			if(list[i].loreQuestion.loreTypeName == "巩固训练"){
				var real_answer = "<input type='hidden' id='real_answer_"+index+"' value='"+replaceChara(list[i].loreQuestion.answer)+"'>";//正确答案
				$("#answerOption_"+index).append(real_answer);
			}else{
			}
			
			//12-28新增加1
			var answerNumber = 0;
			var questionType_flag = false;
			if(list[i].loreQuestion.questionType == "问答题" || list[i].loreQuestion.questionType == "填空题"){
				$("#ansQuesWrap_"+index).show();
				$("#questionOption_"+index).css({"padding-left":0,"padding-right":0});
				questionType_flag = true;
				answerNumber = 1;//只有错和对，所以赋值1;
				var ts_span = "<div id='tishi_"+index+"' class='tishiBox'><span class='tishiIcon'></span>请拿出纸和笔验算一下，这道题考察的是你的解题规范和解题步骤，要认真验算！得出结果后点击验算完成即可</div>";
				//$("#answer_option_dd_"+index).append(ts_span);
				var realAsnwer_result_title_div = "<div id='realAnswer_result_"+index+"' style='display:none;' class='optionParent clearfix'>";
				realAsnwer_result_title_div += "<div class='relRightAnsBox lineBreak clearfix'><span class='relRightAnsTxt fl'>正确答案：</span><div class='fl'>"+replaceChara(list[i].loreQuestion.answer)+"</div></div>";
				realAsnwer_result_title_div += "<div class='myRealAnsBox'><span class='relRightAnsTxt fl'>我的答案：</span>";
				realAsnwer_result_title_div += "<div class='optionBox_Que'><input class='optionRadio_ques' type='radio' name='answer_option_radio_"+index+"1' value='1'/><span class='rightSpan'>对</span></div><div class='optionBox_Que'><input class='optionRadio_ques' type='radio' name='answer_option_radio_"+index+"1' value='0'/><span class='errorSpan'>错</span></div>";
				realAsnwer_result_title_div += "<span class='warnningIcon'></span><span class='choiceTxt'>请如实选择</span></div>";
				realAsnwer_result_title_div += "</div>";
				var realAnswer_div = "<div id='realAnswer_"+index+"' class='relAnsBox'>"+realAsnwer_result_title_div+"</div>";
				var myAnsResult_div = "<div id='myAnsResultBox_"+ index +"' class='myAnsRes clearfix'></div>";
				$("#ansQuesWrap_"+index).append(ts_span + realAnswer_div + myAnsResult_div);
			}
			//12-28新增加1
				else{
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
						//$("#option_div_"+number_new).append(selectAnserValue+selectLabelAnserValue);
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
			submit_div += "<span class='goNextBtn' ontouchend=submitAnswer("+ currentLoreId +","+index+","+answerNumber+","+studyLogId+",'"+encodeURIComponent(encodeURIComponent(answer_array))+"','"+list[i].loreQuestion.loreTypeName+"','"+list[i].loreQuestion.questionType+"')>提交</span>";
			//我要纠错暂时不需
			//submit_div += "<a href='javascript:void(0)' class='submitErrorA' onclick=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")>我要纠错</a>";
			submit_div += "<a href='javascript:void(0)' class='submitErrorA' ontouchend=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")></a>";
			submit_div += "</div>";
			//12-28新增加2 
			var showButton_div = "<div id='showResult_"+index+"'  class='submitDiv' style='display:none;'>";
			//问答题填空题显示答案
			showButton_div += "<span class='goNextBtn removeAFocBg' ontouchend='showResult("+index+");'>验算完成</span>";
			//问答题填空题下验算完成对应的我要纠错
			showButton_div += "<a href='javascript:void(0)' class='submitErrorA' ontouchend=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")></a>";
			showButton_div += "</div>";
			//12-28新增加2
			var nextButton_div = "<div id='next_button_div_"+index+"' class='submitDiv' style='display:none;'>";
			var nextNumber = index+1;
			nextButton_div += "<span class='goNextBtn' ontouchend='nextQuestion("+nextNumber+")'>进入下一题</span>";
			//我要纠错暂时不需
			//nextButton_div += "<a href='javascript:void(0)' class='submitErrorA' onclick=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")>我要纠错</a>";
			nextButton_div += "<a href='javascript:void(0)' class='submitErrorA' ontouchend=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")></a>";
			nextButton_div += "</div>";
			var resultButton_div = "";
			if(i == questionLength - 1){//表示是最后一题
				resultButton_div = "<div id='result_button_div' class='submitDiv' style='display:none;'>";
				resultButton_div += "<span class='goNextBtn' ontouchend='lastSubmitAnswer("+currentLoreId+")'>做完了</span>";
				//我要纠错暂时不需
				//resultButton_div += "<a href='javascript:void(0)' class='submitErrorA' onclick=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")>我要纠错</a>";
				resultButton_div += "<a href='javascript:void(0)' class='submitErrorA' ontouchend=showErrorWindow("+index+",'"+escape(list[i].loreQuestion.lore.loreName)+"',"+list[i].loreQuestion.id+")></a>";
				resultButton_div += "</div>";	
			}
			//12-28新修改3
			if(option == "relationStudy"){
				//学习记录关联结果里面不需要最后提交
				$("#questionSubmit_"+index).append(loreQuestionId_input_value+mySelectAnswer_lable_value+submit_div+showButton_div+resultButton_div);
			}else{
				$("#questionSubmit_"+index).append(loreQuestionId_input_value+mySelectAnswer_lable_value+submit_div+showButton_div+nextButton_div+resultButton_div);
			}
			//计算提交按钮的宽度
			$(".submitDiv").width(cliWid - $(".showHideBtn").width() - 20);
			$(".goNextBtn").width($(".submitDiv").width() - $(".submitErrorA").width()-10);
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
				//completeNum++;
				var questionType_temp = list[i].loreQuestion.questionType;
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
					}else{//单选题判断题
						var optionIndex = transOption_1(list[i].myAnswer);
						$("#"+optionIndex+"_"+index).removeClass("choice_act").addClass("rightState");
					}						
					currentAllQuestionFlag *= 1;
					//totalMoney++;
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
					}else{//单选题判断题
						var optionIndex = transOption_1(list[i].myAnswer);
						$("#"+optionIndex+"_"+index).removeClass("choice_act").addClass("errorState");
					}
					currentAllQuestionFlag *= 0;
					$(".quesNum").eq(i).css("border-color","#fb5151");
					$(".quesNum span").eq(i).addClass("errorState_queNum");
				}
				$("label[name='comLabelName_"+index+"']").removeAttr("ontouchend");
				//$("#result_button_dd_"+index).show();//显示按钮DIV
				$("#tijiao_"+index).hide();//隐藏提交按钮DIV
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
	$(".questionClass").width(cliWid);
	$("#questionList").css({
		"height":($("#studyInfo").height())
	});
	$(".questionWrap").height($("#questionList").height() - $(".submitOption").height());
	$("#moveBox").animate({"left":getId("consolidKpBox").offsetLeft + comMoveWid},function(){
		var cirLeft = "<span id='criLeft' class='comCirSpan'><i id='cirLeft_i' class='comCirSpan'></i></span>";
		var cirRight = "<span id='criRight' class='comCirSpan'><i id='cirRight_i' class='comCirSpan'></i></span>";
		var cirMask = "<span id='maskSpan'><i id='mask_i'></i></span>";
		$("#consolidKpBox").addClass("active");
		$("#consoSpan").append(cirLeft + cirRight + cirMask).css({"font-size":12,"background":"#006a91"});
		$("#mask_i").html(completeNum + "/"+questionLength);
		$(".submitOption").show().animate({"opacity":1});
		$(".showHideBtn").show().animate({"opacity":1});
	});
	$("#moveLineDiv").animate({"width":$("#guidePoint").width()*4});
	$("#botCardBox").css({"bottom":-$("#botCardBox").height()});
	$("#botCard").css({"width":cliWid - $(".closeBot").width()});
	$("#indexNumber").width($(".quesNum").eq(0).outerWidth() * questionLength + questionLength*10 + 2);
	if($("#indexNumber").width() > $("#botCard").width()){
		$(".shadow").show();
	}else{
		$(".shadow").hide();
	}
	//动态设置每个选项的高度和ABCDEF对应的行高
	setOptionHei();
	choiceOptionAns($(".spaceAnsRadio"),"current");
}


//12-28新增加5
function submitAnswer(currentLoreId,value,answerNumber,studyLogId,answerOptionArray,loreTypeName,questionType){
	//向答案结果DIV中添加元素
	//先判断有误选择答案
	if(checkLoginStatus()){
		var loreQuestionId = $("#loreQuestionId_input_"+value).val();
		var selectAnserValue_result = "";
		var selectAnserLableValue_result = "";
		var flag = false;
		//(2016-04-06增加)
		var regS = new RegExp("\\Module/commonJs/ueditor/jsp/lore/","g");//替换所有带特殊符号的字符串
		if(questionType == "多选题"){
			var selectMultAnserValue = $("#selectMultAnsesr_"+value).val();
			if(selectMultAnserValue == ""){
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("请选择答案");
				commonTipInfoFn($(".warnInfoDiv"));
				//清空数据
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
						selectAnserLableValue_result += $("#answer_option_label_"+number1 + "" + number2+"_"+value).html() + ",";
					}
					//12-28新修改6
					flag = true;
				}
			}
		}

		if(flag){
			$("#tijiao_"+value).hide();//隐藏提交按钮DIV
			selectAnserValue_result = delLastSeparator(selectAnserValue_result);
			selectAnserLableValue_result = delLastSeparator(selectAnserLableValue_result);
			//12-28新修改7
			//向答案结果DIV中添加元素
			//将答案插入数据库
			$("#mySelectAnswer_lable_"+value).val(selectAnserLableValue_result);

			excuteInsertData(loreId,currentLoreId,studyLogId,"巩固训练",loreQuestionId,value,selectAnserLableValue_result,answerOptionArray,questionType);
			
			if(value == questionLength){//表示最后一题
				if(option == "relationStudy"){
					//学习记录关联结果
				}else{
					$("#result_button_div").show(); //显示最后提交按钮DIV
				}
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
		  data:{loreId:loreId,currentLoreId:currentLoreId,studyLogId:studyLogId,loreType:loreType,subjectId:subId,loreQuestionId:questionId,questionStep:questionStep,myAnswer:myAnswer,loreTaskName:escape(loreTaskName)},
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
				   }else{
					   var optionIndex = transOption_1(myAnswer);
					   $("#"+optionIndex+"_"+questionStep).removeClass("choice_act").addClass("errorState");
				   }
				  $("#tipInfoBox").addClass("errorInfo").removeClass("rightInfo");
				  $("#tipFace").addClass("errFace").removeClass("rigFace");
				  $("#facePic").addClass("errFacePic").removeClass("rigFacePic");
				  $("#infoTxt").html("哎呀，答错了！").css({"padding-top":40});
				 /** if(questionType == "问答题" || questionType == "填空题"){
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
				  }else{
					   var optionIndex = transOption_1(myAnswer);
					   $("#"+optionIndex+"_"+questionStep).removeClass("choice_act").addClass("rightState");
				  }
				  $("#tipInfoBox").addClass("rightInfo").removeClass("errorInfo");
				  $("#tipFace").addClass("rigFace").removeClass("errFace");;
				  $("#facePic").addClass("rigFacePic").removeClass("errFacePic");
				  $("#infoTxt").html("恭喜你，回答正确！").css({"padding-top":40});
				  //$("#relAnsTxt").html("");
				  
				  currentAllQuestionFlag *= 1;
				  $(".quesNum").eq(questionStep - 1).css("border-color","#64ccf2");
				  $(".quesNum span").eq(questionStep - 1).addClass("rightState_queNum");
			  }
			  $("label[name='comLabelName_"+questionStep+"']").removeAttr("ontouchend");
			  comTipInfo();
		  }
	});
	completeNum++;
		
	$("#mask_i").html(completeNum + "/"+questionLength);
	var num = completeNum * (360/questionLength);
	if(num <= 180){
		$("#cirRight_i").css('transform', "rotate(" + num + "deg)");
		
	}else{
		$("#cirRight_i").css('transform', "rotate(180deg)");
		$("#cirLeft_i").css('transform', "rotate(" + (num - 180) + "deg)");			
	}
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
		if(checkLoginStatus()){
			studyLogId_curr = updateLogStatus(step_new,0,1,3);	
			window.location.href = "studyApp.do?action=showTracebackPage&loreId="+loreId+"&tracebackType=review&studyLogId="+studyLogId_curr+"&flag=1&currentLoreId="+currentLoreId+"&loreName="+loreName+"&chapterId="+chapterId+"&educationId="+educationId+"&cilentInfo=app";
			//window.location.href = "studyApp.do?action=showTracebackPage&loreId="+loreId+"&tracebackType=review&studyLogId="+studyLogId+"&loreName="+loreName+"&chapterId="+chapterId+"&educationId="+educationId+"&cilentInfo=app";
		}
	}else{
		$(".succImg").hide();
		$(".tipImg").show();
		$("#warnPTxt").html("请先做完其他试题<br/>再提交");
		commonTipInfoFn($(".warnInfoDiv"));
	}
}

/**
当前阶段完成，修改指定logId的isFinish状态、stepComplete状态，access状态
stepComplete:该阶段完成状态0：未完成，1：完成
isFinish:该知识点完成状态1：未完成，2：完成
access：该阶段关联知识点完成状态0：未完成，1：完成
**/
function updateLogStatus(step,stepComplete,isFinish,access){
	//alert(currentLoreId)
	var studyLogId_curr = 0;
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{studyLogId:studyLogId,loreId:loreId,step:step,stepComplete:stepComplete,isFinish:isFinish,access:access,currentLoreId:currentLoreId,type:"study"},
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