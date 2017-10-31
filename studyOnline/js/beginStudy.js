function goStudy(){
	$("#explainInfo").hide();
	getSourceList(currentLoreId,"知识讲解");
	$(".leaStepNavBox").show();
	$("#videoInfo").show();
}
function hiddenAllDiv(){
	$("#explainInfo").hide();
	$("#videoInfo").hide();
	$("#guideParentBox").hide();
	$("#guideInfo").hide();
	$("#listParentBox").hide();
	$("#listInfo").hide();
	$("#exaParentBox").hide();
	$("#exampleInfo").hide();
	$("#consolidationInfo").hide();
	$("#practiceInfo").hide();
}
//获取资源列表
function getSourceList(loreId,loreTypeName){
	var newUrl = "studyOnline.do?action=showSourceDetail&loreId="+loreId+"&loreTypeName="+encodeURIComponent(loreTypeName);
	var flag = true;
	var loreType = "";
	if(loreTypeName == "巩固训练"){
		var allNumber = getId("number_jtsf").value;
		loreType = "巩固训练";
		if(allNumber == ""){
			flag = true;
			newUrl = "studyOnline.do?action=loadQuestionList&loreId="+loreId+"&studyLogId="+studyLogId+"&nextLoreIdArray="+currentLoreId+"&loreTypeName="+encodeURIComponent(loreType);
		}else{
			var number = allNumber.split(",").length - 1;
			flag = false;
			alert(number+"题尚未解答，请继续答题!");
			//newUrl = "studyOnline.do?action=loadQuestionList&loreId="+loreId+"&studyLogId="+studyLogId+"&nextLoreIdArray="+currentLoreId+"&loreTypeName="+loreType;
		}
	}
	
	if(flag){
		hiddenAllDiv();
		$.ajax({
			  type:"post",
			  async:false,
			  dataType:"json",
			  url:newUrl,
			  success:function (json){ 
				  if(loreTypeName == "知识讲解"){
					  showVideoList(json);
				  }else if(loreTypeName == "点拨指导"){
					  $("#viewerPlaceHolder").html("");
					  startMove(getId("moveBox"),{left:getId("guidePoint").offsetLeft + 34},function(){$("#guidePoint").addClass("active");$("#comLook").removeAttr("disabled");});
					  startMove(getId("colorBox"),{width:210});
					  showGuideList(json); 
				  }else if(loreTypeName == "知识清单"){
					  startMove(getId("moveBox"),{left:getId("loreListBox").offsetLeft + 34},function(){$("#loreListBox").addClass("active");$("#comBei").removeAttr("disabled");});
					  startMove(getId("colorBox"),{width:352});
					  showLoreList(json);
				  }else if(loreTypeName == "解题示范"){
					  startMove(getId("moveBox"),{left:getId("exampleKpBox").offsetLeft + 34},function(){$("#exampleKpBox").addClass("active");});
					  startMove(getId("colorBox"),{width:527});
					  showExampleList(json);
				  }else if(loreTypeName == "巩固训练"){
					  startMove(getId("moveBox"),{left:getId("consolidKpBox").offsetLeft + 34},function(){$("#consolidKpBox").addClass("active");});
					  startMove(getId("colorBox"),{width:703});
					  showConsolidationList(json);
					  fnTab();
				  }
			  }
		});
	}
}
//视频讲解
function showVideoList(list){
	if(list != null){
		var videoPath = list[0].answer;
		if(videoPath.indexOf("flv") > 0){
			//playFile(videoPath);
			playFileNew(videoPath);
		}else{
			alert("暂不知识该视频格式播放!");
		}
	}else{
		alert("该知识点暂无视频!");
	}
}
//播放视频
function playFile(videoPath){
	 var so = new SWFObject("Module/loreManager/flashPlayer/PlayerLite.swf","CuPlayerV4","600","385","9","#000000");
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
