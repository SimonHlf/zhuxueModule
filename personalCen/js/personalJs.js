// JavaScript Document
var oLayer=window.parent.$(".layer");

//无帖子时
$(function() {
	var ts = $("#listTable").find("*").length;
	if (ts == 0) {
		$("#bbsturnPage").remove();
		$(".noListTopicBox").show();
	}
});
// 回帖子
function addResp(topicID){
	var Content = editor.getPlainTxt();
	if(Content.length==1){
		alert("帖子内容不能为空");
		return;
	}else{
		$.ajax( {
			type : "post",
			async : false,
			dataType : "json",
			url : 'bbsManager.do?action=addResp&topicID='+topicID+'&content='+encodeURIComponent(Content),
			success : function(json) {
				if (json) {
					alert('信息添加成功!');
					window.location.href="bbsManager.do?action=bbsList&topicID="+topicID;
				} else {
					alert('信息添加失败，请重试!');
				}
			}
		});
	}
}
//发帖子
function addTopic(){
	var topicName =$("#topicName").val();
	var tContent = editor.getPlainTxt();
	if(topicName==null||topicName==""){
		alert("帖子主题不能为空!");
		return ;
	}
	if(tContent.length==1){
		alert("帖子内容不能为空");
		return;
	}else{
		$.ajax( {
			type : "post",
			async : false,
			dataType : "json",
			url : 'bbsManager.do?action=addTopic&topicName='+encodeURIComponent(topicName)+'&tContent='+encodeURIComponent(tContent),
			success : function(json) {
				if (json) {
					alert('信息添加成功!');
					window.location.href='personalCenter.do?action=welcome&moduleId=17';
				} else {
					alert('信息添加失败，请重试!');
				}
			}
		});
	}
}
//修改个人资料
function fixPerInfo(){
	$(".tabNav2 li").removeClass('active');
	$(".tabNav2 li a .triangles").hide();
	var mainWin = getId("personalModu").contentWindow;
	mainWin.location.href = 'userManager.do?action=showUserInfo';	
}

//选项卡导航内的问题替换当前位置内部的文字
function replaceText1(){
	$('.nowInfo').html('资料设置');
}
function replaceText2(){
	$('.nowInfo').html('头像设置');
}
function replaceText3(){
	$('.nowInfo').html('安全设置');
}
function replaceText4(){
	$('.nowInfo').html('密码管理');
}
function replaceText5(){
	$('.nowInfo').html('绑定家长');
}
//密码管理中新密码的强弱
function checkPasStrongWeak(){
	//给密码输入框 注册键放开事件
	$("#newPass").keyup(function(){
		var pwdValue = $(this).val();
		var num = pwdChange(pwdValue);
		if($(this).val()!=''){
			if(num==0 || num==2){
				$(".gray1").attr('id','red');
			}
			if(num==2){
				$(".gray1").attr('id','orange');
				$(".gray2").attr('id','orange');
			}else{
				$(".gray2").attr('id','');
			}
			if(num==3){
				$(".gray1").attr('id','green');
				$(".gray2").attr('id','green');
				$(".gray3").attr('id','green');
			}else{
				$(".gray3").attr('id','');
			}	
		}else{
				$(".gray1").attr('id','');
				$(".gray2").attr('id','');
				$(".gray3").attr('id','');
		}
	});
}

//---------src之间的切换 start

//学习建议
function showAdvicePage(){
	var mainWin = getId("personalModu").contentWindow;
	mainWin.location.href = 'learnAdvice.html';
}
function showMyAskPage(){
	var mainWin = getId("personalModu").contentWindow;
	mainWin.location.href = 'questionManager.do?action=questionMain';
}



//---------src之间的切换 end


//我的提问答疑层的显示
function showQuestion(id){
	var queId = id;
	var oLayer1=$('<div class="layer1"></div>');
	var scrollTop = window.top.document.documentElement.scrollTop || window.top.document.body.scrollTop;
	var oIframeAskQueList = window.top.getId("iframeAskQueList");
	var oIframeAskWrap = window.top.getId("iframeWrap");
	window.top.$('body').append(oLayer1);
	window.top.$("html").addClass('cancelScroll');
	window.top.$(".askBackTop").hide();
	oLayer1.show();
	oIframeAskQueList.contentWindow.location.href="questionManager.do?action=queAskDetailList&queId="+id;
	oLayer1.animate({opacity:0.5},300,function(){
		window.top.$('.ifrmaAskWrap').show();
		oIframeAskWrap.style.height = window.top.document.documentElement.clientHeight + 'px';
		oIframeAskWrap.style.top = scrollTop + 'px';
		oIframeAskQueList.height=oIframeAskQueList.contentWindow.document.body.offsetHeight;
		oIframeAskQueList.contentWindow.getId("parentListBox").style.height = oIframeAskWrap.style.height;
	});
}
//我的提问答疑窗口层的关闭
function closeAskWin(){
	var oLayer1 = window.top.$(".layer1");
	oLayer1.animate({opacity:0},200,function(){
		window.top.$('.ifrmaAskWrap').hide();
		oLayer1.remove();
		window.top.$(".askBackTop").show();
		window.top.$("html").removeClass('cancelScroll');
	});
}
//问题列表的隔行换色
function changeColor(obj){
	$(obj+':odd').addClass('colors');
}
//鼠标移上去的颜色
function moveAddColor(){
	var oTab = getId('listTable');
	var oldColor = "";
	
	for(var i=0;i<oTab.tBodies[0].rows.length;i++){
		oTab.tBodies[0].rows[i].onmouseover = function(){
			
			oldColor = this.style.background;
			this.style.background = "#fae49c";
		};
		oTab.tBodies[0].rows[i].onmouseout = function(){
			this.style.background = oldColor;
		};
		
	}
}
//图片等比例的缩放
function checkImg(){
		var oImgArray = $('.mainContents img');
		var img = new Image();
		for(var i = 0 ; i < oImgArray.length ; i++){
			var img_url=oImgArray.eq(i).attr("src");
			img.src = img_url;
			var oImgWidth=img.width;
			var oImgHeight=img.height;
			var newWidth = 0;
			var newHeight = 0;
			var rate = 0.6;
			if(oImgWidth>=550){
				newWidth = parseInt(rate*parseInt(oImgWidth));
				newHeight = parseInt(rate*parseInt(oImgHeight));
				while(newWidth >= 550){
					newWidth = parseInt(newWidth*rate);	
					newHeight = parseInt(newHeight*rate);
				}
			}else{
				newWidth = parseInt(oImgWidth);
				newHeight = parseInt(oImgHeight);
			}
			$('.mainContents img').eq(i).width(newWidth);		
			$('.mainContents img').eq(i).height(newHeight);
			oImgArray.eq(i).click(function(){showOldPic(this);});
		}
}

//查看原图
function showOldPic(obj){
	var parent = window.parent;
	var parCliWidth = parent.document.documentElement.clientWidth;
	var parCliHeight = parent.document.documentElement.clientHeight;
	var scrollTop = parent.document.documentElement.scrollTop || parent.document.body.scrollTop;
	var startIndex = obj.src.indexOf("Module");
	var imgSrc = obj.src.substring(startIndex,obj.src.length);
	showNoneBox(".orginalImgBox");
	parent.$("#img_old").attr("src",imgSrc);
	parent.$("#img_old").attr("alt",obj.width);
	parent.$("#img_old").width(obj.width);
	parent.$("#img_old").height(obj.height);
	
	//动态计算当前图片父级盒子所处的left值和top值，并且让这个盒子居中
	parent.getId("img_oldBox").style.top = parseInt(((parCliHeight - obj.height)/2))-40 + scrollTop+'px';
	parent.getId("img_oldBox").style.left = parseInt(((parCliWidth - obj.width)/2))+'px';
	//执行拖拽
	dragoBjBox(window.parent.getId("img_oldBox"));
}

//关闭查看原图的盒子
function closeImgOldBox(){
	var oImgOld = window.parent.document.getElementById("img_old");
	$(".layer").animate({opacity:0},200,function(){
		$(".orginalImgBox").hide();
		$(".layer").hide();
		
	});
}

//我要提问  我要发帖的弹窗显示和关闭的公共函数
function showNoneBox(obj){
	var oParent = window.parent;
	var oParWinHeight = oParent.document.documentElement.clientHeight;
	var scrollTop = oParent.document.documentElement.scrollTop || oParent.document.body.scrollTop;
	oLayer.show();
	oLayer.animate({opacity:0.5},300,function(){
		oParent.$(obj).show().css({"top":parseInt((oParWinHeight - oParent.$(obj).height())/2) + scrollTop});
	});
}
function closeNoneBox(obj){
	$(".layer").animate({opacity:0},200,function(){
		$(obj).hide();
		$(".layer").hide();
	});
}

//网络导师论坛移上去显示三角装饰图片的层函数
function toBlockTriangle(){
	$(".replayBox").each(function(i){
		$(this).hover(function(){
			$(".rightTopBg").eq(i).hide();
			$(".rightDec").eq(i).show();
		},function(){
			$(".rightTopBg").eq(i).show();
			$(".rightDec").eq(i).hide();
		});
	});
}

//返回顶部
function goBackTop(){
	var oBack=getId('backtop');
	var timer=null;
	var bSys=true;
	window.onscroll=function(){
		var scrollTop=document.documentElement.scrollTop||document.body.scrollTop;
		if(scrollTop>200){
			startMove(oBack,{opacity:100},function(){
				oBack.style.display="block";
			});
		}else{
			startMove(oBack,{opacity:0},function(){
				oBack.style.display="none";
			});
		}
		if(!bSys){
			clearInterval(timer);
		}
		bSys=false;
	};	
}
//头衔信息
function showLevel(){
	 $.ajax({
			type : "post",
			dataType : "json",
			url : "titleManager.do?action=getLevel",
			success : function(date) {
				$.each(date, function(row, obj) {
					$("#LClevel").text(obj.level);
					//$("#nowLClevel").text(obj.level);
					$("#LCbeginScore").text(obj.beginScore);
					$("#LCendScore").text(obj.endScore);
				});
			}
		});
}
//头衔名称信息
function showRank(){
	 $.ajax({
			type : "post",
			dataType : "json",
			url : "titleManager.do?action=getRank",
			success : function(date) {
				$.each(date, function(row, obj) {
					$("#LChonorStyle").text(obj.name);
					$("#headImg").attr("src","Module/loreCharacter/images/"+obj.loreChraracter.portrait);
				});
			}
		});
}

//经验值层
function experienceBox(){
	var nowExp = parseInt($("#LCbeginScore").html());
	var totalExp = parseInt($("#LCendScore").html());
	var perScale = nowExp/totalExp;
	$(".perLayer").animate({width:perScale*100},500);
	if(getId("layerExp").style.width == 0){
		getId("expValueBox").style.left = -25 + 'px';
	}else{
		//getId("expValueBox").style.left = ($(".perLayer").width())/2 + 'px';
		//startMove(getId("expValueBox"),{left:($(".perLayer").width())/2});
	}
	$(".disExp").html(totalExp - nowExp);
}