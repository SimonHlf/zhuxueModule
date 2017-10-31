//获取订单总数
function getOrdersCount(){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"ordersManager.do?action=getOrdersCount",
		success:function(json){
			listOrdersPage(new Number(json));
		}
	});
}
//分页
var pageNo;
var pageSize;
function listOrdersPage(ordersCount){
	$("#ol").pagination({
		total:ordersCount,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+ordersCount+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageNo = pageNumber;
			pageSize = pageSize;
			listOrders(pageNumber,pageSize);
			$(this).pagination('loaded');
		}
	});
}
//获取订单列表
function listOrders(pageNo,pageSize){
	$("#listOrders").datagrid({
		title:'订单列表',
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"ordersManager.do?action=listOrders&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[{
		        	  field:'orderNumber',
		        	  title:'订单编号',
		        	  width:240,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		return value;  
		        	  }
		          },
		          {
		        	  field:'userId',
		        	  title:'用户编号',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.userId.id;
		        	  }
		          },
		          {
		        	  field:'netTeacherId',
		        	  title:'网络导师编号',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'type',
		        	  title:'订单类型',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'bank',
		        	  title:'银行名称',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'money',
		        	  title:'付款金额',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'status',
		        	  title:'支付状态',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value=="0"){
		        			  return "未支付";
		        		  }else{
		        			  return "已支付";
		        		  } 
		        	  }
		          },
		          {
		        	  field:'addTime',
		        	  title:'提交时间',
		        	  width:300,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString();
		        	  }
		          },
		          {
		        	  field:'operateUserName',
		        	  title:'审核人员',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'operateTime',
		        	  title:'审核时间',
		        	  width:300,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value!=null){
		        			  var date = new Date(value);
			        		  return date.toLocaleString();
		        		  }
		        	  }
		          },
		          {
		        	  field:'id',
		        	  title:'操作',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(rec.status==1){
		        			  return "已审核";
		        		  }else{
		        			  return '<div style="cursor:pointer"><a onclick=checkPay('+value+')><span style="color:blue">审核</span></a></div>';
		        		  } 
		        	  }
		          }
		]],
		toolbar:"#ordersTool"
	});
}

//审核
function checkPay(orderId){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"ordersManager.do?action=updateStatus&orderId="+orderId,
		success:function(json){
			if(json){
				alert("审核成功，相关信息已更改！");
				getOrdersCount();
				listOrders(1,10);
			}
		}
	});
}

//条件查询
function getCountByOptions(){
	var orderNumber = document.getElementById("orderNo").value;
	var userId = document.getElementById("userId").value;
	var bank = document.getElementById("bank").value;
	var status = document.getElementById("status").value;
	var startTime = $("#startTime").datebox('getValue');
	var endTime = $("#endTime").datebox('getValue');
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"ordersManager.do?action=getCountByOptions&orderNumber="+orderNumber+"&userId="+userId+"&bank="+encodeURIComponent(bank)+"&status="+status
		                              +"&startTime="+startTime+"&endTime="+endTime,
		success:function(json){
			listOrdersByOptionsPage(orderNumber,userId,bank,status,startTime,endTime,new Number(json));
		}
	});
}
//条件查询分页
var pageNoByOption;
var pageSizeByOption;
function listOrdersByOptionsPage(orderNumber,userId,bank,status,startTime,endTime,ordersCount){
	$("#ol").pagination({
		total:ordersCount,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+ordersCount+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageNoByOption = pageNumber;
			pageSizeByOption = pageSize;
			listOrdersByOptions(orderNumber,userId,bank,status,startTime,endTime,pageNumber,pageSize);
			$(this).pagination('loaded');
		}
	});
}
//订单显示
function listOrdersByOptions(orderNumber,userId,bank,status,startTime,endTime,pageNo,pageSize){
	$("#listOrders").datagrid({
		title:'订单列表',
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"ordersManager.do?action=listOrdersByOptions&orderNumber="+orderNumber+"&userId="+userId+"&bank="+encodeURIComponent(bank)+"&status="+status
		            +"&startTime="+startTime+"&endTime="+endTime+"&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[{
		        	  field:'orderNumber',
		        	  title:'订单编号',
		        	  width:240,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		return value;  
		        	  }
		          },
		          {
		        	  field:'userId',
		        	  title:'用户编号',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.userId.id;
		        	  }
		          },
		          {
		        	  field:'netTeacherId',
		        	  title:'网络导师编号',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'type',
		        	  title:'订单类型',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'bank',
		        	  title:'银行名称',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'money',
		        	  title:'付款金额',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'status',
		        	  title:'支付状态',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value=="0"){
		        			  return "未支付";
		        		  }else{
		        			  return "已支付";
		        		  } 
		        	  }
		          },
		          {
		        	  field:'addTime',
		        	  title:'提交时间',
		        	  width:300,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString();
		        	  }
		          },
		          {
		        	  field:'operateUserName',
		        	  title:'审核人员',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'operateTime',
		        	  title:'审核时间',
		        	  width:300,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value!=null){
		        			  var date = new Date(value);
			        		  return date.toLocaleString();
		        		  }
		        	  }
		          },
		          {
		        	  field:'id',
		        	  title:'操作',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(rec.status==1){
		        			  return "已审核";
		        		  }else{
		        			  return '<div style="cursor:pointer"><a onclick=checkPay('+value+')><span style="color:blue">审核</span></a></div>';
		        		  }
		        	  }
		          }
		]]
	});
}

//搜索
function searchOrders(){
	var orderNumber = document.getElementById("orderNo").value;
	var userId = document.getElementById("userId").value;
	var bank = document.getElementById("bank").value;
	var status = document.getElementById("status").value;
	var startTime = $("#startTime").datebox('getValue');
	var endTime = $("#endTime").datebox('getValue');
	if(startTime==""&&endTime!=""){
		alert("请选择起始时间！");
	}else{
		getCountByOptions();
		listOrdersByOptions(orderNumber,userId,bank,status,startTime,endTime,1,10);
	}
}