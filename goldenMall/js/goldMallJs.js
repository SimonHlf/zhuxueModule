function moveTopBottom(top){
	var oMaryLayer = getId("moveBor");
	var aNavList = $(".navList_1 li");
	var timer = null;
	var timer2 = null;
	var iSpeed = 0;
	for(var i=0;i<aNavList.length;i++){
		aNavList[i].index = i;
		aNavList[i].onmouseover = function(){
			clearTimeout(timer2);
			goMove(this.offsetTop,oMaryLayer);
		};
		aNavList[i].onmouseout = function(){
			timer2 = setTimeout(function(){
				goMove(top,oMaryLayer);
			},30);
		};
		
	}
	function goMove(iTarget,obj){
		clearInterval(timer);
		timer = setInterval(function(){
			
			iSpeed += (iTarget - obj.offsetTop)/5;
			iSpeed *= 0.6;
				
			if( Math.abs(iSpeed)<=1 && Math.abs(iTarget - obj.offsetTop)<=1 ){
					clearInterval(timer);
					obj.style.top = iTarget + 'px';
					iSpeed = 0;
			}else{
				obj.style.top = obj.offsetTop + iSpeed + 'px';
			}
			
		},30);
	}
	
}
//关闭兑换窗口
function closeExcWin(){
	$(".exchangeWin").hide();
	$(".layer").hide();
}

//局部更新积分商品
function listIntegralProduct(productType,credits,pageNo,pageSize){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"shopManager.do?action=listIntegralProduct&productType="+productType+"&credits="+credits+"&pageNo="+pageNo+"&pageSize="+pageSize,
		success:function(json){
			$("#ip").empty();
			$.each(json,function(i){
				var img = "<li><a class='imgBox' href='shopManager.do?action=proDetail&id="+json[i].id+"'><img src='Module/goldenMall/images/pro.jpg'/></a>";
				var ipName="<a class='proName' href='javascript:void(0)'>"+json[i].productName+"</a>";
				var credits="<p class='needGold'>"+json[i].credits+"金币</p>";
				var stocks = "<p class='leaveNum'>剩余："+json[i].stocks+"个</p>";
				var btn = "";
				if(json[i].stocks!=0){
					btn = "<a class='buyBtn' href='shopManager.do?action=goldenMallPay&ipId="+json[i].id+"'><span>立即</span><br/>兑换</a>";
				}else{
					btn = "<a class='soldOutBtn' href='javascript:void(0)'><span>已经</span><br/>售罄</a>";
				}
				$("#ip").append(img+ipName+credits+stocks+btn);
			});
			getIPCount(productType,credits,pageNo);
		}
	});
}

var pageNo = 1;
var pageCount = 0;
function getIPCount(productType,credits,pageNo){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"shopManager.do?action=getIPCount&productType="+productType+"&credits="+credits,
		success:function(json){
			pageCount = parseInt((json+11)/12);
			document.getElementById("ipCount").value = json;
			document.getElementById("pageNo").value = pageNo;
			document.getElementById("pageCount").value = pageCount;
		}
	});
}

//首页
function first(){
	pageNo = 1;
	showIP(5,0,pageNo);
}
//上一页
function previous(){
	if(pageNo!=1){
		 pageNo--;
		 showIP(5,0,pageNo);
	 }else{
		 alert("已经是第一页了！");
	 }
}
//下一页
function next(){
	if(pageNo!=pageCount){
		 pageNo++;
		 showIP(5,0,pageNo);
	 }else{
		 alert("已经是最后一页了！");
	 }
}
//尾页
function last(){
	pageNo = pageCount;
	showIP(5,0,pageNo);
}

//根据条件删选积分商品
function showIP(productType,credits,pageNo){
	var li1 = $(".catag1 li");
	for(var i=0;i<li1.length;i++){
		if(productType!=5){
			if(li1[i].id==productType){
				productType = li1[i].value;
				break;
			}
		}else{
			if(li1[i].className=="active"){
				productType = li1[i].value;
				break;
			}
		}
	}
	var li2 = $(".catag2 li");
	for(var j=0;j<li2.length;j++){
		if(credits!=0){
			if(li2[j].id==credits){
				credits = li2[j].innerText;
				break;
			}
		}else{
			if(li2[j].className=="active"){
				credits = li2[j].innerText;
				break;
			}
		}
	}
	listIntegralProduct(productType,credits,pageNo,12);
}

//保存用户的收货地址
function saveAddress(){
	var usaId = document.getElementById("usaId").value;
	var buyerName = document.getElementById("buyer_Name").value;
	var province = document.getElementById("province").value;
	var city = document.getElementById("city").value;
	var detailAddress = document.getElementById("detailAddress").value;
	var zip = document.getElementById("emailNum").value;
	var mobile = document.getElementById("telPhone").value;
	if(zip=="请填写您所在地的邮编号码"){
		zip = "";
	}
	if(buyerName=="长度不超过16个字符"||!(/^[\u4E00-\u9FA5]+$/).test(buyerName)){
		alert("请正确填写收货人中文姓名！");
		document.getElementById("buyer_Name").value = "";
	}else if(detailAddress=="建议您如实填写详细收货地址，例如街道名称、门牌号码"){
		alert("请填写您的详细收货地址！");
		document.getElementById("detailAddress").value = "";
	}else if(mobile=="请填写有效的手机号码"||!(/^1[3|4|5|7|8][0-9]\d{4,8}$/).test(mobile)){
		alert("请填写有效的手机号码，确保畅通，以便商家或送货人联系！");
		document.getElementById("telPhone").value = "";
	}else if(usaId==""){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"shopManager.do?action=checkUSA",
			success:function(json){
				if(json){
					saveAddr(usaId,buyerName,province,city,detailAddress,zip,mobile);
				}else{
					alert("收货地址最多可以添加三条!");
				}
			}
		});
	}else{
		saveAddr(usaId,buyerName,province,city,detailAddress,zip,mobile);
	}
}
//保存收货地址
function saveAddr(usaId,buyerName,province,city,detailAddress,zip,mobile){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"shopManager.do?action=saveUserShipAddress&usaId="+usaId+"&buyerName="+buyerName+"&province="+province+"&city="+city
		            +"&detailAddress="+detailAddress+"&zip="+zip+"&mobile="+mobile,
		success:function(json){
			if(json){
				alert("收货地址保存成功！");
				window.location.reload(true);
			}else{
				alert("收货地址保存失败，请重新填写！");
			}
		}
	});
}
//删除指定地址
function delAddress(id){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"shopManager.do?action=delUSAByID&UsaID="+id,
		success:function(json){
			if(json){
				alert("删除收货地址成功！");
				window.location.reload(true);
			}else{
				alert("删除收货地址失败，请重试！");
			}
		}
	});
}
//获得选择的收货地址
function check_radio(){
	   var usaId;
	   var chkObjs = document.getElementsByName("addRadio");
	   for(var i=0;i<chkObjs.length;i++){
	       if(chkObjs[i].checked){
	    	   usaId = chkObjs[i].value;
	       }
	   }
	   return usaId;
	}

//兑换
function exchangeIP(ipId,ipName,credits,coin){
	var addrName = $("#addrName").val();
	alert(addrName);
	if(credits>coin){
		alert("您拥有的积分不足以兑换该商品，请下次再来或兑换其他商品！");
		//listIntegralProduct(0,"全部",1,12);
		window.location.href = "shopManager.do?action=welcome";
	}else{
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"shopManager.do?action=exchangeIP&ipId="+ipId+"&ipName="+ipName+"&addrName="+addrName+"&credits="+credits,
			success:function(json){
				if(json){
					alert("您已成功兑换该商品，请注意查收！");
					//跳转到订单详情页面
					window.location.href = "shopManager.do?action=orderDetail";
				}else{
					alert("兑换商品过程中出现错误，请联系客服！");
				}
			}
		});
	}
}