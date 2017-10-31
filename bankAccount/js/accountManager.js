//获取网络导师银行账户列表
function getAccountCount(){
	$.ajax({
		type:"post",
		dataType:"json",
		url:"netTeacher.do?action=getNTCount",
		success:function(json){
			listAccountPage(new Number(json));
		}
	});
}
var pageANo;
var pageASize;
function listAccountPage(count){
	$("#netAcc").pagination({
		total:count,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+count+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageANo=pageNumber;
			pageASize=pageSize;
			listAccount(pageNumber,pageSize);
			$(this).pagination("loaded");
		}
	});
}
function listAccount(pageNo,pageSize){
	$("#accounts").datagrid({
		title:'账户列表',
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"netTeacher.do?action=listNetTeacher&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'username',
		        	  title:'用户名',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.username;
		        	  }
		          },
		          {
		        	  field:'realname',
		        	  title:'导师姓名',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.realname;
		        	  }
		          },
		          {
		        	  field:'bankName',
		        	  title:'银行名称',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'bankNumber',
		        	  title:'银行账号',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          }
		          ]],
		          toolbar:"#accTool"
	});
}
function getACountByUser(){
	var username = document.getElementById("username").value;
	var realname = document.getElementById("realname").value;
	$.ajax({
		type:"post",
		dataType:"json",
		url:"bankAccountManager.do?action=getACountByUser&username="+encodeURIComponent(username)+"&realname="+encodeURIComponent(realname),
		success:function(json){
			listAccPageByUser(username,realname,new Number(json));
		}
	});
}
var pageNoU;
var pageSizeU;
function listAccPageByUser(username,realname,count){
	$("#netAcc").pagination({
		total:count,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+count+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageANo=pageNumber;
			pageASize=pageSize;
			listAccountByUser(username,realname,pageNumber,pageSize);
			$(this).pagination("loaded");
		}
	});
}
function listAccountByUser(username,realname,pageNo,pageSize){
	$("#accounts").datagrid({
		title:'账户列表',
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"bankAccountManager.do?action=listAccountByUser&username="+encodeURIComponent(username)+"&realname="+encodeURIComponent(realname)+"&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'username',
		        	  title:'用户名',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.username;
		        	  }
		          },
		          {
		        	  field:'realname',
		        	  title:'导师姓名',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.realname;
		        	  }
		          },
		          {
		        	  field:'bankName',
		        	  title:'银行名称',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'bankNumber',
		        	  title:'银行账号',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          }
		          ]]
	});
}
function searchAcc(){
	var username = document.getElementById("username").value;
	var realname = document.getElementById("realname").value;
	getACountByUser();
	listAccountByUser(username,realname,1,10);
}

//提现申请审核
function getTxCount(){
	$.ajax({
		type:"post",
		dataType:"json",
		url:"bankAccountManager.do?action=getNttrCount",
		success:function(json){
			listNttrPage(new Number(json));
		}
	});
}
var pageTxNo;
var pageTxSize;
function listNttrPage(txCount){
	$("#tx").pagination({
		total:txCount,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+txCount+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageTxNo=pageNumber;
			pageTxSize = pageSize;
			listNTTR(pageNumber,pageSize);
			$(this).pagination("loaded");
		}
	});
}
function listNTTR(pageNo,pageSize){
	$("#txCheck").datagrid({
		title:'提现申请列表',
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"bankAccountManager.do?action=listNTTR&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'netTeacher',
		        	  title:'提现申请人',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.netTeacher.user.username;
		        	  }
		          },
		          {
		        	  field:'txMoney',
		        	  title:'提现金额',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'txDate',
		        	  title:'提现日期',
		        	  width:300,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString();
		        	  }
		          },
		          {
		        	  field:'operator',
		        	  title:'审核人',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.realname;
		        	  }
		          },
		          {
		        	  field:'txOperateDate',
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
		        	  field:'txStatus',
		        	  title:'支付状态',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value==0){
		        			  return "未支付";
		        		  }else{
		        			  return "已支付";
		        		  } 
		        	  }
		          },
		          {
		        	  field:'id',
		        	  title:'审核',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(rec.txStatus==1){
		        			  return "已审核";
		        		  }else{
		        			  return '<div style="cursor:pointer"><a onclick=txCheck('+value+')><span style="color:blue">审核</span></a></div>'; 
		        		  }
		        		  
		        	  }
		          }
		          ]],
		          toolbar:"#txTool"
	});
}
//审核
function txCheck(id){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"bankAccountManager.do?action=updateNTTR&id="+id,
		success:function(json){
			if(json){
				alert("已审核，请立即支付提现金额！");
				getTxCount();
				listNTTR(1,10);
			}else{
				alert("审核过程中更新相关信息时出现错误，请重试！");
			}
		}
	});
}
//条件查询提现信息
function getTxCountByOptions(){
	var ntName = document.getElementById("ntName").value;
	var startTxDate = $("#startTxDate").datebox('getValue');
	var endTxDate = $("#endTxDate").datebox('getValue');
	var operator = document.getElementById("operator").value;
	var txStatus = document.getElementById("txStatus").value;
	$.ajax({
		type:"post",
		dataType:"json",
		url:"bankAccountManager.do?action=getTxCountByOptions&ntName="+encodeURIComponent(ntName)+"&startTxDate="+startTxDate+"&endTxDate="+endTxDate+"&operator="
		                                      +encodeURIComponent(operator)+"&txStatus="+txStatus,
		success:function(json){
			listTxPageByOptions(ntName,startTxDate,endTxDate,operator,txStatus,new Number(json));
		}
	});
}
var pageTxNoByOP;
var pageTxSizeByOP;
function listTxPageByOptions(ntName,startTxDate,endTxDate,operator,txStatus,txCount){
	$("#tx").pagination({
		total:txCount,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+txCount+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageTxNoByOP=pageNumber;
			pageTxSizeByOP = pageSize;
			listNTTRByOptions(ntName,startTxDate,endTxDate,operator,txStatus,pageNumber,pageSize);
			$(this).pagination("loaded");
		}
	});
}
function listNTTRByOptions(ntName,startTxDate,endTxDate,operator,txStatus,pageNo,pageSize){
	$("#txCheck").datagrid({
		title:'提现申请列表',
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"bankAccountManager.do?action=listNTTRByOptions&ntName="+encodeURIComponent(ntName)+"&startTxDate="+startTxDate+"&endTxDate="+endTxDate
		                               +"&operator="+encodeURIComponent(operator)+"&txStatus="+txStatus+"&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'netTeacher',
		        	  title:'提现申请人',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.netTeacher.user.username;
		        	  }
		          },
		          {
		        	  field:'txMoney',
		        	  title:'提现金额',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },
		          {
		        	  field:'txDate',
		        	  title:'提现日期',
		        	  width:300,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString();
		        	  }
		          },
		          {
		        	  field:'operator',
		        	  title:'审核人',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.realname;
		        	  }
		          },
		          {
		        	  field:'txOperateDate',
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
		        	  field:'txStatus',
		        	  title:'支付状态',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value==0){
		        			  return "未支付";
		        		  }else{
		        			  return "已支付";
		        		  } 
		        	  }
		          },
		          {
		        	  field:'id',
		        	  title:'审核',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(rec.txStatus==1){
		        			  return "已审核";
		        		  }else{
		        			  return '<div style="cursor:pointer"><a onclick=txCheck('+value+')><span style="color:blue">审核</span></a></div>'; 
		        		  }
		        		  
		        	  }
		          }
		          ]]
	});
}
//搜索函数
function searchTxRecord(){
	var ntName = document.getElementById("ntName").value;
	var startTxDate = $("#startTxDate").datebox('getValue');
	var endTxDate = $("#endTxDate").datebox('getValue');
	var operator = document.getElementById("operator").value;
	var txStatus = document.getElementById("txStatus").value;
	if(startTxDate==""&&endTxDate!=""){
		alert("请选择提现起始日期！");
	}else{
		getTxCountByOptions();
		listNTTRByOptions(ntName,startTxDate,endTxDate,operator,txStatus,1,10);
	}
}

//返现记录
function getNtrrCount(){
	var ntName = document.getElementById("nt").value;
	var stuName = document.getElementById("stuName").value;
	$.ajax({
		type:"post",
		dataType:"json",
		url:"bankAccountManager.do?action=getNtrrCount&ntName="+encodeURIComponent(ntName)+"&stuName="+encodeURIComponent(stuName),
		success:function(json){
			listNtrrPage(ntName,stuName,new Number(json));
		}
	});
}
var pageNo;
var pageSize;
function listNtrrPage(ntName,stuName,count){
	$("#return").pagination({
		total:count,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+count+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageNo = pageNumber;
			pageSize = pageSize;
			listNTRR(ntName,stuName,pageNumber,pageSize);
			$(this).pagination("loaded");
		}
	});
}
function listNTRR(ntName,stuName,pageNo,pageSize){
	$("#returnRecord").datagrid({
		title:"返现记录表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapisible:false,
		striped:true,
		url:"bankAccountManager.do?action=listNTRR&ntName="+encodeURIComponent(ntName)+"&stuName="+encodeURIComponent(stuName)+"&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'user',
		        	  title:'学生用户名',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.username;
		        	  }
		          },
		          {
		        	  field:'netTeacher',
		        	  title:'导师用户名',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.netTeacher.user.username;
		        	  }
		          },
		          {
		        	field:'returnMoney',
		        	title:'返现金额',
		        	width:160,
		        	align:'center',
		        	rowspan:2,
		        	formatter:function(value,rec){
		        		return value;
		        	}
		          },
		          {
		        	  field:'returnDate',
		        	  title:'返现日期',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString();
		        	  }
		          }
		          ]],
		          toolbar:"#returnTool"
	});
}
//搜索
function searchNTRR(){
	var ntName = document.getElementById("nt").value;
	var stuName = document.getElementById("stuName").value;
	getNtrrCount();
	listNTRR(ntName,stuName,pageNo,pageSize);
}

//新增返现记录
function getNewNtrrCount(){
	$.ajax({
		type:"post",
		dataType:"json",
		url:"bankAccountManager.do?action=getNewNtrrCount",
		success:function(json){
			listNewNtrrPage(new Number(json));
		}
	});
}
var pageNoNew;
var pageSizeNew;
function listNewNtrrPage(newCount){
	$("#new").pagination({
		total:newCount,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+newCount+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageNoNew = pageNumber;
			pageSizeNew = pageSize;
			listNewNTRR(pageNumber,pageSize);
			$(this).pagination("loaded");
		}
	});
}
function listNewNTRR(pageNo,pageSize){
	$("#newReturn").datagrid({
		title:"新增返现记录表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapisible:false,
		striped:true,
		url:"bankAccountManager.do?action=listNewNTRR&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'user',
		        	  title:'学生用户名',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.username;
		        	  }
		          },
		          {
		        	  field:'netTeacher',
		        	  title:'导师用户名',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.netTeacher.user.username;
		        	  }
		          },
		          {
		        	field:'returnMoney',
		        	title:'返现金额',
		        	width:160,
		        	align:'center',
		        	rowspan:2,
		        	formatter:function(value,rec){
		        		return value;
		        	}
		          },
		          {
		        	  field:'returnDate',
		        	  title:'返现日期',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString();
		        	  }
		          }
		          ]],
		          toolbar:"#addTool"
	});
}
