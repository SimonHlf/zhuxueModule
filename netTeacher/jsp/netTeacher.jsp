<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>导师管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css"href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css"href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
	<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="Module/netTeacher/js/netTeacher.js"></script>
	<script>
	//设置日期不可手动输入(导师学生绑定)
    function loadStartDate(){  
		$('#startDate').datebox( {      
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
		$('#endDate').datebox( {      
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
    
  //设置日期不可手动输入(导师学生绑定编辑)
    function loadBindTime(){  
		$('#bindTime').datebox( {      
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
    function loadDueTime(){  
		$('#dueTime').datebox( {      
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
    
		$(function load(){
			loadStartDate();
			loadEndDate();
			loadBindTime();
			loadDueTime();
			$('#tt').tabs({   
			    onSelect:function(title){
			    	if(title=='导师管理'){
			    		getNTCount();
			    		listNT(1,10);
			    	}
			    	if(title=='导师学生管理'){
			    		getNTSCount();
			    		listNTS(1,10);
			    	}
			    	if(title=='导师学生绑定'){
			    		getUncheckCount();
			    		listUncheckNTS(1,10);
			    	}
			    	
			    }
			});
			getNTC();
			listNToRU(1,10);
		});
	</script>
  </head>
  <body>
  <div id="tt" class="easyui-tabs" style="width: 1000px; height: 500px;">
			<div  title="导师管理" style="padding: 10px;">
				<table id="listnt"></table>
				<div id="aa"
					style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
			<div title="导师学生管理" style="padding: 10px;">
				<table id="listnts"></table>
				<div id="bb"
					style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
			<div title="导师学生绑定" style="padding:10px;">
			    <table id="listBind"></table>
			    <div id="cc" style="width:100%;background:#efefef;border:1px solid #ccc;"></div>
			</div>
			
		</div>
		<!-- 添加导师学生关系窗口 -->
		<div id="addTSWindow" style="display:none">
			<div style="float: left;padding: 10px;">
				<table id="nttoru" style="width: 380px"></table>
				<div id="toru" style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
			<div style="float: left;padding: 10px;">
				<table id="listbyru" style="width: 380px" class="easyui-datagrid"></table>
				<div id="byru" style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
			<div align="center">
			   <input id="addts" type="button" onclick="addts();" value="添加">
			</div>
		</div>
		<!-- 导师学生工具栏 -->
		<div id="ntstoolbar" style="display:none">
			 <input id="cg" style="width:150px" />
			 <a id="searchNtoS" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchNtos()">搜索</a>
			 <a id="allShowEduc" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-undo'"  onclick="showallNTS()" >全部</a>
			 <a id="addNts" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="showAddTS()">添加</a>
		</div>
		<!-- 编辑导师 -->
		<div id="editNetTeacherWindow"  style="display:none">
			<input id="nID" type="hidden" name="nID">
			<input id="uID" type="hidden" name="uID">
			真实姓名:<input id="rName" type="text" name="rName"><br>
			&nbsp;&nbsp;&nbsp;&nbsp;昵称:<input id="nName" type="text" name="nName"><br>
			&nbsp;&nbsp;&nbsp;&nbsp;手机:<input id="mob" type="text" name="mob"><br>
			&nbsp;&nbsp;导师价:<input id="tMoney" type="text" name="tMoney">
			<div align="center">
				<input type="button" value="确定" onclick="editNetTeacher()" />
				<input type="button" value="取消" onclick="closeNetTeacherEditWindow()" />
			</div>
		</div>
		<!-- 详情窗口 -->
		<div id="showDetailWindow" style="display: none;">
		<br>
		真实姓名:<input id="rName_detail" type="text" readonly="readonly"><br>
		&nbsp;&nbsp;&nbsp;&nbsp;昵称:<input id="nName_detail" type="text" readonly="readonly"><br>
		&nbsp;&nbsp;&nbsp;&nbsp;手机:<input id="mob_detail" type="text" readonly="readonly"><br>
		基本价格:<input id="bMoney_detail" type="text" readonly="readonly"><br>
		导师价格:<input id="tMoney_detail" type="text" readonly="readonly">
		</div>
		
		<!-- 导师学生绑定工具栏 -->
		<div id="bindTool" style="display:none;">
		  <div style="float:left;">导师用户名：<input type="text" id="ntName" name="ntName" style="width:100px;"></div>
		  <div style="float:left;">学生用户名：<input type="text" id="stuName" name="stuName" style="width:100px;"></div>
		  <div style="float:left;" id="applyDate">
		          请选择申请时间：
		           自<input type="text" id="startDate" class="easyui-datebox"> 至<input type="text" id="endDate" class="easyui-datebox" >
		  </div>
		  &nbsp;
		  <a href="###" id="searchNTS" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchNTS()">搜索</a>
		</div>
		<!-- 导师学生绑定审核窗口 -->
		<div id="checkBindWindow" style="display:none;">
		 <font size="2">绑定编号：</font> <input type="text" id="bindId" style="border:0px;height:20px;" readonly><br><br>
		 <font size="2">绑定导师：</font> <input type="text" id="bindNT" style="border:0px;height:20px;" readonly><br><br>
		 <font size="2">学生用户：</font> <input type="text" id="student" style="border:0px;height:20px;" readonly><br><br>
		 <font size="2">申请时间：</font> <input type="text" id="applyTime" style="border:0px;height:20px;" readonly><br><br>
		 <font size="2">到期时间：</font> <input type="text" id="endTime" style="border:0px;height:20px;" readonly><br><br>
		 <center><input type="button" id="bindSuccess" onclick="bindSuccess()" value="通过" 
		       style="font-family:Microsoft Yahei;color:#fff;background-color:#33c505;display:inline-block;border:none"></center>
		</div>
		 
	    <!-- 绑定编辑窗口 -->
	    <div id="editWindow" style="display:none;">
	     <font size="2">绑定关系编号：</font><input type="text" id="ntsId" style="border:0px;height:20px;" readonly><br><br>
	     <font size="2">绑定状态：</font><input type="text" id="bindFlag" style="width:80px;height:20px;"><br><br>
	     <font size="2">加入时间：</font><input type="text" id="bindTime" class="easyui-datebox"><br><br>
	     <font size="2">到期时间：</font><input type="text" id="dueTime" class="easyui-datebox"><br><br>
	     <input type="button" value="保存" onclick="saveEdit()">     
	    </div>
		
  </body>
</html>
