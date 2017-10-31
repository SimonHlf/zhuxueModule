/*--------------  网络导师绑定支付start  ------------------*/

//绑定支付窗口
function showPayWindow(ntsId,subId,ntId,ntName,subName,baseMoney){
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	var cliHeight = document.documentElement.clientHeight;
	getId("ntsId").value=ntsId;
	getId("neteaId").value=ntId;
	getId("subId").value=subId;
	getId("ntName").value=ntName;
	getId("subName").value=subName;
	getId("baseMoney").value=baseMoney;
	$("#showPayDiv").show().css({"top":(cliHeight - $("#showPayDiv").height())/2 + scrollTop});
	$(".payLayer").show();	
}

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

//支付第二步确认按钮
//function pay(){
//	var payType = check_radio();
//	//var subID=$("#alisubID").val();
//	var ntsId = document.getElementById("ntsId").value;
//	var bindFlag = document.getElementById("bindFlag").value;
//	if(bindFlag==""){
//		alert("请先确认您要绑定导师的详细信息！");
//		pay2.style.display="none";
//		pay1.style.display="block";
//	}else{
//		if(payType=="快捷支付"){
//			
//			//增加订单
//			var ntId = document.getElementById("neteaId").value;
//			var baseMoney = document.getElementById("baseMoney").value;
//			$.ajax({
//				type:"post",
//				async:false,
//				dataType:"json",
//				url:"ordersManager.do?action=addOrders&ntId="+ntId+"&baseMoney="+baseMoney+"&payType="+encodeURIComponent(payType),
//				success:function(json){
//					if(json){
//						if(json==true){
//							alert("您的订单信息已更改，请及时付款！");
//						}else{
//							alert("您的绑定订单已提交，请及时付款！");
//						}
//						//跳转到支付宝页面，获取返回值，if(true)；如果false，再次跳转
//						//修改订单支付状态
//						var orderId = json;
//						$.ajax({
//							type:"post",
//							async:false,
//							dataType:"json",
//							url:"ordersManager.do?action=updateStatus&orderId="+orderId+"&ntId="+ntId,
//							success:function(json){
//								if(json){
//									alert("订单支付成功！");
//									$.ajax({
//										type:"post",
//										async:false,
//										dataType:"json",
//										url:"netTeacherStudent.do?action=updateBindFlag&ntsId="+ntsId,
//										success:function(json){
//											if(json){
//												alert("网络老师绑定成功！现在您可以与该导师互动了！");
//												getId("choiceStyle").style.color = "#94c22e";
//												pay2.style.display="none";
//												$("#payTab2 em").show();
//												pay3.style.display="block";
//												getId("movebox").innerHTML = 3;
//												startMove(getId("movebox"),{left:getId("payTab3").offsetLeft+5},function(){
//													getId("movebox").style.display = "none";
//													getId("succ").style.color = "#94c22e";
//													$("#payTab3 em").show();
//													
//												});
//												startMove(getId("smallLine"),{width:360});	
//											}
//										}
//									});
//								}
//							}
//						});
//						
//					}
//				}
//			});
//			
//		}else{
//			var val=$('.com_BankRdio[name="bankRadio"]:checked').val();
//			if(val == null){
//				alert("请选择一张银行卡");
//				
//			}else{
//				alert("请及时汇款！汇款成功1-2个工作日内，绑定服务将开通！届时您将可以与该导师互动！如果申请绑定成功5个工作日后尚未汇款，您将需要重新申请！");
//				window.location.reload(true);	
//			}
//		}
//	}	
//}
//绑定确认按钮
function bindConfirm(ntsId,subId,ntId,ntName,subName,baseMoney,flag){
	if(flag){//true点击申请绑定按钮
		if(confirm("确认绑定此导师?")){
			applyBind(ntsId,subId,ntId,ntName,subName,baseMoney);
		}else{
			window.location.reload(true);
		}
	}else{//false点击试用按钮直接申请
		applyBind(ntsId,subId,ntId,ntName,subName,baseMoney);
	}
}
//申请绑定
function applyBind(ntsId,subId,ntId,ntName,subName,baseMoney){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=checkDuration&subId="+subId+"&netTName="+encodeURIComponent(ntName),
		success:function(json){
				if(json==3||json==0){
					alert("您已申请绑定其他导师，不能同时申请绑定多个导师！");
					window.location.reload(true);
				}else if(json==1&&json!=true){
					alert("您的申请已到期！请重新申请绑定！");
					window.location.reload(true);
				}else{
					showPayWindow(ntsId,subId,ntId,ntName,subName,baseMoney);
				}
		}
	});
}
//取消导师绑定
function cancelBind(subId,ntsId){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=limitCancel&subId="+subId,
		success:function(json){
			if(json){
				alert("您在本月已转换过一次该科目的网络导师，不能再次取消所绑定导师！");
			}else{
				if(confirm("确定取消该导师？")){
					$.ajax({
						type:"post",
						async:false,
						dataType:"json",
						url:"netTeacherStudent.do?action=updateBindFlag&ntsId="+ntsId,
						success:function(json){
							if(json){
								alert("您已成功取消该导师的绑定，请绑定您选定的其他导师！在未来30天内您将不能重新绑定该导师");
								window.location.reload(true);
							}
						}
					});
				}
			}
		}
	});
}

//再次绑定
function secondBind(ntsId,subId,ntName){
	if(confirm("确定重新绑定该导师？")){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"netTeacherStudent.do?action=checkDuration&subId="+subId+"&netTName="+encodeURIComponent(ntName),
			success:function(json){
				if(json==0||json==3){//申请未到期或者绑定未到期
					alert("您已申请或绑定其他导师，不能重新绑定此导师！");
				}else{
					$.ajax({
						type:"post",
						async:false,
						dataType:"json",
						url:"netTeacherStudent.do?action=secondBind&ntsId="+ntsId,
						success:function(json){
							if(json==true){
								alert("您对该导师重新绑定成功，可以与导师互动了！");	
								window.location.reload(true);
							}else if(json==-1){
								alert("您的付款已到期，请重新申请绑定！");
								window.location.reload(true);
							}else{
								alert("再次绑定失败，请重试！");
							}
						}
					});
				}
			}
		});
	}	
}

//未付款时直接跳转支付第二步
function showPayAccount(ntsId,ntId,ntName,subName,baseMoney,bindFlag){
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	var cliHeight = document.documentElement.clientHeight;
	getId("ntsId").value=ntsId;
	getId("neteaId").value=ntId;
	getId("ntName").value=ntName;
	getId("subName").value=subName;
	getId("baseMoney").value=baseMoney;
	getId("bindFlag").value=bindFlag;
	$("#showPayDiv").show().css({"top":(cliHeight - $("#showPayDiv").height())/2 + scrollTop});;
	$(".payLayer").show();
	getId("sureInfo").style.color = "#94c22e";
	$("#payTab1 em").show();
	pay1.style.display="none";
	pay2.style.display="block";
	getId("movebox").innerHTML = 2;
	getId("movebox").style.left = getId("payTab2").offsetLeft+5 + 'px';
	getId("smallLine").style.width = "180px";
	account.style.display="block";
	fnTabNav($('.payWayTab'),$('.payContent'),'click');
	
	choiceOptionAns();
	//showBankInfo();
	
	if(bindFlag!=1){
		account.style.display="block";
	}else{}
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
//支付方式
/*function selectPay(){
	var payType = document.getElementsByName("payType");
	if(payType[0].checked){
		getId("pay").value = "去支付";
	}else{
		getId("pay").value = "去支付";
	}
}*/
//选择支付方式时input的raido的点击
function choiceOptionAns(){
	$(".inpRadio").each(function(){
		$(this).click(function(){
			$(this).parent("li").append("<span class='triangle'></span>").siblings().find('span').remove();
		});
	});
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
	$(objIcon).addClass("tipIcon");
}
//点击银行卡图标raido显示当前银行卡的持卡人和银行卡号
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

//银行卡号、持卡人、银行名字的盒子的隐藏
function closeBankInfoWin(){
	$(".showBankInfoBox").slideUp();
}

function closeWindow(){
	$("#showPayDiv").hide();
	window.location.reload(true);
}

/*--------------  网络导师绑定支付end  ------------------*/