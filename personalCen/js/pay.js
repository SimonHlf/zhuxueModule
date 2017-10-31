//支付第二步确认按钮
function pay(){
	var payType = check_radio();
	var ntsId = getId("ntsId").value;
	var ntId = getId("neteaId").value;
	var bindFlag = getId("bindFlag").value;
	if(bindFlag==""){
		alert("请先确认您要绑定导师的详细信息！");
		getId("pay2").style.display="none";
		getId("pay1").style.display="block";
	}else{
			//增加订单
			var ntId = getId("neteaId").value;
			var baseMoney = getId("baseMoney").value;
			$.ajax({
				type:"post",
				async:false,
				dataType:"json",
				url:"ordersManager.do?action=addOrders&ntId="+ntId+"&baseMoney="+baseMoney+"&payType="+encodeURIComponent(payType),
				success:function(json){
						alert("您的订单信息已更改或者订单已提交，请及时付款！");
						//跳转到支付宝页面，获取返回值，if(true)；如果false，再次跳转
						//修改订单支付状态
					   // var orderId = json;
						var input = $("#payType").find("input:radio");
				        input.attr("disabled","disabled");
						$("#pay").remove();
						$("#account").after(" <input type='button' class='payCon' value='支付完成'  onclick='closeWindow()'>");
						if(payType=="快捷支付"){
						window.open("alipayAction.do?action=goAliPay&ntsId="+ntsId+"&OrderNumber="+json);
						}else{
							window.open("chinapayAction.do?action=goChinaPay&ntsId="+ntsId+"&OrderNumber="+json);
						}
				}
			});
	}	
}