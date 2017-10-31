//inint章节层的高度
function inintSubjHei(){
	var oCliHei = document.documentElement.clientHeight;
	var oNowLocHei = $("#nowLoc").height();
	var oIntroInfoHei = $("#introInfo").height();
	$("#chapterDiv").height(oCliHei - oNowLocHei - oIntroInfoHei - 21);

}
//iscroll
function loaded() {
	myScroll = new iScroll('chapterDiv', { 
		checkDOMChanges: true,
		hScrollbar : false,
		onScrollMove:function(){
			chapterFlag = false;
		},
		onScrollEnd:function(){
			chapterFlag = true;
		}
	});
}
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
window.addEventListener("load",loaded,false);
//获取章节、知识点数据
function getChapterList(educationId){
	$.ajax({
		  type:"post",
		  async:true,
		  dataType:"json",
		  data:{educationId:educationId,userId:userId},
		  url:"studyApp.do?action=getChapterList&cilentInfo=app",
		  beforeSend:function(){
        	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		  },
		  success:function (json){
			  showChapterList(json);
		  },
		  complete:function(){
        	$("#loadDataDiv").hide();
        	$(".loadingIcon").remove();
          }
	});
}
//显示章节列表
function showChapterList(list){
	var chapterObj = list["chapterList"];
	var chapterCon = "";
	if(chapterObj.length !=0){
		for(var i = 0 ; i < chapterObj.length; i++){
			chapterCon += "<div class='comChapterDiv'><span id=loreSpan_"+chapterObj[i].id+" class='triSpan leftTri'></span>";
			chapterCon += "<h3><a class='ellip' href=javascript:void(0) onclick=getLoreList("+chapterObj[i].id+","+educationId+");>"+chapterObj[i].chapterName+"</a></h3>";
			chapterCon += "<ul id=loreDiv_"+chapterObj[i].id+" class='comDetListUl' style=display:none;></ul></div>";
		}
		$("#scroller").append(chapterCon);
	}else{
		$(".noDataDiv").show().stop().animate({"opacity":1},500);
	}
	
}

//根据指定章节编号获取知识点数据(userId需要调本地手机存储的编号)
function getLoreList(chapterId,educationId){
	if(checkLoginStatus()){
		$.ajax({
			  type:"post",
			  async:false,
			  dataType:"json",
			  data:{educationId:educationId,chapterId:chapterId,userId:userId},
			  url:"studyApp.do?action=getLoreList&cilentInfo=app",
			  success:function (json){ 
				  showLoreList(json,chapterId);
			  }
		});
	}
}
//显示知识点列表
function showLoreList(list,chapterId){
	var loreObj = list["loreList"];
	var loreCon = "";
	
	$(".triSpan").removeClass("topTri").addClass("leftTri");
	$(".comDetListUl").hide();

	$("#loreSpan_"+chapterId).removeClass("leftTri").addClass("topTri");
	$("#loreDiv_"+chapterId).show();
	
	for(var i = 0 ; i < loreObj.length; i++){
		var isFinish = loreObj[i].answerFlag;//0：未做1:未通过,2:已经掌握
		if(isFinish == 0){
			//loreCon += "<li><i class='iconfont icon-wujiaoxing iconCol3 posLR4'></i>";
			loreCon += "<li><i class='starIcon noLearnIcon posLR4'></i>";
		}else if(isFinish == 1){
			//loreCon += "<li><i class='iconfont icon-wujiaoxing iconCol2 posLR4'></i>";
			loreCon += "<li><i class='starIcon noFinIcon posLR4'></i>";
		}else if(isFinish == 2){
			//loreCon += "<li><i class='iconfont icon-wujiaoxing iconCol1 posLR4'></i>";
			loreCon += "<li><i class='starIcon finIcon posLR4'></i>";
		}
		loreCon += "<a class='ellip' href=javascript:void(0) ontouchend=showSpecLoreStudyPage("+loreObj[i].id+",'"+loreObj[i].loreName+"',"+educationId+","+isFinish+","+loreObj[i].chapter.id+");>"+loreObj[i].loreName+"</a></li>";
	}
	$("#loreDiv_"+chapterId).html(loreCon);
}
//根据知识点编号进入知识点学习界面
function showSpecLoreStudyPage(loreId,loreName,educationId,isFinish,chapterId){
	var flag = false;
	if(isFinish == 2){//该知识点完成
		if(checkCurrentLore(loreId,userId)){//当天已经完成，不能再做
			//alert("一个知识点一天只能完成一次");
			commonTipInfoFn($(".warnInfoDiv"));
			flag = false;
		}else{
			if(chapterFlag){
				//（按照1-5步顺序学习）
				flag = true;
			}else{
				chapterFlag = false;
			}	
		}
	}else{//未开始学习--1-4步可能完成可能没完成
		if(chapterFlag){
			flag = true;	
		}else{
			chapterFlag = false;
		}
	}
	if(flag){//跳转到学习地图
		window.location.href = "studyApp.do?action=goStudyMapPage&loreId="+loreId+"&loreName="+loreName+"&educationId="+educationId+"&isFinish="+isFinish+"&chapterId="+chapterId+"&cilentInfo=app";
	}
}
//判断当前知识点每天只能完成一次（true:当天已经完成，false:当天未完成或者未做）
function checkCurrentLore(loreId,userId){
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        data:{loreId:loreId,userId:userId},
        url:"studyApp.do?action=checkCurrentLore&cilentInfo=app",
        success:function (json){
        	flag = json["success"];
        }
    });
	return flag;
}