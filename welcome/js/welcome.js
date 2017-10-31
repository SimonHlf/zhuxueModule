// JavaScript Document
var iNow = 0;
//遮罩层显示/隐藏
function showLayer(option){
	if(option == "show"){
		$(".judgeNetTea").show();
		$('#layer').show();
		tabKeyCode();
	}else{
		$(".judgeNetTea").hide();
		$('#layer').hide();
	}
}
//设置个人信息窗口的显示和隐藏
function setPerInfo(){
	var oSet=getId('set');
	var oPersonInfo=getId('personInfo');
	var timer=null;
	oPersonInfo.onmouseover=oSet.onmouseover=function(){
		clearTimeout(timer);
		oPersonInfo.style.display="block";
	};
	oPersonInfo.onmouseout=oSet.onmouseout=function(){
		timer=setTimeout(function(){
			oPersonInfo.style.display="none";
		},500);
	};
}


//显示必填项（nickName和teachMoney）
//没填写时返回true,已填写返回false
function showSelectMustInput(roleName,realName){
	if(roleName == "网络导师"){
		if(checkMustInput()){
			prevPageNone();
    		showLayer("show");
    		getId("reallyName").value = realName;
		}
	}
}

//初始化加载上一页隐藏的函数
function prevPageNone(){
	var oPrevPage=getId("prevPage");
	if(iNow==0){
		oPrevPage.style.display="none";
	}
}
//下一页
function showNextPage(){
	var oViewCon=getId("viewCon");
	var oNextPage=getId("nextPage");
	var oPrevPage=getId("prevPage");
	var oEndButton=getId("endButton");
	var oUl=oViewCon.getElementsByTagName("ul")[0];
	var aLi=oUl.getElementsByTagName("li");
	oUl.style.width=aLi[0].offsetWidth*aLi.length+'px';
	var nickNameObj = getId("netName");
	var nickName = nickNameObj.value;
	tabKeyCode();
	if(nickName == ""){
		alert("请输入网络姓名!");
		getId("netName").focus();
	}else{
		if(checkChinese(nickNameObj,"网络名字必须为中文!")){
			iNow++;
			oPrevPage.style.display="block";
			startMove(oUl,{left:-iNow*aLi[0].offsetWidth});
		}
	}
	if(iNow==aLi.length-1){
		oNextPage.style.display="none";
		oEndButton.style.display="block";		
	}
}
//上一页
function showPrevPage(){
	var oViewCon=getId("viewCon");
	var oNextPage=getId("nextPage");
	var oPrevPage=getId("prevPage");
	var oEndButton=getId("endButton");
	var oUl=oViewCon.getElementsByTagName("ul")[0];
	var aLi=oUl.getElementsByTagName("li");
	tabKeyCode();
	
	iNow--;
	if(iNow==aLi.length-2){
		oNextPage.style.display="block";
		oEndButton.style.display="none";
		oPrevPage.style.display="none";
	}
	startMove(oUl,{left:-iNow*aLi[0].offsetWidth});
}
//结束网络导师收费文本框的设置窗口
function endSet(){
	//先判辅导价格
	var teachMoneyObj = getId("teachMoney");
	var teachMoney = teachMoneyObj.value;
	if(teachMoney == ""){
		alert("请输入导师价格");
		teachMoneyObj.focus();
		flag = false;
	}else{
		if(checkNumber(teachMoneyObj,"请输入正确的价格!")){
			//修改网络名称
			updateNickName();
			//修改指导价
			updateTeacherMoney();
			showLayer("hide");
		}
	}
}
//修改网络名称
function updateNickName(){
	var nickName = getId("netName").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"userManager.do?action=updateUserNickName&nickName="+encodeURIComponent(nickName),
        success:function (json){
        	
        }
    });
}
//修改网络导师指导价
function updateTeacherMoney(){
	var teachMoney = getId("teachMoney").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"userManager.do?action=updateNetTeacherServiceMoney&teachMoney="+teachMoney,
        success:function (json){
        	
        }
    });
}
//检查数据库中网络导师的用户名是否存在
function checkMustInput(){
	var flag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"userManager.do?action=checkMustInput",
        success:function (json){
        	flag = json;
        }
    });
	return flag;
}

/* 用户反馈窗口 */

function showFeedbackWindow(){
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	var cliWidth = document.documentElement.clientHeight;
	$("#feedbackBox").show().css({"top":(cliWidth - $("#feedbackBox").height())/2 + scrollTop});
	$("#feedbackBox").animate({left:"50%"},400);
	$("#layer").show();
}
function closeFeedox(){
	$("#feedbackBox").animate({left:"-50%"},300,function(){
		$("#feedbackBox").hide();
		$("#layer").hide();
		$(".feedType").find("em").remove();
		$(".input_Tit").val("");
		$("#textareaBoxs").val("请详细描述您的反馈信息，我们将据以改善现状，更好地为您服务...");
	});
}

//提交反馈
function feedback(){
	var backType = document.getElementById("typeVal").value;
	var title = getId("fbTitle").value;
	var content = document.getElementById("textareaBoxs").value;
	//choiceTypeVal();
	if(title==""){
		alert("请输入反馈标题！");
	}else if(content=="" || content=="请详细描述您的反馈信息，我们将据以改善现状，更好地为您服务..."){
		alert("请填写反馈内容，您的反馈将是我们改善服务质量的重要依据！");
	}else if(backType==""){
		alert("请选择您要反馈问题的类型！");
	}else{
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"feedback.do?action=addFeedback&backType="+encodeURIComponent(backType)+"&title="+encodeURIComponent(title)+"&content="+encodeURIComponent(content),
		    success:function(json){
		    	if(json>0){
		    		alert("您的反馈信息已提交成功，谢谢您的建议！我们将努力为您提供更优质的服务！");
		    		setTimeout(function(){
		    			closeFeedox();
		    		},100);	
		    	}else{
		    		alert("您的反馈信息提交失败，请重新提交！");
		    	}
		    }
		});
	}
}

//选择反馈问题的类型
function choiceTypeVal(){
	$(".selBtn").each(function(i){
		$(this).click(function(){
			$("#typeVal").val($(this).val());
			$(this).parent("div").append("<em></em>").siblings().find("em").remove();
		});
	});
}
//字数限制
function LimitTextArea(obj){
	var maxlimit = 500;
	var oNowNum = getId("nowNum");
	var oMaxNum = getId("maxNum");
	if(obj.value.length>maxlimit){
		obj.value = objs.value.substring(0,maxlimit);
	}else{
		oMaxNum.innerHTML = maxlimit - obj.value.length;
		oNowNum.innerHTML = obj.value.length;
	}
}
function onlineBuy(){
	window.location.href = "onlineBuy.do?action=load";
}
//1024*768下的充值入口
function checkScreen(){
	var oWidth = $(window).width();
	if(oWidth > 1000 && oWidth <=1024){
		$(".chargeCardEnBtn").removeClass("classBtn1");
		$(".chargeCardEnBtn").addClass("classBtn2");
	}else{
		$(".chargeCardEnBtn").addClass("classBtn1");
	}
}
