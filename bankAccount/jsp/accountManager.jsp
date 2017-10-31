<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>银行账户管理</title>
    
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
	<script type="text/javascript" src="Module/bankAccount/js/accountManager.js"></script>
    <script type="text/javascript">
  
  //设置日期不可手动输入
    function loadStartDate(){  
		$('#startTxDate').datebox( {      
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
		$('#endTxDate').datebox( {      
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
    	  $("#acc").tabs({
    		  onSelect:function(title){
    			  if(title=="导师账户"){
    				  getAccountCount();
    				  listAccount(1,10);
    			  }
    			  if(title=="提现审核"){
    				  getTxCount();
    				  listNTTR(1,10);
    			  }
    			  if(title=="返现记录"){
    				  getNtrrCount();
    				  listNTRR(1,10);
    			  }
    			  if(title=="新增返现记录"){
    				  getNewNtrrCount();
    				  listNewNTRR(1,10);
    			  }
    		  }
    	  });
      });
      
      function addNTRR(){
    	  $.ajax({
    		  type:"post",
    		  async:false,
    		  dataType:"json",
    		  url:"bankAccountManager.do?action=addNTRR",
    		  success:function(json){
    			  if(json==false){
    				  alert("这个月的返现信息已添加，不能重复添加！");
    			  }else{
    				  getNewNtrrCount();
        			  listNewNTRR(1,10);
    			  }
    		  }
    	  });
      }
    </script>
  </head>
  
  <body>
   <div id="acc" class="easyui-tabs" style="width:1000px;height:500px;">
    <div title="导师账户" style="padding:10px;">
      <table id="accounts"></table>
      <div id="netAcc" style="width:100%;background:#efefef;border:1px solid #ccc;"></div>
    </div>
    <div title="提现审核" style="padding:10px;">
      <table id="txCheck"></table>
      <div id="tx" style="width:100%;background:#efefef;border:1px solid #ccc;"></div>
    </div>
    <div title="返现记录" style="padding:10px;">
      <table id="returnRecord"></table>
      <div id="return" style="width:100%;background:#efefef;border:1px solid #ccc;"></div>
    </div>
    <div title="新增返现记录" style="padding:10px;">
      <table id="newReturn"></table>
      <div id="new" style="width:100%;background:#efefef;border:1px solid #ccc;"></div>
    </div>
  </div>
  
  <!-- 查询导师账户 -->
   <div id="accTool" style="display:none">
     <div style="float:left">用户名：<input type="text" id="username" style="width:100px;"></div>
     <div style="float:left">导师姓名：<input type="text" id="realname" style="width:100px;"></div>
     &nbsp;&nbsp;
     <a href="###" id="searchAcc" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchAcc()">搜索</a>
   </div>
   
   <!-- 提现审核工具栏 -->
   <div id="txTool" style="display:none">
     <div style="float:left">提现申请人：<input type="text" id="ntName" style="width:100px;"></div>
     <div style="float:left">提现日期：
                自<input type="text" id="startTxDate" class="easyui-datebox">至<input type="text" id="endTxDate" class="easyui-datebox">
     </div>
     <div style="float:left">审核人：<input type="text" id="operator" style="width:100px;"></div>
     <div style="float:left">提现支付状态：<select id="txStatus">
                                             <option value="-1">请选择</option>
                                             <option value="0">未支付</option>
                                             <option value="1">已支付</option>
                                          </select>
     </div>&nbsp;&nbsp;
     <a href="###" id="searchTx" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchTxRecord()">搜索</a>
   </div>
   
   <!-- 返现记录工具栏 -->
   <div id="returnTool" style="display:none">
     <div style="float:left">网络导师：<input type="text" id="nt"></div>
     <div style="float:left">学生用户名：<input type="text" id="stuName"></div>
     <a href="###" id="searchRR" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="searchNTRR()">搜索</a>
   </div>
   
   <!-- 新增返现记录工具栏 -->
   <div id="addTool" style="display:none">
     <a href="###" id="addNtrr" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addNTRR()">新增</a>
   </div>
  </body>
</html>
