var onOff = true;
//申请提现窗口
	 function showApplyWithdrawWindow(availableMoney){
		 $("#applyWithdrawWindow").show();
		 $(".layer").show();
		 $("#availableMoney").val($(".expedCrash").text());
	 }
	 function closeWindow(){
		 $("#applyWithdrawWindow").hide();
		 $(".layer").hide();
	 }
	 function applyWithdraw(){
		 var txMoney = document.getElementById("txMoney").value;
		 //判断可提现金额
		 var availableMoney = document.getElementById("availableMoney").value;
		 if(txMoney==""){
			 alert("请输入提现金额！");
		 }else if(txMoney>availableMoney){
			 alert("提取金额不能超过可提现金额，请重新输入！");
			 document.getElementById("txMoney").value="";
		 }else if(txMoney<100||txMoney>10000){
			 alert("单次提现金额最低100元，最高10000元，请重新输入！");
			 document.getElementById("txMoney").value="";
		 }else{
			 $.ajax({
				 type:"post",
				 async:false,
				 dataType:"json",
				 url:"bankAccountManager.do?action=applyWithdraw&txMoney="+txMoney,
				 success:function(json){
					 if(json){
						 alert("您已成功申请提现，请及时所查收申请账款！");
						 window.location.reload(true);
					 }
				 }
			 });
		 } 
	 }
	 //保存银行账号
	 function saveMyAccount(){
		 var bankName = document.getElementById("bankName").value;
		 var bankNo = document.getElementById("bankNo").value;
		 var reg = /^\d{19}$/g;   // 以19位数字开头，以19位数字结尾
		 if(bankName==""){
			 alert("请输入银行名称！");
		 }else if(bankNo==""){
			 alert("请输入银行账号！");
		 }else if(!reg.test(bankNo) ){
			 alert("银行卡号格式错误，应该是19位数字！");
			 getId("bankNo").focus();
		 }else{
			 $.ajax({
				 type:"post",
				 async:false,
				 dataType:"json",
				 url:"bankAccountManager.do?action=saveAccount&bankName="+bankName+"&bankNo="+bankNo,
				 success:function(json){
					 if(json){
						 alert("您的银行账户信息保存成功！");
					 }
				 }
			 });
		 }
	 }
	 
	 //提现信息(分页)
	 function txRecord(pageNo,pageSize){
		 var pagination = "";
		 $.ajax({
			 type:"post",
			 dataType:"json",
			 url:"bankAccountManager.do?action=listNTTR&pagenNo="+pageNo+"&pageSize="+pageSize,
					 success:function(json){
					     $("#txTable tr:not(:first)").remove();
					     $("#page").empty();
						 $.each(json,function(i){
							 var txMoney = "<tr class='conTr'><td class='wid3 bolds' align='center'>"+json[i].txMoney+"</td>";
							 var txDate = "<td class='wid4' align='center'>"+(new Date(json[i].txDate)).toLocaleString()+"</td>";
							 var txStatus = "";
							 if(json[i].txStatus==0){
								 txStatus = "<td class='wid3' align='center'>未支付</td>";
							 }else{
								 txStatus = "<td class='wid3' align='center'>已支付</td>";
							 }
							 var operateDate = json[i].txOperateDate;
							 if(operateDate==null){
								 operateDate = "<td class='wid3' align='center'>&nbsp;</td>";
							 }else{
								 operateDate = "<td class='wid4' align='center'>"+(new Date(json[i].txOperateDate)).toLocaleString()+"</td>";
							 }
							 var others = "<td class='wid3' align='center'>提现</td></tr>";
							 $("#txTable").append(txMoney+txDate+txStatus+operateDate+others);
						 });
						 getNttrCount();
						 pagination = "第<input id='currentPage' style='width:12px;border:0px;text-align:center' readonly>页&nbsp;"
						 +"<a href='javascript:void(0)' onclick=first()>首页</a>&nbsp;<a href='javascript:void(0)' onclick=previous()>上一页</a>&nbsp;"
	                        +" <a href='javascript:void(0)' onclick=next()>下一页</a>&nbsp;<a href='javascript:void(0)s' onclick=last()>尾页</a>&nbsp;"
	                                      +"共<input id='totalPage' style='width:12px;border:0px;text-align:center' readonly>页";
	                     $("#page").append(pagination);
	                     //tableSort1($("#txTable"),1);
	                     $("#txTable .conTr:odd").addClass("oddColor");
					 }
		 }); 
	 }
	 var pageNo = 1;
	 var pageCount = 0;
	 function getNttrCount(){
		 $.ajax({
			 type:"post",
			 dataType:"json",
			 url:"bankAccountManager.do?action=getNttrCount",
			 success:function(json){
				 var nttrCount = json;
				 pageCount = parseInt((nttrCount+9)/10); 
				 if(pageCount==0){
					 $(".noTixianRecord").show();
					 $("#page").hide();
					 pageCount=1;
				 	}
				 document.getElementById("currentPage").value=pageNo;
				 document.getElementById("totalPage").value = pageCount;
			 }
		 });
	 }
 function first(){
	 pageNo = 1;
	 txRecord(pageNo,10);
 }
 function previous(){
	 if(pageNo!=pageCount){
		 pageNo--;
		 txRecord(pageNo,10);
	 }else{
		 alert("已经是第一页了！");
	 }
 }
 function next(){
	 if(pageNo!=pageCount){
		 pageNo++;
		 txRecord(pageNo,10);
	 }else{
		 alert("已经是最后一页了！");
	 }
 }
 function last(){
	 pageNo=pageCount;
	 txRecord(pageNo,10);
 }
 
 //学生购买记录
 function paidNTSRecord(pageNo,pageSize){
	 $.ajax({
		 type:"post",
		 async:false,
		 dataType:"json",
		 url:"bankAccountManager.do?action=listPaidNTS&pageNo="+pageNo+"&pageSize="+pageSize,
		 success:function(json){
			 $("#ntsTable tr:not(:first)").remove();
			 $("#page1").empty();
			 $.each(json,function(i){
				 var stuName = "<tr class='conTr'><td class='wid5' align='center'>"+json[i].user.realname+"</td>";
				 var addDate = "<td class='wid4' align='center'>"+json[i].addDate+"</td>";
				 var price = "<td class='wid5' align='center'>"+json[i].teacher.baseMoney+"</td>";
				 var endDate = "<td class='wid4' align='center'>"+json[i].endDate+"</td></tr>";
				 $("#ntsTable").append(stuName+addDate+price+endDate);
			 });
			 getPaidNTSCount();
			 var pagination = "第<input id='currentPage1' style='width:12px;border:0px;text-align:center' readonly>页&nbsp;"
				 +"<a href='javascript:void(0)' onclick=first1()>首页</a>&nbsp;<a href='javascript:void(0)' onclick=previous1()>上一页</a>&nbsp;"
                 +" <a href='javascript:void(0)' onclick=next1()>下一页</a>&nbsp;<a href='javascript:void(0)' onclick=last1()>尾页</a>&nbsp;"
                               +"共<input id='totalPage1' style='width:12px;border:0px;text-align:center' readonly>页";
              $("#page1").append(pagination);
              tableSort($("#ntsTable"),1);
              $("#ntsTable .conTr:odd").addClass("oddColor");
		 }
	 });
 }
 var pageNo1 = 1;
 var pageCount1 = 0;
 function getPaidNTSCount(){
	 $.ajax({
		 type:"post",
		 dataType:"json",
		 url:"bankAccountManager.do?action=getPaidNTSCount",
		 success:function(json){
			 var ntsCount = json;
			 pageCount1 = parseInt((ntsCount+9)/10);
			 if(pageCount1==0){
				 pageCount1 = 1;
				 $(".noBuyRecord").show();
				 $("#page1").hide();
			 }
			 document.getElementById("currentPage1").value=pageNo1;
			 document.getElementById("totalPage1").value=pageCount1;
		 }
	 });
 }
 function first1(){
	 pageNo1 = 1;
	 paidNTSRecord(pageNo1,10);
 }
 function previous1(){
	 if(pageNo1!=pageCount1){
		 pageNo1--;
		 paidNTSRecord(pageNo1,10);
	 }else{
		 alert("已经是第一页了！");
	 }
 }
 function next1(){
	 if(pageNo1!=pageCount1){
		 pageNo1++;
		 paidNTSRecord(pageNo1,10);
	 }else{
		 alert("已经是最后一页了！");
	 }
 }
 function last1(){
	 pageNo1=pageCount1;
	 paidNTSRecord(pageNo1,10);
 }
 
 //收支明细分页
 var direct = 0;
 var pageSize = 10;
 var currentPage = 1;
 var tpageCount=0;
 function displayPage(currentPage){
	 var count = $("#totalTable tr").length-1;
	 tpageCount = count%pageSize==0?count/pageSize:Math.floor(count/pageSize)+1;
	 if(tpageCount == 0){
		$(".noShouzhi").show();
		$("#tPage").hide();
		tpageCount = 1;
	 }
	 document.getElementById("total").value=tpageCount;
	 if(currentPage<=1&&direct==-1){
		 alert("已经是第一页了！");
		 currentPage = 1;
		 direct = 0;
		 return;
	 }else if(currentPage>=tpageCount&&direct==1){
		 alert("已经是最后一页了！");
		 currentPage = tpageCount;
		 direct = 0;
		 return;
	 }
	 if(count>pageSize){
		 currentPage = (currentPage+direct+count)%count;
	 }else{
		 currentPage = 1;
	 }
	 document.getElementById("current").value=currentPage;
	 
	 var begin = (currentPage-1)*pageSize+1;
	 var end = begin+pageSize-1;
	 if(end>count){
		 end = count;
	 }
	 $("#totalTable tr").hide();
	 $("#totalTable tr").each(function(i){
		 if(i>=begin&&i<=end||i==0){
			 $(this).show();
		 }
	 });
	// tableSort($("#totalTable"),3);
 }
 function tFirst(){
	 currentPage = 1;
	 direct = 0;
	 displayPage(currentPage);
 }
 function tPrevious(){
	 direct = -1;
	 currentPage = document.getElementById("current").value;
	 displayPage(currentPage--);
 }
 function tNext(){
	 direct = 1;
	 currentPage = document.getElementById("current").value;
	 displayPage(currentPage++);
 }
 function tLast(){
	 direct = 0;
	 currentPage = tpageCount;
	 displayPage(currentPage);
 }
 
//初始化检测银行名称是否为空
function checkBankNameVal(){
	if($("#bankName").val()==""){
		$(".selBankTxt").show();
	}else{
		$(".selBankTxt").hide();
	}
}
//选择银行
function choiceBank(){
	$(".com_BankRdio").each(function(i){
		$(this).click(function(){
			$("#bankName").val($(this).val());
			$(".bankBox").hide();
			$(".selBankTxt").hide();
			$("#bankNo").val("");
			$(".selTriangles").removeClass("topTri").addClass("botTri");
			onOff = true;
		});
	});
}
//点击显示选择银行的盒子
function showBankBox(){
	if(onOff){
		$(".selTriangles").removeClass("botTri").addClass("topTri");
		$(".bankBox").show();
		choiceBank();
		onOff = false;
	}else{
		$(".selTriangles").removeClass("topTri").addClass("botTri");
		$(".bankBox").hide();
		onOff = true;
	}
}
//关闭选择银行的盒子
function closeBankWin(){
	$(".selTriangles").removeClass("topTri").addClass("botTri");
	$(".bankBox").hide();
	onOff = true;
	
}
//银行账号的格式化
function bankNumPattern(){
	var oBankNum = getId("bankNo");
	var oPattBankNum = getId("pattbBankNum");
	oBankNum.onkeydown=function(e){
		if(!isNaN(this.value.replace(/[ ]/g,""))){         
			setTimeout(function(){
				oPattBankNum.value =oBankNum.value.replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");//四位数字一组，以空格分割     
			},30);
			
		}else{         
			if(e.keyCode==8){//当输入非法字符时，禁止除退格键以外的按键输入
				return true;         
			}else{
				return false;        
			}
		}
	};
	oBankNum.onfocus = function(){
		oPattBankNum.style.display="block";
		oPattBankNum.value =oBankNum.value.replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");//四位数字一组，以空格分割     
	};
	oBankNum.onblur = function(){
		oPattBankNum.style.display="none";
	};
}
//银行卡号当输入是字母时给删除了
function clearWord(){
	var oBankNum = getId("bankNo");
	var oPattBankNum = getId("pattbBankNum");
	oBankNum.value=oPattBankNum.value.replace(/\D/g,'');
	oPattBankNum.value = oPattBankNum.value.replace(/\D/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");
}