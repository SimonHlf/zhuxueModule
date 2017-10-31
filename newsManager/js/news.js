/**
 * 新闻公告后台管理
 */
function getNewsCount(){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"newsManager.do?action=getNewsCount",
		success:function(json){
			listNewsPage(new Number(json));
		}
	});
}
var pageNo;
var pageSize;
function listNewsPage(count){
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
			listNews(pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
function listNews(pageNo,pageSize){
	$("#newslist").datagrid({
		title:"新闻公告列表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"newsManager.do?action=listNews&pageNo="+pageNo+"&pageSize="+pageSize,
		//sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'title',
		        	  title:'新闻标题',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },{
		        	  field:'type',
		        	  title:'类型',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },{
		        	  field:'hotFlag',
		        	  title:'热点标识',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value=="1"){
		        			  return "热点";
		        		  } 
		        	  }
		          },{
		        	  field:'addDate',
		        	  title:'发布时间',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var addDate = new Date(value);
		        		  return addDate.toLocaleString();
		        	  }
		          },{
		        	  field:'addUser',
		        	  title:'发布人',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },{
		        	  field:"id",
		        	  title:'操作',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return "<div style='cursor:pointer'>"
		        		  		 +"<img class='icon' src='Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png'/>"
		        		         +"<a onclick=showUpdateWindow("+value+"))>"
		        		         +"<span style='color:blue'>编辑</span></a>&nbsp;"
		        		         +"<img class='icon' src='Module/commonJs/jquery-easyui-1.3.0/themes/icons/no.png'/>"
		        		         +"<a onclick=deleteNews("+value+")><span style='color:blue'>删除</span></a></div>";
		        	  }
		          }
		          ]],
		          toolbar:"#newsTool"
	});
}

//增加新闻窗口
function showAddWindow(){
	document.getElementById("addNewsWin").style.display="";
	$("#addNewsWin").window({
		title : "增加新闻窗口",
		width : 860,
		height : 500,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
function addNews(){
	var title=document.getElementById("title").value;
	var type = document.getElementById("type").value;
	var content = editor_content.getContent();
	var hotFlag = document.getElementById("hotFlag").value;
	if(title==""){
		alert("请填写新闻标题！");
	}else if(type==""){
		alert("请选择新闻类型！");
	}else if(content==""){
		alert("请填写新闻详细内容！");
	}else{
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"newsManager.do?action=addNews&title="+encodeURIComponent(title)+"&type="+encodeURIComponent(type)+"&content="
			                +encodeURIComponent(content)+"&hotFlag="+hotFlag,
			success:function(json){
				if(json){
					alert("新闻信息已成功保存！");
					$("#addNewsWin").window("close");
					//getNewsCount();
					//listNews(1,10);
					window.location.reload(true);
				}else{
					alert("新闻信息保存失败，请重新发布！");
				}
			}
		});
	}
}

//编辑
function showUpdateWindow(id,title,content,hotFlag){
	document.getElementById("newsId").value = id;
	document.getElementById("oldTitle").value = title;
	document.getElementById("oldContent").value = content;
	document.getElementById("oldHotFlag").value = hotFlag;
	document.getElementById("updateNewsWin").style.display = "";
	$("#updateNewsWin").window({
		title : "编辑新闻窗口",
		width : 560,
		height : 300,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
function updateNews(){
	var id = document.getElementById("newsId").value;
	var title = document.getElementById("oldTitle").value;
	var content = document.getElementById("oldContent").value;
	var hotFlag = document.getElementById("oldHotFlag").value;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"newsManager.do?action=updateNews&id="+id+"&title="+encodeURIComponent(title)+"&content="+encodeURIComponent(content)
		                                +"&hotFlag="+hotFlag,
		success:function(json){
			if(json){
				alert("新闻信息修改成功！");
				window.location.reload(true);
			}else{
				alert("新闻信息修改失败，请重试！");
			}
		}
	});
}

//删除
function deleteNews(id){
	if(confirm("确认删除该条新闻？")){
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"newsManager.do?action=deleteNews&id="+id,
			success:function(json){
				if(json){
					alert("新闻信息已成功删除！");
					window.location.reload(true);
				}else{
					alert("新闻删除失败，请重试！");
				}
			}
		});
	}
}

//搜索
function searchNews(){
	var type = document.getElementById("typeS").value;
	var hotFlag = document.getElementById("hotFlagS").value;
	var addUser = document.getElementById("addUser").value;
	getSNewsCount(type,hotFlag,addUser);
	listSNews(type,hotFlag,addUser,1,10);
}

function getSNewsCount(type,hotFlag,addUser){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"newsManager.do?action=getNewsCount&type="+encodeURIComponent(type)+"&hotFlag="+hotFlag+"&addUser="+encodeURIComponent(addUser),
		success:function(json){
			listSNewsPage(type,hotFlag,addUser,new Number(json));
		}
	});
}
var pageNoS;
var pageSizeS;
function listSNewsPage(type,hotFlag,addUser,count){
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
			pageNoS = pageNumber;
			pageSizeS = pageSize;
			listSNews(type,hotFlag,addUser,pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
function listSNews(type,hotFlag,addUser,pageNo,pageSize){
	$("#newslist").datagrid({
		title:"新闻公告列表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"newsManager.do?action=listNews&pageNo="+pageNo+"&pageSize="+pageSize+"&type="+encodeURIComponent(type)+"&hotFlag="+hotFlag
		                     +"&addUser="+encodeURIComponent(addUser),
		//sortName:'id',
		remoteSort:false,
		idField:'id',
		rownumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:'title',
		        	  title:'新闻标题',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },{
		        	  field:'type',
		        	  title:'类型',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },{
		        	  field:'hotFlag',
		        	  title:'热点标识',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value=="1"){
		        			  return "热点";
		        		  } 
		        	  }
		          },{
		        	  field:'addDate',
		        	  title:'发布时间',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  var addDate = new Date(value);
		        		  return addDate.toLocaleString();
		        	  }
		          },{
		        	  field:'addUser',
		        	  title:'发布人',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return value;
		        	  }
		          },{
		        	  field:"id",
		        	  title:'操作',
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return "<div style='cursor:pointer'>"
		        		  		 +"<img class='icon' src='Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png'/>"
		        		         +"<a onclick=showUpdateWindow("+value+",'"+rec.title+"','"+rec.content+"',"+rec.hotFlag+")>"
		        		         +"<span style='color:blue'>编辑</span></a>&nbsp;"
		        		         +"<img class='icon' src='Module/commonJs/jquery-easyui-1.3.0/themes/icons/no.png'/>"
		        		         +"<a onclick=deleteNews("+value+")><span style='color:blue'>删除</span></a></div>";
		        	  }
		          }
		          ]]
	});
}