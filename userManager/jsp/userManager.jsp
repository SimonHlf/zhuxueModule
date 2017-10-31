<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>用户管理</title>
    
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
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript" src="Module/account/registerPage/js/GlobalProvinces_main.js"></script>
	<script type="text/javascript" src="Module/account/registerPage/js/GlobalProvinces_extend.js"></script>
	<script type="text/javascript" src="Module/account/registerPage/js/jquery.citySelect.js"></script>
	<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/ecmascript"></script>
	<script type="text/javascript" src="Module/userManager/js/userManager.js"></script>
	<script type="text/javascript">
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
	
		$(function load(){
			loadEndDate();
			getUserCount();
			listUser(1,10);
			getAllRoleList("roleID","roleDiv");
			getSchoolList();
		});
	</script>

  </head>
  
  <body>
   <div  title="用户管理" style="padding: 10px;">
				<table id="lisUser"></table>
				<div id="aa"
					style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
	</div>
	<!-- 用户管理工具栏 -->
		<div id="userTool" style="display:none;">
		<div style="float: left;"> 登录账户: <input type="text" id="uName" name="uName" style="width:100px;"></div>
		<div style="float: left;"> 真实姓名: <input type="text" id="relName" name="relName" style="width:100px;"></div>
		<div style="float: left;">学校名称:<input type="text" id="schName" name="schName" onclick="shouSchool()" style="width:100px;" readonly="readonly"></div>
		 <input type="hidden" id="sID">
		<div style="float: left;"  id="roleDiv"></div>
		  <a href="###" id="searchUser" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="getOptionUserCount()">搜索</a>
		  <a href="###" id="allUser" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="allUser()">全部</a>
		</div>
		<!-- 学校信息窗口 -->
		<div id="SchoolWindow"  style="display: none">
		 <div id="address" style="margin-top: 20px;margin-left: 20px" >
				地址:<select id="prov" name="prov">
					</select>
				<select id="city" name="city">
				</select>
				<select id="county" name="county">
				<option value="0">请选择县/区</option>
				</select>
			</div>
			<div id="shoolInfo" style="margin-top: 20px;margin-left: 20px">
				<div id="schoolStyle" style="float: left">
				学校类型:<select id="schoolType" onchange="getSchoolList()">
					<option value="小学">小学</option>
					<option value="初中">初中</option>
					<option value="高中">高中</option>
				</select>	
			</div>
			<div id="selectSchoolWindowDiv"  style="float: left"></div>
			</div>
			<br>
			<div style="margin-top: 20px;margin-left: 150px">
			  	<input type="button" value="确定" onclick="SubmitSchool()" />
				<input type="button" value="取消" onclick="closeSchoolWindow()" />
				<input type="button" value="清空" onclick="clearSchool()" />
			</div>
		</div>
		
		<!-- 延长用户的使用期限 -->
		<div id="extendWindow" style="display:none">
			<input type="hidden" id="id">
			用户名：<input type="text" id="username" style="boeder:0px" ><br><br>
			截止时间：<input type="text" id="endDate" class="easyui-datebox"><br><br>
			<input type="button" id="submit" value="提交" onclick="extend()">
		</div>
  </body>
</html>
