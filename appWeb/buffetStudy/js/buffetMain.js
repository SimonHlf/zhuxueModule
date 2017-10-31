//重置input日期宽度
function initWid(){
	var strSpan = "<span class='calIcon'></span>";
	$(".timeBox").width($(".searInner").width() - $(".subBox").width() - $(".searBtn").width()-11);
	$(".timeBox div").width(($(".timeBox").width()/2) - $(".timeBox span").width()+7);
	$(".timeBox div").each(function(i){
		$(".timeBox div").eq(i).append(strSpan);
	});
	$("#subjLayer").height(cliHei - 50);
	$("#studyStaLayer").height(cliHei - 90);
	$("#bsDiv").height($("#studyStaLayer").height());
	showSubBg();
	getStudyStatus();
}
function showSubBg(){
	$("#subjectDiv li").each(function(i){
		var subTxt = $(".subTxt").eq(i).text();
		if(subTxt == "数学"){
			$(".subImgBg").eq(i).addClass("mathBg");
		}else if(subTxt == "物理"){
			$(".subImgBg").eq(i).addClass("phyBg");
		}else if(subTxt == "生物"){
			$(".subImgBg").eq(i).addClass("biologyBg");
		}else if(subTxt == "化学"){
			$(".subImgBg").eq(i).addClass("chemBg");
		}else if(subTxt == "地理"){
			$(".subImgBg").eq(i).addClass("geograBg");
		}else if(subTxt == "科学"){
			$(".subImgBg").eq(i).addClass("sicBg");
		}else if(subTxt == "生命科学"){
			$(".subImgBg").eq(i).addClass("sicBg_1");
		}else if(subTxt == "语文"){
			$(".subImgBg").eq(i).addClass("yuwenBg");
		}else if(subTxt == "英语"){
			$(".subImgBg").eq(i).addClass("engBg");
		}else if(subTxt == "历史"){
			$(".subImgBg").eq(i).addClass("historyBg");
		}
	});
}
//格式化日期控件
function initDateSel(obj,endYear){
	var opt = {
        preset: 'date', //日期
        theme: 'android-ics light', //皮肤样式
        display: 'modal', //显示方式 
        mode: 'scroller', //日期选择模式
        dateFormat: 'yy-mm-dd', // 日期格式
        setText: '确定', //确认按钮名称
        cancelText: '取消',//取消按钮名籍我
        dateOrder: 'yymmdd', //面板中日期排列格式
        dayText: '日', monthText: '月', yearText: '年', //面板中年月日文字
        endYear:endYear //结束年份
    };
    $("#"+obj).mobiscroll(opt).date(opt);
}
//显示学科列表
function showCurrSubjectList(list){
	var options = '';
	var subId_hidden = "<input type=hidden id=sub_id_hidd value='"+subId+"'/>";
	for(i=0; i<list.length; i++){
		options += "<li class='subNames' id='"+list[i].subject.id+"'><span class='subImgBg'></span><span class='subTxt'>"+list[i].subject.subName+"</span></li>";			  	
	}
	$('#subjectDiv').html(subId_hidden+options);
	selectSub();//选择学科
}
//获取当前学生的学科列表
function getCurrSubjectList(){
	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  data:{gradeNumber:gradeNumber},
		  url:"buffetApp.do?action=getSelfSubjectJson&cilentInfo=app",
		  success:function (json){ 
			  showCurrSubjectList(json["gList"]);
		  }
	});
}
//选择学科动作
function selectSub(){
	$(".subjDiv").on("touchend",function(event){
		$("#subjLayer").show();
		$("#stuSubWrapper").css({
			"-webkit-transform":"translateY(90px)",
			"transform":"translateY(50px)"
		});
		$("#spanTri").addClass("flip");
		$(".triSpan").css({"top":17});
		$("#subjLayer").show();
		$("#studyStaLayer").hide();
		$("#statusDiv").hide();
		event.stopPropagation();
	});
	$("#subjectDiv > li").on("touchend",function(){
		var sub=$(this).attr("id");
		$("#sub_id_hidd").val(sub);
		$("#subjSpan").html($(this).text());
		$(".triSpan").css({"top":24});
		$("#stuSubWrapper").css({
			"-webkit-transform":"translateY(-100%)",
			"transform":"translateY(-100%)"
		});
		$("#subjLayer").hide();
		getSelfBuffetList("clickQuery");
		$("#studyStaInpVal").val("-1");
		$("#studyStaSpan").html("全部");
	});
	$("body").on("touchend",function(){
		$("#stuSubWrapper").css({
			"-webkit-transform":"translateY(-100%)",
			"transform":"translateY(-100%)"
		});
		$("#subjLayer").hide();
		$("#spanTri").removeClass("flip");
		$(".triSpan").css({"top":24});
	});	
}
//获取学习状态
function getStudyStatus(){
	$("#studyStaSpan").on("touchend",function(event){
		$("#statusDiv").show();
		$("#studyStaLayer").show();
		event.stopPropagation();
	});
	$("#resultStatus li").on("touchend",function(){
		var selectedStuSta = $(this).attr("value");
		$("#studyStaInpVal").val(selectedStuSta);
		$("#studyStaSpan").html($(this).html());
		$("#statusDiv").hide();
		$("#studyStaLayer").hide();
	});
	$("body").on("touchend",function(){
		$("#statusDiv").hide();
		$("#studyStaLayer").hide();
	});
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
		return new Date(parseFloat(nS)).format("yyyy-MM-dd");
	}else{
		return "";
	}
}
//检查条件是否发生变化，防止不点击查询按钮直接向上拖动刷新数据
function checkSelectOptions(){
	var flag = false;
	var subId_1 = $("#sub_id_hidd").val();
	var completeStatus_1 = $("#studyStaInpVal").val();
	var stime_1 = $("#stime").val();
	var etime_1 = $("#etime").val(); 
	if(subId_temp != subId_1 || studyStatus_temp != completeStatus_1 || stime_temp != stime_1 || etime_temp != etime_1){
		 flag = false;
	 }else{
		 flag = true;
	 }
	return flag;
}
//获取自己的自助餐列表
function getSelfBuffetList(option){
	subId = $("#sub_id_hidd").val();
	var completeStatus = $("#studyStaInpVal").val();
	stime = $("#stime").val();
	etime = $("#etime").val();
	var flag_query = false;
	var flag_async = false;//异步
	if(option == "clickQuery"){//点击查询按钮触发
		$("#buffetSendInfo").html("");
		pageNo = 1;//初始化
		noDataFlag = false;
		subId_temp = subId;
		studyStatus_temp = completeStatus;
		stime_temp = stime;
		etime_temp = etime;
		flag_query = true;
		flag_async = true;
	}else{//拖动刷新
		 flag_query = checkSelectOptions();
		 flag_async = false;
	}
	if(flag_query){
		$.ajax({
			  type:"post",
			  async:flag_async,
			  dataType:"json",
			  data:{subId:subId,result:completeStatus,stime:stime,etime:etime,pageNo:pageNo},
			  url:"buffetApp.do?action=getSelfBuffetJson&cilentInfo=app",
			  beforeSend:function(){
	        	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
			  },
			  success:function (json){ 
				  showSelfBuffeList(json["bsList"],option);
			  },
			  complete:function(){
	        	$("#loadDataDiv").hide();
	        	$(".loadingIcon").remove();
	         }
		});
	}else{
		$("#warnPTxt").html("请先点查询击按钮再进行拖动");
		commonTipInfoFn($(".warnInfoDiv"));
	}
}
//显巴菲特学习列表
function showSelfBuffeList(list,option){
	var content = "";
	if(list.length > 0){
		noDataFlag = false;
		$("#pullUp").show();
		pageNo++;
		for(var i = 0 ; i < list.length ; i++){
			content += "<li>";
			content += "<div class='innerCon'><p class='titP ellip'><strong>知识点:"+list[i].studyLog.lore.loreName+"</strong></p>";
			content += "<div class='listPar clearfix'><div class='comListDiv'><p>发送人</p><p>"+list[i].user.nickname+"</p></div>";
			content += "<div class='comListDiv'><p>发送时间</p><p>"+getLocalDate(list[i].sendTime)+"</p></div>";
			var studyResult = list[i].result;
			var buttonValue = "";
			var studyResult_txt = "";
			if(studyResult == 0){
				studyResult_txt = "<span class='noStudySta'>未学习</span>";
				buttonValue = "去学习";
			}else if(studyResult == 1){
				studyResult_txt = "<span class='comPleteSta'>完成</span>";
				buttonValue = "查看";
			}else if(studyResult == 2){
				studyResult_txt = "<span class='noPassSta'>未通过</span>";
				buttonValue = "继续学习";
			}
			content += "<div class='comListDiv'><p>完成状态</p><p>"+studyResult_txt+"</span></div></div>";
			content += "<div class='compScaleDiv'><p>完成进度</p><p class='compScaleNum'><span class='comPleteNumSpan'>"+list[i].completeNumber+"</span>/<span class='allNumSpan'>"+list[i].allNumber+"</span></p><div class='prograDiv'><span class='nowPerBar'></span></div></div>";
			content += "<div class='btnDiv'><a class='comBtn' href=javascript:void(0) ontouchend=goBuffetStudyPage("+list[i].id+",'"+list[i].studyLog.lore.loreName+"');>"+buttonValue+"</a></div>";
			content += "<div class='completePic'></div>";
			content += "</div></li>";
		}
	}else{
		noDataFlag = true;
	}
	if(noDataFlag && option == "clickQuery"){//初始或者点击查询按钮无数据
		$("#pullUp").hide();
		$("#buffetSendInfo").html("<div class='noData'><img src='Module/appWeb/studyRecord/images/noRecord.png' alt='暂无数据'/><p>暂无数据</p></div>");
		$(".noData").css({"margin-top":((cliHei-90) - $(".noData").height())/2 - 20});
	}
	$("#buffetSendInfo").append(content);
	completeProgBox();
}

//巴菲特完成进度条
function completeProgBox(){
	$("#buffetSendInfo li").each(function(i){
		var nowExp = parseInt($(".comPleteNumSpan").eq(i).html());
		var totalExp = parseInt($(".allNumSpan").eq(i).html());
		var perScale = nowExp/totalExp;
		$(".nowPerBar").eq(i).width(perScale * $(".prograDiv").width());
		if(perScale == 1){
			$(".completePic").eq(i).show();
		}
	});
}

/**
 * 拉滚动翻页 （自定义实现此方法）
 * myScroll.refresh();		// 数据加载完成后，调用界面更新方法
 */
function pullUpAction () {
	loadOption = "pullUpAction";
	setTimeout(function () {	// <-- Simulate network congestion, remove setTimeout from production!
		getSelfBuffetList("pullQuery");
		myScroll.refresh();		// 数据加载完成后，调用界面更新方法 Remember to refresh when contents are loaded (ie: on ajax completion)
	}, 1000);	// <-- Simulate network congestion, remove setTimeout from production!
	
}

/**
 * 初始化iScroll控件
 */
 function loaded() {
		pullUpEl = document.getElementById('pullUp');	
		pullUpOffset = pullUpEl.offsetHeight;
		
		myScroll = new iScroll('bsDiv', {
			checkDOMChanges : true,
			onRefresh: function () {
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
				if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
					pullUpEl.className = 'flip';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '释放加载更多...';
					this.maxScrollY = this.maxScrollY;
				} else if (this.y > (this.maxScrollY + 5) && pullUpEl.className.match('flip')) {
					pullUpEl.className = '';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = 'Pull up to load more2...';
					this.maxScrollY = pullUpOffset;
				}
			},
			onScrollEnd: function () {
				if (pullUpEl.className.match('flip')) {
					pullUpEl.className = 'loading';
					pullUpEl.querySelector('.pullUpLabel').innerHTML = '数据加载中...';				
					pullUpAction();	// Execute custom function (ajax call?)
				}
			}
		});
		
		setTimeout(function () { document.getElementById('bsDiv').style.left = '0'; }, 800);
	}

	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);

	document.addEventListener('DOMContentLoaded', function () { setTimeout(loaded, 200); }, false);
	
function goBuffetStudyPage(bsId,loreName){
	var url = "&buffetSendId="+bsId+"&loreName="+encodeURIComponent(loreName)+"&closeFlag=bf";
	url += "&stime="+stime_temp+"&etime="+etime_temp+"&subId="+subId_temp+"&result="+studyStatus_temp;
	window.location.href = "buffetApp.do?action=showBuffetQuestionPage"+url+"&cilentInfo=app";
}