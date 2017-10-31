//获得优惠券张数
function getCount(){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"couponsManager.do?action=getCouponsCount",
		success:function(json){
			listCouponsPage(new Number(json));
		}
	});
}
//页数显示
var pageNo;
var pageSize;
function listCouponsPage(count){
	$("#page").pagination({
		total : count, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 5, 10, 20 ],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + count + ' 条记录',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageNo = pageNumber;
			pageSize = pageSize;
			listCoupons(pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
//优惠券列表
function listCoupons(pageNo,pageSize){
	$("#listCoupons").datagrid({
		title:"优惠券列表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"couponsManager.do?action=listCoupons&pageNo="+pageNo+"&pageSize="+pageSize,
		//sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'faceValue',
		        	  title:'面值',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },{
		        	  field:'account',
		        	  title:'账号',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2
		          },{
		        	  field:'password',
		        	  title:'密码',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2
		          },{
		        	  field:'createDate',
		        	  title:'生成时间',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString();
		        	  }
		          },{
		        	  field:'validDate',
		        	  title:'到期时间',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var validDate = new Date(value);
		        		  if(new Date()>validDate){
		        			  return "<span style='color:red;'>"+validDate.toLocaleString()+"</span>";
		        		  }else{
		        			  return "<span style='color:green;'>"+validDate.toLocaleString()+"</span>";
		        		  }
		        	  }
		          },{
		        	  field:'status',
		        	  title:'使用状态',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value=="0"){
		        			  return "未使用";
		        		  }else{
		        			  return "已使用";
		        		  }
		        	  }
		          },{
		        	  field:'id',
		        	  title:'操作',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(new Date()>new Date(rec.validDate)){
		        			  return "无效";
		        		  }
		        		  return "<div style='cursor:pointer'><a onclick=disableCoupon("+value+")><span style='color:blue'>设为无效</span></a></div>";
		        	  }
		          }
		          ]],
		          toolbar:"#couTools"
	});
}
//设为无效
function disableCoupon(id){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"couponsManager.do?action=updateCoupons&id="+id,
		success:function(json){
			if(json){
				alert("该优惠券已设为无效！");
				listCoupons(1,10);
			}
		}
	});
}

//新增窗口
function showAddWindow(){
	document.getElementById("addCouWindow").style.display="";
	$("#addCouWindow").window({
		title : "增加优惠券窗口",
		width : 240,
		height : 200,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
function saveCoupon(){
	var faceValue = document.getElementById("faceValue").value;
	var aleph = document.getElementById("aleph").value;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"couponsManager.do?action=addCoupons&faceValue="+faceValue+"&aleph="+aleph,
		success:function(json){
			if(json){
				alert("新的优惠券已生成并保存成功！");
				$("#addCouWindow").window("close");
				getCount();
				listCoupons(1,10);
			}else{
				alert("优惠券生成保存失败，请重试！");
			}
		}
	});
}

//搜索优惠券
function searchCoupons(){
	var faceValue = document.getElementById("FV").value;
	var account = document.getElementById("account").value;
	var status = document.getElementById("status").value;
	getSCount();
	listSCoupons(faceValue,account,status,1,10);
}

//获得查询数目
function getSCount(){
	var faceValue = document.getElementById("FV").value;
	var account = document.getElementById("account").value;
	var status = document.getElementById("status").value;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"couponsManager.do?action=getCouponsCount&account="+account+"&status="+status+"&faceValue="+faceValue,
		success:function(json){
			listSCouponsPage(faceValue,account,status,new Number(json));
		}
	});
}
var pageSNo;
var pageSSize;
function listSCouponsPage(faceValue,account,status,count){
	$("#page").pagination({
		total : count, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 5, 10, 20 ],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + count + ' 条记录',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageSNo = pageNumber;
			pageSSize = pageSize;
			listSCoupons(faceValue,account,status,pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
function listSCoupons(faceValue,account,status,pageNo,pageSize){
	$("#listCoupons").datagrid({
		title:"优惠券列表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"couponsManager.do?action=listCoupons&account="+account+"&status="+status+"&faceValue="+faceValue
		                          +"&pageNo="+pageNo+"&pageSize="+pageSize,
		//sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'faceValue',
		        	  title:'面值',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },{
		        	  field:'account',
		        	  title:'账号',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2
		          },{
		        	  field:'password',
		        	  title:'密码',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2
		          },{
		        	  field:'createDate',
		        	  title:'生成时间',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString();
		        	  }
		          },{
		        	  field:'validDate',
		        	  title:'到期时间',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var validDate = new Date(value);
		        		  if(new Date()>validDate){
		        			  return "<span style='color:red;'>"+validDate.toLocaleString()+"</span>";
		        		  }else{
		        			  return "<span style='color:green;'>"+validDate.toLocaleString()+"</span>";
		        		  }
		        	  }
		          },{
		        	  field:'status',
		        	  title:'使用状态',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value=="0"){
		        			  return "未使用";
		        		  }else{
		        			  return "已使用";
		        		  }
		        	  }
		          },{
		        	  field:'id',
		        	  title:'操作',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(new Date()>new Date(rec.validDate)){
		        			  return "无效";
		        		  }
		        		  return "<div style='cursor:pointer'><a onclick=disableCoupon("+value+")><span style='color:blue'>设为无效</span></a></div>";
		        	  }
		          }
		          ]]
	});
}
