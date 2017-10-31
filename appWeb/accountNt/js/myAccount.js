/**
 * 拉滚动翻页 （自定义实现此方法）
 * myScroll.refresh();		// 数据加载完成后，调用界面更新方法
 */
function pullUpAction () {
	setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
		getSelfAccount(option_a,"pull");
		myScroll.refresh();		// 数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
	}, 1000);	// <-- Simulate network congestion, remove setTimeout from production!
	
}

/**
 * 初始化iScroll控件
 */
 function loaded() {
		pullUpEl = document.getElementById('pullUp');	
		pullUpOffset = pullUpEl.offsetHeight;
		myScroll = new iScroll(wrapperObj, {
			checkDOMChanges : true,
			onRefresh: function () {
				pullUpEl = document.getElementById('pullUp');
				if (pullUpEl.className.match('loading')) {
					pullUpEl.className = '';
					if(noDataFlag){//没有数据
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '没有更多了...';
					}else{
						pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
					}
				}
			},
			onScrollMove: function () {
				pullUpEl = document.getElementById('pullUp');
				if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
					pullUpEl.className = 'flip';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '释放加载更多...';
					this.maxScrollY = this.maxScrollY;
				} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
					pullUpEl.className = '';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
					this.maxScrollY = pullUpOffset;
				}
			},
			onScrollEnd: function () {
				pullUpEl = document.getElementById('pullUp');
				if (pullUpEl.className.match('flip')) {
					pullUpEl.className = 'loading';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '数据加载中...';				
					pullUpAction();	// Execute custom function (ajax call?)
				}
			}
		});
		
		setTimeout(function () { document.getElementById(wrapperObj).style.left = '0'; }, 800);
	}

	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);

	document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 200); }, false);
	
//获取我的班级
function getSelfAccount(option,dragStatus){
	option_a = option;
	$(".accountType").hide();
	$("#infoDiv_"+option).show();
	$(".accNav li").removeClass("active");
	$("#li_"+option).addClass("active");
	
	var incPullDiv = $("#infoDiv_con_income").siblings();
	var txPullDiv = $("#infoDiv_con_tx").siblings();
	var buyPullDiv = $("#infoDiv_con_buy").siblings();
	if(option == "account"){//我的账户			
		$.ajax({
			  type:"post",
			  async:false,//同步
			  dataType:"json",
			  url:"accountApp.do?action=getMyAccountJson&cilentInfo=app",
			  success:function (json){ 
				  showSelfAccount(json,dragStatus);
			  }
		});
	}else if(option == "income"){//收支明细
		$.ajax({
			  type:"post",
			  async:false,//同步
			  dataType:"json",
			  data:{pageNo:pageNo_1,pageSize:pageSize},
			  url:"accountApp.do?action=getIncomeDetail&cilentInfo=app",
			  success:function (json){ 
				  showSelfAccount(json["result"],dragStatus);
				  wrapperObj = "infoDiv_incWrap";
				  if(incPullDiv.length > 0){
					txPullDiv.remove();//删除第二个pullUp
				  }
				  var str_inc = "<div id='pullUp'><span class='pullup-icon'></span><span class='pullUpLabel'>上拉加载更多...</span></div>";
				  if(incPullDiv.length == 0){
					$("#scroller_inc").append(str_inc);
				  }
				  if($("#infoDiv_con_income li").length == 0){
					$("#pullUp").hide();
				  }
			  }
		});
	}else if(option == "tx"){//提现记录
		$.ajax({
			  type:"post",
			  async:false,//同步
			  dataType:"json",
			  data:{pageNo:pageNo_2,pageSize:pageSize},
			  url:"accountApp.do?action=getTXRecord&cilentInfo=app",
			  success:function (json){ 
				  showSelfAccount(json["result"],dragStatus);
				  wrapperObj = "infoDiv_tx";
				  if(incPullDiv.length > 0 || buyPullDiv.length > 0){
					incPullDiv.remove();//删除第一个pullUp
					buyPullDiv.remove();//删除第三个pullUp
				  }
				  var str_tx = "<div id='pullUp'><span class='pullup-icon'></span><span class='pullUpLabel'>上拉加载更多...</span></div>";
				  if(txPullDiv.length == 0){
					$("#scroller_tx").append(str_tx);
				  }
				  if($("#infoDiv_con_tx li").length == 0){
					$("#pullUp").hide();
				  }
				  if(txFlag && $("#infoDiv_con_tx li").length > 0){
					loaded();
				  }
				  txFlag = false; //只执行一次iscroll
			  }
		});
	}else if(option == "buy"){//购买记录
		wrapperObj = "infoDiv_buy";
		$.ajax({
			  type:"post",
			  async:false,//同步
			  dataType:"json",
			  data:{pageNo:pageNo_3,pageSize:pageSize},
			  url:"accountApp.do?action=getBuyRecord&cilentInfo=app",
			  success:function (json){ 
				  showSelfAccount(json["result"],dragStatus);
				  if(incPullDiv.length > 0 || txPullDiv.length > 0){
					txPullDiv.remove();//删除第二个pullUp
					incPullDiv.remove();//删除第一个pullUp
				   }
				   var str_buy = "<div id='pullUp'><span class='pullup-icon'></span><span class='pullUpLabel'>上拉加载更多...</span></div>";
				   if(buyPullDiv.length == 0){
						$("#scroller_buy").append(str_buy);
					}	
					if($("#infoDiv_con_buy li").length == 0){
						$("#pullUp").hide();
					}
					if(buyFlag && $("#infoDiv_con_buy li").length > 0){
						loaded();
					}
					buyFlag = false;//只执行一次iscroll
			  }
		});
	}
	checkLiLen();
}
//显示我的班级成员列表
function showSelfAccount(list,dragStatus){
	var content = "";
	if(option_a == "account"){
		content += "<div class='basicInfo'><span class='infoSpan'>基本信息</span>";
		content += "<h2>预计总收入:<span>"+list["totalMoney"]+"元</span></h2>";
		content += "<div class='botInfo'><div><span class='line'></span><p>可提现</p><p>"+list["returnMoney"]+"元</p></div>";
		content += "<div><span class='line'></span><p>待到账</p><p>"+list["onPaying"]+"元</p></div>";
		content += "<div><p>已提现</p><p>"+list["txMoney"]+"元</p></div></div></div>";
		
		content += "<div class='backAccInfo'><p class='accTitP'>账户信息</p>";
		content += "<div class='bankNaNum'><p ontouchend='showFixBankName()'><span class='moreIcon'></span><span>银行名称：</span>";
		content += "<input id='bankName' type='hidden' value='"+list["bankName"]+"'/><span id='bankNameSpan'>"+list["bankName"]+"</span></p>";
		content += "<p><span>银行账号：</span>";
		content += "<input id='bankNum' class='removeAFocBg' type='text' value='"+list["bankNum"]+"'/></p></div>";
		content += "<div class='upDateDiv'><a class='updateBtn' href='javascript:void(0)' ontouchend='updateBank();'>保存账号</a></div></div>";
		
		content += "<div class='applyInfo'><a href='javascript:void(0)' ontouchend='applyTX("+list["returnMoney"]+");'>申请提现</a></div>";
		$("#infoDiv_"+option_a).html(content);
		addBankCard();
	}else{
		if(option_a == "income"){//收入明细
			if(cliWid >= 527){
				$("#titleInfo").html("你的辅导价格："+baseMoney+"，您的收益构成：("+baseMoney+"/180天)x辅导天数x学生评分系数</span>");
			}else{
				$("#titleInfo").html("<marquee>你的辅导价格："+baseMoney+"，您的收益构成：("+baseMoney+"/180天)x辅导天数x学生评分系数</marquee>");
			}
		}
		if(list.length > 0){//有记录
			if(option_a == "income"){//收入明细
				pageNo_1++;
				for(var i = 0 ; i < list.length ; i++){
					content += "<li class='listItem'><h3><strong>￥"+list[i].returnMoney+"元</strong><span>/收入</span></h3>";
					content += "<div class='listSon_inc fl'><p>返现</p><p>项目</p></div>";
					content += "<div class='listSon_inc fl'><p>"+getLocalDate(list[i].returnDate)+"</p><p>操作时间</p></div>";
					content += "<div class='listSon_inc fl'><p>"+list[i].user.realname+"</p><p>备注</p></div></li>";
				}
			}else if(option_a == "tx"){//提现记录
				pageNo_2++;
				for(var j = 0 ; j < list.length ; j++){
					content += "<li class='listItem'><h3><strong>￥"+list[j].txMoney+"元</strong><span>/提现金额</span>&nbsp;&nbsp;";
					var txStatus = list[j].txStatus;
					if(txStatus == 0){
						 txStatus = "<span class='noPayState'>未支付</span>";
					 }else{
						 txStatus = "<span class='payState'>已支付</span>";
					 }
					content += "<span>状态："+txStatus+"</span></h3>";
					content += "<div class='listSon_tx fl'><p class='txTimep ellip'>"+getLocalDate(list[j].txDate)+"</p><p>申请时间</p></div>";
					content += "<div class='listSon_tx fl'><p class='txTimep ellip'>"+getLocalDate(list[j].txOperateDate)+"</p><p>处理时间</p></div>";
					content += "<div class='listSon_tx fl'><p>提现</p><p>备注</p></div></li>";
				}
			}else if(option_a == "buy"){//购买记录
				pageNo_3++;
				for(var k = 0 ; k < list.length ; k++){
					content += "<li class='listItem'><h3><strong>"+list[k].user.realname+"</strong></h3>";
					content += "<div class='listSon_buy fl'><p>"+getLocalDate_new(list[k].addDate)+"</p><p>购买时间</p></div>";
					content += "<div class='listSon_buy fl'><p>"+list[k].teacher.baseMoney+"元</p><p>购买价格</p></div>";
					content += "<div class='listSon_buy fl'><p>"+getLocalDate_new(list[k].endDate)+"</p><p>到期时间</p></div></li>";
				}
			}
			if($("#infoDiv_con_"+option_a).html() == ""){//div中无数据
				$("#infoDiv_con_"+option_a).append(content);
			}else{//存在数据
				if(dragStatus == "init"){//点击查询事件
					$("#infoDiv_"+option_a).show();
					if(option_a == "income"){
						pageNo_1--;
					}else if(option_a == "tx"){
						pageNo_2--;
					}else if(option_a == "buy"){
						pageNo_3--;
					}
				}else{//拖动事件
					$("#infoDiv_con_"+option_a).append(content);
				}
			}
		}else{//无记录
			noDataFlag = true;
			
		}
	}
}
//修改银行信息
function updateBank(){
	var bankName = $("#bankName").val();
	var bankNum = $("#bankNum").val();
	var reg = /^\d{19}$/g;   // 以19位数字开头，以19位数字结尾
	if(bankName == ""){
		$(".tipImg").show();
		$(".succImg").hide();
		$("#warnPTxt").html("银行名称不能为空");
		commonTipInfoFn($(".warnInfoDiv"));
	}else if(bankNum == ""){
		$(".tipImg").show();
		$(".succImg").hide();
		$("#warnPTxt").html("银行账号不能为空");
		commonTipInfoFn($(".warnInfoDiv"));
	}else if(!reg.test(bankNum) ){
		 $(".tipImg").show();
		 $(".succImg").hide();
		 $("#warnPTxt").html("银行卡号格式错误<br/>应该是19位数字");
		 commonTipInfoFn($(".warnInfoDiv"));
	}else{
		$.ajax({
			 type:"post",
			 async:false,
			 dataType:"json",
			 data:{bankName:escape(bankName),bankNo:bankNum},
			 url:"accountApp.do?action=updateBankNumber&cilentInfo=app",
			 success:function(json){
				 if(json["result"]){
					$(".succImg").show();
					$(".tipImg").hide();
					$("#warnPTxt").html("保存成功");
					commonTipInfoFn($(".warnInfoDiv"));
				 }else{
					 $(".tipImg").show();
					 $(".succImg").hide();
					 $("#warnPTxt").html("修改失败");
					 commonTipInfoFn($(".warnInfoDiv"));
				 }
			 }
		 });
	}
}
//新注册网路导师提示暂无银行，需要添加银行卡
function addBankCard(){
	if($("#bankName").val() == ""){//添加银行
		$("#bankName").val("添加银行卡");
		$("#bankNameSpan").html($("#bankName").val());
		$(".fixChangeTit").html("新建银行卡");
	}
}
//检查老师是否属于培训学校(是：true)
function checkNTSchool(){
	var flag = false;
	$.ajax({
		 type:"post",
		 async:false,
		 dataType:"json",
		 url:"accountApp.do?action=checkNTSchool&cilengInfo=app",
		 success:function(json){
			 if(json["result"] == "pxxx"){
				 flag = true;
			 }
		 }
	 });
	return flag;
}

//判断输入的数是否为正整数(false:不合格，true:合格)
function checkNumber(inputNum){   
     var re = /^[1-9]+[0-9]*]*$/;
     if (!re.test(inputNum)){   
        return false;
    }else{
		return true;
	}   
}

//申请提现页面
function applyTX(returnMoney){
	if(checkNTSchool()){
		$(".tipImg").show();
		$(".succImg").hide();
		$("#warnPTxt").html("培训学校老师不能进行提现");
		commonTipInfoFn($(".warnInfoDiv"));
	}else{
		$("#applyWindow").css({
			"-webkit-transform":"translateX(0px)",
			"transform":"translateX(0px)"
		});
		$("#applyConDiv").height(cliHei - 30);
		var content = "<div class='topApplyDiv'><div class='applyDec'><img src='Module/appWeb/accountNt/images/applyDec.png' alt='可提现金额'/></div>";
		content += "<p>可提现金额</p>";
		content += "<p id='maxTxMoney' alt='"+returnMoney+"'>￥"+returnMoney+"元</p></div>";
		content += "<div class='botApplyDiv'><p>提现方式：<span>现金转账</span></p>";
		content += "<p>提现金额：<span><input id='txMoney' type='text'placeholder='可转出金额"+ returnMoney +"元'></span></p>";
		content += "<div class='txABtn removeAFocBg' ontouchend='applyTXMoney();'>申请提现</div></div>";
		content += "<div class='botNote'><p class='padClas'><span>注：</span>单次提现金额最低100元,最高10000元,提现金额不能大于可提现金额</p></div>";
		$("#applyConDiv").html(content);
		$(".botApplyDiv").height($("#applyConDiv").height()-$(".topApplyDiv").height()-$(".botNote").height()-21);
		if(cliWid >= 468 ){
			$(".botNote p").removeClass("padClas").addClass("lineClas");
		}else{
			$(".botNote p").removeClass("lineClas").addClass("padClas");
		}
	}
}
//申请提现动作
function applyTXMoney(){
	var maxTxMoney = $("#maxTxMoney").attr("alt");
	var txMoney = $("#txMoney").val();
	var bankNum = $("#bankNum").val();
	if(bankNum == ""){
		$(".tipImg").show();
		 $(".succImg").hide();
		 $("#warnPTxt").html("请添加银行账号");
		 commonTipInfoFn($(".warnInfoDiv"));
	}else{
		if(txMoney==""){
			 $(".tipImg").show();
			 $(".succImg").hide();
			 $("#warnPTxt").html("请输入提现金额");
			 commonTipInfoFn($(".warnInfoDiv"));
		 }else if(!checkNumber(txMoney)){
			 $(".tipImg").show();
			 $(".succImg").hide();
			 $("#warnPTxt").html("请输入有效的提取金额");
			 commonTipInfoFn($(".warnInfoDiv"));
		 }else if(parseInt(txMoney) > parseInt(maxTxMoney)){
			 $(".tipImg").show();
			 $(".succImg").hide();
			 $("#warnPTxt").html("提取金额不能超过可提现金额");
			 commonTipInfoFn($(".warnInfoDiv"));
		 }else if(parseInt(txMoney) < parseInt(100) || parseInt(txMoney) > 10000){
			 $(".tipImg").show();
			 $(".succImg").hide();
			 $("#warnPTxt").html("单次提现最低100元,最高10000元");
			 commonTipInfoFn($(".warnInfoDiv"));
		 }else{
			 $.ajax({
				 type:"post",
				 async:false,
				 dataType:"json",
				 data:{txMoney:txMoney},
				 url:"accountApp.do?action=applyTX&cilengInfo=app",
				 success:function(json){
					 if(json["result"]){
						 $(".succImg").show();
						 $(".tipImg").hide();
						 $("#warnPTxt").html("申请提现成功");
						 commonTipInfoFn($(".warnInfoDiv"),function(){
							 goBackTx();
						 });
						 getSelfAccount(option_a);
					 }else{
						 $(".tipImg").show();
						 $(".succImg").hide();
						 $("#warnPTxt").html("申请提现失败,请重试或者联系管理员");
						 commonTipInfoFn($(".warnInfoDiv"));
					 }
				 }
			 });
		 } 
	}
}
//自定义日期格式
Date.prototype.format = function(format) {
	   var o = {
	       "M+": this.getMonth() + 1,
	       // month
	       "d+": this.getDate(),
	       // day
	       "h+": this.getHours(),
	       // hour
	       "m+": this.getMinutes(),
	       // minute
	       "s+": this.getSeconds(),
	       // second
	       "q+": Math.floor((this.getMonth() + 3) / 3),
	       // quarter
	       "S": this.getMilliseconds()
	       // millisecond
	   };
	   if (/(y+)/.test(format) || /(Y+)/.test(format)) {
	       format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	   }
	   for (var k in o) {
	       if (new RegExp("(" + k + ")").test(format)) {
	           format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	       }
	   }
	   return format;
};
//获取自定义日期格式
function getLocalDate(nS) { 
	if(nS != undefined){
		return new Date(parseFloat(nS)).format("yyyy-MM-dd hh:mm:ss");
	}else{
		return "暂无";
	}
}
//获取日期格式
function getLocalDate_new(nS){
	if(nS != undefined){
		return nS.substring(0,10);
	}else{
		return "暂无";
	}
}
function calLiWid(){
	$(".accNav li").each(function(i){
		$(".accNav li").eq(i).width(cliWid/4);
	});
	$(".accountType").height(cliHei - 85);
	$("#infoDiv_incWrap").height($(".accountType").height() - $(".titDiv").height());
	$("#bankWrapper").height(cliHei - 40);
	bankCardScroll();
	choiceOptionBankCard();
}
//检测数据div下的li length
function checkLiLen(){
	if(option_a == "income"){
		if($("#infoDiv_con_income li").length == 0){
			$("#infoDiv_con_income").html("<div id='noData_inc' class='noAccDataDiv'><img src='Module/appWeb/accountNt/images/noIncome.png' alt='暂无收入明细'/></div>");
			$("#noData_inc").css({"margin-top":($("#infoDiv_incWrap").height() - $(".noAccDataDiv").height())/2});
		}
	}else if(option_a == "tx"){
		if($("#infoDiv_con_tx li").length == 0){
			$("#infoDiv_con_tx").html("<div id='noData_tx' class='noAccDataDiv'><img src='Module/appWeb/accountNt/images/noTx.png' alt='暂无提现记录'/></div>");
			$("#noData_tx").css({"margin-top":($("#infoDiv_tx").height() - $(".noAccDataDiv").height())/2});
		};
	}else if(option_a == "buy"){
		if($("#infoDiv_con_buy li").length == 0){
			$("#infoDiv_con_buy").html("<div id='noData_buy' class='noAccDataDiv'><img src='Module/appWeb/accountNt/images/noBuy.png' alt='暂无学生购买记录'/></div>");
			$("#noData_buy").css({"margin-top":($("#infoDiv_buy").height() - $(".noAccDataDiv").height())/2});
		};
	}
}
//展开修改或者新增银行名称
function showFixBankName(){
	$(".changeBank").css({
		"-webkit-transform":"translateX(0px)",
		"transform":"translateX(0px)"
	});
	tmpBankFlag = false; //每次展开初始化
}
//返回
function goBack(){
	$(".changeBank").css({
		"-webkit-transform":"translateX("+ cliWid +"px)",
		"transform":"translateX("+ cliWid +"px)"
	});
	if(tmpBankFlag == false){ //说明没有点击完成保存按钮
		$(".compBtn").hide();
		$(".bankMidWinDiv li").find("b").remove();
	}
}
function goBackTx(){
	$("#applyWindow").css({
		"-webkit-transform":"translateX("+ cliWid +"px)",
		"transform":"translateX("+ cliWid +"px)"
	});
}
//新增银行卡和更换银行卡
function choiceOptionBankCard(){
	$(".com_BankRdio").each(function(){
		$(this).on("touchend",function(){
			if(bankFlag){
				$(this).attr("checked",true);
				tmpBankVal = $(this).val();
				$(".compBtn").show();
				$(this).parent("li").append("<b></b>").siblings().find('b').remove();
			}
		});
	});
}
//保存银行名称
function saveBankName(){
	$("#bankName").val(tmpBankVal);
	$("#bankNameSpan").html(tmpBankVal);
	$("#bankNum").val("");
	$(".changeBank").css({
		"-webkit-transform":"translateX("+ cliWid +"px)",
		"transform":"translateX("+ cliWid +"px)"
	});
	tmpBankFlag = true; //说明点击完成保存按钮了
	$(".compBtn").hide();
	$(".bankMidWinDiv li").find("b").remove();
}
//iscroll银行卡的变更和新增
function bankCardScroll() {
	myScroll = new iScroll('bankWrapper', {
		onScrollMove:function(){
			bankFlag = false;
		},
		onScrollEnd:function(){
			bankFlag = true;
		}
	});		
}