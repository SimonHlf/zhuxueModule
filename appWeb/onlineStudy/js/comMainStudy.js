//替换所有的单引号为自定义字符
function replaceChara(value){
	return value.replace(/&#wmd;/g,"'");
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
//将字母转成数字
function transOption_1(myAnswer){
	if(myAnswer == "A"){
		return 1;
	}else if(myAnswer == "B"){
		return 2;
	}else if(myAnswer == "C"){
		return 3;
	}else if(myAnswer == "D"){
		return 4;
	}else if(myAnswer == "E"){
		return 5;
	}else if(myAnswer == "F"){
		return 6;
	}
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
//单选题，多选题，判断题选中状态
function choiceOption(quesType,optionIndex,number){
	if(quesAreaFlag){				
		if(quesType == "单选题" || quesType == "判断题"){
			$("span[name='nameSpan_"+ number +"']").removeClass("choice_act");
			$("#"+optionIndex+"_"+number).addClass("choice_act");
		}else if(quesType == "多选题"){
			var currSelectAnswer = $("#selectMultAnsesr_"+number).val();
			var currSelectLabelValue = $("#selectLabelMultAnsesr_"+number).val();
			var objInp = $("#answer_option_radio_" + number + "_" + optionIndex);
			var objInpVal = $("#answer_option_radio_" + number + "_" + optionIndex).val();
			if($("#"+optionIndex+"_"+number).attr("class").indexOf("choice_act") < 0){ //选中
				$("#"+optionIndex+"_"+number).addClass("choice_act");
				var selectIndex = objInp.attr("id").replace("answer_option_radio_"+number+"_","");
				if(currSelectAnswer == ""){
					currSelectAnswer += objInp.val();
					currSelectLabelValue += $("#answer_option_label_1"+selectIndex+"_"+number).html();
				}else{
					currSelectAnswer += "," + objInp.val();
					currSelectLabelValue += "," + $("#answer_option_label_1"+selectIndex+"_"+number).html();
				}	
			}else{//未选中
				$("#"+optionIndex+"_"+number).removeClass("choice_act");
				var resultArray = currSelectAnswer.split(",");
				var labelArray = currSelectLabelValue.split(",");//和答案多少一样，可共用
				var strLength = resultArray.length;
				var repalceStr = "";
				var replaceLabelStr = "";
				for(var i = 0 ; i < strLength;i++){
					if(resultArray[i] == objInpVal){
						if(i == 0){//首位
							if(strLength == 1){
								repalceStr = objInpVal;
								replaceLabelStr = labelArray[i];
							}else{
								repalceStr = objInpVal + ",";
								replaceLabelStr = labelArray[i] + ",";
							}
						}else{//中间任何位置+末尾
							repalceStr = "," + objInpVal;
							replaceLabelStr = "," + labelArray[i];
						}
						break;
					}
				}
				currSelectAnswer = currSelectAnswer.replace(repalceStr,"");
				currSelectLabelValue = currSelectLabelValue.replace(replaceLabelStr,"");
			}
			$("#selectMultAnsesr_"+number).val(currSelectAnswer);
			$("#selectLabelMultAnsesr_"+number).val(currSelectLabelValue);
		}		
	}
}
/* 核心区域答题列表下每个li的上下scroll */
function quesScroll(number) {
	myScroll = new iScroll("questionWrap_" + number, { 
		checkDOMChanges: true,
		vScrollbar:false,
		hScrollbar : false,
		
		onScrollMove:function(){
			quesAreaFlag = false;
		},
		onScrollEnd:function(){
			quesAreaFlag = true;
		}
	});
}	
//点击题号显示相应题信息
function showQuestionByIndex(number){
	if(botCardFlag){
		$(".questionClass").hide().css({"opacity":0});
		$("#question_"+number).show().animate({"opacity":1},200);
		$(".quesNum").removeClass("active");
		$("#queIndex_"+number).addClass("active");
		quesScroll(number);
		$("#botCardBox").stop().animate({"bottom":-$("#botCardBox").height()});
	}else{
		botCardFlag = false;
	}
}	
//问答题和填空题时显示答案
function showResult(index){
	$("#tishi_"+index).hide();//隐藏提示
	$("#showResult_"+index).hide();//隐藏提交按钮(显示正确答案)
	$("#realAnswer_result_"+index).show();//显示正确答案和结果
	$("#tijiao_"+index).show();//显示最后提交按钮
	choiceOptionAns($(".optionRadio_ques"),"curr_ques");
}
//填空选择题，问答题，填空题raido点击
function choiceOptionAns(obj,newClassName){
	$(obj).each(function(){
		$(this).on("touchend",function(){
			$(this).attr("checked",true);
			$(this).parent("div").addClass(newClassName).append("<b></b>").siblings().removeClass(newClassName).find('b').remove();
		});
	});
}

var t_img; // 定时器
var isLoad = true; // 控制变量


// 判断图片加载的函数
function isImgLoad(obj,callback){
    // 注意我的图片类名都是cover，因为我只需要处理cover。其它图片可以不管。
    // 查找所有封面图，迭代处理
    $(obj).each(function(){
        // 找到为0就将isLoad设为false，并退出each
        if(this.height === 0){
            isLoad = false;
            return false;
        }
    });
    // 为true，没有发现为0的。加载完毕
    if(isLoad){
        clearTimeout(t_img); // 清除定时器
        // 回调函数
        callback();
    // 为false，因为找到了没有加载完成的图，将调用定时器递归
    }else{
        isLoad = true;
        t_img = setTimeout(function(){
            isImgLoad(obj,callback); // 递归扫描
        },500); // 我这里设置的是500毫秒就扫描一次，可以自己调整
    }
}

//选项高度和行高的动态设置
function setOptionHei(){
	$(".optionDetailTxt").each(function(i){
		$(".optionDetailTxt").eq(i).width($(".optionDiv").eq(i).width() - 56);
		//判断图片加载状况，加载完成后回调
		//isImgLoad($(".optionDetailTxt img"),comInitHei);
		
		if($(".optionDetailTxt img").length != 0){
			var imgdefereds=[];
			$(".optionDetailTxt img").each(function(){
			  	var dfd=$.Deferred();
			  	$(this).bind('load',function(){
			   		dfd.resolve();
			  	}).bind('error',function(){
			  		//图片加载错误，加入错误处理
			  		// dfd.resolve();
			 	 });
			  	if(this.complete) setTimeout(function(){
			   		dfd.resolve();
			 	 },500);
			  		imgdefereds.push(dfd);
			 });
			 $.when.apply(null,imgdefereds).done(function(){
				 comInitHei();
			 });
		}else{
			comInitHei();
		}
		function comInitHei(){
			if($(".optionDetailTxt").eq(i).height() < 30 ){
				$(".optionDetailTxt").eq(i).height(40);
				$(".optionDetailTxt").eq(i).parent().css({"line-height":"0.4rem"});
			 }else{
				 $(".optionDetailTxt").eq(i).css({"padding-top":8,"padding-bottom":8});
				 var thanHei = $(".optionDetailTxt").eq(i).outerHeight();
				 $(".optionWrod").eq(i).css({"line-height": thanHei + "px"});
				 $(".comChoiceLabel").eq(i).height(thanHei + 2);
			 } 
		}
	});
}
/* 底部答题卡题量数目多出横向滚动条 */
function botScroll() {
	myScroll = new iScroll('botCard', { 
		checkDOMChanges: true,
		hScrollbar : false,
		vScroll : false,
		onScrollMove:function(){
			botCardFlag = false;
		},
		onScrollEnd:function(){
			botCardFlag = true;
		}
	});
}	
//底部答题卡的隐藏和显示
function showHidBotCardBox(){
	var botHei = $("#botCardBox").height();
	$("#botCardBox").show().stop().animate({"bottom":0});
	if(goFlag){//展开答题卡后左右滑动后再次展开只执行一次
		botScroll();
	}
	goFlag = false;
}
function closeBotCard(){
	var botHei = $("#botCardBox").height();
	$("#botCardBox").stop().animate({"bottom":-botHei});
}
//下一题按钮动作
function nextQuestion(number){
	if(number <= questionLength){
		$(".questionClass").hide().css({"opacity":0});//全部题隐藏
		for(var i = 1 ; i <= questionLength ; i++){
			if(i != number){
				$("#queIndex_"+i).removeClass('active');//题号
			}else{
				$("#queIndex_"+i).addClass('active');
				$("#question_"+number).show().animate({"opacity":1},200);
				quesScroll(number);
			}
		}
	}
}
//回答正确或错误的提示信息
function comTipInfo(){
	/*setTimeout(function(){
		$("#tipInfoBox").show().animate({"bottom":0},600,function(){
			$("#tipInfoBox").show().animate({"bottom":-150},1200,function(){
				$("#tipInfoBox").hide();
			});
		});
	},10);*/
	$("#tipInfoBox").css({
		"-webkit-transform":"translateY(0)",
		"transform":"translateY(0)"
	});
	setTimeout(function(){
		$("#tipInfoBox").css({
			"-webkit-transform":"translateY(150px)",
			"transform":"translateY(150px)"
		});
	},1000);
}
//显示我要纠错窗口
function showErrorWindow(indexNumber,loreName,loreQuestionId){
	/**$(".errorDivWrap").css({
		"-webkit-transform":"translateX(0)",
		"transform":"translateX(0)"
	});
	$(".errTipP").attr("alt",loreQuestionId).attr("number",indexNumber).html(unescape(loreName)+"”知识点第"+indexNumber+"题");
	if(cliWid <= 690){
		$(".errInfoTxt").addClass("infoWid");
		setTimeout(function(){
			$(".errInfoTxt p").addClass("errInfoMove");
		},650);
	}**/
}
//关闭我要纠错窗口(清空数据)
function closeErrorWindow(){
	if($(".errInfoMove").length > 0){
		$(".errInfoTxt p").removeClass("errInfoMove");
		$(".errInfoTxt").removeClass("infoWid");
	}
	$(".errorDivWrap").css({
		"-webkit-transform":"translateX(100%)",
		"transform":"translateX(100%)"
	});
	$(".errTipP").attr("alt","");
	$(".errTipP").attr("number","");
	$("#editArea").val("");
	/*$("#nowNum").html("0");
	$("#maxNum").html("共200字");*/
	$(".selSpan i").removeClass("choiceActive");
	clearCheckBoxStatus("errorBox");
	
}
//提交错误
function submitError(){
	if(checkLoginStatus()){
		var errorType = getCheckBoxStatus("errorBox");
		var loreQuestionId = $(".errTipP").attr("alt");
		var indexNumber = $(".errTipP").attr("number");
		var content = $("#editArea").val();
		if(errorType == ""){
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("请选择问题类型");
			commonTipInfoFn($(".warnInfoDiv"));
		}else if(content == ""){
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("请填写纠错内容");
			commonTipInfoFn($(".warnInfoDiv"));
		}else if(loreQuestionId == ""){
			
		}else{
			//检查当天是否对该题进行错误提交，一题一天一人只能提交一次
			var flag = checkCurrSubmitError(loreQuestionId);
			if(flag){
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("您当天已经提交过该题错误了");
				commonTipInfoFn($(".warnInfoDiv"));
			}else{
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  data:{loreQuestionId:loreQuestionId,errorType:errorType,content:escape(content)},
					  url:"lqeApp.do?action=submitLQE&cilentInfo=app",
					  success:function (json){ 
						  if(json["result"] != 0){
							  //关闭层并清空层数据，显示题库列表。
							  $(".succImg").show();
							  $(".tipImg").hide();
							  $("#warnPTxt").html("提交纠错成功");
							  commonTipInfoFn($(".warnInfoDiv"),function(){
								  closeErrorWindow();
							  });
						  }else{
							  $(".succImg").hide();
							  $(".tipImg").show();
							  $("#warnPTxt").html("提交纠错失败");
							  commonTipInfoFn($(".warnInfoDiv"));
						  }
					  }
				});
			}
		}
	}
}
//检查一人一天对当天知识点只能提交一次错误
function checkCurrSubmitError(loreQuestionId){
	var flag;
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{loreQuestionId:loreQuestionId},
		  url:"lqeApp.do?action=checkCurrSubmitError&cilentInfo=app",
		  success:function (json){ 
			  flag = json["result"];
		  }
	});
	return flag;
}
/* input复选框选中前后的状态 */
function selErrType(option){
	var checkStatus = $("#errType"+option).prop("checked"); 
	if(checkStatus){
		$("#choiceI"+option).removeClass("choiceActive");
	}else{
		$("#choiceI"+option).addClass("choiceActive");
	}
}
//清空所有复选框的选中状态
function clearCheckBoxStatus(checkObj){
	var selectOptions = document.getElementsByName(checkObj);
	for(var i = 0 ; i < selectOptions.length ; i++){
		selectOptions[i].checked = false;
	}
}
//获取复选框选择的结果
function getCheckBoxStatus(checkObj){
	var selectOptions = document.getElementsByName(checkObj);
	var resultStr = "";
	for(var i = 0 ; i < selectOptions.length ; i++){
		if(selectOptions[i].checked){
			resultStr += selectOptions[i].value + ",";
		}
	}
	if(resultStr != ""){
		resultStr = resultStr.substring(0,resultStr.length - 1);
	}
	return resultStr;
}