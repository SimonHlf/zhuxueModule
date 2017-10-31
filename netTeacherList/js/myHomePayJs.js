/*--------------  网络导师绑定支付start  ------------------*/

var oParent = window.parent;
var scrollTop = oParent.document.documentElement.scrollTop || oParent.document.body.scrollTop;
var oParWinHeight = oParent.document.documentElement.clientHeight;
//绑定支付窗口
function showPayWindow(ntsId,subId,ntId,ntName,subName,baseMoney){
	var oParent = window.parent;
	var scrollTop = oParent.document.documentElement.scrollTop || oParent.document.body.scrollTop;
	var oParWinHeight = oParent.document.documentElement.clientHeight;
	oParent.getId("ntsId").value=ntsId;
	oParent.getId("neteaId").value=ntId;
	oParent.getId("subId").value=subId;
	oParent.getId("ntName").value=ntName;
	oParent.getId("subName").value=subName;
	oParent.getId("baseMoney").value=baseMoney;
	oParent.$(".showPayDiv").show().css({"top":(oParWinHeight - oParent.$(".showPayDiv").height())/2 + scrollTop});
	oParent.$(".payLayer").show();	
}

//绑定确认按钮
function bindConfirm(ntsId,subId,ntId,ntName,subName,baseMoney){
	if(confirm("确认绑定此导师?")){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"netTeacherStudent.do?action=checkDuration&subId="+subId+"&netTName="+encodeURIComponent(ntName),
			success:function(json){
					if(json==3||json==0){
						alert("您已申请绑定其他导师，不能同时申请绑定多个导师！");
						window.location.reload(true);
					}else if(json==1){
						alert("您的申请已到期！请重新申请绑定！");
						window.location.reload(true);
					}else{
						showPayWindow(ntsId,subId,ntId,ntName,subName,baseMoney);
					}
			}
		});
	}
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
								alert("您已成功取消该导师的绑定，请绑定您选定的其他导师！");
								window.location.reload(true);
							}
						}
					});
				}
			}
		}
	});
}

//弹窗显示汇款账号
function showAccount(endDate,remainDays,ntsId,ntId,ntName,subName,baseMoney,bindFlag){
	var oParent = window.parent;
	var scrollTop = oParent.document.documentElement.scrollTop || oParent.document.body.scrollTop;
	var oParWinHeight = oParent.document.documentElement.clientHeight;
	oParent.getId("dueDate").value=endDate.substring(0,10);
	oParent.getId("remainDays").value=remainDays;
	oParent.getId("ntsId").value=ntsId;
	oParent.getId("neteaId").value=ntId;
	oParent.getId("ntName").value=ntName;
	oParent.getId("subName").value=subName;
	oParent.getId("baseMoney").value=baseMoney;
	oParent.getId("bindFlag").value=bindFlag;
	oParent.$(".showPayDiv").show().css({"top":parseInt((oParWinHeight - oParent.$(".showPayDiv").height())/2 + scrollTop)});
	oParent.$(".payLayer").show();
	oParent.getId("sureInfo").style.color = "#94c22e";
	oParent.$("#payTab1 em").show();
	oParent.getId("pay1").style.display="none";
	oParent.getId("pay2").style.display="block";
	oParent.getId("movebox").innerHTML = 2;
	oParent.getId("movebox").style.left = oParent.getId("payTab2").offsetLeft+5 + 'px';
	oParent.getId("smallLine").style.width = "180px";
	oParent.getId("account").style.display="block";
	fnTabNav(oParent.$('.payWayTab'),oParent.$('.payContent'),'click');
	
	oParent.choiceOptionAns();
	//oParent.showBankInfo();
	
	if(bindFlag!=1){
		oParent.getId("account").style.display="block";
	}
}
/*--------------  网络导师绑定支付end  ------------------*/