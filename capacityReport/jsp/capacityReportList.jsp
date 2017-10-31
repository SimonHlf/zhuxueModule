<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>questionList.jsp</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/capacityReport/css/capacityReportCss.css" type="text/css" rel="stylesheet" />
	<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
	<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript">
	//设置日期不可手动输入
    $(function(){  
		$('#startTime').datebox( {      
			currentText : '今天',      
			closeText : '关闭',      
			disabled : false,     
			required : false, 
			formatter : function(formatter){
				
			    var year = formatter.getFullYear().toString();
			    var month = (formatter.getMonth() + 1);
			    if(month < 10){
			    	month = "0"+month;
			    }
			    var day = formatter.getDate();
			    if(day < 10){
			    	day = "0"+day;
			    }
	    	  	return year+"-"+month+"-"+day;  
			}
	    });
		$(".datebox :text").attr("readonly", "readonly");
    });
    $(function(){  
		$('#endTime').datebox( {      
			currentText : '今天',      
			closeText : '关闭',      
			disabled : false,     
			required : false,          
			formatter : function(formatter){
				
			    var year = formatter.getFullYear().toString();
			    var month = (formatter.getMonth() + 1);
			    if(month < 10){
			    	month = "0"+month;
			    }
			    var day = formatter.getDate();
			    if(day < 10){
			    	day = "0"+day;
			    }
	    	  	return year+"-"+month+"-"+day;  
			}
	    });
		$(".datebox :text").attr("readonly", "readonly");
    });
    function findInfo(){
    	var subjectId = $("#subjectId").val();
    	var subjectName = $("#subjectId").find("option:selected").text();
    	//var subjectId = $("input[name='subRadio']:checked").val();
    	//var subjectName = getId("sub_"+subjectId).innerHTML;
    	
    	var startTime = $('#startTime').datebox('getValue');
    	var endTime = $('#endTime').datebox('getValue');
    	if(startTime != "" && endTime != ""){
    		if(endTime < startTime){
    			alert("结束时间不能小于开始时间!");
    		}else{
    			//查询从开始到结束日期的答题记录
        		window.location.href="capacityReportManager.do?action=load&subjectId="+subjectId+"&startTime="+startTime+"&endTime="+endTime
        				              +"&subjectName="+encodeURIComponent(subjectName);
    		}
    	}else if(startTime == "" && endTime == ""){
    		//默认查询最近7天的记录
    		var currentTime = new Date();
    		var month = currentTime.getMonth() + 1;
    		var day = currentTime.getDate();
    		if(month < 10){
		    	month = "0"+month;
		    }
    		if(day < 10){
		    	day = "0"+day;
		    }
    		var currentDate = currentTime.getFullYear() + "-" + month + "-" + day;
    		window.location.href="capacityReportManager.do?action=load&subjectId="+subjectId+"&startTime="+0+"&endTime="+currentDate
                      +"&subjectName="+encodeURIComponent(subjectName);
    	}else if(startTime != "" && endTime == ""){
    		//查询从开始时间到当前日期的答题记录
    		var currentTime = new Date();
    		var month = currentTime.getMonth() + 1;
    		var day = currentTime.getDate();
    		if(month < 10){
		    	month = "0"+month;
		    }
    		if(day < 10){
		    	day = "0"+day;
		    }
    		var currentDate = currentTime.getFullYear() + "-" + month + "-" + day;
    		window.location.href="capacityReportManager.do?action=load&subjectId="+subjectId+"&startTime="+startTime+"&endTime="+currentDate
                                   +"&subjectName="+encodeURIComponent(subjectName);
    	}else{
    		alert("请选择时间!");
    	}
    }

	</script>
  </head>
  
  <body>
  	<div class="nowPosition">
		<p><span>能</span>力报告</p>
	</div>
	<div class="capaRepWrap">
		<!-- 选择学科时间段  -->
  		<div id="option" class="optionBox">
  			<!-- 选择学科  -->
  			<div class="selSubTimeBox_1 fl">
  				<span class="selSubIcon pl"></span>
  				<div class="subBoxStud clearfix">
	  				<span id="subjectInfo" class="txtChoice">选择学科:</span>
			  		<select id="subjectId">
			  		  <c:forEach items="${requestScope.gList}" var="grade">
			  		   <option value="${grade.subject.id}" <c:out value="${grade.subject.subName==requestScope.subName?'selected':''}"/>>${grade.subject.subName}</option>
			  		  </c:forEach>
			  		</select>
  				</div>
  			</div>
  			<div class="selSubTimeBox fl">	
  				<span class="selSubIcon pr"></span>
  				<div class="timeBox fl">
	  				<span class="timeMl">从</span>&nbsp;<input type="text" id="startTime" class="easyui-datebox" value="${requestScope.startTime}"/>
				    <span class="till">至</span><input type="text" id="endTime"   class="easyui-datebox" value="${requestScope.endTime}"/>
  				</div>
			    <a href="javascript:void(0)" class="searchBtn fr" onclick="findInfo()"></a>
  			</div>
  		</div>
  		
  		<!-- 最近多少天盒子  -->
  	  	<div class="recentlyBox">最近&nbsp;${requestScope.days}&nbsp;天，您的<c:if test="${roleName == '家长'}">孩子在</c:if>&nbsp;${requestScope.subName}&nbsp;各方面的能力如下</div>

		<!--  了解 理解 应用能力  -->
		<div class="moduBox clearfix">
		  	<c:forEach items="${requestScope.result}" var="result">
		  		<!-- 了解能力  -->
		  		<div id="liaojieDiv" class="comModDiv bg1 mr">
		  			<div class="decIcon bgIcon1"></div>
		  			<div class="comInnerCon">
		  				<h3 class="abiTit titCol1">了解能力</h3>
		  				<p class="nowScore"><span>${result.score_liaojie}</span>分</p>
		  				<p class="detailTxt">理解辨析题答题数:&nbsp;&nbsp;<span>${result.number_liaojie}</span>道</p>
		  				<p class="detailTxt">解答知识点正确率:&nbsp;&nbsp;${result.success_scale_liaojie}%</p>
		  				<p class="detailTxt">助学网平均正确率:&nbsp;&nbsp;${result.all_success_scale_liaojie}%</p>
		  				<h3 class="weakTxt">${result.step_liaojie}</h3>
		  				<p class="detaWeak">${result.explain_liaojie}</p>
		  			</div>
		  		</div>
		  		<div id="lijieDiv" class="comModDiv bg2 mr">
		  			<div class="decIcon bgIcon2"></div>
		  			<div class="comInnerCon">
		  				<h3 class="abiTit titCol2">理解能力</h3>
		  				<p class="nowScore"><span>${result.score_lijie}</span>分</p>
		  			    <p class="detailTxt">理解辨析题答题数：${result.number_lijie}道</p>
    	   				<p class="detailTxt">解答知识点正确率：${result.success_scale_lijie}%</p>
    	  	 			<p class="detailTxt">助学网平均正确率：${result.all_success_scale_lijie}%</p>
    	  	 			<h3 class="weakTxt">${result.step_lijie}</h3>
		  				<p class="detaWeak">${result.explain_lijie}</p>
		  			</div>
		  		</div>
		  		<div id="yingyongDiv" class="comModDiv bg3">
		  			<div class="decIcon bgIcon3"></div>
		  			<div class="comInnerCon">
		  				<h3 class="abiTit titCol3">应用能力</h3>
		  				<p class="nowScore"><span>${result.score_yy}</span>分</p>
		  				<p class="detailTxt">理解辨析题答题数：${result.number_yy}道</p>
    	   				<p class="detailTxt">解答知识点正确率：${result.success_scale_yy}%</p>
    	  	 			<p class="detailTxt">助学网平均正确率：${result.all_success_scale_yy}%</p>
    	  	 			<h3 class="weakTxt">${result.step_yy}</h3>
		  				<p class="detaWeak">${result.explain_yy}</p>
		  			</div>
		  		</div>
		    </c:forEach> 
	    </div>
    </div>
  </body>
</html>
