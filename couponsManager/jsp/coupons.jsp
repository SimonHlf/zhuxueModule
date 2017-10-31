<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>优惠券管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="Module/couponsManager/js/coupons.js"></script>
	<script type="text/javascript">
		$(function load(){
			getCount();
			listCoupons(1,10);
		});
	</script>

  </head>
  
  <body>
    <div title="优惠券管理" style="padding:10px;height:500px">
    	<table id="listCoupons"></table>
    	<div id="page" style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
    </div>
    
    <!-- 工具栏 -->
    <div id="couTools" style="display:none">
    	<a id="addCoupon" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="showAddWindow()">新增</a>
    	面值：<input type="text" id="FV" style="width:80px">
    	账号：<input type="text" id="account" style="width:80px">
    	使用状态：<select id="status">
    				<option value="-1">请选择使用状态</option>
    				<option value="0">未使用</option>
    			    <option value="1">已使用</option>	
    			 </select>
    	<a id="searchCoupons" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchCoupons()">搜索</a>
    </div>
    
    <div id="addCouWindow" style="display:none">
    	优惠券面值：<input id="faceValue" type="text" style="width:80px"><br><br>
    	优惠券账号标识：<input id="aleph" type="text" style="width:80px"><br><br><br>
    	<input type="button" id="saveCou" onclick="saveCoupon()" value="保存">
    </div>
  </body>
</html>
