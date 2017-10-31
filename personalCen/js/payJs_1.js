//绑定确定支付第一步按钮
function bindNetTeacher(){
	var ntId = document.getElementById("neteaId").value;
	var ntsId = document.getElementById("ntsId").value;
	var subId = document.getElementById("subId").value;
	//判断是否为转换导师
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=checkNTSBySubject&subId="+subId,
		success:function(json){
			if(json==true){//转换
				$.ajax({
					type:"post",
					async:false,
					dataType:"json",
					url:"netTeacherStudent.do?action=updateBindFlag&ntsId="+ntsId,
					success:function(json){
						if(json){
							alert("导师转换成功！");
							pay1.style.display="none";
							pay3.style.display="block";
							getId("movebox").innerHTML = 3;
							startMove(getId("movebox"),{left:getId("payTab3").offsetLeft+5},function(){
								getId("movebox").style.display = "none";
								getId("succ").style.color = "#94c22e";
								$("#payTab3 em").show();
							});
							startMove(getId("smallLine"),{width:360});
						}
					}
				});
			}else{//第一次绑定
				$.ajax({
					type:"post",
					async:false,
					dataType:"json",
					url:"netTeacherStudent.do?action=updateBindFlag&ntsId="+ntsId,
						success:function(json){
							if(json){
								alert("申请绑定该网络导师成功，请尽快支付费用！");
								getId("sureInfo").style.color = "#94c22e";
								$("#payTab1 em").show();
								pay1.style.display="none";
								pay2.style.display="block";
								getId("movebox").innerHTML = 2;
								startMove(getId("movebox"),{left:getId("payTab2").offsetLeft+5});
								startMove(getId("smallLine"),{width:180});
								fnTabNav($('.payWayTab'),$('.payContent'),'click');
								choiceOptionAns();
								//showBankInfo();
								document.getElementById("bindFlag").value=0;
							}else{
								alert("网络老师绑定失败，请重试！");
							}
						}
				});
			}
		}
	});
}



//支付方式
/*function selectPay(){
	var payType = document.getElementsByName("payType");
	if(payType[0].checked){
		getId("pay").value = "去支付";
	}else{
		getId("pay").value = "去支付";
	}
}*/
//显示指定银行信息
function showBank(bankName){
	var cardName = getId("cardName_"+bankName).value;
	var bankName = getId("bankName_"+bankName).value;
	var bankNumber = $("input[name='bankRadio']:checked").val();
	$(".showBankInfoBox").slideDown();
	$(".bankNum").html('<span>卡<span class="blank"></span>号：</span>' + '<span class="numStyle">' + bankNumber + '</span>');
	$(".cardsName").html('<span>持卡人：</span>' + '<span class="numStyle">' + cardName + '</span>');
	$(".nowBankName").html(bankName);
	//增加订单
	var ntId = getId("neteaId").value;
	var baseMoney = getId("baseMoney").value;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"ordersManager.do?action=addOrders&ntId="+ntId+"&bankName="+encodeURIComponent(bankName)+"&baseMoney="+baseMoney,
		success:function(json){
			if(json>=1&&json!=true){
				alert("您的绑定订单已成功提交，请在24小时内付款！否则，系统将删除该订单！");
			}else if(json==true){
				alert("您选择的付款银行已更改，请在24小时内付款！否则，系统将删除该订单！");
			}
		}
	});
	
}


//获得选择的支付方式
function check_radio(){
	   var payType = "";
	   var chkObjs = document.getElementsByName("payType");
	   for(var i=0;i<chkObjs.length;i++){
	       if(chkObjs[i].checked){
	    	   payType = chkObjs[i].value;
	       }
	   }
	   return payType;
}

//选择支付方式时input的raido的点击
function choiceOptionAns(){
	$(".inpRadio").each(function(){
		$(this).click(function(){
			$(this).parent("li").append("<span class='triangle'></span>").siblings().find('span').remove();
		});
	});
}


//银行卡号、持卡人、银行名字的盒子的隐藏
function closeBankInfoWin(){
	$(".showBankInfoBox").slideUp();
}


//温馨提示窗口的显示
function showTipInfo(obj,objIcon){
	$(obj).slideDown(200);
	$(objIcon).removeClass("tipIcon");
	$(objIcon).addClass("tipIcon1");
	
}
//温馨提示窗口的隐藏
function closeTip(obj,objIcon){
	$(obj).slideUp(200);
	$(objIcon).removeClass("tipIcon1");
	$(objIcon).addClass("tipIconPay");
}

function closeWindow(){
	$("#showPayDiv").hide();
	window.location.reload(true);
}
