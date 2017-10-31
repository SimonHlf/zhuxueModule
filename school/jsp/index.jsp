<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>学校管理e</title>
    
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
	<script type="text/javascript" src="Module/account/registerPage/js/GlobalProvinces_main.js"></script>
	<script type="text/javascript" src="Module/account/registerPage/js/GlobalProvinces_extend.js"></script>
	<script type="text/javascript" src="Module/account/registerPage/js/jquery.citySelect.js"></script>
	<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/ecmascript"></script>
	<script type="text/javascript" src="Module/school/js/school.js"></script>
		<script type="text/javascript">
			//初始化加载
			$(function load(){
				getSchoolCount();
				listSchool(1, 10);
			
			});
		</script>
  </head>
  
  <body>
			<div title="学校管理" style="padding: 10px;width: 1000px; height: 500px;">
				<table id="listSchool"></table>
				<div id="pp"
					style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
		<%--添加学校窗口--%>
		<div id="addSchoolWindow"  style="display: none">
		<div>
			<label>学校名称:</label>
			<input id="sName" type="text" name="sName">
			<label>学校类型:</label>
			<select id="schoolType">
					<option value="小学">小学</option>
					<option value="初中">初中</option>
					<option value="高中">高中</option>
			 </select>
			 <select id="schoolType2">
					<option value="公立">公立</option>
					<option value="私立">私立</option>
					<option value="培训机构">培训机构</option>
			 </select>
		</div>
		 <br>
		   <div id="address" >
			地址: <select id="prov" name="prov">
					</select>
				<select id="city" name="city">
				</select>
				<select id="county" name="county">
				<option value="0">请选择县/区</option>
				</select>
			 </div>
			 <br>
		<div style="text-align: center;">
				<input type="button" value="确定" onclick="addSchool()" />
				<input type="button" value="取消" onclick="closeSchoolWindow()" />
			</div>
		</div>
		<%--编辑学校窗口--%>
	<div id="editSchoolWindow"  style="display: none">
		<div >
			<input id="editsID" type="hidden">
			<label>学校名称:</label>
			<input id="editsName" type="text" name="editsName">
			<label>学校类型:</label>
			<select id="schoolTypeEdit">
					<option value="小学">小学</option>
					<option value="初中">初中</option>
					<option value="高中">高中</option>
			 </select>
			  <select id="schoolType2Edit">
					<option value="公立">公立</option>
					<option value="私立">私立</option>
					<option value="培训机构">培训机构</option>
			 </select>
		</div>
		<br>
		   <div id="addressView">
			地址: <select id="provView" name="provView">
					</select>
				<select id="cityView" name="cityView">
				</select>
				<select id="countyView" name="countyView">
				<option value="0">请选择县/区</option>
				</select>
			 </div>
			 <br>
		<div style="text-align: center;">
				<input type="button" value="确定" onclick="editSchool()" />
				<input type="button" value="取消" onclick="closeSchoolEditWindow()" />
			</div>
		</div>
	</body>
</html>
