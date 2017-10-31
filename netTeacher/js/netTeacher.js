//获取导师学生总记录数
function getNTSCount() {
		$.ajax({
			type : "post",
			dataType : "json",
			url : "netTeacherStudent.do?action=getNTSCount",
			success : function(json) {
				listNTSPage(new Number(json));
			}
		});
}
// 导师学生分页
var pageSts;
var pageNts;
function listNTSPage(ntsCount) { // 分页
	$('#bb').pagination({
		total : ntsCount, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 5, 10, 20 ],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + ntsCount + ' 条记录',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageNts = pageNumber;
			pageSts = pageSize;
			listNTS(pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
//导师学生分页数据
function listNTS(pageNo, pageSize) {
	$('#listnts')
			.datagrid(
					{
						title : '导师学生列表',
						fit : false,
						fitColumns : true,
						nowrap : true,
						autoRowHeight : false,
						collapsible : false,// 是否可折叠的
						striped : true,
						url : "netTeacherStudent.do?action=listNTS&pageNo="
								+ pageNo + "&pageSize=" + pageSize,
						sortName : 'id',
						remoteSort : false,
						idField : 'id', // 指定那些字段时标识字段
						rownumbers : true,// 行号
						pagination : false,// 是否显示底部分页工具栏
						singleSelect:true,
						columns : [[
								{
									field : 'teacher',
									title : '导师用户名',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.teacher.user.username;
									}
								},{
									field : 'user',
									title : '学生用户名',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.username;
									}
								},{
									field : 'schoolType',
									title : '学段',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.teacher.schoolType;
									}
								},{
									field : 'subName',
									title : '学科',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.teacher.subject.subName;
									}
								},{
									field : 'endDate',
									title : '到期时间',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										var end = rec.endDate;
										var endDate=end.substr(0,end.length-2);
										var cDate = new Date();
										var currentDate = cDate.format("yyyy-MM-dd hh:mm:ss");
										if(dateCompare(currentDate,endDate)){
											return "<span style='color:red;'>"+endDate+"</span>";
										}
										return "<span style='color:green ;'>"+endDate+"</span>";
									}
								},{
									field : 'id',
									title : '操作',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value,rec){
										return '<div style="cursor:pointer"><a onclick=editWindow('+value+','+rec.bindFlag+',"'+rec.addDate.substring(0,10)+'","'
										    +rec.endDate.substring(0,10)+'")><span style="color:blue">编辑</span></a></div>';
									}
								}
								] ],
								toolbar : '#ntstoolbar'
					});
}

//编辑窗口
function editWindow(ntsId,bindFlag,addDate,endDate){
	document.getElementById("ntsId").value=ntsId;
	document.getElementById("bindFlag").value=bindFlag;
	$("#bindTime").datebox('setValue',addDate);
	$("#dueTime").datebox('setValue',endDate);
	document.getElementById("editWindow").style.display="";
	$('#editWindow').window({
		title : "编辑绑定关系",
		width : 280,
		height : 220,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
function closeEditWindow(){
	$("#editWindow").window("close");
}
//保存编辑内容
function saveEdit(){
	var ntsId = document.getElementById("ntsId").value;
	var bindFlag = document.getElementById("bindFlag").value;
	var bindTime = $("#bindTime").datebox('getValue');
	var dueTime = $("#dueTime").datebox('getValue');
	if(bindFlag==""){
		alert("请填写绑定状态！");
	}else{
		$.ajax({
			type:"post",
			dataType:"json",
			url:"netTeacherStudent.do?action=saveEdit&ntsId="+ntsId+"&bindFlag="+bindFlag+"&bindTime="+bindTime+"&dueTime="+dueTime,
			success:function(json){
				if(json==true){
					alert("编辑内容保存成功！");
					closeEditWindow();
					getNTSCount();
		    		listNTS(1,10);
				}else{
					alert("编辑内容保存失败，请重试！");
				}
			}
		});
	}
}
//网络导师的总记录数
function getNTCount() {
	$.ajax({
		type : "post",
		dataType : "json",
		url : "netTeacher.do?action=getNTCount",
		success : function(json) {
			listNTPage(new Number(json));
		}
	});
}
//网络导师分页
var pageSnt;
var pageNnt;
function listNTPage(ntCount) { // 分页
	$('#aa').pagination({
		total : ntCount, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 5, 10, 20 ],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + ntCount + ' 条记录',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageNnt = pageNumber;
			pageSnt = pageSize;
			listNT(pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
//网络导师分页数据
function listNT(pageNo, pageSize) {
	$('#listnt')
			.datagrid(
					{
						title : '导师列表',
						fit : false,
						fitColumns : true,
						nowrap : true,
						autoRowHeight : false,
						collapsible : false,// 是否可折叠的
						striped : true,
						url : "netTeacher.do?action=listNetTeacher&pageNo="
								+ pageNo + "&pageSize=" + pageSize,
						sortName : 'id',
						remoteSort : false,
						idField : 'id', // 指定那些字段时标识字段
						rownumbers : true,// 行号
						pagination : false,// 是否显示底部分页工具栏
						singleSelect:true,
						columns : [[
								{
									field : 'username',
									title : '账号',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.username;
									}
								},{
									field : 'nickname',
									title : '昵称',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.nickname;
									}
								},{
									field : 'realname',
									title : '真实姓名',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.realname;
									}
								},{
									field : 'sex',
									title : '性别',
									width : 40,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.sex;
									}
								},{
									field : 'mobile',
									title : '手机号码',
									width : 150,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.mobile;
									}
								},{
									field : 'qq',
									title : 'QQ',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.qq;
									}
								},{
									field : 'subject',
									title : '科目',
									width : 80,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.subject.subName;
									}
								},
								{
									field : 'lastLoginDate',
									title : '最后登录时间',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.lastLoginDate;
									}
								},{
									field : 'id',
									title : '操作',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return '<div style="cursor:pointer"><a onclick=showDetail("'+rec.user.realname+'","'+rec.user.nickname+'","'+rec.user.mobile+'",'+rec.baseMoney+','+rec.teachMoney+')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/tip.png"/><span style="color:blue">查看详情</span></a>&nbsp;&nbsp;<a onclick=showUpdateNetTeacher('+value+','+rec.teachMoney+','+rec.user.id+',"'+rec.user.realname+'","'+rec.user.nickname+'","'+rec.user.mobile+'")><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png"/><span style="color:blue">编辑</span></a></div>';
									}
								}
							 ] ]
					});
}
//显示所有导师学生
function showallNTS(){
	getNTSCount();
	listNTS(1,10);
}
//网络导师的总记录数(用于导师学生关系)
function getNTC() {
	$.ajax({
		type : "post",
		dataType : "json",
		url : "netTeacher.do?action=getNTCount",
		success : function(json) {
			listNTP(new Number(json));
		}
	});
}
//网络导师分页(用于导师学生关系)
var pageSTont;
var pageNTont;
function listNTP(ntC) { // 分页
	$('#toru').pagination({
		total : ntC, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 10 ],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + ntC + ' 条记录',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageNTont = pageNumber;
			pageSTont = pageSize;
			listNToRU(pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
//网络导师分页数据(用于导师学生关系)
function listNToRU(pageNo, pageSize) {
	$('#nttoru')
			.datagrid(
					{
						title : '导师列表',
						fit : false,
						fitColumns : true,
						nowrap : true,
						autoRowHeight : false,
						collapsible : false,// 是否可折叠的
						striped : true,
						url : "netTeacher.do?action=listNetTeacher&pageNo="
								+ pageNo + "&pageSize=" + pageSize,
						sortName : 'id',
						remoteSort : false,
						idField : 'id', // 指定那些字段时标识字段
						rownumbers : true,// 行号
						pagination : false,// 是否显示底部分页工具栏
						singleSelect:true,
						frozenColumns:[[
							{field:'ck',checkbox:true},
							]],
						columns : [[{
									field : 'user',
									title : '导师用户名',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.username;
									}
								},{
									field : 'schoolType',
									title : '学段',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.schoolType;
									}
								},{
									field : 'subName',
									title : '科目',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.subject.subName;
									}
								}
							 ] ],
							 onLoadSuccess:function(row){
								 $('#nttoru').datagrid('selectRow',0);
							  },
							onSelect:function (rowIndex,rowData){
								var selected = $('#nttoru').datagrid('getSelected');
								var nID=selected.id;
								listByRU(1, 10,nID);
								getRUByroleIDCount(nID);
							}
					});
}

//根据角色编号获取角色用户总记录数
function getRUByroleIDCount(ntID) {
	$.ajax({
		type : "post",
		dataType : "json",
		url : "roleUser.do?action=getRidCount&ntID="+ntID,
		success : function(json) {
			listRUByRoleIDPage(new Number(json),ntID);
		}
	});
}
//据角色编号获取角色用户分页
var pageSByru;
var pageNByru;
function listRUByRoleIDPage(byruCount,ntID) { // 分页
	$('#byru').pagination({
		total : byruCount, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 10],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + byruCount + ' 条',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageNByru = pageNumber;
			pageSByru = pageSize;
			listByRU(pageNumber, pageSize,ntID);
			$(this).pagination('loaded');
		}
	});
}
//据角色编号获取角色用户分页数据
function listByRU(pageNo, pageSize,nID) {
	$('#listbyru').datagrid(
					{
						title : '学生列表',
						fit : false,
						fitColumns : true,
						nowrap : true,
						autoRowHeight : false,
						collapsible : false,// 是否可折叠的
						striped : true,
						url : "roleUser.do?action=listRoleUserByroleID&pageNo="
								+ pageNo + "&pageSize=" + pageSize+"&ntID="+nID,
						sortName : 'id',
						remoteSort : false,
						idField : 'id', // 指定那些字段时标识字段
						rownumbers : true,// 行号
						pagination : false,// 是否显示底部分页工具栏
						singleSelect:false,
						frozenColumns:[[
							 {field:'ck',checkbox:true},
							   ]],
						columns : [[
								{
									field : 'userID',
									title : '用户编号',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.id;
									}
								},{
									field : 'userName',
									title : '用户名称',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										return rec.user.username;
									}
								}
							 ] ]
					});
	}
//显示添加导师学生窗口
function showAddTS(){
	document.getElementById("addTSWindow").style.display = "";
	$('#addTSWindow').window({
		title : "添加导师学生",
		width : 900,
		height : 425,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
//添加导师学生关系
function addts(){
	var selected = $('#nttoru').datagrid('getSelected');
	var nID=selected.id;
	var ids = [];
	var rows = $('#listbyru').datagrid('getSelections');
	if(rows==""){
		alert("请选择一名学生!");
	}else{
		for(var i=0;i<rows.length;i++){
			var sID=rows[i].user.id;
			$.ajax({
				type : "post",
				async : false,
				dataType : "json",
				url : 'netTeacherStudent.do?action=addNTS&nID=' + nID+"&sID="+sID,
				success : function(json) {
					if (json) {
						listNTS(1,10);
					} else {
						alert('信息保存失败，请重试！');
					  }
					}
				});
			}
			$('#addTSWindow').window('close');
	}
}
//网路导师窗口
function showUpdateNetTeacher(nID,tMoney,uID,rName,nName,mob){
	document.getElementById("nID").value=nID;
	document.getElementById("uID").value=uID;
	document.getElementById("rName").value=rName;
	document.getElementById("nName").value=nName;
	document.getElementById("mob").value=mob;
	document.getElementById("tMoney").value=tMoney;
	document.getElementById("editNetTeacherWindow").style.display = "";
	$('#editNetTeacherWindow').window({
		title : "编辑导师信息",
		width : 300,
		height : 200,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
//编辑网路导师
function editNetTeacher(){
	var nID=document.getElementById("nID").value;
	var uID=document.getElementById("uID").value;
	var realname=encodeURIComponent(document.getElementById("rName").value);
	var nickname=encodeURIComponent(document.getElementById("nName").value);
	var mobile=document.getElementById("mob").value;
	var teachMoney=document.getElementById("tMoney").value;
	 $.ajax({
         type: "post",
         async: false,
         dataType: "json",
         url: 'netTeacher.do?action=modifyNetTeacher&nID=' + nID + '&uID=' + uID + '&realname=' + realname + '&nickname=' + nickname + '&mobile=' + mobile + '&teachMoney=' + teachMoney,
         success: function (json) {
             if (json) {
                 $('#editNetTeacherWindow').window('close');
                 listNT(1, 10);
             } else {
                 alert('信息保存失败，请重试！');
             }
         }
     });
}
//查看网路导师信息详情
function showDetail(rName,nName,mobile,bMoney,tMoney){
	document.getElementById("rName_detail").value=rName;
	document.getElementById("nName_detail").value=nName;
	document.getElementById("mob_detail").value=mobile;
	document.getElementById("bMoney_detail").value=bMoney;
	document.getElementById("tMoney_detail").value=tMoney;
	document.getElementById("showDetailWindow").style.display = "";
	$('#showDetailWindow').window({
		title : "导师详情",
		width : 300,
		height : 200,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
//关闭编辑网路导师窗口
function closeNetTeacherEditWindow(){
	$('#editNetTeacherWindow').window('close');
}
//根据导师名称查询学生总记录数
function searchNtos(){
	var username=document.getElementById("cg").value;
	$.ajax({
		type:"post",
		dataType: "json",
		url:"netTeacherStudent.do?action=getNtoSCount&uName="+encodeURIComponent(username),
		success: function(json){
			PageNtoS(username,new Number(json));
		}
	});
	listNtoS(username,1, 10);
}
//根据导师名称查询学生分页
var pageS_NtoS;
var pageN_NtoS;
function PageNtoS(username,NtoSCount){
	
	$('#bb').pagination({
		total : NtoSCount, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 5, 10, 20 ],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + NtoSCount + ' 条记录',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageN_NtoS = pageNumber;
			pageS_NtoS = pageSize;
			listNtoS(username,pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
//根据导师名称查询学生数据表
function listNtoS(username,pageNo, pageSize){
	$('#listnts')
	.datagrid(
			{
				title : '导师学生列表',
				fit : false,
				fitColumns : true,
				nowrap : true,
				autoRowHeight : false,
				collapsible : false,// 是否可折叠的
				striped : true,
				url : "netTeacherStudent.do?action=listByusername&uName="+encodeURIComponent(username)+"&pageNo="
						+ pageNo + "&pageSize=" + pageSize,
				sortName : 'id',
				remoteSort : false,
				idField : 'id', // 指定那些字段时标识字段
				rownumbers : true,// 行号
				pagination : false,// 是否显示底部分页工具栏
				singleSelect:true,
				columns : [[
						{
							field : 'teacher',
							title : '导师用户名',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter : function(value, rec) {
								return rec.teacher.user.username;
							}
						},{
							field : 'schoolType',
							title : '学段',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter : function(value, rec) {
								return rec.teacher.schoolType;
							}
						},{
							field : 'subName',
							title : '学科',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter : function(value, rec) {
								return rec.teacher.subject.subName;
							}
						},{
							field : 'user',
							title : '学生用户名',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter : function(value, rec) {
								return rec.user.username;
							}
						},{
							field : 'endDate',
							title : '到期时间',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter : function(value, rec) {
								var end = rec.endDate;
								var endDate=end.substr(0,end.length-2);
								var cDate = new Date();
								var currentDate = cDate.format("yyyy-MM-dd hh:mm:ss");
								if(dateCompare(currentDate,endDate)){
									return "<span style='color:red;'>"+endDate+"</span>";
								}
								return "<span style='color:green ;'>"+endDate+"</span>";
							}
						},{
							field : 'id',
							title : '操作',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter : function(value,rec){
								return '<div style="cursor:pointer"><a onclick=editWindow('+value+','+rec.bindFlag+',"'+rec.addDate.substring(0,10)+'","'
							         +rec.endDate.substring(0,10)+'")><span style="color:blue">编辑</span></a></div>';
							}
						}
					 ] ]
			});
}

//测试生产导师报表(没用)
function exportExcel(){
	 $.ajax({
         type: "post",
         async: false,
         dataType: "json",
         url: 'netTeacher.do?action=exportExcel',
         success: function (json) {
            alert("测试成功");
         }
     });
}

//未审核关系列表(申请绑定)
function getUncheckCount(){
	var bindFlag = 0;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=getUncheckCount&bindFlag="+ bindFlag,
		success:function(json){
			listUncheckNTSPage(new Number(json));
		}
	});
}
var pageNoUC;
var pageSizeUC;
function listUncheckNTSPage(uncheckCount){
	$("#cc").pagination({
		total:uncheckCount,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10,20],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+uncheckCount+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageNoUC = pageNumber;
			pageSizeUC = pageSize;
			listUncheckNTS(pageNumber,pageSize);
			$(this).pagination('loaded');
		}
	});
}

function listUncheckNTS(pageNo,pageSize){
	var bindFlag = 0;
	$("#listBind").datagrid({
		title:"未审核导师学生绑定列表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"netTeacherStudent.do?action=listUncheckNTS&pageNo="+pageNo+"&pageSize="+pageSize+"&bindFlag="+ bindFlag,
		sortName:"id",
		remoteSort:false,
		idField:"id",
		rowNumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:"teacher",
		        	  title:"导师用户名",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.teacher.user.username;
		        	  }
		          },
		          {
		        	  field:"user",
		        	  title:"学生用户名",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.username;
		        	  }
		          },
		          {
		        	  field:"addDate",
		        	  title:"申请时间",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2
		          },
		          {
		        	  field:"bindFlag",
		        	  title:"审核状态",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value=="0"){
		        			  return "未审核";
		        		  }
		        	  }
		          },
		          {
		        	  field:"id",
		        	  title:"操作",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return '<div style="cursor:pointer"><a onclick=checkBind('+value+',"'+rec.teacher.user.username+'","'+rec.user.username
		        		  +'","'+rec.addDate.substring(0,10)+'","'+rec.endDate.substring(0,10)
		        		  +'")><span style="color:blue">审核</span></a></div>';
		        	  }
		          }
		          ]],
		          toolbar:"#bindTool"
	});
}

//条件查询关系列表
function getCountByOption(){
	var ntName = document.getElementById("ntName").value;
	var stuName = document.getElementById("stuName").value;
	var startDate = $("#startDate").datebox('getValue');
	var endDate = $("#endDate").datebox('getValue');
	var bindFlag = 0;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=getCountByOption&ntName="+encodeURIComponent(ntName)+"&stuName="+encodeURIComponent(stuName)+"&startDate="+startDate
		            +"&endDate="+endDate+"&bindFlag="+bindFlag,
		success:function(json){
			listNTSByOptionPage(ntName,stuName,startDate,endDate,new Number(json));
		}
	});
}
var pageNoTSB;
var pageSizeTSB;
function listNTSByOptionPage(ntName,stuName,startDate,endDate,ntsCount){
	$("#cc").pagination({
		total:ntsCount,
		pageSize:10,
		pageNumber:1,
		pageList:[5,10],
		loading:false,
		showPageList:true,
		showRefresh:true,
		beforePageText:'第',
		afterPageText:'页，共{pages}页',
		displayMsg:'共'+ntsCount+'条记录',
		showRefresh:false,
		onSelectPage:function(pageNumber,pageSize){
			pageNoTSB = pageNumber;
			pageSizeTSB = pageSize;
			listNTSByOption(ntName,stuName,startDate,endDate,pageNumber,pageSize);
			$(this).pagination("loaded");
		}
	});
}
function listNTSByOption(ntName,stuName,startDate,endDate,pageNo,pageSize){
	var bindFlag = 0;
	$("#listBind").datagrid({
		title:"未审核导师学生绑定列表",
		fit:false,
		fitColumns:true,
		nowrap:true,
		autoRowHeight:false,
		collapsible:false,
		striped:true,
		url:"netTeacherStudent.do?action=listNTSByOption&ntName="+encodeURIComponent(ntName)+"&stuName="+encodeURIComponent(stuName)+"&startDate="+startDate+"&endDate="+endDate
		                      +"&pageNo="+pageNo+"&pageSize="+pageSize+"&bindFlag="+bindFlag,
		sortName:"id",
		remoteSort:false,
		idField:"id",
		rowNumbers:true,
		pagination:false,
		singleSelect:true,
		columns:[[
		          {
		        	  field:"teacher",
		        	  title:"导师用户名",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.teacher.user.username;
		        	  }
		          },
		          {
		        	  field:"user",
		        	  title:"学生用户名",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return rec.user.username;
		        	  }
		          },
		          {
		        	  field:"addDate",
		        	  title:"申请时间",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2
		          },
		          {
		        	  field:"bindFlag",
		        	  title:"审核状态",
		        	  width:160,
		        	  align:"center",
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  if(value=="0"){
		        			  return "未审核";
		        		  }
		        	  }
		          },
		          {
		        	  field:"id",
		        	  title:"操作",
		        	  width:160,
		        	  align:'center',
		        	  rowspan:2,
		        	  formatter:function(value,rec){
		        		  return '<div style="cursor:pointer"><a onclick=checkBind('+value+',"'+rec.teacher.user.username+'","'+rec.user.username+'","'
		        		          +rec.addDate.substring(0,10)+'","'+rec.endDate.substring(0,10)
		        		          +'")><span style="color:blue">审核</span></a></div>';
		        	  }
		          }
		          ]]
	});
}
function searchNTS(){
	var ntName = document.getElementById("ntName").value;
	var stuName = document.getElementById("stuName").value;
	var startDate = $("#startDate").datebox('getValue');
	var endDate = $("#endDate").datebox('getValue');
	if(startDate==""&&endDate!=""){
		alert("请选择起始日期！");
	}else{
		getCountByOption();
		listNTSByOption(ntName,stuName,startDate,endDate,1,10);
	}
}
function checkBind(id,ntName,stuName,addDate,endDate){
	document.getElementById("bindId").value=id;
	document.getElementById("bindNT").value=ntName;
	document.getElementById("student").value=stuName;
	document.getElementById("applyTime").value=addDate;
	document.getElementById("endTime").value=endDate;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=checkPeriod&addDate="+addDate+"&ntsId="+id+"&endDate="+endDate,
		success:function(json){
			if(json){
				alert("该未审核绑定已过期，请重新申请！");
				window.location.reload(true);
			}else{
				document.getElementById("checkBindWindow").style.display="";
				$("#checkBindWindow").window({
					title:"绑定关系审核",
					width:300,
					height:240,
					collapsible:false,
					minimizable:false,
					maximizable:false,
					resizable:false,
					modal:true
				});
			}
		}
	});
}
function closeWindow(){
	$("#checkBindWindow").window("close");
}
function bindSuccess(){
	var ntsId = document.getElementById("bindId").value;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=updateBindFlag&ntsId="+ntsId,
		success:function(json){
			if(json){
				//window.location.reload(true);
				getUncheckCount();
	    		listUncheckNTS(1,10);
	    		closeWindow();
			}else{
				alert("审核过程中更新数据库信息失败，请重新审核！");
			}
		}
	});
}
//格式化日期时间
Date.prototype.format = function(format){
    var o = {
        "M+" : this.getMonth()+1, //month
        "d+" : this.getDate(), //day
        "h+" : this.getHours(), //hour
        "m+" : this.getMinutes(), //minute
        "s+" : this.getSeconds(), //second
        "q+" : Math.floor((this.getMonth()+3)/3), //quarter
        "S" : this.getMilliseconds() //millisecond
    }
    if(/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    }
    for(var k in o) {
        if(new RegExp("("+ k +")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
        }
    }
    return format;
}
//日期时间的比较
function dateCompare(date1,date2){
	date1 = date1.replace(/\-/gi,"/");
	date2 = date2.replace(/\-/gi,"/");
	var time1 = new Date(date1).getTime();
	var time2 = new Date(date2).getTime();
	if(time1 > time2){
		return true;
	}else if(time1 < time2){
		return false;
	}
}
