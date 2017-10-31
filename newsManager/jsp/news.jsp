<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>新闻公告管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="Module/newsManager/js/news.js"></script>
	<script type="text/javascript">
		var editor_content;
		function editTextBox(){
			editor_content = new baidu.editor.ui.Editor( {
				initialFrameWidth : 750,
				initialFrameHeight : 240,
				wordCount:true,
				textarea : 'description'
			});
			editor_content.render("myEditor_content");
		}
		$(function load(){
			getNewsCount();
			listNews(1,10);
			editTextBox();
		});
	
	</script>

  </head>
  
  <body>
    <div title="新闻公告管理" style="padding:10px;height:500px">
    	<table id="newslist"></table>
    	<div id="page" style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
    </div>
    
    <!-- 工具栏 -->
    <div id="newsTool" style="display:none">
    	<a id="addNews" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="showAddWindow()">新增</a>
    	新闻类型：<select id="typeS">
    				<option value="0">请选择新闻类型</option>
    	         	<option value="时事新闻">时事新闻</option>
    	         	<option value="通知公告">通知公告</option>
    	         </select>
    	是否热点：<select id="hotFlagS">
    				<option value="-1">请选择</option>
    			 	<option value="0">否</option>
    			 	<option value="1">是</option>	
    			 </select>
    	发布人：<input type="text" id="addUser">
    	<a id="searchNews" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchNews()">搜索</a>
    </div>
    
    <!-- 添加新闻窗口 -->
    <div id="addNewsWin" style="display:none">
    	新闻标题：<input type="text" id="title"><br>
    	新闻类型：<select id="type">
    	         	<option value="时事新闻">时事新闻</option>
    	         	<option value="通知公告">通知公告</option>
    	         </select><br>
    	新闻内容：<div id="myEditor_content"></div>
    	是否热点：<select id="hotFlag">
    			 	<option value="0">否</option>
    			 	<option value="1">是</option>	
    			 </select><br><br>
    	<input type="button" id="save" value="保存" onclick="addNews()">
    </div>
    
    <!-- 编辑新闻窗口 -->
    <div id="updateNewsWin" style="display:none">
    	<input type="hidden" id="newsId">
    	新闻标题：<input type="text" id="oldTitle"><br>
    	新闻内容：<textarea rows="10" cols="60" id="oldContent"></textarea><br>
    	是否热点：<select id="oldHotFlag">
    			 	<option value="0">否</option>
    			 	<option value="1">是</option>	
    			 </select><br><br>
    	<input type="button" id="submit" value="提交" onclick="updateNews()">
    </div>
  </body>
</html>
