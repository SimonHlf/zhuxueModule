// JavaScript Document

//
function showAskWin(gradeName,subId,subName,teacherId){
	var oParent = window.parent;
	var oParWinHeight = oParent.document.documentElement.clientHeight;
	var scrollTop = oParent.document.documentElement.scrollTop || oParent.document.body.scrollTop;
	var oLayer=$('<div class="layer"></div>');
	oParent.$('body').append(oLayer);
	oLayer.show();
	oLayer.animate({opacity:0.5},300,function(){
		oParent.$('.myAskBox').show().css({"top":parseInt((oParWinHeight - oParent.$('.myAskBox').height())/2) + scrollTop});
		oParent.$('.gradeNum').html(gradeName);
		oParent.$('.scheNum').html(subName);
		oParent.document.getElementById("subId").value=subId;
		oParent.document.getElementById("ntId").value=teacherId;
	});
}
//
function closeLearnWin(){
	var oLayer=$('.layer');
	oLayer.animate({opacity:0},200,function(){
		$('.myAskBox').hide();
		oLayer.remove();
	});
	
}
function goLearning(educationId){
	//var mainWin = window.parent.document.getElementById("studyOnline").contentWindow;
	window.location.href = "studyOnline.do?action=showChapter&educationId="+educationId;
}

function smallLiMove(){
	var oTabNav1 = getId("tabNav1");
	var oMoveLi = getId("moveLi");
	var aSmallLi = getByClass(oTabNav1,"smallNavList");
	var timer = null;
	var timer2 = null;
	var iSpeed = 0;
	var oldOffsetLeft = 0;

	for(var i = 0;i<aSmallLi.length;i++){
		aSmallLi[i].index = i;
		aSmallLi[i].onmouseover = function(){
			clearTimeout(timer2);
			goMove(this.offsetLeft);

		};
		aSmallLi[i].onclick = function(){
			oldOffsetLeft = aSmallLi[this.index].offsetLeft;
		};
		aSmallLi[i].onmouseout = function(){
			timer2 = setTimeout(function(){
				goMove(oldOffsetLeft);
			},100);
		};
	}
	function goMove(iTarget){
		clearInterval(timer);
		timer = setInterval(function(){
			
			iSpeed += (iTarget - oMoveLi.offsetLeft)/6;
			iSpeed *= 0.7;
			
			if( Math.abs(iSpeed)<=1 && Math.abs(iTarget - oMoveLi.offsetLeft)<=1 ){
				clearInterval(timer);
				oMoveLi.style.left = iTarget + 'px';
				iSpeed = 0;
			}
			else{
				oMoveLi.style.left = oMoveLi.offsetLeft + iSpeed + 'px';
			}
			
		},30);
	}
}

//提交问题
function submitQuestion(){
	var question = editor.getPlainTxt();
	var subId = document.getElementById("subId").value;
	var ntId = document.getElementById("ntId").value;
	var qTitle = document.getElementById("tiwen").value;
	//var headUrl = document.getElementById("headUrl").value;
	//var moduleId = document.getElementById("moduleId").value;
	if(qTitle==""){
		alert("请填写提问标题");
	}else if(question.length==1){
		alert("请编辑问题内容！");
	}else{
	  $.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"questionManager.do?action=addQuestion&question="+encodeURIComponent(question)+"&subId="+subId+"&ntId="+ntId
				+"&qTitle="+encodeURIComponent(qTitle),
		success:function(json){
			if(json){
				alert("您的问题已成功提交，请等待老师答复！");
				//window.location.href = headUrl + moduleId;
				window.location.reload(true);
			}else{
				alert("问题提交失败，请重试！");
			}
		}
	});
  }
}

//在线答题头部导航公共方法
function checkSubLiLen(){
	var aBooKLiLen = $(".tabNav1 li").length;
	if(aBooKLiLen ==1){
		$(".bookDec1").show();
		$(".bookDec2").show().css({"right":160});
	}else if(aBooKLiLen ==2){
		$(".bookDec1").show();
		$(".bookDec2").show().css({"right":138});
	}else if(aBooKLiLen == 3){
		$(".bookDec1").show();
	}else{
		if(aBooKLiLen ==4 || aBooKLiLen == 5){
			$(".comBtns").hide();
		}else{
			$(".comBtns").show();
			bookBtnClick();	
		}
	}
}
function bookBtnClick(){
	var iNow = 0;
	var oPervBtns = getId("prevBtns");
	var oNextBtns = getId("nextBtns");
	var oUl = getId("tabNav1");
	var aBookLi = oUl.getElementsByTagName("li");
	oUl.style.width = aBookLi[0].offsetWidth * aBookLi.length + "px";
	oPervBtns.onclick = function(){
		if(iNow > 0){
			iNow --;
			startMove(oUl,{"left":-iNow*aBookLi[0].offsetWidth});
		}
	}
	oNextBtns.onclick = function(){
		if(iNow < aBookLi.length - 5){
			iNow ++;
			startMove(oUl,{"left":-iNow*aBookLi[0].offsetWidth});
		}
	}
}