
function initDiagInfoTxt(){
	if(option == "1"){//诊断 taskInfoBox
		if(totalMoney == "-1"){//未开始做题
			getLoreTree(tracebackType);
		}else{
			if(success == "0"){//本节题未做完或者未进行最后提交  
				$(".taskInfoBox p").html("<span>"+ successStep +"</span>" + "的针对性诊断还没有结束，点击继续诊断帮你检测出本知识点的掌握情况");
				getLoreTree1(path);
			}else if(success == "1"){
				//这里需要判断是否中途做题未做完就关闭  如果未做完提示该任务对应的题目还没作答完，点击继续诊断继续做题
				//如果做完 未做对 显示恭喜您完成当前任务，并且显示获得金币的数量
					if(access == "0"){//当前节点未全部做完
						$(".taskInfoBox p").html("学习要持之以恒，<span>"+ successStep +"</span>诊断还未结束，点击确定继续诊断");
					}else{
						$(".taskInfoBox strong").html("恭喜你完成任务，获得"+ totalMoney +"金币奖励");
						$(".taskInfoBox p").html("通过诊断，您对<span>"+ successStep +"</span>" + "掌握的不是很好，需要启动溯源对下一级关联知识点进行诊断");	
					}
				
				getLoreTree1(path);
			}else{
				//显示当前任务获得的金币数量 恭喜您完成任务
				$(".taskInfoBox p").html("很棒哦，这个知识点的诊断题全对了");
				getLoreTree1(path);
			}
		}
	}else{//学习
		if(success == "6"){//全部正确，诊断学习结束
			$(".taskInfoBox p").html("这个知识点通过听“视频讲解”、看“点拨指导”、背“知识清单”、学“解题示范”、做“再次诊断”，你掌握的很棒");
		}else if(success == "5"){//再次诊断全部做对
			//五步学习针对某个知识点学习后进行再次诊断然后全部正确
			$(".taskInfoBox p").html("这个知识点通过听“视频讲解”、看“点拨指导”、背“知识清单”、学“解题示范”、做“再次诊断”，你掌握的很棒！根据学习路线图学习下一个知识点吧！");
		}else if(success == "4"){//5步学习完成，即将进入再次诊断
			//开始学习某一个知识点然后巩固训练全部做对 或者部分做对
			$(".taskInfoBox p").html("您已对<span>"+ currentloreName_study +"</span>" + "知识点学习完成，现在开始再次诊断吧");
		}else if(success == "3"){
			$(".taskInfoBox p").html("很棒哦，这个知识点的<span>"+ successStep +"</span>全对了，跟着老师学习一下" + nextLoreStep + "吧");
		}else if(success == "2"){//没通过，学习一下这些知识
			$(".taskInfoBox p").html("通过诊断，您对<span>"+ successStep +"</span>掌握的不是很好，跟着老师系统依次学习一下这些知识点吧");
		}else if(success == "1"){//5步学习法通过
			$("#common").html("恭喜你，完成任务");
			$(".taskInfoBox p").html("恭喜您，完成任务");
		}else if(success == "0"){
			$(".taskInfoBox p").html("学习要持之以恒，<span>"+ successStep +"</span>再次诊断还未结束,继续学习直到掌握住");
		}
		getStudyLoreTree(studyPath);
	}
}

function loaded() {
	myScroll = new iScroll('loreTreePar', { 
		checkDOMChanges: true
	});
	
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
window.addEventListener("load",loaded,false);



//根据知识点编号获取该知识点信息（溯源学习时用）
function getLoreTree1(path){
	if(path != ""){
		var pathArray = path.split(":");
		for(var i = 0 ; i < pathArray.length; i++){
			var alonePathArray = pathArray[i].split("|");
			for(var j = 0 ; j < alonePathArray.length ; j++){
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"studyApp.do?action=getLoreQuestionList&loreId="+alonePathArray[j]+"&cilentInfo=app",
					  
					  success:function (json){ 
						  showPathList(json["loreList"],i,pathArray.length - 1);
					  }
				});
			}
		}
		setLoreColoreStudy(path,nextLoreIdArray,"zd");
	}
}

function showPathList(list,step,totalStep){
	var existDiv = document.getElementById("div_"+step);
	if(existDiv == null){
		if(step != 0){
			$('#divKpWrap').append("<div id='div_"+step+"' class='numKpBoxDiv clearfix'><p class='stepNums'><span class='circle'></span><strong>"+step+"</strong>级</p><div id='sonDiv_"+step+"' class='nowKpBox comBgCol'></div></div>");
		}else{
			$('#nowKpWrap').append("<div id='div_"+step+"' class='nowKpoint comBgCol'><span class='comCircl lSpan'></span><p>本知识点</p><div id='sonDiv_"+step+"'></div><span class='comCircl rSpan'></span></div>");
		}
		
	}
	//当前知识点
	$('#sonDiv_'+step).append("<p id='span_"+list[0].id+"'><span class='treeSpan'><i id='i_"+list[0].id+"' class='comDiagIcon_tree noDiag_tree'></i>"+list[0].loreName+"</span></p>");
	if(success != "2"){ //代表将要诊断 oranges
		for(var i = 0 ; i < nextLoreIdArray.split(",").length ; i++){
			$("#span_"+nextLoreIdArray.split(",")[i]).addClass("oranges");
			$("#i_"+nextLoreIdArray.split(",")[i]).addClass("diagIng_tree").removeClass("noDiag_tree");
		}
	}			
}

function getLoreTree(tracebackType){
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  url:"studyApp.do?action=getLoreTree&loreId="+loreId+"&cilentInfo=app",
		  success:function (json){ 
			  if(tracebackType == "preview"){
				  showPreviewTracebackList(json["loreTree"]);
			  }else if(tracebackType == "review"){
				  showReviewTracebackList(json["loreTree"]);
				  if(nextLoreIdArray != ""){
					  var array = nextLoreIdArray.split(",");
					  for(var i = 0 ; i < array.length ; i++){
						  $("#span_"+array[i]).addClass("oranges");
						  $("#i_"+array[i]).addClass("diagIng_tree").removeClass("noDiag_tree");
					  }
				  }
			  }
		  }
	});
}

function getStudyLoreTree(studyPath){
	if(studyPath != ""){
		var studyPathArray = studyPath.split(":");
		for(var i = 0 ; i < studyPathArray.length; i++){
			var alonePathArray = studyPathArray[i].split("|");
			for(var j = 0 ; j < alonePathArray.length ; j++){
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"studyApp.do?action=getLoreQuestionList&loreId="+alonePathArray[j]+"&cilentInfo=app",
					  success:function (json){ 
						  showStudyTracebackList(json["loreList"],i,studyPathArray.length - 1);
					  }
				});
			}
		}
		setLoreColoreStudy(studyPath,nextLoreIdArray,"study");
	}
}
//学习路线图
function showStudyTracebackList(list,step,totalStep){
	var stepNum = totalStep - step;
	var existDiv = document.getElementById("div_"+step);
	var str = "<div id='nowKpWrap'><span class='nowKpLine posLine'></span></div>";
	$("#nowKpWrap").remove();
	$(".diagIconUl li span").eq(0).html("已掌握");
	$(".diagIconUl li span").eq(1).html("将要学习");
	$(".diagIconUl li span").eq(2).html("未学习");
	if(existDiv == null){
		if(step != totalStep){
			$('#divKpWrap').append("<div id='div_"+step+"' class='numKpBoxDiv clearfix'><p class='stepNums'><span class='circle'></span><strong>"+stepNum+"</strong>级</p><div id='sonDiv_"+step+"' class='nowKpBox comBgCol'></div></div>");
		}else{
			$("#loreTreeDiv").append(str);
			$('#nowKpWrap').append("<div id='div_"+step+"' class='nowKpoint_1 comBgCol'><span class='comCircl lSpan'></span><p>本知识点</p><p id='sonDiv_"+step+"'></p><span class='comCircl rSpan'></span></div>");
		}
	}
	$("#sonDiv_"+step).append("<p id='span_"+list[0].id+"'><span class='treeSpan'><i id='i_"+list[0].id+"' class='comDiagIcon_tree noDiag_tree'></i>"+list[0].loreName+"</span></p>");
	$("#span_"+nextLoreIdArray).addClass("oranges");
	$("#i_"+nextLoreIdArray).addClass("diagIng_tree").removeClass("noDiag_tree");
}
//着色状态(诊断/学习过的变绿色)
function setLoreColoreStudy(studyPath,nextLoreIdArray,type){
	var studyPathArray = studyPath.split(":");
	var flag = false;
	for(var i = 0 ; i < studyPathArray.length; i++){
		if(type == "study"){
			var alonePathArray = studyPathArray[i].split("|");
			for(var j = 0 ; j < alonePathArray.length ; j++){
				if(alonePathArray[j] != nextLoreIdArray){
					$("#span_"+alonePathArray[j]).addClass("green");
					$("#i_"+alonePathArray[j]).addClass("hasDiag_tree").removeClass("noDiag_tree");
				}else{
					flag = true;
					break;
				}
			}
			if(flag){
				break;
			}
		}else{//诊断时
			if(success == "2"){//本知识典直接一次性全部正确
				$("#span_"+nextLoreIdArray).addClass("green");
				$("#i_"+nextLoreIdArray).addClass("hasDiag_tree").removeClass("noDiag_tree");
			}else{
				var nextLoreArray_new = nextLoreIdArray.replace(/\,/g,"|");
				if(studyPathArray[i] != nextLoreArray_new){
					var array = studyPathArray[i].split("|");
					for(var k = 0; k < array.length ; k++){
						$("#span_"+array[k]).addClass("green");
						$("#i_"+array[k]).addClass("hasDiag_tree").removeClass("noDiag_tree");
					}
				}else{
					flag = true;
					break;
				}
			}
		}
		
	}
}
//顺序溯源开始
var previewStep = 0;
function showReviewTracebackList(list){
	var reviewStep = 0;
	if(list != null){
		$('#nowKpWrap').append("<div id='div_0' class='nowKpoint comBgCol'><span class='comCircl lSpan'></span><p>本知识点</p><p id='sonDiv_"+list[0].id+"'></p><span class='comCircl rSpan'></span></div>");
		$('#sonDiv_'+list[0].id).append("<p id='span_"+list[0].id+"'><span class='treeSpan'><i id='i_"+list[0].id+"' class='comDiagIcon_tree noDiag_tree'></i>"+list[0].text+"</span></p>");
		var list_1 = list[0].children;
		var list_length_1 = 0;
		if(list_1 != undefined){
			list_length_1 = list_1.length;
		}
		if(list_length_1 > 0){
			reviewStep++;
			$('#divKpWrap').append("<div id='div_"+ reviewStep +"' class='numKpBoxDiv clearfix'><p class='stepNums'><span class='circle'></span><strong>"+reviewStep+"</strong>级</p><div id='sonDiv_"+ reviewStep +"' class='nowKpBox comBgCol'></div></div>");
			var nextStep = reviewStep + 1;//nextStep = 2;reviewStep = 1;
			for(var i = 0 ; i < list_length_1 ; i++){
				if(list_1[i].repeatFlag == false){
					$('#sonDiv_'+reviewStep).append("<p id='span_"+list_1[i].id+"'><span class='treeSpan'><i id='i_"+list_1[i].id+"' class='comDiagIcon_tree noDiag_tree'></i>"+list_1[i].text+"</span></p>");
					var list_10 = list_1[i].children;
					var list_length = 0;
					if(list_10 != undefined){
						list_length = list_10.length;
					}
					if(list_length > 0){
						showSubTracebackList(list_10,nextStep,"review");
					}
				}
			}
		}
	}
}
//顺序溯源子项
function showSubTracebackList(list,currentStep,type){			
	var nextStep = currentStep + 1;//currentStep = 2;nextStep = 3;
		for(var i = 0 ; i < list.length ; i++){
			if(list[i].repeatFlag == false){
				if(type == "review"){
					var existDiv = document.getElementById("div_"+currentStep);
					if(existDiv == null){
						$('#divKpWrap').append("<div id='div_"+ currentStep +"' class='numKpBoxDiv clearfix'><p class='stepNums'><span class='circle'></span><strong>"+currentStep+"</strong>级</p><div id='sonDiv_"+ currentStep +"' class='nowKpBox comBgCol'></div></div>");
					}
				}else{
					previewStep++;
					$('#divKpWrap').append("<div id='div_"+ nextLoreIdStr +"' class='numKpBoxDiv clearfix'><p class='stepNums'><span class='circle'></span><strong>"+previewStep+"</strong>级</p><div id='sonDiv_"+ nextLoreIdStr +"' class='nowKpBox comBgCol'></div></div>");
				}
				$('#sonDiv_'+currentStep).append("<p id='span_"+list[i].id+"'><span class='treeSpan'><i id='i_"+list[i].id+"' class='comDiagIcon_tree noDiag_tree'></i>"+list[i].text+"</span></p>");
				var list_10 = list[i].children;
				var list_length = 0;
				if(list_10 != undefined){
					list_length = list_10.length;
				}
				if(list_length > 0){
					showSubTracebackList(list_10,nextStep,"review");
				}
			}
		}
}
//顺序课后学习

//顺序课前预习
function showPreviewTracebackList(list){
	if(list != null){
		var list_1 = list[0].children;
		var list_length_1 = 0;
		if(list_1 != undefined){
			list_length_1 = list_1.length;
		}
		if(list_length_1 > 0){
			var nextLoreIdStr = "";
			for(var i = 0 ; i < list_length_1 ; i++){
				if(list_1[i].repeatFlag == false){
					nextLoreIdStr += list_1[i].id + "_";
				}	
			}
			previewStep++;
			nextLoreIdStr = nextLoreIdStr.substring(0,nextLoreIdStr.length - 1);
			$('#loreTreeDiv').append("<div class='arrowBox' id='div_gx_"+ previewStep +"'><span class='arrowIcon'></span></div>");
			$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+ nextLoreIdStr +"'><span class='numKp fl'>"+"<span class='stepNums'>"+previewStep+"</span>"+"级关联知识点07:</span><div class='nowKpBox fl' id='sonDiv_"+ nextLoreIdStr +"'></div></div>");
			for(var i = 0 ; i < list_length_1 ; i++){
				if(list_1[i].repeatFlag == false){
					$('#sonDiv_'+nextLoreIdStr).append("<span class='nowKp font14' id='span_"+list_1[i].id+"' title='"+ list_1[i].text +"'>"+list_1[i].text+"</span>");
					var list_10 = list_1[i].children;
					var list_length = 0;
					if(list_10 != undefined){
						list_length = list_10.length;
					}
					if(list_length > 0){
						showSubTracebackList(list_10,nextLoreIdStr,"preview");
					}
				}
			}
		}
	}
}
function closeWindow(){
	if(checkLoginStatus()){
		window.location.href = "studyApp.do?action=goStudyMapPage&loreId="+loreId+"&loreName="+loreName+"&educationId="+educationId+"&isFinish="+isFinish+"&chapterId="+chapterId+"&cilentInfo=app";
	}
}