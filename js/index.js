//轮播图
function autoFalsh(){
	var iNow = 0;
	var page = $('.smallBtn span').size();
	var iTime = null;
	
	$('.smallBtn span').each(function(i){
		$(this).click(function(){
			  banner(i);
		});
	});
	function banner(index){
	    iNow = index;
		$('.smallBtn span').eq(index).addClass('active').siblings('span').removeClass('active');
		  
		  $('#flashBox .banner li').eq(index).stop().animate({
			'opacity':1 
		  },1000).siblings('li').stop().animate({
			  'opacity':0
		  },1000);
	}
	
	autoRun();
	
	function autoRun(){
		iTime = setInterval(function(){
		iNow++;
		
		if(iNow>page-1){
		  iNow = 0;	
		}

		banner(iNow);
		
		},4000);
		
	}
		
	$('#flashBox').hover(function(){
		clearInterval(iTime);
		$(".prev_s").animate({left:20},300);
		$(".next_s").animate({right:20},300);
	},function(){
		autoRun();	
		$(".prev_s").animate({left:-58},300);
		$(".next_s").animate({right:-58},300);		
	});
	
	$(".prev_s").click(function(){
		iNow--;
		if(iNow==-1){
			iNow = page - 1;
		}		
		banner(iNow);
	});
	$(".next_s").click(function(){
		iNow++;
		if(iNow == page){
			iNow=0;
		}
		banner(iNow);
	});
}
//展开微信大图
function showBigWeixin(){
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	var winCliHeight = document.documentElement.clientHeight;
	$(".weixinPicBox").show().css("top",(winCliHeight - $(".weixinPicBox").height())/2 + scrollTop);
	$(".weixinPicBox").animate({left:"50%"},400);
	$("#layer").show();
}
//关闭微信大图
function closeWeiBox(){
	$(".weixinPicBox").animate({left:"-50%"},300,function(){
	 	$(".weixinPicBox").hide();
		$("#layer").hide();
	});  	
}
//获取平台所有会员数
function getAllUserCount(){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getAllUserCount",
        success:function (json){
        	testNum(json);
        	$(".totalRegNum").html(json);
        }
    });
}
function testNum(userCount){
	var newLi = "";
	for(var i = 0 ; i < userCount.length;i++){
		var newLi = "<li id='li_"+i+"'></li>";
		$("#userCount").append(newLi);
		if(i < userCount.length - 1){
			checkEveryNumber(userCount.charAt(i),"li_"+i,"");
		}else{
			checkEveryNumber(userCount.charAt(i),"li_"+i,"_3d");
		}
	}
}
//判断数字（会员数量）
function checkEveryNumber(number,liElement,suffix){
	if(number== 1){
		$("#"+liElement).addClass("numOne"+suffix);
	}else if(number== 2){
		$("#"+liElement).addClass("numTwo"+suffix);
	}else if(number== 3){
		$("#"+liElement).addClass("numThree"+suffix);
	}else if(number== 4){
		$("#"+liElement).addClass("numFour"+suffix);
	}else if(number== 5){
		$("#"+liElement).addClass("numFive"+suffix);
	}else if(number== 6){
		$("#"+liElement).addClass("numSix"+suffix);
	}else if(number== 7){
		$("#"+liElement).addClass("numSeven"+suffix);
	}else if(number== 8){
		$("#"+liElement).addClass("numEight"+suffix);
	}else if(number== 9){
		$("#"+liElement).addClass("numNine"+suffix);
	}else if(number== 0){
		$("#"+liElement).addClass("numZero"+suffix);
	}else{
		$("#"+liElement).addClass("wan");
	}
}
//新闻列表的当前状态的运动小icon
function newsModMove(){
	$(".ulList li").each(function(i){
		$(this).hover(function(){
			$(".moveActive").show().stop().animate({top:this.offsetTop + 14},300);
		});
	});
}
//页面初始化给附着在banner上的登录框的一个timeout的运动
function fixLoginBoxMove(){
	setTimeout(function(){
		$(".fixLoginBox").show().animate({"margin-right":-500});
	},500);
}