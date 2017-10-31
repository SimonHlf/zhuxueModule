/* 用户反馈窗口 */

function showKonowMore(){
	//var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	//var cliWidth = document.documentElement.clientHeight;
	var oKnowMoreWin = window.parent.$(".knowMoreWin");
	oKnowMoreWin.show();//.css({"top":(cliWidth - $("#feedbackBox").height())/2 + scrollTop});
	oKnowMoreWin.animate({top:"50%"},400);
	window.parent.$(".layer").show();
}
function closeKonWin(){
	$(".knowMoreWin").animate({top:"-50%"},300,function(){
		$(".knowMoreWin").hide();
		$(".layer").hide();
	});
}
//价格疑问帮助文档

//获取优惠劵的面值
function inp4_onkeyup() {
	if(getId("password_4").value.length==5){
		var coupAcc=$("#coupAcc").val();
		var p1=$("#password_1").val();
		var p2=$("#password_2").val();
		var p3=$("#password_3").val();
		var p4=$("#password_4").val();
		var pass=p1+p2+p3+p4;
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"couponsManager.do?action=listCoupByAP&account="+coupAcc+"&password="+pass,
			success:function(json){
				if(json!=""){
					 $.each(json, function(index,obj) {
							$("#coupID").attr("value",obj.id);
							var curr=new Date().getTime();
							var vdate=obj.validDate;
							if(vdate>=curr){
								$("#faceVal").text(obj.faceValue);
								$("#tipMsg").text("");
							}else{
								$("#tipMsg").text("您的优惠券已过期!");
								$("#faceVal").text("0");
							}
						 });	
				}else{
					$("#tipMsg").text("您的优惠劵无效!");
					$("#faceVal").text("0");
				}
			}
		});
		
	}
}
//在线购买支付
function vipPay(){
var className = document.getElementById("checkBtn").className;
	
	var coupID = $("#coupID").val();
	var odNumer = $("#odNumer").val();
	var vid=$("#vid").val();
	var coupAcc=$("#coupAcc").val();
	var p1=$("#password_1").val();
	var p2=$("#password_2").val();
	var p3=$("#password_3").val();
	var p4=$("#password_4").val();
    var pass=p1+p2+p3+p4;
	if(coupAcc!=''&&p1!=''&&p2!=''&&p3!=''&&p4!=''&&className=='active'){
		window.open("alipayAction.do?action=vipPay&odNumer="+odNumer+"&coupAcc="+coupAcc+"&coupID="+coupID+"&pass="+pass+"&vid="+vid);
	}else{
		window.open("alipayAction.do?action=vipPay&odNumer="+odNumer+"&coupAcc="+''+"&coupID="+''+"&pass="+''+"&vid="+vid);
	}
}
//银联电子支付
function vipChinaPay(){
	var className = document.getElementById("checkBtn").className;
	
	var coupID = $("#coupID").val();
	var odNumer = $("#odNumer").val();
	var vid=$("#vid").val();
	var coupAcc=$("#coupAcc").val();
	var p1=$("#password_1").val();
	var p2=$("#password_2").val();
	var p3=$("#password_3").val();
	var p4=$("#password_4").val();
    var pass=p1+p2+p3+p4;
	if(coupAcc!=''&&p1!=''&&p2!=''&&p3!=''&&p4!=''&&className=='active'){
		window.open("chinapayAction.do?action=vipChinaPay&odNumer="+odNumer+"&coupAcc="+coupAcc+"&coupID="+coupID+"&pass="+pass+"&vid="+vid);
	}else{
		window.open("chinapayAction.do?action=vipChinaPay&odNumer="+odNumer+"&coupAcc="+''+"&coupID="+''+"&pass="+''+"&vid="+vid);
	}
	
	
}