// JavaScript Document
var guideFlag = true;
var loreListFlag = true;
var loreExaFlag = true;
//任务栏自定义模拟滚动条
function testHeight(){
	if($(".taskListCon").height()<150){
		$(".scrollParent").hide();
	}else{
		hoverTask();
		scrollBar("mainTaskCon","tasklist","parentScroll","sonScroll",10);
	}
}
function hoverTask(){
	$(".taskBox").hover(function(){
		$(".scrollParent").animate({opacity:1});
	},function(){
		$(".scrollParent").animate({opacity:0});
	});
}
//鼠标移动到右侧层上后动态创建的滚动条的显示
function toBlockScroll(id1,id2){
	var oMainConsR=$(id1);
	oMainConsR.hover(function(){
		$(id2).animate({opacity:1},500);
	},function(){
		$(id2).animate({opacity:0},500);
	});
}

//创建遮罩层
function createLayer(){
	var oLayer=$('<div class="layer"></div>');
	$('body').append(oLayer);
	oLayer.show();
	oLayer.animate({opacity:0.5},300);
}

//判断当前知识点每天只能完成一次
function checkCurrentLore(loreId){
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"studyOnline.do?action=checkCurrentLore&loreId="+loreId,
        success:function (json){
        	flag = json;
        }
    });
	return flag;
}

//div层显示
function showDivLayer(){
	createLayer();
	$("html").addClass('cancelScroll');
	$(".challengeBox").height($(window).height());
	$(".challengeBox").show();
	var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
	getId("challengeWin").style.top = scrollTop + 'px';
}

//开始挑战
function goChallenge(loreId,nextLoreIdArray,studyLogId,optionType,tracebackType,studyType,subjectId,pathType,loreTaskName,access){
	var mainWin = document.getElementById("questionMainCon").contentWindow;
	loreName = encodeURIComponent(loreName);
	loreTaskName = encodeURIComponent(loreTaskName);
	if(status == "2"){
		//判断一天只能在同一个知识点上完成一次
		if(checkCurrentLore(loreId)){
			alert("您今天已经成功的完成一次了，请明天再来吧!");
			window.location.reload(true);
		}else{
			onKeyDown();
			showDivLayer();
			if(optionType == "study"){
				mainWin.location.href = "studyOnline.do?action=showQuestionPage&loreId="+loreId+"&nextLoreIdArray="+nextLoreIdArray+"&studyLogId="+studyLogId+"&task="+task+"&loreName="+loreName+"&studyType="+studyType+"&subjectId="+subjectId+"&pathType="+pathType+"&loreTaskName="+loreTaskName+"&access="+access;
			}else if(optionType == "traceback"){
				mainWin.location.href = "studyOnline.do?action=showTracebackPage&loreId="+loreId+"&nextLoreIdArray="+nextLoreIdArray+"&tracebackType="+tracebackType+"&loreName="+loreName+"&studyLogId="+studyLogId+"&studyType="+studyType+"&subjectId="+subjectId;
			}	
		}
	}else{
		onKeyDown();
		showDivLayer();
		if(optionType == "study"){
			mainWin.location.href = "studyOnline.do?action=showQuestionPage&loreId="+loreId+"&nextLoreIdArray="+nextLoreIdArray+"&studyLogId="+studyLogId+"&task="+task+"&loreName="+loreName+"&studyType="+studyType+"&subjectId="+subjectId+"&pathType="+pathType+"&loreTaskName="+loreTaskName+"&access="+access;
		}else if(optionType == "traceback"){
			mainWin.location.href = "studyOnline.do?action=showTracebackPage&loreId="+loreId+"&nextLoreIdArray="+nextLoreIdArray+"&tracebackType="+tracebackType+"&loreName="+loreName+"&studyLogId="+studyLogId+"&studyType="+studyType+"&subjectId="+subjectId;
		}	
	}
}
function onKeyDown(){
	document.onkeydown = function(ev){
		var oEvent = ev || event;
		if(oEvent.keyCode == 32){
			return false;
		}
	};
}
//判断当前知识点每天只能完成一次
function checkCurrentLore(loreId){
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"studyOnline.do?action=checkCurrentLore&loreId="+loreId,
        success:function (json){
        	flag = json;
        }
    });
	return flag;
}

//关闭开始挑战窗口
function closeChallengeWin(){
	$(".layer").remove();
	$(".challengeBox").hide();
	$(".challengeBox").css('height',0);
	$("html").removeClass('cancelScroll');
	//刷新页面
	var loreName_new =  encodeURIComponent(loreName);
	window.parent.location.href = "studyOnline.do?action=showLoreQuestionList&loreId="+loreId+"&loreName="+loreName_new+"&educationId="+educationId+"&isFinish="+isFinish;
}

//视频讲解//点拨指导//知识清单//解题示范
function showSourceBox(loreId,loreTypeName,showObj){
	var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
	createLayer();
	getId(showObj).style.top = parseInt((document.documentElement.clientHeight - 587)/2) + scrollTop + 'px';
	$("#"+showObj).show();
	getSourceList(loreId,loreTypeName);
}

//关闭--知识讲解，点拨指导，知识清单 解题示范的弹窗
function closePopWin(){
	$(".layer").remove();
	$(".parPopWin").hide();
	$("#viewerPlaceHolder").html("");
}
//点拨指导、知识清单、解题师范根据内容的高度来判断是否需要创建模拟滚动条
function createScroll(parObj,sonConObj,hasStr){
	var oParentObj = $(parObj);
	var oSonConObj = $(sonConObj);
	var oHasStr = $(hasStr);
	var oScrollGuide = "<div id='scrollParent1' class='parentScroll'><div id='scrollSon1' class='sonScrollBar'></div></div>";
	var oScrollList = "<div id='scrollParent2' class='parentScroll'><div id='scrollSon2' class='sonScrollBar'></div></div>";
	var oScrollExa = "<div id='scrollParent3' class='parentScroll'><div id='scrollSon3' class='sonScrollBar'></div></div>";
	if(oSonConObj.height() > oParentObj.height()){
		if(oHasStr.html() == "点"){
			if(guideFlag){
				$(parObj).append(oScrollGuide);
			}
			scrollBar("guideBox","guideDiv","scrollParent1","scrollSon1",10);
			guideFlag = false;
		}else if(oHasStr.html() == "清"){
			if(loreListFlag){
				$(parObj).append(oScrollList);
			}
			scrollBar("loreListBox","loreListDiv","scrollParent2","scrollSon2",10);
			loreListFlag = false;
		}else if(oHasStr.html() == "解"){
			if(loreExaFlag){
				$(parObj).append(oScrollExa);
			}
			scrollBar("loreExaBox","loreExampleDiv","scrollParent3","scrollSon3",10); 
			loreExaFlag = false;
		}
	}
}
//获取资源列表
function getSourceList(loreId,loreTypeName){
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  url:"studyOnline.do?action=showSourceDetail&loreId="+loreId+"&loreTypeName="+encodeURIComponent(loreTypeName),
		  success:function (json){ 
			  if(loreTypeName == "知识讲解"){
				  showVideoList(json);
			  }else if(loreTypeName == "点拨指导"){				  
				  showGuideList(json);
				  createScroll($(".guideDivBox"),$(".conDivGuide"),$(".firstWrold"));
			  }else if(loreTypeName == "知识清单"){
				  showLoreList(json);
				  createScroll($(".loreListDivBox"),$(".conDivLoreList"),$(".firstWrold"));
			  }else if(loreTypeName == "解题示范"){
				  showExampleList(json);
				  createScroll($(".loreExaDivBox"),$(".conDivLoreExa"),$(".firstWrold")); 
			  }
		  }
	});
}
//显示视频
function showVideoList(list){
	$(".resBoxFlash").show();
	$(".headSources").html("<h2 class='headFont'>知识讲解&nbsp;<span class='smallFont'>一线老师为您精心制作的视频</span></h2>");
	if(list != null){
		var videoPath = list[0].answer;
		if(videoPath.indexOf("flv") > 0){
			videoPath = videoPath;
			//playFile(videoPath);
			playFileNew(videoPath);
		}else{
			alert("暂不知识该视频格式播放!");
		}
	}else{
		alert("该知识点暂无视频!");
	}
}
//显示点拨指导内容
var guideFlag_1 = true;
function showGuideList(list){
	$(".resBoxGuide").show();
	$(".headSources").html("<h2 class='headFont'><span class='firstWrold'>点</span>拨指导&nbsp;<span class='smallFont'>重点、难点、关键点、易混点，认真掌握每一点</span></h2>");
	var loreType = "";
	var title = "";
	var content = "";
	var content_result = "";
	var firstDivS = "";
	var div_id = "";
	if(guideFlag_1){
		if(list != null){
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
				if(i == 0){
					loreType = "<div class='guideNav'><span class='titIcon'></span>"+"<h3 class='headTitle'>"+list[i].subType+"</h3></div>";
					title = "<div class='createDiv'><span class='createTit'>标题： </span>"+"<span class='titDetail'>"+list[i].subTitle+"</span>";
					content = "<div class='createCon clearfix'><span>内容：</span>"+ '<p>' +list[i].subContent + '</p>' +"</div></div>";
					$('#guideDiv').append(loreType + title + content);
				}else{
					if(list[i - 1].subType == list[i].subType){
						loreType = "";
						title = "<div class='createDiv'><span class='createTit'>标题： </span>"+"<span class='titDetail'>"+list[i].subTitle+"</span>";
						content = "<div class='createCon clearfix'><span>内容：</span>"+ '<p>' +list[i].subContent + '</p>' +"</div></div>";
						$('#guideDiv').append(title + content);
					}else{
						firstDivS = "<div id='"+div_id+"' class='botShadow'></div>";
						loreType = "<div class='guideNav'><span class='titIcon'></span>"+"<h3 class='headTitle'>"+list[i].subType+"</h3></div></div>";
						title = "<div class='createDiv'><span class='createTit'>标题： </span>"+"<span class='titDetail'>"+list[i].subTitle+"</span>";
						content = "<div class='createCon clearfix'><span>内容：</span>"+ '<p>' +list[i].subContent + '</p>' +"</div></div>";
						$('#guideDiv').append(firstDivS + loreType + title + content);
					}
				}
			}
		}
	}
	guideFlag_1 = false;
}
//显示知识清单列表
function showLoreList(list){
	$(".resBoxLorelist").show();
	$(".headSources").html("<h2 class='headFont'>知识<span class='firstWrold'>清</span>单&nbsp;<span class='smallFont'>本节知识点需要背诵的内容</span></h2>");
	var title = "";
	var content = "";
	var content_result = "";
	if(list != null){
		for(var i = 0 ; i < list.length; i++){
			title = "<div class='createDivList'><span class='titIconList'></span><span class='createTitList'>标题：</span>"+"<span class='titDetail'>"+list[i].subTitle+"</span>";
			content = "<div class='createConList clearfix'><span class='conTitList'>内容：</span>"+ '<p>' +list[i].subContent+ '</p>' +"</div><div class='botShadow'></div></div>";
			content_result += title + content;
		}
	}
	$('#loreListDiv').html(content_result);
}
//显示解题示范列表
function showExampleList(list){
	$(".resBoxExa").show();
	$(".headSources").html("<h2 class='headFont'><span class='firstWrold'>解</span>题示范&nbsp;<span class='smallFont'>学习解题方法，规范解题步骤</span></h2>");
	var subject = "";
	var answer = "";
	var resolution = "";
	var content_result = "";
	if(list != null){
		for(var i = 0 ; i < list.length; i++){
			subject = "<div class='createDivExa'><span class='titIconList'></span><div class='createConExa clearfix'><span class='exaTit'>题干：</span>"+list[i].subject+"</div>";
			answer = "<div class='createConExa clearfix'><span class='exaAns'>答案：</span> "+ '<p>' +list[i].answer+ '<p>' +"</div>";
			resolution = "<div class='createConExa clearfix'><span class='exaExp'>解析：</span>"+ '<p>' +list[i].resolution+ '</p>' +"</div><div class='botShadow'></div></div>";
			content_result += subject + answer + resolution;
		}
	}
	$('#loreExampleDiv').html(content_result);
}
//播放视频
function playFile(videoPath){
	 var so = new SWFObject("Module/loreManager/flashPlayer/PlayerLite.swf","CuPlayerV4","800","540","9","#000000");
	 so.addParam("allowfullscreen","true");
	 so.addParam("allowscriptaccess","always");
	 so.addParam("wmode","opaque");
	 so.addParam("quality","high");
	 so.addParam("salign","lt");
	 so.addVariable("videoDefault",videoPath); //视频文件地址
	 so.addVariable("autoHide","true");
	 so.addVariable("hideType","fade");
	 so.addVariable("autoStart","false");
	 so.addVariable("startVol","100");
	 so.addVariable("hideDelay","60");
	 so.addVariable("bgAlpha","75");
	 so.write("viewerPlaceHolder");
}
//播放视频
function playFileNew(videoPath){
	flowplayer("viewerPlaceHolder", "Module/loreManager/flowPlayer/flowplayer-3.2.18.swf",{
		clip:{
			url: videoPath,
			autoPlay:false,
			autoBuffering: true
		}
	});
}