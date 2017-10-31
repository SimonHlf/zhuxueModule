//每一屏中间大父级的高度以及头部大标题以及描述文字的运动
function comPageMove(obj1,obj2,obj3){
	$(obj1).height($(window).height());
	$(obj2).css({
		"left":($(obj1).width() - $(obj2).width())/2
	}).animate({"top":25},function(){
		$(obj3).slideDown(500);
	});
}
//屏幕滚动的插件调用方法
function fullPageMove(){
	var runPage;
	runPage = new FullPage({
		id: 'pageContain',
		slideTime: 800,
		effect: {
			transform: {
				translate: 'Y'
			},
			opacity: [0, 1]
		},
		mode: 'wheel, touch, nav:navBar',
		easing: 'ease',
		callback: function(index, thisPage){
			//alert('滚动到了第 ' + (index + 1) + ' 屏');
			if(index == 0){
				//执行第一屏的动作方法
			}else if(index == 1){
				//执行第二屏的动作方法
				$(".mainContent2_1").css({
					"left":($(window).width() - $(".mainContent2_1").width())/2
				});
				comPageMove($(".mainContent2_1"),$(".comH2Tit2"),$(".decTxt2"));
				setTimeout(function(){
					page2FlashMove();
				},850);
			}else if(index == 2){
				//执行第三屏的动作方法
				comPageMove($(".mainContent3"),$(".comH2Tit3"),$(".decTxt3"));
				setTimeout(function(){
					page3ImgMove();
				},850);
			}else if(index == 3){
				//执行第四屏的动作方法
				comPageMove($(".mainContent4"),$(".comH2Tit4"),$(".decTxt4"));
				setTimeout(function(){
					page4ImgMove();
				},850);
			}
			
		}
	});
}
//初始化检测屏幕分辨率来调用不同的元素位置方法
function checkViewScreen(){
	var oWidth = $(window).width();
	if(oWidth >=1920){
		fixPositionBig();
	}else if(oWidth >= 1600 && oWidth < 1920){
		fixPositionMid()
	}else if(oWidth >= 1366 && oWidth < 1600){
		fixPositionNote();
	}else if(oWidth>=1000 && oWidth < 1366){
		fixPositionSmall();
	}
	page1Move();
}
//根据不同分辨率执行小图运动的高度
function comPageImgMove(i){
	var oWidth = $(window).width();
	if(oWidth >=1920){
		if(i==2){//第三屏小图的运动调用
			comPage3SmPicMove(105);
		}else if(i==3){//第四屏小图的运动调用
			comPage4ZoomPicMove(80,336);
		}
	}else if(oWidth >= 1600 && oWidth < 1920){
		if(i==2){
			comPage3SmPicMove(105);
		}else if(i==3){
			comPage4ZoomPicMove(80,279);
		}
	}else if(oWidth >= 1366 && oWidth < 1600){
		if(i==2){
			comPage3SmPicMove(66);
		}else if(i==3){
			comPage4ZoomPicMove(50,210);
		}	
	}else if(oWidth>=1000 && oWidth < 1366){
		if(i==2){
			comPage3SmPicMove(66);
		}else if(i==3){
			comPage4ZoomPicMove(50,210);
		}
	}
}
//第二屏的轮播图调用方法
function page2FlashAuto(){
	$('#myroundabout').roundabout({
		autoplay: true,//自动播放
		autoplayDuration: 3000,//时间
		autoplayPauseOnHover: true,//自动鼠标移上停滞
		shape: 'figure8',  //支持属性theJuggler、figure8、waterWheel、square、conveyorBeltLeft、conveyorBeltRight、goodbyeCruelWorld、diagonalRingLeft、diagonalRingRight、rollerCoaster、tearDrop、tickingClock、flurry、nowSlide、risingEssence随便换 
		minOpacity: 1
	});
}
//第一屏 页面初始化加载时调用的运动方法
function page1Move(){
	$(".mainContent").height($(window).height() - 106);
	$(".comH2Tit").css(
			{"left":($(".mainContent").width() - $(".comH2Tit").width())/2}
		).animate(
			{top:15},500,function(){
				$(".decTxt").slideDown(500);
				setTimeout(function(){
					$(".imgLayer").show().animate({"opacity":0.5},300,function(){
						$(".imgBox").show().animate({"left":0},function(){$(".page1BotBox").slideDown();});
					});
				},300);
				
			}
		);
}
//第二屏轮播图的显示
function page2FlashMove(){
	$(".roundabout li").show();
}
//第三屏中间图片的运动显示
function page3ImgMove(){
	$(".page3DecImg").show();
	setTimeout(function(){
		$(".page3ComImg").animate({"left":($(window).width() - $(".page3MagicImg").width())/2},500,function(){
			comPageImgMove(2);
		});
	},300);
}
//第三屏中间图片的小图高度的运动
function comPage3SmPicMove(hei){
	$(".page3SmallImg_1").animate({"height":hei},300,function(){
		$(".page3SmallImg_3").animate({"height":hei},300,function(){
			$(".page3SmallImg_2").animate({"height":hei});
		});
	});
}
//第四屏中间图片的运动显示
function page4ImgMove(){
	$(".page4Img").show();
	setTimeout(function(){
		comPageImgMove(3);
	},500);
}
//第四屏中间图片放大镜和详情图片的运动
function comPage4ZoomPicMove(targetL,targetWid){
	$(".page4ZoomPic").show().animate({"left":targetL},400,function(){
		$(".zoomPicCon").show().animate({"width":targetWid});
	});
}

/* 根据屏幕分辨率来调用不同的方法-----------start */

/* ----  大于等于1920的宽度  start ------ */
function fixPositionBig(){
	//第一屏
	$(".imgLayer").width(850).height(520);
	$(".imgBox").width(850).height(520);
	$(".imgBox img").width(803).height(468).css({
		"top":parseInt(($(".imgBox").height() - $(".imgBox img").height())/2),
		"left":parseInt(($(".imgBox").width() - $(".imgBox img").width())/2)
	});
	$(".comFontH2").css({"font-size":60});
	$(".comTxtP").css({"padding-top":100});
	$(".centerImgBox").height($(".imgLayer").height()).width(850);
	$(".comTxtP_1").css({"padding-top":123});
	$(".page1BotBox").width(930).height(78);
	//第二屏
	$(".roundabout li").css({
		"width":380,
		"height":519,
		"margin-top":65
	});
	//第三屏
	$(".page3DecImg").width(680).height(660).css({
		"left":($(window).width() - $(".page3DecImg").width())/2
	});
	$(".page3ComImg").width(643).height(430).css({
		"bottom":150
	});
	$(".page3SmallImg_1").width(125).css({
		"left":306,
		"top":55
	});
	$(".page3SmallImg_2").width(125).css({
		"right":-36,
		"top":172
	});
	$(".page3SmallImg_3").width(125).css({
		"left":32,
		"bottom":32
	});
	//第四屏
	$(".comPage4Pic").width(382).height(550).css({
		"left":($(window).width() - $(".comPage4Pic").width())/2 - 40,
		"bottom":60
	});
	$(".page4ZoomPic").width(182).height(200).css({
		"top":136
	});
	$(".zoomPicCon").height(301).css({
		"left":210,
		"top":-58
	});
}


/* ----  大于等于1600的宽度并且小于1920宽度  start ------ */
function fixPositionMid(){
	//第一屏
	$(".imgLayer").width(620).height(379);
	$(".imgBox").width(620).height(379);
	$(".imgBox img").width(590).height(344).css({
		"top":parseInt(($(".imgBox").height() - $(".imgBox img").height())/2),
		"left":parseInt(($(".imgBox").width() - $(".imgBox img").width())/2)
	});
	$(".comFontH2").css({"font-size":50});
	$(".comTxtP").css({"padding-top":90});
	$(".comTxtP_1").css({"padding-top":110});
	$(".centerImgBox").height($(".imgLayer").height()).width(620);
	
	$(".page1BotBox").width(730).height(61);
	$(".page1Bot").width(730).height(61);
	//第三屏
	$(".page3DecImg").width(613).height(590).css({
		"left":($(window).width() - $(".page3DecImg").width())/2
	});
	$(".page3ComImg").width(643).height(430).css({
		"bottom":120
	});
	$(".page3SmallImg_1").width(125).css({
		"left":306,
		"top":55
	});
	$(".page3SmallImg_2").width(125).css({
		"right":-36,
		"top":172
	});
	$(".page3SmallImg_3").width(125).css({
		"left":32,
		"bottom":32
	});
	//第四屏
	$(".comPage4Pic").width(330).height(475).css({
		"left":($(window).width() - $(".comPage4Pic").width())/2 - 40,
		"bottom":40
	});
	$(".page4ZoomPic").width(130).height(143).css({
		"top":136
	});
	$(".zoomPicCon").height(250).css({
		"left":190,
		"top":-10
	});
}

/* ----  大于等于1366的宽度并且小于1600宽度  start ------ */
function fixPositionNote(){
	//第一屏
	$(".imgLayer").width(470).height(287);
	$(".imgBox").width(470).height(287);
	$(".imgBox img").width(440).height(256).css({
		"top":parseInt(($(".imgBox").height() - $(".imgBox img").height())/2),
		"left":parseInt(($(".imgBox").width() - $(".imgBox img").width())/2)
	});
	$(".comFontH2").css({"font-size":40});
	$(".comTxtP").css({"padding-top":75});
	$(".comTxtP_1").css({"padding-top":95});
	$(".centerImgBox").height($(".imgLayer").height()).width(470);
	$(".page1BotBox").width(530).height(44);
	$(".page1Bot").width(530).height(44);
	//第二屏
	$(".roundabout").css({
		"margin-top":-30
	});
	//第三屏
	$(".page3DecImg").width(426).height(410).css({
		"left":($(window).width() - $(".page3DecImg").width())/2
	});
	$(".page3ComImg").width(415).height(278).css({
		"bottom":100
	});
	$(".page3SmallImg_1").width(78).css({
		"left":198,
		"top":30
	});
	$(".page3SmallImg_2").width(78).css({
		"right":-22,
		"top":110
	});
	$(".page3SmallImg_3").width(78).css({
		"left":21,
		"bottom":20
	});
	//第四屏
	$(".comPage4Pic").width(243).height(350).css({
		"left":($(window).width() - $(".comPage4Pic").width())/2 - 30,
		"bottom":50
	});
	$(".page4ZoomPic").width(110).height(121).css({
		"top":80
	});
	$(".zoomPicCon").height(188).css({
		"left":145,
		"top":-30
	});
}

/* ----  大于等于1000的宽度并且小于1366宽度  start ------ */
function fixPositionSmall(){
	//第一屏
	$(".imgLayer").width(470).height(287);
	$(".imgBox").width(470).height(287);
	$(".imgBox img").width(440).height(256).css({
		"top":($(".imgBox").height() - $(".imgBox img").height())/2,
		"left":parseInt(($(".imgBox").width() - $(".imgBox img").width())/2)
	});
	$(".comFontH2").css({"font-size":40});
	$(".comTxtP").css({"padding-top":75});
	$(".comTxtP_1").css({"padding-top":95});
	$(".centerImgBox").height($(".imgLayer").height()).width(470);
	$(".page1BotBox").width(530).height(44);
	$(".page1Bot").width(530).height(44);
	//第二屏
	$(".roundabout").css({
		"margin-top":-30
	});
	//第三屏
	$(".page3DecImg").width(426).height(410).css({
		"left":($(window).width() - $(".page3DecImg").width())/2
	});
	$(".page3ComImg").width(415).height(278).css({
		"bottom":100
	});
	$(".page3SmallImg_3").width(78).css({
		"left":21,
		"bottom":20
	});
	$(".page3SmallImg_1").width(78).css({
		"left":198,
		"top":30
	});
	$(".page3SmallImg_2").width(78).css({
		"right":-22,
		"top":110
	});
	$(".page3SmallImg_3").width(78).css({
		"left":21,
		"bottom":20
	});
	//第四屏
	$(".comPage4Pic").width(243).height(350).css({
		"left":($(window).width() - $(".comPage4Pic").width())/2 - 30,
		"bottom":50
	});
	$(".page4ZoomPic").width(110).height(121).css({
		"top":80
	});
	$(".zoomPicCon").height(188).css({
		"left":145,
		"top":-30
	});
}

/* 根据屏幕分辨率来调用不同的方法-----------end */