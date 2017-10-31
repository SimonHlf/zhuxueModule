// JavaScript Document

//查看个人简介的弹窗
function showPerIntro(id){
	var ntId = id;
	var scrollTop=window.parent.document.documentElement.scrollTop||window.parent.document.body.scrollTop;
	var oCliHeight = document.documentElement.clientHeight;
	var oPerResumeFrame = getId("perResumeFrame");
	var mainWin = oPerResumeFrame.contentWindow;
	mainWin.location.href = "netTeacher.do?action=personalResume&ntId="+id;
	$(".layer").show();
	$(".teaResumeBox").show();
	if($(window).height()>831){
		$(".teaResumeBox").height(831);
		$(".teaResumeBox").show().css({
			"top":(oCliHeight - $(".teaResumeBox").height())/2 + scrollTop
		});
	}else if($(window).height() < 831){
		$(".teaResumeBox").css({"top":scrollTop}).show();
	}	
}
//自定义滚动条的隐藏
function hideScrollBar(){
	if($("#sonCon").height()>=130){
		scrollBar("detailParent","sonCon","parentScrollBox","sonScrollBar",10);
		$(".detailConBox").hover(function(){
			$(".scrollBox").animate({opacity:0.5},300);
		},function(){
			$(".scrollBox").animate({opacity:0},200);
		});	
	}	
}
//网路导师列表科目的悬浮和fixed定位
window.onscroll = function(){
	var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
	if(scrollTop > 300){
		$(".leftSubBox").addClass("Fixed");
		$(".cenList").css('margin-left','190px');
	}else{
		$(".leftSubBox").removeClass("Fixed");
		$(".cenList").css('margin-left','10px');
	}
};

//个人荣誉的无缝滚动
function gloryPicMove(){
	var oGloryLayer = getId("gloryLayer");
	var oUl = oGloryLayer.getElementsByTagName("ul")[0];
	var aLi = oGloryLayer.getElementsByTagName("li");
	
	var timer = null;
	var speed = -2;
	if(aLi.length < 6){
		return;
	}else{
		oUl.innerHTML+=oUl.innerHTML;
		oUl.style.width = aLi[0].offsetWidth*aLi.length+'px';
		
		function toMove(){
			if(oUl.offsetLeft < -oUl.offsetWidth/2){
				oUl.style.left = 0;
			}
			if(oUl.offsetLeft > 0){
				oUl.style.left = -oUl.offsetWidth/2+'px';
			}
			oUl.style.left = oUl.offsetLeft+speed+'px';
		}
		
		timer = setInterval(toMove,30);
		
		oGloryLayer.onmouseover = function(){
			clearInterval(timer);
		};
		oGloryLayer.onmouseout = function(){
			timer = setInterval(toMove,30);
		};	
	}
}

//img图片查看原图的弹窗
function checkOrigImg(){
	$("#gloryImgBox li").each(function(i){
		if($(".gloryImg").length!=0){
			$(this).hover(function(){
				$(".markLayer").eq(i).show();
				$(".checkIcon").eq(i).stop().animate({top:40},200);
			},function(){
				
				$(".checkIcon").eq(i).stop().animate({top:-40},200,function(){
					$(".markLayer").eq(i).hide();
				});
			});
		}else{
			return;
		}
	});
}
//关闭个人简介的弹窗
function closeResumeWin(){
	window.parent.$(".layer").hide();
	window.parent.$(".teaResumeBox").hide();
}
//查看原图的弹窗
function showBigImg(url){
	var oParent = window.parent;
	var oLayer = oParent.$(".layer");
	var oParWinWidth = oParent.document.documentElement.clientWidth;
	var oParWinHeight = oParent.document.documentElement.clientHeight;
	var scrollTop=oParent.document.documentElement.scrollTop||oParent.document.body.scrollTop;
	var oNewLayer = oParent.$(".newLayer");
	var oBigImgBox = oParent.$("#bigImgBox");
	var oOriginPic = oParent.$("#originPic");
	//获取原来图片的宽高
	oOriginPic.attr("src",url);
	oLayer.animate({opacity:0},300,function(){
		oNewLayer.show().css({"left":-oParWinWidth}).animate({left:0},function(){
			oBigImgBox.show();
			oBigImgBox.css({
				"left":parseInt((oParWinWidth - oBigImgBox.width())/2),
				"top":parseInt((oParWinHeight - oBigImgBox.height())/2) + scrollTop
			});
			//将图片原来的宽高成为一个临界点然后将这个点存至这个img的alt属性里面
			oOriginPic.attr("alt",oOriginPic.width());
		});
	});
	//执行拖拽
	dragoBjBox(window.parent.getId("bigImgBox"));	
}


//关闭个人荣誉的原图展现的相册
function closeImgOrgBox(){
	var oParWinWidth = document.documentElement.clientWidth;
	$("#bigImgBox").hide();
	setTimeout(function(){
		$(".newLayer").animate({left:-oParWinWidth},function(){
			$(".layer").animate({opacity:0.5});
			$("#originPic").removeAttr("style");
		});
	},200);
}


function showResumeBox(){
	var aNetTeaImg = $(".netTeaImg");
	aNetTeaImg.each(function(i) {
        $(this).hover(function(){
			$(".imgMarker").eq(i).show();
		},function(){
			$(".imgMarker").eq(i).hide();
		});
    });
}
