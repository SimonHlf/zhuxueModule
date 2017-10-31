<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>培优学习记录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/appWeb/mobiscroll/css/mobiscroll.custom-2.5.0.min.css" rel="stylesheet" type="text/css" />
	<link href="Module/appWeb/buffetSend/css/buffetStudyLog.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script src="Module/appWeb/mobiscroll/js/jquery.mobile-1.3.0.min.js"></script>	
	<script src="Module/appWeb/mobiscroll/js/mobiscroll.custom-2.5.0.min.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script src="Module/appWeb/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/dist/echarts.js"></script>
	<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/themes/macarons.js"></script>
	<script type="text/javascript">
	var subId = "${requestScope.subId}";
	var startTime = "${requestScope.startTime}";
	var endTime = "${requestScope.endTime}";
	var ntId = "${requestScope.ntId}";//导师编号--nt
	var stuId = "${requestScope.stuId}";//学生编号--nt	
	var stuName = "";
	var cliWid = document.documentElement.clientWidth;
	var cliHei = document.documentElement.clientHeight;
	var recordFlag = true;
	var loadStFlag = true;
	$(function(){
		$("#startTime").val(startTime);
		$("#endTime").val(endTime);
		initDateSel("startTime",2020);
		initDateSel("endTime",2020);	
		$("#stNaInpVal").val(stuId);
		$("#guidInpVal").val(status);
		getSelfBindStuList();//获取学生列表
		getSRList("init");
		initWid();
	});
	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
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
	
	
	function getLocalTime(nS) { 
		return new Date(parseFloat(nS)).format("yyyy-MM-dd");
	}
	//获取自己绑定有效的学生列表（没过期，没取消，没清除）
	function getSelfBindStuList(){
		$.ajax({
			  type:"post",
			  async:false,//同步
			  dataType:"json",
			  data:{ntId:ntId},
			  url:"guideApp.do?action=getSelfBindStuInfo&cilentInfo=app",
			  success:function (json){ 
				  showStuList(json["stuInfo"]);
			  }
		});
	}
	//显示学生列表
	function showStuList(list){
		var stuCon = "";
		for(var i = 0 ; i < list.length ; i++){
			stuCon += "<li value='"+list[i].user.id+"'>"+list[i].user.realname+"</li>";
		}
		$("#stuDataUl").html(stuCon);
		if($("#stuDataUl li").length > 0){
			loadStudent();
			getStuData();
		}
	}
	function getStuData(){
		$(".showStBtn").on("touchend",function(event){
			$("#stuWrapper").css({
				"-webkit-transform":"translateY(50px)",
				"transform":"translateY(50px)"
			});
			$("#spanTri").addClass("flip");
			$(".triSpan").css({"top":17});
			$("#statusDiv").hide();
			//$(".recordLayer").hide();
			event.stopPropagation();
		});
		$("#stuDataUl li").on("touchend",function(){
			if(loadStFlag){
				var selectedSt = $(this).attr("value");
				$("#stNaInpVal").val(selectedSt);
				$("#stNameSpan").html($(this).html());
				$("#stuName").html($(this).html());
				$("#stuWrapper").css({
					"-webkit-transform":"translateY(-100%)",
					"transform":"translateY(-100%)"
				});
				$("#spanTri").removeClass("flip");
				$(".triSpan").css({"top":24});
				getSRList('manu');
			}
		});
		//进入学习记录匹配对应的学生编号和名字
		$("#stuDataUl li").each(function(i){
			var selectedSt = $("#stuDataUl li").eq(i).attr("value");
			if(selectedSt == stuId){
				$("#stNameSpan").html($("#stuDataUl li").eq(i).html());
			}
			
		});
		$("body").on("touchend",function(){
			if(loadStFlag){
				$("#stuWrapper").css({
					"-webkit-transform":"translateY(-100%)",
					"transform":"translateY(-100%)"
				});
				$("#spanTri").removeClass("flip");
				$(".triSpan").css({"top":24});
			}
			
		});
	};
	function loadStudent() {
		myScroll = new iScroll('stuWrapper', { 
			checkDOMChanges: true,
			onScrollMove:function(){
				loadStFlag = false;
			},
			onScrollEnd:function(){
				loadStFlag = true;
			}
		});		
	}
	//获取学习记录
	function getSRList(option){
		stuId = $("#stNaInpVal").val();
		stuName = $("#stNameSpan").html();
		startTime = $("#startTime").val();
		endTime = $("#endTime").val();
		if(stuId == 0){
			if(option == "init"){
				$(".txtSpan").hide();
				$(".showStBtn").hide();
				$("#recordWrap").html("<div class='noStDiv'><img width='110' src='Module/trainSchoolManager/images/noNtDyPic.jpg'/><p>暂无学生</p></div>");
			}else{
				if($("#stuDataUl li").length > 0){
					$("#warnPTxt").html("请选择学生");
					commonTipInfoFn($(".warnInfoDiv"));
				}else{
					$("#warnPTxt").html("暂无学生");
					commonTipInfoFn($(".warnInfoDiv"));
				}
			}
		}else{
			$.ajax({
				  type:"post",
				  async:true,//异步
				  dataType:"json",
				  beforeSend:function(){
					  $("#loadingSpan").show();
				  },
				  data:{stuId:stuId,subId:subId,stime:startTime,etime:endTime},
				  url:"buffetApp.do?action=showStudyCompleteLog&cilentInfo=app",
		          beforeSend:function(){
					 $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
				  },
				  success:function (json){ 
					  showSRList(json["result"]);
				  },
				  complete:function(){
		        	  $("#loadDataDiv").hide();
		        	  $(".loadingIcon").remove();
			      }
			});
			$("#days").html(compareDate(startTime,endTime));
			$("#stuName").html(stuName);
		}
	}
	//显示学习记录
	function showSRList(list){
		var slList = "";
		if(list[0].bsList.length > 0){
			for(var i = 0 ; i < list[0].bsList.length ; i++){
				var bsList = list[0].bsList;
				if(bsList[i].result == 1){//完成
        			status = 'status1';
        		}else {
        			status = 'status2';//未完成
        		}
        		slList += "<div id=study_"+bsList[i].id+" class='recordDiv'>";
				if(bsList[i].id == 0){
					slList += "<span class='noCompSpan'></span><p class='recordTxtp ellip fl' ontouchend=showBuffetSendPage('"+bsList[i].studyLog.id+"','"+bsList[i].studyLog.lore.id+"','"+bsList[i].studyLog.lore.loreName+"','"+bsList[i].studyLog.lore.quoteLoreId+"','"+bsList[i].studyLog.user.id+"')>"+ bsList[i].studyLog.lore.loreName +"</p><p class='comStateP noPubTxtP fl'>未发布</p>";
				}else{
        			slList += "<span class='compSpan'></span><p class='recordTxtp ellip fl'>"+bsList[i].studyLog.lore.loreName+"</p><p class='comStateP pubTxtP fl'>已发布["+getLocalTime(bsList[i].sendTime)+"]</p>";
				}
				slList += "<span id=span_"+bsList[i].id+" class='viewDetailP fr' ontouchend=getSpecificBuffetLoreChart('"+bsList[i].id+"','"+bsList[i].user.id+"','"+bsList[i].studyLog.lore.loreName+"')></span>";
        		slList += "</div>";
			}
    		$("#recordInfo").html(slList);
    		function recoListScroll() {
    			myScroll = new iScroll('innerRecoWrap', { 
    				checkDOMChanges: true,
    				onScrollMove:function(){
    					recordFlag = false;
    				},
    				onScrollEnd:function(){
    					recordFlag = true;
    				}
    			});	
    		}
    		recoListScroll();
    		if(cliWid < 530){
    			calListDivWid();
    		}
		}else{
			$("#recordInfo").html("<div class='noRecoDiv'><img src='Module/appWeb/studyRecord/images/noRecord.png' alt='暂无学习记录'><p>该学生暂无学习记录</p></div>");
			$(".noRecoDiv").css({"margin-top":($("#innerRecoWrap").height() - $(".noRecoDiv").height())/2});
		}
		$("#stuNames").html("&nbsp;" + stuName + "&nbsp;");
		$("#daySpan").html("&nbsp;" + compareDate(startTime,endTime));
		$("#daySpanShow").html("&nbsp;" +compareDate(startTime,endTime) + "&nbsp;");
		$("#sbn").html("&nbsp;"+list[0].sendBuffetNumber+"&nbsp;");
		$("#sbnShow").html("&nbsp;" +list[0].sendBuffetNumber + "&nbsp;");
		$("#cbn").html("&nbsp;"+list[0].completeBuffetNumber+"&nbsp;");
		$("#ucbn").html("&nbsp;"+list[0].unCompleteNuffetNumber+"&nbsp;");
		$("#cr").html("&nbsp;"+list[0].completeRate+"&nbsp;");
	}
	function calListDivWid(){
		$(".recordTxtp").each(function(i){
			var parWid = $(".recListWrap").width();
			var pubStateWid = $(".comStateP").eq(i).width();
			var viewBtn = $(".viewDetailP").eq(i).width();
			$(".recordTxtp").eq(i).width(parWid - pubStateWid - viewBtn);
			$(".recordTxtp").eq(i).css({
				"width":parWid - pubStateWid - viewBtn-20,
				"max-width":parWid - pubStateWid - viewBtn-20
			});
		});
	}
	//日期相差的天数
	function compareDate(startTime,endTime){
		var stiem = new Date(Date.parse(startTime.replace(/-/g, "/")));
		var etime = new Date(Date.parse(endTime.replace(/-/g, "/")));
		var difference = stiem.getTime() - etime.getTime();
		var diffDays =  Math.round(difference / (1000 * 60 * 60 * 24));
		return Math.abs(diffDays);
	}
	//获取指定知识点学习记录的巴菲特记录图表
	function getSpecificBuffetLoreChart(currentBuffetSendId,stuId,currLoreName){
		$("#studyRelaDivWin").css({
			"-webkit-transform":"translateX(0px)",
			"transform":"translateX(0px)"
		});
		$("#loreName").html("["+currLoreName+"]统计图");
		$.ajax({
	        type:'post',
	        dataType:'json',
	        data:{currentBuffetSendId:currentBuffetSendId,stuId:stuId,subName:"all"},
	        async:true,//异步
	        url:'buffetApp.do?action=getBuffetChartData&cilentInfo=app',
	        beforeSend:function(){
			  $("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
		  	},
	        success:function (json){
	        	loadChart(json["result"]);
	        },
	        complete:function(){
	        	$("#loadDataDiv").hide();
	        	$(".loadingIcon").remove();
	        	showDetailChartScroll();
	        }
		});
	}
	function showDetailChartScroll() {
		myScroll = new iScroll('chartReport', { 
			checkDOMChanges: true
		});	
	}
	function goBack(){
		$("#studyRelaDivWin").css({
			"-webkit-transform":"translateX("+ cliWid +"px)",
			"transform":"translateX("+ cliWid +"px)"
		});
	}
	//加载echarts报表
	function loadChart(list){
		var currMindSuccRateArray = list[0].currMindSuccRate.split(",");
		var allMindSuccRateArray = list[0].allMindSuccRate.split(",");
		var currAbilitySuccRateArray = list[0].currAbilitySuccRate.split(",");
		var allAbilitySuccRateArray = list[0].currAbilitySuccRate.split(",");
		var currMindNumberArray = list[0].currMindNumber.split(",");
		var currAbilityNumberArray = list[0].currAbilityNumber.split(",");
		var allMindNumberArray = list[0].allMindNumber.split(",");
		var allAbilityNumberArray = list[0].allAbilityNumber.split(",");
		var xAxisData_mind = "定向,发散,逆向,抽象,类比,移植,形象,联想";
		var xAxisDataArray_mind = xAxisData_mind.split(",");
		var xAxisData_ability = "理解,分析,表达,实践,质疑,联想,综合,创新";
		var xAxisDataArray_ability = xAxisData_ability.split(",");
		//路径配置
		require.config({
			paths:{
				echarts:'Module/commonJs/echarts-2.2.1/build/dist'
			}
		});
		//使用
		require(
			[
			 	'echarts',
			 	'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
			 	'echarts/chart/line'// 使用曲线图就加载bar模块，按需加载
		    ],
		    function(ec){
				// 基于准备好的dom，初始化echarts图表
		    	var myChart_mind = ec.init(getId('curr_chart_mind'),getThemes()); 
				var myChart_ability = ec.init(getId('curr_chart_ability'),getThemes());
				var myChart_all_mind = ec.init(getId('all_chart_mind'),getThemes()); 
				var myChart_all_ability = ec.init(getId('all_chart_ability'),getThemes()); 
		    	
		    	// 为echarts对象加载数据 
                myChart_mind.setOption(getChartData("巴菲特思维正确率统计图","当前巴菲特思维正确率","汇总巴菲特思维正确率",
                		xAxisDataArray_mind,currMindSuccRateArray,allMindSuccRateArray)); 
                myChart_ability.setOption(getChartData("巴菲特能力正确率统计图","当前巴菲特能力正确率","汇总巴菲特能力正确率",
		    			xAxisDataArray_ability,currAbilitySuccRateArray,allAbilitySuccRateArray));
                myChart_all_mind.setOption(getChartData("巴菲特思维数量统计图","当前巴菲特思维总数","汇总巴菲特思维总数",
                		xAxisDataArray_mind,currMindNumberArray,allMindNumberArray)); 
                myChart_all_ability.setOption(getChartData("巴菲特能力数量统计图","当前巴菲特能力总数","汇总巴菲特能力总数",
		    			xAxisDataArray_ability,currAbilityNumberArray,allAbilityNumberArray));
			});
	}
	//统计图数据
	function getChartData(title,chartData1,chartData2,xAxisDataArray,seriesData1,seriesData2){
		var option = {
    		    title : {
    		    	x : 'center',
    		        text: title
    		    },
    		    tooltip : {
    		        trigger: 'axis'
    		    },
    		    legend: {
    		    	y : '35px',
    		    	padding : '1px',
    		    	data:[chartData1,chartData2]
    		    },
    		    toolbox: {
    		        show : true,
    		        orient : 'vertical',
    		        y : 'center',
    		        feature : {
    		        	dataView:{
		    		    	show:false,
		    		    	readOnly:false
		    		    },
		    		    magicType:{
		    		    	show:true,
		    		    	type:['line','bar']
		    		    },
		    		    restore : {show: true},
    		            saveAsImage : {show: false}
    		        }
    		    },
    		    
    		    calculable : false,
    		    xAxis : [
    		        {
    		            type : 'category',
    		            axisLabel : {
    		                show:true,
    		                interval: 'auto',    // {number}
    		                rotate: 0,
    		                margin: 5,
    		                formatter: '{value}',
    		                textStyle: {
    		                    color: '#1e90ff',
    		                    fontFamily: 'sans-serif',
    		                    fontSize: 12,
    		                    fontStyle: 'normal'
    		                }
    		            },
    		            data : [xAxisDataArray[0],xAxisDataArray[1],xAxisDataArray[2],xAxisDataArray[3],
    		                    xAxisDataArray[4],xAxisDataArray[5],xAxisDataArray[6],xAxisDataArray[7]]
    		        }
    		    ],
    		    yAxis : [
    		        {
    		            type : 'value',
    		            min : 0
    		        }
    		    ],
    		    grid : {
    		    	x : 30,
    		    	x2 : 30,
    		    	y2 : 20
    		    },
    		    series : [
    		        {
    		            name:chartData1,
    		            type:'bar',
    		            data:[seriesData1[0],seriesData1[1],seriesData1[2],seriesData1[3],
    		                  seriesData1[4],seriesData1[5],seriesData1[6],seriesData1[7]]
    		        },
    		        {
    		            name:chartData2,
    		            type:'bar',
    		            data:[seriesData2[0],seriesData2[1],seriesData2[2],seriesData2[3],
    		                  seriesData2[4],seriesData2[5],seriesData2[6],seriesData2[7]]
    		        }
    		    ]
    		};
		return option;
	}
	//打开发布自助餐页面
	function showBuffetSendPage(stuLogId,loreId,loreName,quoteLoreId,stuId){
		if(recordFlag){
			var url = "&studyLogId="+stuLogId+"&loreId="+loreId+"&loreName="+loreName+"&quoteLoreId="+quoteLoreId+"&stuId="+stuId;
			url += "&stime="+startTime+"&etime="+endTime;
			window.location.href = "buffetApp.do?action=goBuffetSendPage"+url+"&cilentInfo=app";
		}
	}
	//重置input日期宽度
	function initWid(){
		var strSpan = "<span class='calIcon'></span>";
		$(".timeBox").width($(".searInner").width() - $(".searBtn").width()-11);
		$(".timeBox div").width(($(".timeBox").width()/2) - $(".timeBox span").width()+7);
		$(".timeBox div").each(function(i){
			$(".timeBox div").eq(i).append(strSpan);
		});
		$("#recordWrap").height(cliHei - 100);
		$(".studyLogLayer").height(cliHei-90);
		$("#chartReport").height(cliHei - 40);
		$(".loreNameP").width(cliWid - $(".goBackBtn").width() - 5).css({"max-width":$(".loreNameP").width() - 10});
		var recWrapHei = $("#recordWrap").height();
		$(".recListWrap").css({"height":recWrapHei * 0.95});
		$(".recListPar").css({"height":recWrapHei * 0.95});
		$("#innerRecoWrap").css({"height":$(".recListPar").height() - $(".recordTit").height() - $(".recordBot").height()});
		//初始化调整学习记录底部代表已完成未完成的位置
		if(cliWid > 410 && cliWid <= 500){
			$(".completeP").html("<span></span>代表已完成");
			$(".noCompleteP").html("<span></span>代表未完成");
		}else if(cliWid > 500 && cliWid <=600){
			$(".statusP").css({"text-indent":35});
			$(".completeP").html("<span></span>代表已完成");
			$(".noCompleteP").html("<span></span>代表未完成");
			$(".statusP span").css({"left":18});
		}else if(cliWid > 600 && cliWid <= 650){
			$(".statusP").css({"text-indent":45});
			$(".completeP").html("<span></span>代表已完成");
			$(".noCompleteP").html("<span></span>代表未完成");
			$(".statusP span").css({"left":28});
		}else if(cliWid >650 && cliWid <= 700){
			$(".statusP").css({"text-indent":55});
			$(".completeP").html("<span></span>代表已完成");
			$(".noCompleteP").html("<span></span>代表未完成");
			$(".statusP span").css({"left":38});
		}else if(cliWid > 700 && cliWid <= 730){
			$(".statusP").css({"text-indent":65});
			$(".completeP").html("<span></span>代表已完成");
			$(".noCompleteP").html("<span></span>代表未完成");
			$(".statusP span").css({"left":48});
		}else if(cliWid > 730){
			$(".statusP").css({"text-indent":75});
			$(".completeP").html("<span></span>代表已完成");
			$(".noCompleteP").html("<span></span>代表未完成");
			$(".statusP span").css({"left":58});
		}
	}
	function showPubDeatil(event){
		event.stopPropagation();
		$(".studyLogLayer").stop().show().animate({"opacity":1},300,function(){
			$(".detailTxtDiv").stop().show().animate({"opacity":1});
		});
		$("body").on("touchend",function(){
			$(".detailTxtDiv").stop().animate({"opacity":0},function(){
				$(".detailTxtDiv").hide();
				$(".studyLogLayer").stop().animate({"opacity":0},function(){
					$(".studyLogLayer").hide();
				});
			});
		});
	}
	</script>
  </head>
<body>
	<div id="nowLoc" class="nowLoc">
		<span class="backIcon"></span>
		<p><input id="stNaInpVal" type="hidden"/><span id="stNameSpan"></span><span class="txtSpan">的</span>培优学习记录</p>
		<span class="showStBtn">更换学生<span id="spanTri"><span class="triSpan topTri"></span></span></span>
	</div>
	<div id="stuWrapper">
		<div class="stScroller">
			<ul id="stuDataUl" class="clearfix"></ul>
		</div>
	</div>
	<div class="searchBox">
		<div class="searInner clearfix">
			<input id="stNaInpVal" type="hidden"/>
			<div class="timeBox fl">
				<input id="startTime"/><span class="fl">至</span><input id="endTime"/>
			</div>
			<a class="searBtn fl" href="javascript:void(0)"  ontouchend="getSRList('manu')"></a>
		</div>
	</div>
	<div id="recordWrap">
		<!-- 学习记录列表  -->
		<div class="recListWrap">
			<div class="recListPar">
				<div class="recordTit ellip">
					最近<strong id="days"></strong>天<span id="stuName"></span>学习过的知识点如下:
				</div>
				<div id="innerRecoWrap" class="parentWrapRel">
					<div id="recordInfo" class="sonScrollerAbso"></div>
					<!-- 统计结果  -->
					<div class="detailTxtDiv">
						<span class="detailTriSpan"></span>
						<p class="totalTxt">最近<span id="daySpan"></span>天您发布了<span id="sbn"></span>个自助餐,其中<span id="stuNames"></span>完成了<span id="cbn"></span>个,未完成<span id="ucbn"></span>个,完成率<span id=cr></span></p>
					</div>
				</div>
				<div class="recordBot">
					<div id="totalInfo" class="totalDiv fl"><p class="totalTxt">最近<span id="daySpanShow"></span>天您发布了<span id="sbnShow"></span>个自助餐......<a class="viewDetailBtn" href="javascript:void(0)" ontouchend="showPubDeatil(event);">[查看明细]</a></div>
					<div class="statusP fr">
						<p class="completeP"><span></span>已完成</p>
						<p class="noCompleteP"><span></span>未完成</p>
					</div>
				</div>
			</div>
		</div>	
	</div>
	<div id="studyRelaDivWin" class="detailInfoBox">
		<div class="detailTit">
			<a class="goBackBtn fl" href="javascript:void(0)" ontouchend="goBack()"><span></span>返回</a>
			<p class="loreNameP ellip fl"><span id="loreName"></span></p>
		</div>
		<div id="chartReport" class="parentWrapRel">
			<div class="sonScrollerAbso">
				<div id="chart_mind">
					<div class="tableBox" id="curr_chart_mind"></div>
		        	<div class="tableBox" id="all_chart_mind"></div>
				</div>
				<div id="chart_ability">
			        <div class="tableBox" id="curr_chart_ability"></div>
			        <div class="tableBox" id="all_chart_ability"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="studyLogLayer"></div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
	<!-- 提示信息层  -->
	<div class="warnInfoDiv longDiv">
		<img class="tipImg" src="Module/appWeb/onlineStudy/images/tipIcon.png"/>
		<p id="warnPTxt" class="longTxt"></p>
	</div>
  </body>
</html>
