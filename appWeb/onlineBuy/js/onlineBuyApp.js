//学习卡列表
function listvip(){
	$.ajax({
		type:"post",
		async:true,
		dataType:"json",
		url:"OnlineBuyApp.do?action=listVip&cilentInfo=app",
		beforeSend:function(){
	    	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		},
		success:function(json){
			$.each(json, function(row, obj) {	
				$("#price"+row).text(obj.price);
			});
		},
		complete:function(){
	    	$("#loadDataDiv").hide();
	    	$(".loadingIcon").remove();
	    }
	});
}
//跳转到去购买
function goBuy(id){
	if(checkLoginStatus()){
		/*$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"OnlineBuyApp.do?action=addVipCardOrders&vid="+id+"&cilentInfo=app",
			success:function(json){*/
				window.location.href = "OnlineBuyApp.do?action=detailPayApp&vid="+id+"&cilentInfo=app";
		/*	}
		});*/
	}
}
//获取自己购买半/全年卡费用的计算公式
function getSelfFeeInfo(buyDays){
	var feeResult = "";
	if(checkLoginStatus()){
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        data:{buyDays:buyDays},
	        url:"OnlineBuyApp.do?action=getSelfFee&cilentInfo=app",
	        success:function (json){
	        	feeResult = json + "";
	        }
	    });
	}
	return feeResult;
}
//购买详情页头
function detailPay(vid){
	$.ajax({
		type:"post",
		async:true,
		dataType:"json",
		data:{vid:vid},
		url:"OnlineBuyApp.do?action=detailPay&cilentInfo=app",
		beforeSend:function(){
	    	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		},
		success:function(json){
			$.each(json.vipcardinfos, function(row, obj) {	
				if(obj.activeDays==365){
					$("#vipPic").attr("src",obj.cardImg);
				}
				$("#viName").text(obj.vipName);
				$("#viPrice").text(obj.price);
				$("#payable").text(obj.price);
			});	
		},
		complete:function(){
	    	$("#loadDataDiv").hide();
	    	$(".loadingIcon").remove();
	    }
	});
}
//获取优惠劵的面值
function input_onkeyup() {
		var coupId = 0;
		var oldPrice = $("#viPrice").text();
		var coupAcc=$("#vipAcc").val();
		var pass=$("#vipPass").val();
		var checkStatus = $("#myonoffswitch1").prop("checked");
		if(pass.length==20){
			$.ajax({
				type:"post",
				async:false,
				dataType:"json",
				url:"couponsManager.do?action=listCoupByAP&account="+coupAcc+"&password="+pass+"&cilentInfo=app",
				success:function(json){
					if(json!=""){
						 $.each(json, function(index,obj) {
							var curr=new Date().getTime();
							var vdate=obj.validDate;
							var fVale= obj.faceValue;
							if(checkStatus && $("#uYp").text() != "0"){//使用圆培币
								//判断输入的元培币不能大于应付价格
								if($("#viPrice").text() - $("#uYp").val() - fVale>= 0){
									
									if(vdate>=curr){
										$("#payable").text($("#viPrice").text() - $("#uYp").val() - fVale);
										$("#yVip").text(fVale);
										//$("#tipMsg").text("");
										coupId = obj.id;
									}else{
										$(".succImg").hide();
										$(".tipImg").show();
										$("#warnPTxt").html("您的优惠券已过期");
										commonTipInfoFn($(".warnInfoDiv"));
										$("#yVip").text("0");
										$("#payable").text(oldPrice);
										coupId = 0;
									}
								}else{
									$("#yVip").text(fVale);
									$(".succImg").hide();
									$(".tipImg").show();
									$("#warnPTxt").html("优惠券和圆培币总价格大于实付价格");
									commonTipInfoFn($(".warnInfoDiv"));
								}
							}else{//没有使用圆培币
								if(vdate>=curr){
									$("#payable").text(oldPrice - fVale);
									$("#yVip").text(fVale);
									//$("#tipMsg").text("");
									coupId = obj.id;
								}else{
									//$("#tipMsg").text("您的优惠券已过期!");
									$(".succImg").hide();
									$(".tipImg").show();
									$("#warnPTxt").html("您的优惠券已过期");
									commonTipInfoFn($(".warnInfoDiv"));
									$("#yVip").text("0");
									$("#payable").text(oldPrice);
									coupId = 0;
								}
							}
					  });
					}else{
						$(".succImg").hide();
						$(".tipImg").show();
						$("#warnPTxt").html("您的优惠劵无效");
						commonTipInfoFn($(".warnInfoDiv"));
						$("#payable").text(oldPrice);
						$("#yVip").text("0");
						coupId = 0;
					}
				}
			});
		}else{
			$("#yVip").text("0");
		}
	return coupId;
}
//获取个人当前元培币数
function getSelfCoin(ypc){
	var number;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"OnlineBuyApp.do?action=getSelfCoin&options="+ypc+"&cilentInfo=app",
		success:function(json){
			$("#yCoin").text(json);
			number = json;
		}
	});
	return number;
}
//判断输入的数是否为正整数
function checkNumber(obj){   
     var re = /^[1-9]+[0-9]*]*$/;
     if (!re.test(obj.value)){   
        obj.focus();
        return false;
    }else{
		return true;
	}   
} 

//输入元培币后的动作
function getFinalPrice(obj){
	var coinYpNumber = $(obj).val();
	var coni=getSelfCoin("coinYp");
	var checkStatus = $("#myonoffswitch0").prop("checked");
	var finalPrice = 0;
	if(checkStatus && $("#yVip").text() != "0"){//使用优惠劵
		if(checkNumber(obj)){//判断必须为大于0的数字
			if(coinYpNumber > getSelfCoin("coinYp")){//判断输入的元培币数量必须小于等于自己拥有的数目
				$(obj).val("");
				finalPrice = 0;
				//$("#msgSpan").html("输入元培币数目有误!");
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("输入圆培币数目有误");
				commonTipInfoFn($(".warnInfoDiv"));
				$("#payable").text($("#viPrice").text() - $("#yVip").text());
			}else{
				//判断输入的元培币不能大于应付价格
				if($("#viPrice").text() - $("#yVip").text() - coinYpNumber >= 0){
					$("#payable").text($("#viPrice").text() - $("#yVip").text() - coinYpNumber);
					finalPrice = coinYpNumber;
				}else{
					finalPrice = 0;
					$(".succImg").hide();
					$(".tipImg").show();
					$("#warnPTxt").html("输入圆培币数目有误");
					commonTipInfoFn($(".warnInfoDiv"));
					$("#payable").text($("#viPrice").text() - $("#yVip").text());
				}
			}
		}else{
			finalPrice = 0;
			$("#payable").text($("#viPrice").text() - $("#yVip").text());
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("输入圆培币数必须为大于0的整数");
			commonTipInfoFn($(".warnInfoDiv"));
		}
	}else{//无优惠劵
		if(checkNumber(obj)){
			if(coinYpNumber > getSelfCoin("coinYp")){
				$(obj).val("");
				finalPrice = 0;
				$(".succImg").hide();
				$(".tipImg").show();
				$("#warnPTxt").html("输入圆培币数目有误");
				commonTipInfoFn($(".warnInfoDiv"));
				$("#payable").text($("#viPrice").text());
			}else{
				//判断输入的元培币不能大于应付价格
				if($("#viPrice").text() - coinYpNumber >= 0){
					//$("#msgSpan").html("");
					finalPrice = coinYpNumber;
					$("#payable").text($("#viPrice").text() - coinYpNumber);
				}else{
					finalPrice = 0;
					$(obj).val("");
					$(".succImg").hide();
					$(".tipImg").show();
					$("#warnPTxt").html("输入圆培币数目有误");
					commonTipInfoFn($(".warnInfoDiv"));
					$("#payable").text($("#viPrice").text());
				}
			}
		}else{
			finalPrice = 0;
			$(obj).val("");
			$(".succImg").hide();
			$(".tipImg").show();
			$("#warnPTxt").html("输入圆培币数必须为大于0的整数");
			commonTipInfoFn($(".warnInfoDiv"));
			$("#payable").text($("#viPrice").text());
		}
	}
	return finalPrice;
}