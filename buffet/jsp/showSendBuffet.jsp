<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>发布巴菲特</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link type="text/css" rel="stylesheet" href="Module/learnRecord/css/learnRecordCss.css"/>
	<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
	<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/dist/echarts.js"></script>
	<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/themes/macarons.js"></script>
	<script type="text/javascript">
	var ntSubId = "${requestScope.subId }";
	var stuId = "${requestScope.stuId}";
	var stuName = "${requestScope.stuName}";
	var stime = "${requestScope.stime}";
	var etime = "${requestScope.etime}";
	var initStatus = "${requestScope.initStatus}";
	var buffetSendId = "${requestScope.buffetSendId}";
	var studyLogId = "${requestScope.studyLogId}";
	//初始加载日历控件
	function initStartTime(){
		//设置开始日期
		$('#startTime').datebox( {
			currentText : '今天',
			closeText : '关闭',
			disabled : false,
			formatter : function(formatter) {
				var year = formatter.getFullYear().toString();
				var month = formatter.getMonth() + 1;
				var day = formatter.getDate();
				if(month < 10){
					month = "0"+month;
				}
				if(day < 10){
					day = "0"+day;
				}
				return year + "-" + month + "-" + day;
			}
		});
		$(".datebox :text").attr("readonly", "readonly");
		
		//设置结束日期
		$('#endTime').datebox( {
			currentText : '今天',
			closeText : '关闭',
			disabled : false,
			formatter : function(formatter) {
				var year = formatter.getFullYear().toString();
				var month = formatter.getMonth() + 1;
				var day = formatter.getDate();
				if(month < 10){
					month = "0"+month;
				}
				if(day < 10){
					day = "0"+day;
				}
				return year + "-" + month + "-" + day;
			}
		});
		$(".datebox :text").attr("readonly", "readonly");
	}
	//获取指定知识点学习记录的巴菲特记录图标
	function getSpecificBuffetLoreChart(currentBuffetSendId,stuId){
		$.ajax({
	        type:'post',
	        dataType:'json',
	        url:'buffetManager.do?action=getBuffetChartData&currentBuffetSendId='+currentBuffetSendId+'&stuId='+stuId,
	        success:function (json){
	        	loadChart(json);
	        }
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
		var xAxisData_ability = "理解,分析,表达,实践,质疑,联想,综合,创造";
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
    		    	data:[chartData1,chartData2]
    		    },
    		    toolbox: {
    		        show : true,
    		        orient : 'vertical',
    		        y : 'center',
    		        feature : {
    		        	dataView:{
		    		    	show:true,
		    		    	readOnly:false
		    		    },
		    		    magicType:{
		    		    	show:true,
		    		    	type:['line','bar']
		    		    },
		    		    restore : {show: true},
    		            saveAsImage : {show: true}
    		        }
    		    },
    		    
    		    calculable : true,
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
	$(function(){
		initStartTime();
		getNTtoStu(stuId);
		$("input[name='startTime']").val(stime);
		$("input[name='endTime']").val(etime);
		$('#startTime').datebox('setValue',stime);
		$('#endTime').datebox('setValue',etime);
		showBuffetAnalyze();
		getSpecificBuffetLoreChart(buffetSendId,stuId);
	});
	//日期相差的天数
	function compareDate(startTime,endTime){
		var stiem = new Date(Date.parse(startTime.replace(/-/g, "/")));
		var etime = new Date(Date.parse(endTime.replace(/-/g, "/")));
		var difference = stiem.getTime() - etime.getTime();
		var diffDays =  Math.round(difference / (1000 * 60 * 60 * 24));
		return Math.abs(diffDays);
	}
	//网络老师所教的学生
	function getNTtoStu(stuId){
		$.ajax({
	        type:"post",
	        dataType:"json",
	        url:"netTeacherStudent.do?action=listBynID",
	        success:function (date){
	        	var stu='<option value="0">请选择学生</option>';
	        	var options ='';
	        	$.each(date, function(row, obj) {
	        		options +=  "<option value='"+obj.user.id+"'>"+obj.user.realname+"</option>";
	        	});
	        	$('#stu').html(stu+options);
	        	$('#stu').val(stuId);
	        }
	    });
	}
	//手动查询学生学习记录showStudyCompleteLog
	function showStuLogList(){
		var stuId = $("#stu").val();
		var stuName = $("#stu").find("option:selected").text();
		var stime = $('#startTime').datebox('getValue');
		var etime=$('#endTime').datebox('getValue');
		var slList='';
		if(stuId == 0){
			alert("请选择一个学生进行查询!");
		}else if(etime < stime){
			alert("结束时间不能小于开始时间!");
		}else{
			var days=compareDate(stime,etime);
			$('#days').text(days);
			$('#uname').text(stuName);
			$.ajax({
		        type:'post',
		        dataType:'json',
		        url:'buffetManager.do?action=showStudyCompleteLog&stuId='+stuId+'&subId='+ntSubId+'&stime='+stime+'&etime='+etime,
		        success:function (date){
		        	$.each(date, function(row, obj) {
		        		var status = '';
		        		if(obj.result == 2){
		        			status = 'status1';
		        		}else {
		        			status = 'status2';
		        		}
		        		slList += "<li class='"+status+"' id='"+obj.id+"' style='width:314px;max-width:314px;' onclick=getSpecificBuffetLoreChart('"+obj.id+"','"+obj.user.id+"');>"+obj.studyLog.lore.loreName+"&nbsp;";
						if(obj.id == 0){
							slList += '<font color="blue">未发布</font>';
		        		}else{
		        			slList += '<font color="red">已发布</font>';
		        		}
		        		slList += "</li>";
		        	});
		        	$('#recordListCon').html(slList);
		        }
			});
			//$("#cloreNameDet").text("【"+obj.studyLog.lore.loreName+"】巴菲特分析");
		}
	}
	//显示发布页面
	function showBuffetSend(studyLogId){
		
	}
	//分析巴菲特学习情况
	function showBuffetAnalyze(){
		
	}
	</script>
  </head>
  
  <body style="height:1010px;">
    <p>助学网&gt;发布巴菲特</p>
    <!-- 科目时间条件筛选盒子 -->
    <div class="subTimeBox clearfix">
    	<div class="optionBox">
    		<div class="autoBox">
  				<span class="selIcons pl"></span>
  				<span class="selIcons pr"></span>
  			</div>
  			<!-- 选择学科  -->
  			<div class="selSubTimeBox_1 fl">
	            <div class="subBoxNet fl">
	            	<div class="seleSubBox fl">
	                    <span class="ptNet fl">选择学生：</span>
	                    <select id="stu" class="fl"></select> 
	                </div>
	            </div>
  			</div>
  			<div class="selSubTimeBox fr">
           		<div class="timeBox fl">
           			<span class="timeMl">从</span>&nbsp;<input type="text" id="startTime" class="easyui-datebox" />
           			<span class="till">至</span><input type="text" class="easyui-datebox" id="endTime"  />
           		</div>
           		<input type="hidden" id="rname" value="${sessionScope.roleName}" >
           		<a href="javascript:void(0)" class="searchBtn fr" onclick="showStuLogList()">查询</a>
            </div>
    	</div>
    </div>
        <!-- 学习记录的主题盒子 -->
    <div class="recordWrap">
    	<!-- 头部提示状态以及知识点列表的盒子 -->
    	<div class="recordTop">
            <!-- 提示说明盒子 -->
            <div class="recordTip">
                <input type="hidden" id="slID" value="">
                <input type="hidden" id="sl_lore_id" value="">
                <div class="netTeaTip comTipBox fl">
	               <p><span id="ntdays">最近&nbsp;<strong class="learnTime" id="days">${requestScope.diffDays }</strong>&nbsp;天</span><strong class="stusName" id="uname">${requestScope.stuName }</strong>学习通过的&nbsp;知识点如下！</p>
                </div>
	            <!-- 状态盒子 -->
	            <div class="tipIcon">
	            	<span class="one"></span>
	                <span class="complete">代表已完成</span>
	            	<span class="two"></span>
	                <span class="nocomplete">代表未完成</span>
	            </div>
            </div>
            <!-- 学习知识点记录列表 -->
            <div id="kpListBox" class="listBox">
                <ul id="recordListCon">
	                 <c:forEach items="${requestScope.result}" var="buffetSend">
	                 	<c:if test="${buffetSend.result == 0 || buffetSend.result == -1}">
               				<li class="status2" id="${buffetSend.id}" style="width:314px;max-width:314px;" onclick="getSpecificBuffetLoreChart('${buffetSend.id}','${buffetSend.user.id}')">
               			</c:if>
	                 	<c:if test="${buffetSend.result == 1}">
               				<li class="status2" id="${buffetSend.id}" style="width:314px;max-width:314px;" onclick="getSpecificBuffetLoreChart('${buffetSend.id}','${buffetSend.user.id}')">
               			</c:if>
               			<c:if test="${buffetSend.result == 2}">
               				<li class="status1" id="${buffetSend.id}" style="width:314px;max-width:314px;" onclick="getSpecificBuffetLoreChart('${buffetSend.id}','${buffetSend.user.id}')">
               			</c:if>
	                 		${buffetSend.studyLog.lore.loreName }
	                 		<c:if test="${buffetSend.id == 0}">
	                 			<font color="blue">未发布</font>
	                 		</c:if>
	                 		<c:if test="${buffetSend.id != 0}">
	                 			<font color="red">已发布</font>
	                 		</c:if>
	                 	</li>
					</c:forEach>
                </ul>
            </div>
            <div id="parenScroll" class="scrollPar">
                <div id="sonScrollBar" class="scrollSon"></div>
            </div>
        </div>
        <!-- 巴菲特学习倾向分析 -->
        <div class="recordBot">
        	<!-- 巴菲特的学习情况 -->
        	<div class="learnSit">
            	<p id="cloreNameDet"></p>
            	<span class="recordIcon recBg"></span>
            </div>
            <div>
            <div class="tableBox" id="curr_chart_mind" style="width:50%;height:260px;float:left;">
            <!-- 分析巴菲特学习倾向 -->
            </div>
            <div class="tableBox" id="all_chart_mind" style="width:50%;height:260px;float:left;"></div>
            <div class="tableBox" id="curr_chart_ability" style="width:50%;height:260px;float:left;"></div>
            <div class="tableBox" id="all_chart_ability" style="width:50%;height:260px;float:left;"></div>
            </div>
        </div>
    </div>
  </body>
</html>
