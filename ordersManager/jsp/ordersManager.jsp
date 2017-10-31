<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>用户订单管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css"href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
	<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="Module/ordersManager/js/ordersManager.js"></script>
	<script type="text/javascript">
	//设置日期不可手动输入
    function loadStartDate(){  
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
    }
    function loadEndDate(){  
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
    }
	//初始化加载
	$(function load(){
		loadStartDate();
		loadEndDate();
		getOrdersCount();
		listOrders(1,10);
	});
	
	</script>

  </head>
  
  <body>
    
     <div title="订单管理" style="padding:10px;width:1200px;height:500px">
       <table id="listOrders"></table>
       <div id="ol" style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
     </div> 
     
    <!-- 订单查询 -->
     <div id="ordersTool" style="display:none">
       <div style="float:left">订单编号：<input type="text" id="orderNo" ></div>
       <div style="float:left">用户编号：<input type="text" id="userId" style="width:100px;"></div>
       <div style="float:left">银行名称：<select id="bank" style="width:120px">
                                          <option value="0">请选择</option>
                                          <option value="支付宝">支付宝</option>
                                          <option value="中国建设银行">中国建设银行</option>
                                          <option value="中国工商银行">中国工商银行</option>
                                          <option value="中国农业银行">中国农业银行</option>
                                          <option value="中国邮政储蓄银行">中国邮政储蓄银行</option>
                                          <option value="中国银行">中国银行</option>
                                        </select>
       
       </div>
       <div style="float:left">支付状态：<select id="status">
                                          <option value="-1">请选择</option>
                                          <option value="0">未支付</option>
                                          <option value="1">已支付</option>
                                        </select>
       </div>
       <div style="float:left">请选择提交时间：自<input type="text" id="startTime" class="easyui-datebox">
                                                                                                                           至<input type="text" id="endTime" class="easyui-datebox">
       </div>
       &nbsp;
       <a href="###" id="searchOrders" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchOrders()">搜索</a>
     </div>
     
  </body>
</html>
