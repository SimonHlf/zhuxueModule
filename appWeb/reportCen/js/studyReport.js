function initWid(){
	$(".imgTabNav li").each(function(i){
		$(".imgTabNav li").eq(i).width(($(".imgTabNav").outerWidth() / 5)- 3);
		$(this).click(function(){
			$(".imgTabNav li").removeClass("active");
			$(this).addClass("active");
		});
	});
	$(".imgTabBox").height(cliHei - 60);
	$(".tableBox").height($(".imgTabBox").height() - 104);
}
function stuReport(week) {
	if(week==1){
		$(".decSpan").hide();
		$("#weeks").text("第一周");
	}
	if(week==2){
		$(".decSpan").hide();
		$("#weeks").text("第二周");
	}
	if(week==3){
		$(".decSpan").hide();
		$("#weeks").text("第三周");
	}
	if(week==4){
		$(".decSpan").show();
		$("#weeks").text("第四周");
	}
	if(week==5){
		$(".decSpan").hide();
		$("#weeks").text("");
	}
	$.ajax({
		type : "post",
		async : false,
		dataType : "json",
		data:{week:week},
		url : "reportCenterApp.do?action=getQFJson&cilentInfo=app",
		success : function(json) {
			if(json["roleName"] == "家长"){
				$("#stuInfo").html("的孩子");
			}
			var uCount = parseInt(json["ucount"]);
			var natCount = parseInt(json["natCount"]);
			$("#stuRepCount").text(uCount);
			if (uCount > natCount) {
				$("#stuRepCom").text("比全国同学学习次数高，保持努力哦！");
			} else {
				$("#stuRepCom").text("比全国同学学习次数较低，急需努力哦！");
			}
			loadChart(uCount,natCount);
		}
	});
}
   //加载echarts报表
   function loadChart(uCount,natCount){
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
			 	'echarts/chart/bar',// 使用柱状图就加载bar模块，按需加载
			 	'echarts/chart/line'// 使用曲线图就加载bar模块，按需加载
		    ],
		    function(ec){
				// 基于准备好的dom，初始化echarts图表
		    	var myChart = ec.init(document.getElementById('chart_report'),getThemes()); 
		    	// 为echarts对象加载数据 
                //myChart.setOption(getChartData("勤奋报告","知识点个数","我学习的知识点个数","全国同学学习知识点平均个数",uCount,natCount)); 
		    	if(cliWid <= 350){
		    		myChart.setOption(getChartData("勤奋报告","知识点个数","我","全国",uCount,natCount));
		    	}else if(cliWid > 351 && cliWid <= 400){
		    		myChart.setOption(getChartData("勤奋报告","知识点个数","我(知识点个数)","全国(知识点个数)",uCount,natCount));
		    	}else if(cliWid > 401 && cliWid <= 500){
		    		myChart.setOption(getChartData("勤奋报告","知识点个数","我(学习知识点个数)","全国(学习知识点个数)",uCount,natCount));
		    	}else{
		    		myChart.setOption(getChartData("勤奋报告","知识点个数","我学习的知识点个数","全国同学学习知识点平均个数",uCount,natCount));
		    	}
			});
   }
 	//统计图数据
	function getChartData(title,chartData1,xAxisData1,xAxisData2,uCount,natCount){   		
	   	 var option = {
	   				title : {
	   	   		    	x : 'center',
	   	   		        text: title
	   	   		    },
	                tooltip: {
	                    show: true
	                },
	                legend: {
	                	y : '35px',
	                    data:[chartData1]
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
	       		    calculable : true,
	       		 	xAxis : [
	         		        {
	         		            type : 'category',
	         		            axisLabel : {
	         		                show:true,
	         		                interval: 'auto',    // {number}
	         		                margin: 5,
	         		                textStyle: {
	         		                    color: '#1e90ff',
	         		                    fontFamily: 'sans-serif',
	         		                    fontSize: 12,
	         		                    fontStyle: 'normal'
	         		                }
	         		            },
	         		            data : [xAxisData1,xAxisData2]
	         		        }
	         		],
	                yAxis : [
	                    {
	                        type : 'value'
	                    }
	                ],
	                grid : {
	    		    	x : 40,
	    		    	y : 80,
	    		    	x2 : 15,
	    		    	y2 : 30
	    		    },
	                series : [
	                    {
	                        "name":chartData1,
	                        "type":"bar",
	                        //barWidth:'50',
	                        data:[uCount,natCount]
	                    }
	                ]
	            };
	   		
			return option;
	}