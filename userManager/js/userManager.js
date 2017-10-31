 //解决IE7中的new Date问题
function parseDate(dateStringInRange) {  
   var dateExp = /^\s*(\d{4})-(\d\d)-(\d\d)\s*$/,  
       date = new Date(NaN), month,  
       parts = dateExp.exec(dateStringInRange);  
  
   if(parts) {  
     month = +parts[2];  
     date.setFullYear(parts[1], month - 1, parts[3]);  
     if(month != date.getMonth() + 1) {  
       date.setTime(NaN);  
     }  
   }  
   return date;  
 }
// 获取用户总记录数
function getUserCount() {
		$.ajax({
			type : "post",
			dataType : "json",
			url : "userManager.do?action=getUserCount",
			success : function(json) {
				listUserPage(new Number(json));
			}
		});
}
// 用户分页
var pageS;
var pageN;
function listUserPage(uCount) { // 分页
	$('#aa').pagination({
		total : uCount, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 5, 10, 20 ],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + uCount + ' 条记录',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageN = pageNumber;
			pageS = pageSize;
			listUser(pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
//用户数据表生成
function listUser(pageNo, pageSize) {
	$('#lisUser')
			.datagrid(
					{
						title : '用户列表',
						fit : false,
						fitColumns : true,
						nowrap : true,
						autoRowHeight : false,
						collapsible : false,// 是否可折叠的
						striped : true,
						url : "userManager.do?action=listUser&pageNo="
								+ pageNo + "&pageSize=" + pageSize,
						sortName : 'id',
						remoteSort : false,
						idField : 'id', // 指定那些字段时标识字段
						rownumbers : true,// 行号
						pagination : false,// 是否显示底部分页工具栏
						singleSelect:true,
						columns : [[
								{
									field : 'userName',
									title : '登录账号',
									width : 160,
									align : 'center',
									rowspan : 2
								},{
									field : 'realName',
									title : '真实姓名',
									width : 160,
									align : 'center',
									rowspan : 2
								},{
									field : 'nickName',
									title : '网络昵称',
									width : 160,
									align : 'center',
									rowspan : 2
								},{
									field : 'roleUsers',
									title : '角色',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter:function(value,rec,index){
										  var rus="";
										  for(var i=0;i<value.length;i++){
											  if(i>0&&i!=value.length){
												  rus=rus+'&';
											  }
											  rus=rus+value[i].role.roleName;
										  }
										  return rus;
									}
								},{
									field : 'sex',
									title : '性别',
									width : 160,
									align : 'center',
									rowspan : 2
								},{
									field : 'mobile',
									title : '手机号码',
									width : 160,
									align : 'center',
									rowspan : 2
								},{
									field : 'qq',
									title : 'QQ号码',
									width : 160,
									align : 'center',
									rowspan : 2
								},{
									field : 'birthday',
									title : '生日',
									width : 160,
									align : 'center',
									rowspan : 2
								},{
									field : 'schoolName',
									title : '学校名称',
									width : 160,
									align : 'center',
									rowspan : 2
								},{
									field : 'endDate',
									title : '到期时间',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value, rec) {
										if(value == undefined){
											value = "";
										}else{
											var endDate = parseDate(value.substring(0,10).replace('/\-/g','/'));
											var date = new Date();
											if(date.getTime()>endDate.getTime()){
												return "<span style='color:red;'>"+value+"</span>";
											}
										}
										return "<span style='color:green;'>"+value+"</span>";
									}
								},{
									field : 'id',
									title : '操作',
									width : 160,
									align : 'center',
									rowspan : 2,
									formatter : function(value,rec){
										return "<div style='cursor:pointer'><a onclick=showExtendWindow("+value+",'"+rec.userName+"','"
										             +rec.endDate+"')><span style='color:blue'>编辑</span></a></div>";
									}
								}
							 ] ],
							 toolbar : '#userTool'
					});
}
//延长使用期限
function showExtendWindow(id,username,endDate){
	document.getElementById("id").value = id;
	document.getElementById("username").value = username;
	$("#endDate").datebox('setValue',endDate);
	document.getElementById("extendWindow").style.display = "";
	$("#extendWindow").window({
		title : "延长期限窗口",
		width : 240,
		height : 180,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
function extend(){
	var id = document.getElementById("id").value;
	var endDate = $("#endDate").datebox('getValue');
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"userManager.do?action=extend&id="+id+"&endDate="+encodeURIComponent(endDate),
		success:function(json){
			if(json){
				alert("您已成功延长该用户的使用期限！");
				window.location.reload(true);
			}
		}
	});
}
//获取角色列表
function getAllRoleList(roleID,roleDiv){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"roleUser.do?action=getAllRole",
        success:function (json){
        	showRoleList(json,roleID,roleDiv);
        }
    });
}
//显示学校列表
function showRoleList(list,roleID,roleDiv){
	var t='<span>角色</span><select id="'+roleID+'" style="width:100px;">';
	var options = '<option value="0">请选择角色</option>';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
			if(i == 0){
				 options +=  "<option value='"+list[i].id+"'>"+list[i].roleName+"</option>";
			}else{
				 options +=  "<option value='"+list[i].id+"'>"+list[i].roleName+"</option>";
			}
		}
	}
	var h='</select> ';
	$('#'+roleDiv).html(t+options+h);
}
//条件获取用户总记录数
function getOptionUserCount() {
	var userName = $("#uName").val();
	var realName = $("#relName").val();
	var schoolID = $("#sID").val();
	var roleID = $("#roleID").val();
	$("#lisUser").empty();
		$.ajax({
			type : "post",
			dataType : "json",
			url : "userManager.do?action=listByOptionCount&userName="+encodeURIComponent(userName)+"&realName="+encodeURIComponent(realName)+"&schoolID="+schoolID+"&roleID="+roleID,
			success : function(json) {
				listOptionUserPage(userName,realName,schoolID,roleID,new Number(json));
			}
		});
		searchUser(userName,realName,schoolID,roleID,1,10);
}
// 条件用户分页
var pageSp;
var pageNp;
function listOptionUserPage(userName,realName,schoolID,roleID,uCount) { // 分页
	$('#aa').pagination({
		total : uCount, // 记录总数
		pageSize : 10,
		pageNumber : 1, // 初始加载的页数
		pageList : [ 5, 10, 20 ],
		loading : false,
		showPageList : true,
		showRefresh : true,
		beforePageText : '第',
		afterPageText : '页，共{pages}页',
		displayMsg : '共 ' + uCount + ' 条记录',
		showRefresh : false,// 是否显示刷新按钮
		onSelectPage : function(pageNumber, pageSize) {
			pageNp = pageNumber;
			pageSp = pageSize;
			searchUser(userName,realName,schoolID,roleID,pageNumber, pageSize);
			$(this).pagination('loaded');
		}
	});
}
//条件查询用户信息
function searchUser(userName,realName,schoolID,roleID,pageNumber, pageSize){
	$('#lisUser').datagrid(
			{
				title : '用户列表',
				fit : false,
				fitColumns : true,
				nowrap : true,
				autoRowHeight : false,
				collapsible : false,// 是否可折叠的
				striped : true,
				url : "userManager.do?action=listByOption&userName="+encodeURIComponent(userName)+"&realName="+encodeURIComponent(realName)+"&schoolID="+schoolID+"&roleID="+roleID+"&pageNo="+ pageNumber + "&pageSize=" + pageSize,
				sortName : 'id',
				remoteSort : false,
				idField : 'id', // 指定那些字段时标识字段
				rownumbers : true,// 行号
				pagination : false,// 是否显示底部分页工具栏
				singleSelect:true,
				columns : [[
						{
							field : 'userName',
							title : '登录账号',
							width : 160,
							align : 'center',
							rowspan : 2
						},{
							field : 'realName',
							title : '真实姓名',
							width : 160,
							align : 'center',
							rowspan : 2
						},{
							field : 'nickName',
							title : '网络昵称',
							width : 160,
							align : 'center',
							rowspan : 2
						},{
							field : 'roleUsers',
							title : '角色',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter:function(value,rec,index){
								  var rus="";
								  for(var i=0;i<value.length;i++){
									  if(i>0&&i!=value.length){
										  rus=rus+'&';
									  }
									  rus=rus+value[i].role.roleName;
								  }
								  return rus;
							}
						},{
							field : 'sex',
							title : '性别',
							width : 160,
							align : 'center',
							rowspan : 2
						},{
							field : 'mobile',
							title : '手机号码',
							width : 160,
							align : 'center',
							rowspan : 2
						},{
							field : 'qq',
							title : 'QQ号码',
							width : 160,
							align : 'center',
							rowspan : 2
						},{
							field : 'birthday',
							title : '生日',
							width : 160,
							align : 'center',
							rowspan : 2
						},{
							field : 'schoolName',
							title : '学校名称',
							width : 160,
							align : 'center',
							rowspan : 2
						},{
							field : 'endDate',
							title : '到期时间',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter : function(value, rec) {
								if(value == undefined){
									value = "";
								}else{
									var endDate = parseDate(value.substring(0,10).replace('/\-/g','/'));
									var date = new Date();
									if(date.getTime()>endDate.getTime()){
										return "<span style='color:red;'>"+value+"</span>";
									}
								}
								return "<span style='color:green;'>"+value+"</span>";
							}
						},{
							field : 'id',
							title : '操作',
							width : 160,
							align : 'center',
							rowspan : 2,
							formatter : function(value,rec){
								return "<div style='cursor:pointer'><a onclick=showExtendWindow("+value+",'"+rec.userName+"','"
					             +rec.endDate+"')><span style='color:blue'>编辑</span></a></div>";
							}
						}
					 ] ],
					 toolbar : '#userTool'
			});
}
// 地址定位
function showAddress(provinceLocation,cityLocation,countyView,townView,prov,city,county,town){
    init(provinceLocation,cityLocation,countyView,townView,prov,city,county,town);
}
//学校信息窗口
function shouSchool(){
	showAddress(remote_ip_info["province"],remote_ip_info["city"],"","","prov","city","county","town");
	document.getElementById("SchoolWindow").style.display = "";
	$('#SchoolWindow').window({
		title : "学校信息",
		width : 450,
		height : 200,
		collapsible : false,
		minimizable : false,
		maximizable : false,
		resizable : false,
		modal : true
	});
}
//获取学校列表
function getSchoolList(){
	var province = encodeURIComponent(getId("prov").value);
	var city = encodeURIComponent(getId("city").value);
	var county = encodeURIComponent(getId("county").value);
	var townObj = getId("town");
	var town = 0;
	if(townObj == null){
		town = 0;
	}else{
		town = encodeURIComponent(townObj.value);
	}
	var schoolType = encodeURIComponent(getId("schoolType").value);	
	var newUrl = "&prov="+province+"&city="+city+"&county="+county+"&town="+town+"&schoolType="+schoolType;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getSchoolList"+newUrl,
        success:function (json){
        	schoolList(json);
        }
    });
}
function schoolList(list){
	var schoolType = getId("schoolType").value;	
	var t='学校名称:<select id="schoolID" style="width:100px;">';
  	var f='<option value="0">请选择学校</option>';
  	var options = "";
  	if(schoolType == "小学"){
  		options = "<option value='-1'>其他学校(小学)</option>";
  	}else if(schoolType == "初中"){
  		options = "<option value='-2'>其他学校(初中)</option>";
  	}else if(schoolType == "高中"){
  		options = "<option value='-3'>其他学校(高中)</option>";
  	}
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].schoolName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectSchoolWindowDiv').html(t+f+options+h);
}
//关闭学校信息窗口
function closeSchoolWindow(){
	$('#SchoolWindow').window('close');
}
//选择学校信息
function SubmitSchool(){
	var sID = $("#schoolID option:selected").val();
	var sName = $("#schoolID option:selected").text();
    if(sID==0){
    	alert("请选择学校!");
    	return;
    }
	$("#schName").val(sName);
	$("#sID").val(sID);
	$('#SchoolWindow').window('close');
}
//清空学校条件
function clearSchool(){
	$("#schName").val("");
	$("#sID").val("");
	$('#SchoolWindow').window('close');
}
//查看所有的用户信息
function allUser(){
	listUser(1,10);
	getUserCount();
}
