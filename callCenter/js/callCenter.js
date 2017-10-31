/**
 * 
 */
//反馈信息总数
function getFeedbackCount(){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"feedback.do?action=getFeedbackCount",
		success:function(json){
			listFBPage(new Number(json));
		}
	});
}
//反馈信息分页
var pageNofb;
var pageSizefb;
function listFBPage(fbCount){
	$("#fb").pagination({
		total:fbCount,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+fbCount+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageNofb = pageNumber;
			pageSizefb = pageSize;
			listFeedback(pageNumber,pageSize);
			$(this).pagination('loaded');
		}
	});
}
//反馈信息列表
function listFeedback(pageNo,pageSize){
	$("#feedback").datagrid({
		title:"反馈信息列表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"feedback.do?action=listFeedback&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:"id",
		remoteSort:false,
		idField:"id",
		rowNumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'user',
		        	  title:'客户名称',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2,
		        	  formatter:function(value,rec){
		        		  return rec.user.username;
		        	  }
		          },
		          {
		        	  field:'title',
		        	  title:'反馈标题',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2
		          },
		          {
		        	  field:'backType',
		        	  title:'反馈类型',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2
		          },
		          {
		        	  field:'addTime',
		        	  title:'反馈时间',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString().replace(/年|月/g, '-').replace(/日/g, '').replace(/上午|下午/g, '');
		        	  }
		          },
		          {
		        	  field:'readFlag',
		        	  title:'阅读标记',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2,
		        	  formatter:function(value,rec){
		        		  if(value=="0"){
		        			  return "未读";
		        		  }
		        		  return "已读";
		        	  }
		          },
		          {
		        	  field:"id",
		        	  title:'查看',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2,
		        	  formatter:function(value,rec){
		        		  return '<div style="cursor:pointer"><a onclick=showFeedback('+value+',"'+rec.user.username+'",'+rec.backType+',"'+rec.title+'","'+rec.content
		        		          +'")><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/tip.png"/><span style="color:blue">查看</span></a></div>'
		        	  }
		          }
		          ]],
		          toolbar:'#fbTool'
	});
}

//查看反馈详细信息
function showFeedback(id,username,backType,title,content){
	document.getElementById("id").value=id;
	document.getElementById("username").value=username;
	document.getElementById("backType").value=backType;
	document.getElementById("title").value=title;
	document.getElementById("content").value=content;
	document.getElementById("feedbackDiv").style.display="";
	$("#feedbackDiv").window({
		title:"反馈信息",
		width:400,
		height:300,
		collapsible:false,
		minimizable:false,
		maximizable:false,
		resizable:false,
		modal:true,
		onBeforeClose:function(){window.location.reload(true);}
	});
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"feedback.do?action=updateReadFlag&fbId="+id,
		success:function(json){
			if(json){
				
			}else{
				alert("修改该反馈信息阅读状态失败！");
			}
		}
	});
}

function getFBCountByOption(){
	var backType = document.getElementById("fbType").value;
	var startTime = $("#startTime").datetimebox('getValue');
	var endTime = $('#endTime').datetimebox('getValue');
	var readFlag = document.getElementById("read").value;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"feedback.do?action=getFBCountByOption&backType="+encodeURIComponent(backType)+"&startTime="+startTime+"&endTime="+endTime+"&readFlag="+readFlag,
		success:function(json){
			listFBPageByOption(backType,startTime,endTime,readFlag,new Number(json));
		}
	});
}
var pageNofbOption;
var pageSizefbOption;
function listFBPageByOption(backType,startTime,endTime,readFlag,fbCountOption){
	$("#fb").pagination({
		total:fbCountOption,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+fbCountOption+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageNofbOption = pageNumber;
			pageSizefbOption = pageSize;
			listFeedbackByOption(backType,startTime,endTime,readFlag,pageNumber,pageSize);
			$(this).pagination('loaded');
		}
	});
}
function listFeedbackByOption(backType,startTime,endTime,readFlag,pageNo,pageSize){
	$("#feedback").datagrid({
		title:"反馈信息列表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"feedback.do?action=listFeedbackByOption&backType="+encodeURIComponent(backType)+"&startTime="+startTime+"&endTime="+endTime+"&readFlag="+readFlag
		                                    +"&pageNo="+pageNo+"&pageSize="+pageSize,
		sortName:"id",
		remoteSort:false,
		idField:"id",
		rowNumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'user',
		        	  title:'客户名称',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2,
		        	  formatter:function(value,rec){
		        		  return rec.user.username;
		        	  }
		          },
		          {
		        	  field:'title',
		        	  title:'反馈标题',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2
		          },
		          {
		        	  field:'backType',
		        	  title:'反馈类型',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2
		          },
		          {
		        	  field:'addTime',
		        	  title:'反馈时间',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2,
		        	  formatter:function(value,rec){
		        		  var date = new Date(value);
		        		  return date.toLocaleString().replace(/年|月/g, '-').replace(/日/g, '').replace(/上午|下午/g, '');
		        	  }
		          },
		          {
		        	  field:'readFlag',
		        	  title:'阅读标记',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2,
		        	  formatter:function(value,rec){
		        		  if(value=="0"){
		        			  return "未读";
		        		  }
		        		  return "已读";
		        	  }
		          },
		          {
		        	  field:"id",
		        	  title:'查看',
		        	  width:160,
		        	  align:'center',
		        	  rowspan: 2,
		        	  formatter:function(value,rec){
		        		  return '<div style="cursor:pointer"><a onclick=showFeedback('+value+',"'+rec.user.username+'",'+rec.backType+',"'+rec.title+'","'+rec.content
		        		         +'")><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/tip.png"/><span style="color:blue">查看</span></a></div>';
		        	  }
		          }
		          ]]
	});
}
//条件搜索
function searchFeedback(){
	var backType = document.getElementById("fbType").value;
	var startTime = $("#startTime").datetimebox('getValue');
	var endTime = $('#endTime').datetimebox('getValue');
	var readFlag = document.getElementById("read").value;
	if(startTime==""&&endTime!=""){
		alert("请选择开始起始日期！");
	}else {
		getFBCountByOption();
		listFeedbackByOption(backType,startTime,endTime,readFlag,1,10);
	}
}