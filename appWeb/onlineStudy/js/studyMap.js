//上下滑动的iscroll
function loaded() {
	myScroll = new iScroll('studyMap', { 
		checkDOMChanges: true,
	
		onScrollMove:function(){
			stepFalg = false;
		},
		onScrollEnd:function(){
			stepFalg = true;
		}
	});
			
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
//window.addEventListener("load",loaded,false);
//获取做题后的任务奖励和做题记录
function getStudyTaskInfo(){
	//打开窗口
	$.ajax({
		  type:"post",
		  async:true,
		  dataType:"json",
		  data:{loreId:loreId,studyLogId:studyLogId},
		  url:"studyApp.do?action=getStudyTaskInfo&cilentInfo=app",
		  beforeSend:function(){
        	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		  },
		  success:function (json){ 
			  showStudyTaskInfo(json["stInfo"]);
		  },
		  complete:function(){
        	$("#loadDataDiv").hide();
        	$(".loadingIcon").remove();
          }
	});
}
//显示学习任务信息列表
function showStudyTaskInfo(list){
	var content = "";
	for(var i = 0 ; i < list.length ; i++){
		content += "<li><p class='taskListName ellip'>"+list[i].taskName+"</p>";
		content += "<p class='reword ellip'>+"+list[i].coin+"金币</p>";
		content += "<p class='complete'><i class='taskIcon'></i></p></li>";
	}
	$("#stadus").html(content);
}
//初始化页面数据
function initPage(currStep){
	//根据学段不同放置不同模板(暂时取消)
	/**if(para == "primary"){//小学
		
	}else if(para == "junior"){//初中
		
	}else if(para == "hign"){//高中
		
	}**/
	var content = "";
	content += "<div id='scroller'><div class='topStepDiv'><ul class='clearfix'>";
	content += "<li ontouchend=showStudyInfo('知识讲解');><span></span><strong>视频讲解</strong></li>";
	content += "<li ontouchend=showStudyInfo('点拨指导');><span class='stepNumTwo'></span><strong>点拨指导</strong></li>";
	content += "<li ontouchend=showStudyInfo('知识清单');><span class='stepNumThree'></span><strong>知识清单</strong></li>";
	content += "<li ontouchend=showStudyInfo('解题示范');><span class='stepNumFour'></span><strong>解题示范</strong></li>";
	content += "</ul></div>";
	
	content += "<div class='botStepDiv'><strong class='nowTask'><em class='fl'>任务"+task+"</em><span class='fl ellip'>"+loreTaskName+"</span></strong>";
	content += "<div class='goldenBox'><div class='goldenWrap'><div class='goldNum fl'>"+ rewordNum +"<span class='rewordPic'>奖励</span></div><div class='goldenPic fl'></div></div></div>";
	content += "<a class='backKnBtn' href=javascript:void(0)><span class='tracTit'>溯源路线图:</span>共<i>"+ stepCount +"</i>级<i>"+ loreCount +"</i>个知识点</span><em class='checkBtn' ontouchend=showStudyInfo('溯源');>查看&gt;&gt;</em></a>";
	content += "<a class='goChallengeBtn removeAFocBg' href=javascript:void(0) ontouchend=showStudyInfo('开始挑战');>"+buttonValue+"</a></div></div>";
	$("#studyMap").html(content);
	$(".goldenBox").height($(".goldenWrap").height());
	$(".goldenWrap").css({"left":($(".goldenBox").width() - $(".goldenWrap").width())/2});
	if(currStep == 0){
		//视频讲解可用
	}else if(currStep == 1){
		//视频讲解、点拨指导可用
		$(".stepNumTwo").css({"opacity":1});

	}else if(currStep == 2){
		//视频讲解、点拨指导、知识清单可用
		$(".stepNumTwo").css({"opacity":1});
		$(".stepNumThree").css({"opacity":1});
	}else if(currStep == 3){
		//视频讲解、点拨指导、知识清单、解题示范可用.
		$(".stepNumTwo").css({"opacity":1});
		$(".stepNumThree").css({"opacity":1});
		$(".stepNumFour").css({"opacity":1});
	}else if(currStep >= 4){
		//全部可用
		$(".stepNumTwo").css({"opacity":1});
		$(".stepNumThree").css({"opacity":1});
		$(".stepNumFour").css({"opacity":1});
	}
}
//获取章节、知识点数据
function getStudyMapInfo(){
	var currStep = 0;
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{currLoreId:loreId,userId:userId},
		  url:"studyApp.do?action=getStudyMapInfo&cilentInfo=app",
		  success:function (json){ 
			  currStep = json["currStep"];
			  mapId = json["mapId"];
		  }
	});
	return currStep;
}
//视频讲解，点拨指导，知识清单，解题示范 关闭窗口
function closeWindow(){
	var currStep = getStudyMapInfo();
	$("#studyInfoDivWin").hide().animate({"opacity":0});
	$(".layer").hide();
	$("#videoInfo").hide().html("");
	$("#studyInfoLay").hide();
	$("#studyInfo").removeAttr("style").html("");
	if(currStep == 1){//将第二步知识清单opacity->1
		$(".stepNumTwo").animate({"opacity":1},800);
	}else if(currStep == 2){ //将第三步知识清单opacity->1
		$(".stepNumTwo").css({"opacity":1});
		$(".stepNumThree").animate({"opacity":1},800);
	}else if(currStep == 3){//将第四步解题示范opacity->1
		$(".stepNumTwo").css({"opacity":1});
		$(".stepNumThree").css({"opacity":1});
		$(".stepNumFour").animate({"opacity":1},800);
	}
}
//修改级数
function updateMapStep(newStep){
	$.ajax({
		  type:"post",
		  async:false,//同步
		  dataType:"json",
		  data:{mapId:mapId,newStep:newStep},
		  url:"studyApp.do?action=updateMapStep&cilentInfo=app",
		  success:function (json){ 
			  
		  }
	});
}
//获取资源
function showStudyInfo(loreTypeName){
	if(checkLoginStatus()){
		$.ajax({
			  type:"post",
			  async:false,//同步
			  dataType:"json",
			  data:{loreId:loreId,loreTypeName:loreTypeName},
			  url:"studyApp.do?action=showSourceDetail&cilentInfo=app",
			  success:function (json){ 
				  if(stepFalg){
					  showSourceInfo(json["result"],loreTypeName);  
				  }else{
					  stepFalg = false;
				  }
				  
			  }
		});
	}
}
//判断当前知识点每天只能完成一次
function checkCurrentLore(loreId){
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        data:{loreId:loreId},
        url:"studyApp.do?action=checkCurrentLore&cilentInfo=app",
        success:function (json){
        	flag = json["success"];
        }
    });
	return flag;
}
//判断收费(2015-8-21新增)
function checkFree(loreId,nextLoreIdArray,pathType){
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        data:{loreId:loreId,nextLoreIdArray:nextLoreIdArray,pathType:pathType},
        url:"studyApp.do?action=checkFreeStatus_1&cilentInfo=app",
        success:function (json){
        	flag = json["success"];
        }
    });
	return flag;
}
//显示资源
function showSourceInfo(list,loreTypeName){
	var dataBaseStep = getStudyMapInfo();
	var content = "";
	var step = 0;
	var cliWid = window.screen.width;
	var cliHei = document.documentElement.clientHeight;
	if(loreTypeName == "知识讲解"){
		$("#studyInfoDivWin").show().animate({"opacity":1});
		$("#studyInfoLay").hide();
		$("#videoInfo").show();
		$(".layer").show();
		$("#closeWinBtn").show();
		if(list != null){
			var videoPath = list[0].answer;
			if(videoPath.indexOf("flv") > 0){
				videoPath = videoPath.replace(".flv",".mp4");
				//videoPath = "Module/commonJs/ueditor/jsp/video/40/20140830175341466637.mp4";
				showH5Video(videoPath,"videoInfo","100%","100%");
				//$("#videoInfo").css({"margin-top":parseInt((cliHei - $("#videoInfo").height())/2)});
			}else{
				$("#warnPTxt").html("暂不支持<br/>该视频格式");
				commonTipInfoFn($(".warnInfoDiv"));
			}
		}else{
			$("#warnPTxt").html("该知识点暂无视频");
			commonTipInfoFn($(".warnInfoDiv"));
		}
		step = 1;
		if(dataBaseStep == 4){ //表示全部可点了
			$(".stepNumTwo").css({"opacity":1});
			$(".stepNumThree").css({"opacity":1});
			$(".stepNumFour").css({"opacity":1});
		}
	}else if(loreTypeName == "点拨指导"){
		if(dataBaseStep >= 1){
			$("#studyInfoDivWin").show().animate({"opacity":1});
			$(".layer").show();
			$("#studyInfoLay").show();
			$("#closeWinBtn").hide();
			var loreType = "";
			var title = "";
			var content = "";
			var firstDivS = "";
			var div_id = "";
			if(list != null){
				var guideTit = "<div id='guideTit' class='comHeadTit'><strong>点拨指导</strong><p>重点、难点、关键点、易混点,认真掌握每一点</p></div>";
				var guideCon = "<div id='guideCon' class='comDetailCon'><div id='guideScroll'></div></div>";
				$('#studyInfo').append(guideTit + guideCon);
				for(var i = 0 ; i < list.length ; i++){
					if(list[i].subType == "重点"){
						div_id = "div_zd";
					}else if(list[i].subType == "难点"){
						div_id = "div_nd";
					}else if(list[i].subType == "关键点"){
						div_id = "div_gjd";
					}else if(list[i].subType == "易混点"){
						div_id = "div_yhd";
					}
					if(i == 0){//重点
						loreType = "<h3 class='comConHeadType'><i class='targetIcon'></i>"+list[i].subType+"</h3>";
						title = "<div class='createDiv'><p class='titP clearfix'><span class='comSpanTit fl'>标题： </span>"+"<span class='comSpanTitCon fl'>"+list[i].subTitle+"</span></p>";
						content = "<div class='clearfix'><span class='comSpanTit conTit fl'>内容：</span>" + "<div class='conWrap fl'><p>" +list[i].subContent + "</p></div>" +"</div></div>";
						$('#guideScroll').append(loreType + title + content);
					}else{//新增的重点，难点，关键点，易混点
						if(list[i - 1].subType == list[i].subType){
							loreType = "";
							title = "<div class='createDiv'><p class='titP clearfix'><span class='comSpanTit fl'>标题： </span>"+"<span class='comSpanTitCon fl'>"+list[i].subTitle+"</span></p>";
							content = "<div class='clearfix'><span class='comSpanTit conTit fl'>内容：</span>"+ "<div class='conWrap fl'><p>" +list[i].subContent + "</p></div>" +"</div></div>";
							$('#guideScroll').append(title + content);
						}else{//难点，关键点，易混点
							firstDivS = "<div id='"+div_id+"'>";
							loreType = "<h3 class='comConHeadType'><i class='targetIcon'></i>"+list[i].subType+"</h3>";
							title = "<div class='createDiv'><p class='titP clearfix'><span class='comSpanTit fl'>标题： </span>"+"<span class='comSpanTitCon fl'>"+list[i].subTitle+"</span></p>";
							content = "<div class='clearfix'><span class='comSpanTit conTit fl'>内容：</span>"+ "<div class='conWrap fl'><p>" +list[i].subContent + "</p></div>" +"</div></div>";
							$('#guideScroll').append(firstDivS + loreType + title + content);
						}
					}
				}
			}
			step = 2;
			calComWid();
			$("#guideCon").height($("#studyInfo").height() - $("#guideTit").outerHeight());
			$(".stepNumTwo").css({"opacity":1});
			function loaded_Guide() {
				myScroll = new iScroll('guideCon', { 
					checkDOMChanges: true
				});
				
			}
			loaded_Guide();
			
		}else{
			$("#warnPTxt").html("请先观看视频讲解");
			commonTipInfoFn($(".warnInfoDiv"));
		}
	}else if(loreTypeName == "知识清单"){
		if(dataBaseStep >= 2){
			$("#studyInfoDivWin").show().animate({"opacity":1});
			$(".layer").show();
			$("#studyInfoLay").show();
			$("#closeWinBtn").hide();
			var title = "";
			var content = "";
			var content_result = "";
			if(list != null){
				var knowledgeTit = "<div id='knowledgeTit' class='comHeadTit'><strong>知识清单</strong><p>本节知识点需要背诵的内容</p></div>";
				var knowledgeCon = "<div id='knowledgeCon' class='comDetailCon'><div id='knowledgeScroll'></div></div>";
				$('#studyInfo').append(knowledgeTit + knowledgeCon);
				for(var i = 0 ; i < list.length; i++){
					listTit = "<h3 class='comConHeadType'><i class='targetIcon'></i>知识清单"+ (i+1) +"</h3>";
					title = "<div class='createDiv'><p class='titP clearfix'><span class='comSpanTit fl'>标题：</span>"+"<span class='comSpanTitCon fl'>"+list[i].subTitle+"</span></p>";
					content = "<div class='clearfix'><span class='comSpanTit conTit fl'>内容：</span><div class='conWrap fl'><p>" + list[i].subContent +"</p></div></div></div>";
					content_result += listTit + title + content;
				}
			}
			$('#knowledgeScroll').append(content_result);
			step = 3;
			$("#knowledgeCon").height($("#studyInfo").height() - $("#knowledgeTit").outerHeight());
			function loaded_knowledgeList() {
				myScroll = new iScroll('knowledgeCon', { 
					checkDOMChanges: true
				});
			}
			loaded_knowledgeList();
			$(".stepNumTwo").css({"opacity":1});
			$(".stepNumThree").css({"opacity":1});
		}else{
			$("#warnPTxt").html("请详细观看点拨指导");
			commonTipInfoFn($(".warnInfoDiv"));
		}
	}else if(loreTypeName == "解题示范"){
		if(dataBaseStep >= 3){
			$("#studyInfoDivWin").show().animate({"opacity":1});
			$(".layer").show();
			$("#studyInfoLay").show();
			$("#closeWinBtn").hide();
			var subject = "";
			var answer = "";
			var resolution = "";
			var content_result = "";
			if(list != null){
				var solveExampleTit = "<div id='solveExampleTit' class='comHeadTit'><strong>解题示范</strong><p>学习解题方法，规范解题步骤</p></div>";
				var solveExampleCon = "<div id='solveExampleCon' class='comDetailCon'><div id='solveExampleScroll'></div></div>";
				$('#studyInfo').append(solveExampleTit + solveExampleCon);
				for(var i = 0 ; i < list.length; i++){
					listTit = "<h3 class='comConHeadType'><i class='targetIcon'></i>解题示范"+ (i+1) +"</h3>";
					subject = "<div class='createDiv'><div class='titP clearfix'><span class='comSpanTit fl'>题干：</span>"+"<div class='comSpanTitCon fl'>"+list[i].subject+"</div></div>";
					answer = "<div class='clearfix'><span class='comSpanTit conTit fl'>答案：</span> "+ "<div class='conWrap fl'><p>" +list[i].answer+ "</p></div></div>";
					resolution = "<div class='clearfix'><span class='comSpanTit conTit fl'>解析：</span>"+ "<div class='conWrap_1 fl'><p>" +list[i].resolution+ "</p></div></div></div>";
					content_result += listTit + subject + answer + resolution;
				}
			}
			$('#solveExampleScroll').append(content_result);
			
			step = 4;
			$("#solveExampleCon").height($("#studyInfo").height() - $("#solveExampleTit").outerHeight());
			function loaded_example() {
				myScroll = new iScroll('solveExampleCon', { 
					checkDOMChanges: true
				});
			}
			loaded_example();
			$(".stepNumTwo").css({"opacity":1});
			$(".stepNumThree").css({"opacity":1});
			$(".stepNumFour").css({"opacity":1});
		}else{
			$("#warnPTxt").html("请详细观看知识清单");
			commonTipInfoFn($(".warnInfoDiv"));
		}

	}else if(loreTypeName == "开始挑战" || loreTypeName == "溯源"){
		if(dataBaseStep >= 4){
			step = 5;
			if(loreTypeName == "溯源"){
				var param = "&loreId="+loreId+"&nextLoreIdArray="+nextLoreIdArray+"&tracebackType=review&loreName="+loreName+"&studyLogId="+studyLogId+"&studyType=2&subjectId="+subId+"&chapterId="+chapterId+"&educationId="+educationId;
				window.location.href = "studyApp.do?action=showTracebackPage"+param+"&cilentInfo=app";
			}else if(loreTypeName == "开始挑战"){
				if(isFinish == "2"){
					//判断一天只能在同一个知识点上完成一次
					if(checkCurrentLore(loreId)){
						//alert("您今天已经成功的完成一次了，请明天再来吧!");
						$("#warnPTxt").html("一个知识点一天只能完成一次");
						commonTipInfoFn($(".warnInfoDiv"));
					}else{
						if(checkFree(loreId,nextLoreIdArray,pathType)){
							var param = "&loreId="+loreId+"&nextLoreIdArray="+nextLoreIdArray+"&studyLogId="+studyLogId+"&task="+task+"&loreName="+loreName+"&subjectId="+subjectId+"&pathType="+pathType+"&loreTaskName="+loreTaskName+"&loreTypeName="+loreTypeName_p+"&access="+access+"&chapterId="+chapterId+"&educationId="+educationId;
							window.location.href = "studyApp.do?action=showQuestionPage"+param+"&cilentInfo=app";
						}else{
							//alert("您的免费使用期限已到，如想继续使用，请及时续费购买以便继续使用!");
							$("#warnPTxt").html("免费使用已到期<br/>请续费");
							commonTipInfoFn($(".warnInfoDiv"));
						}
					}
				}else{//未开始做或者未完成
					if(checkFree(loreId,nextLoreIdArray,pathType)){
						var param = "&loreId="+loreId+"&nextLoreIdArray="+nextLoreIdArray+"&studyLogId="+studyLogId+"&task="+task+"&loreName="+loreName+"&subjectId="+subjectId+"&pathType="+pathType+"&loreTaskName="+loreTaskName+"&loreTypeName="+loreTypeName_p+"&access="+access+"&chapterId="+chapterId+"&educationId="+educationId;
						window.location.href = "studyApp.do?action=showQuestionPage"+param+"&cilentInfo=app";
					}else{
						//alert("您的免费使用期限已到，如想继续使用，请及时续费购买以便继续使用!");
						$("#warnPTxt").html("免费使用已到期<br/>请续费");
						commonTipInfoFn($(".warnInfoDiv"));
					}
				}
			}
		}else{
			$("#warnPTxt").html("请详细观看解题示范");
			commonTipInfoFn($(".warnInfoDiv"));
		}
	}
	$("#studyInfoLay").css({"top":(oClieHei - $("#studyInfoLay").height())/2});
	updateMapStep(step);//根据情况修改map层数
}
/* 查看任务奖励及描述 */
function showTaskWin(){
	$(".layer").show();
	$("#taskWrap").show().stop().animate({"opacity":1});
	$("#mainTaskCon").height($("#taskBox").height() - $("#topTask").outerHeight());
	checkTaskLen();
}
function checkTaskLen(){
	if($("#stadus li").length == 0){
		$(".noRecordP").show();
	}else{
		$(".noRecordP").hide();
		loaded_Task();
	}
}
function closeTaskWin(){
	$(".layer").hide();
	$("#taskWrap").hide().stop().animate({"opacity":0});
}
function loaded_Task() {
	myScroll = new iScroll('mainTaskCon', { 
		checkDOMChanges: true
	});
}
//点拨指导计算右侧每个p标签的宽度
function calComWid(){
	$(".comSpanTitCon").each(function(i){
		$(".comSpanTitCon").eq(i).width($(".createDiv").eq(i).width() - $(".comSpanTit").eq(i).width() - 10);
		$(".conWrap").eq(i).addClass("fl").width($(".comSpanTitCon").eq(i).width() - 10);
	});
}