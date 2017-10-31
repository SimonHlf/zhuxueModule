<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>    
    <title>培优发送页面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/appWeb/buffetSend/css/buffetSend.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript">
	var stuId = "${requestScope.stuId}";
	var stime = "${requestScope.stime}";
	var etime = "${requestScope.etime}";
	var studyLogId = "${requestScope.studyLogId}";
	var currQuoteLoreId = "${requestScope.quoteLoreId}";
	var loreName = "${requestScope.loreName}";
	var userId = "${sessionScope.userId}";
	var loginStatus = "${sessionScope.loginStatus}";
	var cliHei = document.documentElement.clientHeight;
	var cliWid = document.documentElement.clientWidth;
	var loadListDataFlag = true;
	var selAllFlag = false;//判断是否点击了全选
	var tmpNum = 0;
	$(function(){
		getBuffetSendList();
		$("#loreName").html(loreName);
		$("#listWrap").height(cliHei - 90);
		$("#detailConWrap").height(cliHei - 180);
		$("#innerFinalBox").width($("#finalOpaBox").width() - $(".choiceTxt").width()-5);
		if($("#detailNavUl").width() > cliWid){
			$(".posTop").show();
		}else{
			$(".posTop").hide();
		}
	});
	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	
	//类型iscroll
	function detailTabScroll() {
		myScroll = new iScroll('navWrap', { 
			checkDOMChanges: true,
			hScrollbar : false,
			onScrollMove:function(){
				loadListDataFlag = false;
			},
			onScrollEnd:function(){
				loadListDataFlag = true;
			}
		});
	}
	//查看详情上下iscroll
   	function viewDetailScroll() {
		myScroll = new iScroll('detailConWrap', { 
			checkDOMChanges: true,
			onScrollMove:function(){
				loadListDataFlag = false;
			},
			onScrollEnd:function(){
				loadListDataFlag = true;
			}
		});	
  	}
	//获取巴菲特题库列表
	function getBuffetSendList(){
		$.ajax({
	        type:'post',
	        dataType:'json',
	        async:true,
	        data:{quoteLoreId:currQuoteLoreId},
	        url:"buffetApp.do?action=getBuffetSendJson&cilentInfo=app",
	        beforeSend:function(){
	        	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
	        },
	        success:function (json){
	        	showBuffetSendList(json["result"]);
	        },
	        complete:function(){
	        	 $("#loadDataDiv").hide();
	        	 $(".loadingIcon").remove();
	        }
		});
	}
	//进来加载巴菲特类型列表
	function loadDataList() {
		myScroll = new iScroll('listWrap', { 
			checkDOMChanges: true,
			onScrollMove:function(){
				loadListDataFlag = false;
			},
			onScrollEnd:function(){
				loadListDataFlag = true;
			}
		});		
	}
	//显示巴菲特题库列表
	function showBuffetSendList(list){
		var content = "";
		if(list.length > 0){
			for(var i = 0 ; i < list.length ; i++){
				content += "<li><label class='listLabel' for='check_"+list[i].buffet.id+"' ontouchend=selListBuffetItem('"+ list[i].buffet.id +"')>";
				content += "<h3>"+list[i].buffet.buffetType.types+"</h3>";
				content += "<input type='checkbox' id='check_"+list[i].buffet.id+"' class='comCheckInp' name='buffetId' value='"+list[i].buffet.id+"'/>";
				content += "<span class='checkIcon'><span id='selActSpan_"+ list[i].buffet.id +"'></span></span>";
				content += "<div class='listSon fl'><p class='ellip'>"+list[i].buffet.title+"</p><p>名称</p></div>";
				content += "<div class='listSon fl'><p class='ellip'>"+list[i].buffetMindTypeNameStr+"</p><p>思维</p></div>";
				content += "<div class='listSon fl'><p class='ellip'>"+list[i].buffetAbilityTypeNameStr+"</p><p>能力</p></div></label>";
			}
		}else{
			content += "<div class='noListDataDiv'><img src='Module/appWeb/studyRecord/images/noRecord.png' alt='暂无培优试题'><p>暂无培优试题</p></div>'";
		}
		$("#loreListUl").html(content);
		if($(".noListDataDiv").length > 0){
			$(".noListDataDiv").css({"margin-top":($("#listWrap").height() - $(".noListDataDiv").height())/2 + 30});
		}else{
			loadDataList();
		}
	}
	function selListBuffetItem(checkId){
		var checkStatus = $("#check_"+checkId).prop("checked"); 
		if(loadListDataFlag){
			if(checkStatus){
				$("#selActSpan_"+checkId).removeClass("checkActive");
			}else{
				$("#selActSpan_"+checkId).addClass("checkActive");
			}
		}
		
	}
	//全选全不选复选框动作
	function selectAllOrNull(obj){
		if($("#loreListUl li").length > 0){
			var checkStatus = $("[name='buffetAll']").prop("checked");
			if(checkStatus){//全部取消
				$("[name='buffetId']").attr("checked",false);
				$(".checkIcon span").removeClass("checkActive");
				$(".selAllSpan span").removeClass("seLAllActive");
				$("#handSend").html("<span class='lineSpan'></span>手动发送");
			}else{//全选 
				$("[name='buffetId']").attr("checked",true);
				$(".checkIcon span").addClass("checkActive");
				$(".selAllSpan span").addClass("seLAllActive");
				$("#handSend").html("<span class='lineSpan'></span>全选发送");
			}
			selAllFlag = true;
			tmpNum = $(".checkActive").length; //点击全选后将active状态的个数赋给tmpNum	
		}else{
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("暂无培优试题<br/>请联系客服");
			commonTipInfoFn($(".warnInfoDiv"));
		}
	}
	function showBuffetDetail(){
		if($("#loreListUl li").length > 0){
			$("#loreName_1").html(loreName);
			$("#buffetDetailDiv").css({
				"-webkit-transform":"translateX(0px)",
				"transform":"translateX(0px)"
			});
			//step:1 获取兴趣激发内容
			ajaxAction("兴趣激发","xqkfListDiv");
			//step:2获取方法归纳内容
			ajaxAction("方法归纳","ffgnDiv");
			//step:3获取思维训练内容
			ajaxAction("思维训练","swxlDiv");
			//step:4获取智力开发内容
			ajaxAction("智力开发","zlkfDiv");
			//step:5获取能力培养内容
			ajaxAction("能力培养","nlpyDiv");
			//step:6获取中/高考涉猎内容
			ajaxAction("中/高考涉猎","gkslDiv");
		}else{
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("暂无培优试题<br/>请联系客服");
			commonTipInfoFn($(".warnInfoDiv"));
		}
	}
	//根据巴菲特基础类型和章节编号查询巴菲特列表
	function ajaxAction(buffetType,divText){
		$.ajax({
			  type:"post",
			  async:true,
			  dataType:"json",
			  data:{loreId:currQuoteLoreId,buffetType:escape(buffetType)},
			  url:"buffetApp.do?action=showJsonList&cilentInfo=app",
			  beforeSend:function(){
				  $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
			  },
			  success:function (json){ 
				  showBuffetDetailList(json["result"],divText);
			  },
			  complete:function(){
				  $("#loadDataDiv").hide();
	        	  $(".loadingIcon").remove();
	        	  viewDetailScroll();
	        	  detailTabScroll();
	        	  selTypeBuffetTab();
	        	  initCheckBoxStatus();
			  }
		});
	}
	//选择巴菲特类型的左右iscroll
	function selTypeBuffetTab(){
		$("#detailNavUl li").each(function(i){	
			$(this).on("touchend",function(){
				if(loadListDataFlag){
					$("#detailNavUl li").removeClass("active");
					$(this).addClass("active");
					$(".comListDiv").hide().css({"opacity":0});
					$(".comListDiv").eq(i).show().stop().animate({"opacity":1});
				}
			});
		});
	}
	//显示巴菲特列表
	function showBuffetDetailList(list,div){
		var content_result = "";
		if(list != null){
			for(var i = 0 ; i < list.length; i++){
				var queType = "";
				var title = "";
				var checkDiv = "";
				var labelBox = "";
				var buffetMindType = "";
				var buffetAbilityType = "";
				var subject = "";
				var optionA = "";
				var optionB = "";
				var optionC = "";
				var optionD = "";
				var optionE = "";
				var optionF = "";
				var optionTextA = "";
				var optionTextB = "";
				var optionTextC = "";
				var optionTextD = "";
				var optionTextE = "";
				var optionTextF = "";
				var answer = "";
				var resolution = "";
				var tips = "";
				queType = "<div class='createDiv'><div class='innerCreateDiv'><label class='attachInpLab' for='"+ list[i].buffet.id +"' ontouchend=addBuffetItem('"+list[i].buffet.id+"')><p class='queTypeP'>"+list[i].buffet.questionType+"</p>";
				title = "<h3 class='createTit'><span>标<span class='blanks'></span>题：</span>"+list[i].buffet.title+"</h3>";
				checkSpan = "<span class='checkListIcon'><span id='spanAct_"+ list[i].buffet.id +"'></span></span>";
				checkDiv = "<input type='checkbox' class='checkBtn' name='buffetDetailId' id='checkSingle_"+ list[i].buffet.id +"' value='"+list[i].buffet.id+"' title='"+list[i].buffet.title+"'/>";
				buffetMindType = "<div class='createCon'><span class='titTxt'>思维类型：</span>"+list[i].buffetMindTypeNameStr+"</div>";
				buffetAbilityType = "<div class='createCon'><span class='titTxt'>能力类型：</span>"+list[i].buffetAbilityTypeNameStr+"</div>";
				subject = "<div class='createCon clearfix'><span class='titTxt fl'>题<span class='blanks'></span>干：</span><div class='fl'>"+list[i].buffet.subject+"</div></div>";
				if(list[i].buffet.a != ""){
					if(checkAnswerImg(list[i].buffet.answer)){
						optionA = "<div class='optionDiv clearfix'><span class='fl'>A：</span><p class='fl'><img src='"+ list[i].buffet.a +"'></img></p></div>";
					}else{
						optionTextA = "<div class='optionDiv clearfix'><span class='fl'>A：</span><p class='fl'>"+replaceChara(list[i].buffet.a).replace("<","&lt") + "</p></div>";
					}
				}
				if(list[i].buffet.b != ""){
					if(checkAnswerImg(list[i].buffet.answer)){
						optionB = "<div class='optionDiv clearfix'><span class='fl'>B：</span><p class='fl'><img src='"+ list[i].buffet.b +"'></img></p></div>";
					}else{
						optionTextB = "<div class='optionDiv clearfix'><span class='fl'>B：</span><p class='fl'>"+ replaceChara(list[i].buffet.b).replace("<","&lt") +"</p></div>";
					}
				}
				if(list[i].buffet.c != ""){
					if(checkAnswerImg(list[i].buffet.answer)){
						optionC = "<div class='optionDiv clearfix'><span class='fl'>C：</span><p class='fl'><img src='"+ list[i].buffet.c +"'></img></p></div>";
					}else{
						optionTextC = "<div class='optionDiv clearfix'><span class='fl'>C：</span><p class='fl'>"+ replaceChara(list[i].buffet.c).replace("<","&lt") + "</p></div>";
					}
				}
				if(list[i].buffet.d != ""){
					if(checkAnswerImg(list[i].buffet.answer)){
						optionD = "<div class='optionDiv clearfix'><span class='fl'>D：</span><p class='fl'><img src='"+ list[i].buffet.d +"'></img></p></div>";
					}else{
						optionTextD = "<div class='optionDiv clearfix'><span class='fl'>D：</span><p class='fl'>"+ replaceChara(list[i].buffet.d).replace("<","&lt") +"</p></div>";
					}
				}
				if(list[i].buffet.e != ""){
					if(checkAnswerImg(list[i].buffet.answer)){
						optionE = "<div class='optionDiv clearfix'><span class='fl'>E：</span><p class='fl'><img src='"+ list[i].buffet.e +"'></img></p></div>";
					}else{
						optionTextE = "<div class='optionDiv clearfix'><span class='fl'>E：</span><p class='fl'>"+ replaceChara(list[i].buffet.e).replace("<","&lt") +"</p></div>";
					}
				}
				if(list[i].buffet.f != ""){
					if(checkAnswerImg(list[i].buffet.answer)){
						optionF = "<div class='optionDiv clearfix'><span class='fl'>F：</span><p class='fl'><img src='"+ list[i].buffet.f +"'></img></p></div>";
					}else{
						optionTextF += "<div class='optionDiv clearfix'><span class='fl'>F：</span><p class='fl'>"+ replaceChara(list[i].buffet.f).replace("<","&lt") +"</p></div>";
					}
				}
				var answer_pre = "<div class='createCon'><span class='titTxt'>答<span class='blanks'></span>案：</span>";
				var answer_next = "</div>";
				var answerName = "";
				var answerArray = list[i].buffet.answer.split(",");
				if(list[i].buffet.questionType == "判断题"){
					answer = answer_pre + replaceChara(list[i].buffet.answer) + answer_next;
				}else if(list[i].buffet.questionType == "单选题" || list[i].buffet.questionType == "多选题" || list[i].buffet.questionType == "填空选择题"){
					for(var j = 0 ; j < answerArray.length ; j++){
						if(answerArray[j] == list[i].buffet.a.replace("Module/commonJs/ueditor/jsp/lore/","")){
							answerName += "A,";
						}
						if(answerArray[j] == list[i].buffet.b.replace("Module/commonJs/ueditor/jsp/lore/","")){
							answerName += "B,";
						}
						if(answerArray[j] == list[i].buffet.c.replace("Module/commonJs/ueditor/jsp/lore/","")){
							answerName += "C,";
						}
						if(answerArray[j] == list[i].buffet.d.replace("Module/commonJs/ueditor/jsp/lore/","")){
							answerName += "D,";
						}
						if(answerArray[j] == list[i].buffet.e.replace("Module/commonJs/ueditor/jsp/lore/","")){
							answerName += "E,";
						}
						if(answerArray[j] == list[i].buffet.f.replace("Module/commonJs/ueditor/jsp/lore/","")){
							answerName += "F,";
						}
					}
					answer = answer_pre + answerName.substring(0,answerName.length - 1) + answer_next;
				}else{
					answer = answer_pre + replaceChara(list[i].buffet.answer) + answer_next;
				}
				if(list[i].buffet.resolution != ""){
					resolution = "<div class='createCon clearfix'><span class='titTxt fl'>解<span class='blanks'></span>析：</span>"+list[i].buffet.resolution+"</div>";
				}
				if(list[i].buffet.tips != ""){
					tips = "<div class='createCon clearfix'><span class='titTxt fl'>提<span class='blanks'></span>示：</span>"+list[i].buffet.tips+"</div>";
				}
				
				if(checkAnswerImg(list[i].buffet.answer)){
					content_result += queType + title + checkSpan + checkDiv + buffetMindType + buffetAbilityType + subject + optionA + optionB + optionC + optionD + optionE + optionF + answer + resolution + tips + "</label></div></div>";
				}else{
					content_result += queType + title + checkSpan + checkDiv + buffetMindType + buffetAbilityType + subject + optionTextA +  optionTextB +  optionTextC +  optionTextD +  optionTextE +  optionTextF + answer + resolution + tips + "</label></div></div>"; 
				}
			}
		}
		if(div == "xqkfListDiv"){
			$('#'+div).html(content_result);
		}else if(div == "ffgnDiv"){
			$('#'+div).html(content_result);
		}else if(div == "swxlDiv"){
			$('#'+div).html(content_result);
		}else if(div == "zlkfDiv"){
			$('#'+div).html(content_result);
		}else if(div == "nlpyDiv"){
			$('#'+div).html(content_result);
		}else if(div == "gkslDiv"){
			$('#'+div).html(content_result);
		}
		//addBuffetItem();
	}
	function addBuffetItem(checkId){
		var result = $("#finalOptions").html();
		var checkStatus = $("#checkSingle_"+checkId).prop("checked");
		var checkInpTit = $("#checkSingle_"+checkId).attr("title");
		if(loadListDataFlag){
			if(checkStatus){//取消选中
				$("#spanAct_"+checkId).removeClass("checkSingAct");
				$("#span_text_"+checkId).remove();
			}else{//选中
				$("#spanAct_"+checkId).addClass("checkSingAct");
				$("#finalOptions").append("<span id='span_text_"+checkId+"' class='choiceSpan'>"+checkInpTit+"</span>");
			}
			$("#finalOptions").css({"width":($(".choiceSpan").width()*$(".checkSingAct").length)});
			if($("#finalOptions").width() > $("#innerFinalBox").width()){
				$(".posTop1").show();
				selChoiceTxtScroll();
			}else{
				$(".posTop1").hide();
			}
		}
	}
	//检查答案是否为图片
	function checkAnswerImg(answer){
		if(answer.indexOf("jpg") > 0 || answer.indexOf("gif") > 0 || answer.indexOf("bmp") > 0 || answer.indexOf("png") > 0){
			return true;
		}
		return false;
	}
	//替换所有的单引号为自定义字符
	function replaceChara(value){
		return value.replace(/&#wmd;/g,"'");
	}
	//关闭详情窗口
	function closeWindow(){
		$("#buffetDetailDiv").css({
			"-webkit-transform":"translateX("+ cliWid +"px)",
			"transform":"translateX("+ cliWid +"px)"
		});
		setTimeout(function(){
			$("#finalOptions").html("");
		},500);
	}
	//初始获取复选框选择状态(详情)
	function initCheckBoxStatus(){
		//获取页面复选框状态
		var bufdetIdStr = getCheckBoxStatus("buffetId");
		var checkObj = document.getElementsByName("buffetDetailId");
		var resultStr = "";
		if(bufdetIdStr != ""){
			var bufdetIdArray = bufdetIdStr.split(",");
			var buffetLen = bufdetIdArray.length;
			for(var i = 0 ; i < checkObj.length ; i ++){
				for(var j = 0 ; j < buffetLen ; j++)
				if(checkObj[i].value == bufdetIdArray[j]){
					checkObj[i].checked = "checked";
					resultStr += "<span id='span_text_"+ bufdetIdArray[j] +"' class='choiceSpan'>"+ checkObj[i].title +"</span>";
					$("#spanAct_"+bufdetIdArray[j]).addClass("checkSingAct");
					break;
				}
			}
		}
		$("#finalOptions").html(resultStr).css({"width":($(".choiceSpan").width()*buffetLen)});
		if($("#finalOptions").width() > $("#innerFinalBox").width()){
			$(".posTop1").show();
			selChoiceTxtScroll();
		}else{
			$(".posTop1").hide();
		}
	}

	//选中某项在查看详情中能够看到选中文字层的左右iscroll
	function selChoiceTxtScroll() {
		myScroll_1 = new iScroll('innerFinalBox', { 
			checkDOMChanges: true,
			hScrollbar : false
		});
	}
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
	//重新选择后动作
	function checkBuffet(){
		//获取返回的巴菲特编号列表
		var bufdetIdStr = getCheckBoxStatus("buffetDetailId");
		//匹配复选框选中状态
		var checkObj = document.getElementsByName("buffetId");
		//清空选择框所有状态
		for(var i = 0 ; i < checkObj.length ; i ++){
			checkObj[i].checked = false;
		}
		var bufdetIdArray = bufdetIdStr.split(",");
		$(".checkIcon span").removeClass("checkActive"); //点击确定后先清空所有span的active状态
		for(var i = 0 ; i < checkObj.length ; i ++){
			for(var j = 0 ; j < bufdetIdArray.length ; j++)
			if(checkObj[i].value == bufdetIdArray[j]){
				checkObj[i].checked = "checked";
				$("#selActSpan_"+bufdetIdArray[j]).addClass("checkActive"); //给选中的添加active状态
				if(selAllFlag){ //说明我点击了全选按钮
					if(tmpNum != $(".checkActive").length){
						//说明我在详情里有又取消之前全选后的某个对应的checkbox,这里返回后需要取消全选的checked和全选选中的active状态
						$(".selAllSpan span").removeClass("seLAllActive");
						$("#handSend").html("<span class='lineSpan'></span>手动发送");
					}
				}
				break;
			}
		}
		$("#detailNavUl li").removeClass("active");
		$("#detailNavUl li").eq(0).addClass("active");
		$(".comListDiv").hide().css({"opacity":0});
		$(".comListDiv").eq(0).show().css({"opacity":1});
		$("#buffetDetailDiv").css({
			"-webkit-transform":"translateX("+ cliWid +"px)",
			"transform":"translateX("+ cliWid +"px)"
		});
	}
	//发送巴菲特
	function sendMode(mode){
		var buffetIdArray = getReturnBuffetIdArray(mode);
		var sendMode = 0;
		if($("#loreListUl li").length > 0){
			if(mode == "manual"){
				sendMode = 0;
			}
			if(buffetIdArray != ""){
				//插入数据库
				$.ajax({
			        type:'post',
			        dataType:'json',
			        data:{buffetIdArray:buffetIdArray,studyLogId:studyLogId,sendMode:sendMode},
			        url:"buffetApp.do?action=sendBuffet&cilentInfo=app",
			        success:function (json){
			        	if(json["result"] == true){
			        		$(".succImg").show();
							$(".tipImg").hide();
							$("#warnPTxt").html("发送成功");
							commonTipInfoFn($(".warnInfoDiv"),function(){
								backPage();
							});
			        	}else{
			        		$(".succImg").hide();
							$(".tipImg").show();
							$("#warnPTxt").html("发送失败");
							commonTipInfoFn($(".warnInfoDiv"),function(){
								window.location.reload();
							});
			        	}
			        }
				});
			}
		}else{
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("暂无培优试题<br/>请联系客服");
			commonTipInfoFn($(".warnInfoDiv"));
		}
	}
	//获取返回的巴菲特编号列表
	function getReturnBuffetIdArray(mode){
		var selectedBuffetIdStr = "";
		var selectOptions = document.getElementsByName("buffetId"); 
		var bufdetIdArray = "";
		bufdetIdArray = getCheckBoxStatus("buffetId");
		if(mode == "manual"){
			if(bufdetIdArray == ""){
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("请选择培优试题点击手动发送");
				commonTipInfoFn($(".warnInfoDiv"));
			}
		}else{
			if(bufdetIdArray == ""){
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("暂无培优试题<br/>请联系客服");
				commonTipInfoFn($(".warnInfoDiv"));
			}
		}
		return bufdetIdArray;
	}
	//返回上页
	function backPage(){
		var url = "&userId="+userId+"&loginStatus="+loginStatus+"&startTime="+stime+"&endTime="+etime+"&stuId="+stuId+"&backFlag=back";
		window.location.href = "buffetApp.do?action=goBuffetStudyLogPage"+url+"&cilentInfo=app";
	}
	</script>
	
  </head>
  
  <body>
  	<div id="nowLoc" class="nowLoc">
		<span class="backIcon" ontouchend="backPage()"></span>
		<p class="ellip"><span id="loreName"></span>的培优知识点发送</p>
	</div>
	<div id="listWrap" class="parentWrapRel">
		<div class="sonScrollerAbso">
			<ul id="loreListUl"></ul>
		</div>
	</div>
	<div id="btnBox">
		<a class="comABtn" href=javascript:void(0) ontouchend="showBuffetDetail();"><span class="lineSpan"></span>查看详情</a>
		<a id="handSend" class="comABtn" href=javascript:void(0) ontouchend="sendMode('manual')";><span class="lineSpan"></span>手动发送</a>
		<label class="selAllDiv" for="selAllBtn" ontouchend="selectAllOrNull(this);">
			<span class="selAllSpan"><span></span></span>
			<input type="checkbox" name="buffetAll" id="selAllBtn"/>
		</label>
	</div>
	<!-- 查看巴菲特详情层  -->
	<div id="buffetDetailDiv" class="buffetDetailBox">
		<div class="detailTit">
			<a class="goBackBtn fl" href="javascript:void(0)" ontouchend="closeWindow()"></a>
			<p class="loreNameP ellip fl"><span id="loreName_1"></span></p>
		</div>
		<!-- 头部导航  -->
		<div id="checkDetailNav">
			<div id="navWrap" class="innerNav">
				<ul id="detailNavUl" class="clearfix">
					<li class="active">兴趣激发</li>
					<li>方法归纳</li>
					<li>思维训练</li>
					<li>智力开发</li>
					<li>能力培养</li>
					<li>中/高考涉猎</li>
				</ul>
				<span class="shadowSpan posTop"></span>
			</div>
		</div>
		<!-- 选择条件  -->
		<div class="choiceBox clearfix">
			<div id="finalOpaBox">
				<span class="choiceTxt fl">您选择了：</span>
				<div id="innerFinalBox">
					<p id="finalOptions" class="clearfix"></p>
				</div>
				<span class="shadowSpan posTop1"></span>
			</div>
		</div>
		<!-- 详情主体内容  -->
		<div id="detailConWrap" class="parentWrapRel">
			<div class="sonScrollerAbso">
				<!-- 兴趣开发  -->
	    		<div id="xqkfListDiv" class="comListDiv" style="display:block;opacity:1;"></div>
	    		<!-- 方法归纳 -->
	    		<div id="ffgnDiv" class="comListDiv"></div>
	    		<!-- 思维训练  -->
	    		<div id="swxlDiv" class="comListDiv"></div>
	    		<!-- 智力开发  -->
	    		<div id="zlkfDiv" class="comListDiv"></div>
	    		<!-- 能力培养  -->
	    		<div id="nlpyDiv" class="comListDiv"></div>
	    		<!-- 中/高考涉猎  -->
	    		<div id="gkslDiv" class="comListDiv"></div>
    		</div>
		</div>
		<!-- 确定取消  -->
		<div id="detailBtnBox">
			<a class="comABtnDetailBtn" href=javascript:void(0) ontouchend="checkBuffet();"><span class="lineSpan"></span>确定</a>
			<a class="comABtnDetailBtn" href=javascript:void(0) ontouchend="closeWindow()";></span>取消</a>
		</div>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="succImg" src="Module/appWeb/onlineStudy/images/succIcon.png"/>
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
  </body>
</html>
