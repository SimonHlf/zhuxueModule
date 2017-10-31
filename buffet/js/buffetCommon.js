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
}
//动态改变iframe的高度1
function changeHeightPractice(){
	window.top.$(".rightPart").height(1265);
	window.parent.$(".iframeWrap").height(1230);
}
//重置iframe的高度
function changeHeightReset(){
	window.top.$(".rightPart").height(window.top.$(".leftPart").height());
	window.parent.$(".iframeWrap").height(704);
}
//单选多选动态变换的高度
function singleMutiChoiceHei(){
	window.top.$(".rightPart").height(1508);
	window.parent.$(".iframeWrap").height(1460);
}
function singleMutiChoiceHeiEdit(){
	window.top.$(".rightPart").height(1528);
	window.parent.$(".iframeWrap").height(1480);
}
function singleMutiChoiceHeiImg(){
	window.top.$(".rightPart").height(1555);
	window.parent.$(".iframeWrap").height(1505);
}
function singleMutiChoiceHeiImgEidt(){
	window.top.$(".rightPart").height(1575);
	window.parent.$(".iframeWrap").height(1525);
}
//判断题、填空题动态变换的高度
function judgeQueHei(){
	window.top.$(".rightPart").height(1385);
	window.parent.$(".iframeWrap").height(1335);
}
//问答题动态变换的高度
function AnsQuesHeight(){
	window.top.$(".rightPart").height(1700);
	window.parent.$(".iframeWrap").height(1650);
}
//返回上一级
function backPrevStep(){
	window.parent.queryInfo();
}

