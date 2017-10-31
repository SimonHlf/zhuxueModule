<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>反馈信息管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css"href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="Module/callCenter/js/callCenter.js"></script>
	<script>
	 $(function load(){
		 getFeedbackCount();
		 listFeedback(1,10);
	 });
	</script>

  </head>
  
  <body>
    <div class="easyui-tabs" style="width:1000px;height:500px">
      <div title="反馈信息管理" style="padding:10px">
        <table id="feedback"></table>
        <div id="fb" style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
      </div>
    </div>
    
    <!-- 查看窗口 -->
    <div id="feedbackDiv" style="display:none">
      <br>
      <font size="2"><strong>反馈编号：</strong></font><input type="text" id="id" name="id" style="border:0px;height:20px;" readonly><br><br>
      <font size="2"><strong>用户名称：</strong></font><input type="text" id="username" name="username" style="border:0px;height:20px;" readonly><br><br>
      <font size="2"><strong>反馈类型：</strong></font><input type="text" id="backType" name="backType" style="border:0px;height:20px;" readonly><br><br>
      <font size="2"><strong>反馈标题：</strong></font><input type="text" id="title" name="title" style="border:0px;height:20px;" readonly><br><br>
      <font size="2"><strong>反馈内容：</strong></font><input type="text" id="content" name="content" style="border:0px;height:20px;" readonly>
    </div>
    
    <!-- 反馈信息工具栏 -->
    <div id="fbTool">
      <div style="float:left;" id="fbTypeDiv">
                   请选择反馈类型
       <select id="fbType">
          <option value="0">请选择反馈类型</option>
          <option value="1">意见建议</option>
          <option value="2">错误提示</option>
       </select>
      </div>
      &nbsp;&nbsp;
      <div style="float:left;" id="period">
                 请选择反馈时间
                 自<input type="text" id="startTime" class="easyui-datetimebox">至<input type="text" id="endTime" class="easyui-datetimebox">
      </div>
      &nbsp;&nbsp;
      <div style="float:left;" id="readFlag">
                   请选择阅读状态
       <select id="read">
         <option value="0">未读</option>
         <option value="1">已读</option>
       </select>
      </div>
      &nbsp;&nbsp;
      <a href="###" id="searchFb" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchFeedback()">搜索</a>
    </div>

  </body>
</html>
