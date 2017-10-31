<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>个人培优报表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link href="Module/appWeb/css/reset.css" type="text/css" rel="stylesheet"/>
	<link  href="Module/appWeb/reportCen/css/buffetReport.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/dist/echarts.js"></script>
	<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/themes/macarons.js"></script>
	<script src="Module/appWeb/commonJs/iscroll.js" type="text/javascript"></script>
	<script type="text/javascript">
	var selSubFlag = true;
	var myScroll;
	var cliHei = document.documentElement.clientHeight;
	var cliWid = document.documentElement.clientWidth;
	$(function(){
		getSelfStuSubjectList();
		getSpecificBuffetLoreChart("all");
		$("#tableWrap").height(cliHei - 90);
	});
	//选择学科左右iscroll
	function subJscroll() {
		myScroll = new iScroll('searchWrap', { 
			checkDOMChanges: true,
			hScrollbar : false,
			onScrollMove:function(){
				selSubFlag = false;
			},
			onScrollEnd:function(){
				selSubFlag = true;
			}
		});
		
	}
	document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
	//获取id方法
	function getId(id){
		return document.getElementById(id);
	}
	//加载echarts报表
	function loadChart(list){
		var allMindSuccRateArray = list[0].allMindSuccRate.split(",");
		var allAbilitySuccRateArray = list[0].currAbilitySuccRate.split(",");
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
		    	var myChart_mind = ec.init(getId('chart_mind'),getThemes()); 
				var myChart_ability = ec.init(getId('chart_ability'),getThemes());
		    	var currSubName = "(" + getId("subName").value + ")";
		    	// 为echarts对象加载数据 
                myChart_mind.setOption(getChartData("培优思维统计图"+currSubName,"汇总培优思维正确率","汇总培优思维总数",
                		xAxisDataArray_mind,allMindSuccRateArray,allMindNumberArray)); 
                myChart_ability.setOption(getChartData("培优能力统计图"+currSubName,"汇总培优能力正确率","汇总培优能力总数",
		    			xAxisDataArray_ability,allAbilitySuccRateArray,allAbilityNumberArray));
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
    		    	data:[chartData1,chartData2]
    		    },
    		    toolbox: {
    		        show : true,
    		        orient : 'vertical',
    		        y : 'center',
    		        feature : {
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
    		            name : '正确率',
    		            axisLabel : {
    		                formatter: '{value}%'
    		            }
    		        },
    		        {
    		            type : 'value',
    		            name : '总量',
    		            axisLabel : {
    		                formatter: '{value}'
    		            }
    		        }
    		    ],
    		    grid : {
    		    	x : 40,
    		    	y : 80,
    		    	x2 : 50,
    		    	y2 : 30
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
    		            type:'line',
    		            yAxisIndex: 1,
    		            data:[seriesData2[0],seriesData2[1],seriesData2[2],seriesData2[3],
    		                  seriesData2[4],seriesData2[5],seriesData2[6],seriesData2[7]]
    		        }
    		    ]
    		};
		return option;
	}
	//获取学培优记录图表
	function getSpecificBuffetLoreChart(subName){
		$.ajax({
	        type:'post',
	        async:true,
	        dataType:'json',
	        data:{currentBuffetSendId:0,subName:escape(subName)},
	        url:'reportCenterApp.do?action=getTJJson&cilentInfo=app',
	        beforeSend:function(){
	        	$("#loadDataDiv").show().append("<span class='loadingIcon'></span>");
			},
	        success:function (json){
	        	loadChart(json["result"]);
	        },
	        complete:function(){
	        	$("#loadDataDiv").hide();
	        	$(".loadingIcon").remove();
	        	viewBuffetScroll();
	        }
		});
	}
	//查看学科对应具体培优图上下iscroll
	function viewBuffetScroll(){
		myScroll = new iScroll('tableWrap', { 
			checkDOMChanges: true
		});
	}
	//根据学科加载培优报表
	function showBuffetReport(obj,subName){
		if(selSubFlag){
			getId("subName").value = subName;
			if(subName == "全部"){
				subName = "all";
			}
			$("#subjectUl li").removeClass("active");
			$(obj).addClass("active");
			getSpecificBuffetLoreChart(subName);
		}
	}
	//获取学生的学科列表
	function getSelfStuSubjectList(){
		$.ajax({
	        type:'post',
	        async:true,
	        dataType:'json',
	        url:'reportCenterApp.do?action=getSelfSubjectJson&cilentInfo=app',
	        success:function (json){
	        	showSelfSubjectList(json["gList"]);
	        }
		});
	}
	//显示学科列表
	function showSelfSubjectList(list){
		var content = "<li id='li_0' class='active' ontouchend=showBuffetReport(this,'全部')>全部</li>";
		for(var i = 0 ; i < list.length ; i++){
			content += "<li ontouchend=showBuffetReport(this,'"+list[i].subject.subName+"')>"+list[i].subject.subName+"</li>";
		}
		$("#subjectUl").html(content);
		$("#subjectUl").css({"width":$("#subjectUl li").length * 70});
		if($("#subjectUl").width() > cliWid){
			$(".shadowSpan").show();
		}else{
			$(".shadowSpan").hide();
		}
		subJscroll();
	}
	</script>

  </head>
  
  <body>
  	<div id="nowLoc" class="nowLoc">
		<span class="backIcon"></span>
		<p>统计报告</p>
	</div>
	<input id="subName" type="hidden" value="全部"/>
	<div class="searchBox">
		<div id="searchWrap" class="searchInner">
	 		<ul id="subjectUl" class="selSubUl clearfix"></ul>
	 		<span class="shadowSpan"></span>
 		</div>
	</div>
	<div id="tableWrap" class="parentWrapRel">
		<div class="sonScrollerAbso">
			  <div class="tableBox" id="chart_mind"></div>
   			 <div class="tableBox" id="chart_ability"></div>
		</div>
	</div>
	<div id="loadDataDiv" class="loadingDiv">
		<p>数据加载中...</p>
	</div>
  </body>
</html>
