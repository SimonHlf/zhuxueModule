//当列表内容超过一定高度的使滚动条的出现和翻页列表的拖拽
function toScrollBlock(){
	if($("#conMidBox").height()>=660){
		$("#midCon").hover(function(){
			$("#boxScroll").animate({left:0},300);
		},function(){
			$("#boxScroll").animate({left:-10},300);
		});	
		drayTurnPage();
		$(".turnPageBox").css('cursor','move');
	}
}
function drayTurnPage(){
	var disX=0;
	var disY=0;
	$(".turnPageBox").mousedown(function(ev){
		disX=ev.pageX-$(this).offset().left;
		disY=ev.pageY-$(this).offset().top;
		$(document).mousemove(function(ev){
			$(".turnPageBox").css('left',ev.pageX-disX);
			$(".turnPageBox").css('top',ev.pageY-disY);
		});
		$(document).mouseup(function(){
			$(document).off();
		});
		return false;
	});
}

//返回顶部
function backTop(parentId,btnId){
	var oParentWrap=getId(parentId);
	var oBtnTop=getId(btnId);
	var timer=null;
	var bSys=true;

	oParentWrap.onscroll=function(){
		var scrollTop=oParentWrap.scrollTop;
		if(scrollTop>150){
			startMove(oBtnTop,{bottom:0});
			$(".newAddBtn").show(300);
		}else{
			if(scrollTop==0){
				startMove(oBtnTop,{bottom:-50});
			}
			$(".newAddBtn").hide(300);
		}
		if(!bSys){
			clearInterval(timer);
		}
		bSys=false;
	};
	oBtnTop.onclick=function(){
		timer=setInterval(function(){
			var scrollTop=oParentWrap.scrollTop;
			if(scrollTop==0){
				clearInterval(timer);
			}
			bSys=true;
			var speed=(0-scrollTop)/8;
			speed=speed>0?Math.ceil(speed):Math.floor(speed);
			oParentWrap.scrollTop=speed+scrollTop;

		},30);
	};	
}
//动态改变iframe的高度
function changeHeight(){
	window.top.$(".rightPart").height(1185);
	window.parent.$(".iframeWrap").height(1130);
	$(".rightCon").height(1130);
}
//动态改变iframe的高度1
function changeHeightPractice(){
	window.top.$(".rightPart").height(1265);
	window.parent.$(".iframeWrap").height(1230);
	$(".rightCon").height(1230);
}
//重置iframe的高度
function changeHeightReset(){
	window.top.$(".rightPart").height(window.top.$(".leftPart").height());
	window.parent.$(".iframeWrap").height(669);
	$(".rightCon").height(667);
}
//单选多选动态变换的高度
function singleMutiChoiceHei(){
	window.top.$(".rightPart").height(1400);
	window.parent.parent.$(".iframeWrap").height(1370);
	window.parent.$(".rightCon").height(1370);
}
function singleMutiChoiceHeiImg(){
	window.top.$(".rightPart").height(1460);
	window.parent.parent.$(".iframeWrap").height(1435);
	window.parent.$(".rightCon").height(1435);
}
//判断题、填空题动态变换的高度
function judgeQueHei(){
	window.top.$(".rightPart").height(1285);
	window.parent.parent.$(".iframeWrap").height(1255);
	window.parent.$(".rightCon").height(1250);
}
//问答题动态变换的高度
function AnsQuesHeight(){
	window.top.$(".rightPart").height(1605);
	window.parent.parent.$(".iframeWrap").height(1565);
	window.parent.$(".rightCon").height(1565);
}

//返回主界面
function backMain(loreId){
	window.location.href = "loreManager.do?action=editDetail&loreId="+loreId;
	changeHeightReset();
}
//查询搜索知识点按钮运动的公共方法
function moveQueryBox(id,option){
	var oMoveWrap;
	if(option == "top"){
		oMoveWrap = window.parent.parent.getId(id);
	}else if(option == "parent"){
		oMoveWrap = window.parent.getId(id);
	}else if(option == ""){
		oMoveWrap = getId(id);
	}
	var scrollTop = window.top.document.documentElement.scrollTop || window.top.document.body.scrollTop;
	var t = Math.ceil((window.top.document.documentElement.clientHeight - oMoveWrap.offsetHeight)/2);
	startMove(oMoveWrap,{top:scrollTop+t});
}