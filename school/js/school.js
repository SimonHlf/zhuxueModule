var SchoolCount;
// 获取学校总记录数
	function getSchoolCount() {
		$.ajax({
			type : "post",
			dataType : "json",
			url : "schoolManager.do?action=getSchoolCount",
			success : function(json) {
				Page(new Number(json));
			}
		});
	}
	// 关闭学校添加窗口
	function closeSchoolWindow(){
		$('#addSchoolWindow').window('close');
	}
	// 关闭编辑学校窗口
	function closeSchoolEditWindow(){
		$('#editSchoolWindow').window('close');
	}
	// 学校数据表生成
	function listSchool(pageNo, pageSize) {
		$('#listSchool').datagrid(
				{
					title : '学校列表',
					iconCls : 'icon-save',
					fit : false,
					nowrap : true,
					fitColumns : true,
					autoRowHeight : false,
					collapsible : false,// 是否可折叠的
					striped : true,
					url : "schoolManager.do?action=list&pageNo=" + pageNo
							+ "&pageSize=" + pageSize,
					remoteSort : false,
					idField : 'id', // 指定那些字段时标识字段
					rownumbers : true,// 行号
					pagination : false,// 是否显示底部分页工具栏
					singleSelect:true,
					columns : [

					[ {
						field : 'schoolName',
						title : '学校名称',
						width : 160,
						align : 'center',
						rowspan : 2

					}, {
						field : 'province',
						title : '省份',
						width : 160,
						align : 'center',
						rowspan : 2

					}, {
						field : 'city',
						title : '城市',
						width : 160,
						align : 'center',
						rowspan : 2

					}, {
						field : 'county',
						title : '县/区',
						width : 160,
						align : 'center',
						rowspan : 2

					}, {
						field : 'town',
						title : '乡/镇/街道',
						width : 160,
						align : 'center',
						rowspan : 2

					}, {
						field : 'schoolType',
						title : '学校类型',
						width : 160,
						align : 'center',
						rowspan : 2

					}, {
						field : 'schoolType2',
						title : '学校类型II',
						width : 160,
						align : 'center',
						rowspan : 2

					},{
						field : 'id',
						title : '操作',
						width : 160,
						align : 'center',
						rowspan : 2,
						formatter : function(value, rec) {
							return '<div style="cursor:pointer"><a onclick=showUpdateSchool('+value+',"'+ rec.schoolName+ '","'+rec.province+'","'+ rec.city+ '","'+ rec.county+ '","'+rec.town+'","'+rec.schoolType+'")><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png"/><span style="color:blue">编辑</span></a></div>';
						}
					} ] ],
					toolbar : [ {
						text : '添加学校',
						iconCls : 'icon-add',
						handler : function() {
							showAddress(remote_ip_info["province"],remote_ip_info["city"],"","","prov","city","county","town");
							document.getElementById("addSchoolWindow").style.display = "";
							$('#addSchoolWindow').window({
								title : "添加学校",
								width : 500,
								height : 180,
								collapsible : false,
								minimizable : false,
								maximizable : false,
								resizable : false,
								modal : true
							});
						}
					} ]
				});
	}
	var pageS;
	var pageN;
	// 学校分页
	function Page(SchoolCount) { // 分页
		$('#pp').pagination({
			total : SchoolCount, // 记录总数
			pageSize : 10,
			pageNumber : 1, // 初始加载的页数
			pageList : [ 5, 10, 20 ],
			loading : false,
			showPageList : true,
			showRefresh : true,
			beforePageText : '第',
			afterPageText : '页，共{pages}页',
			displayMsg : '共 ' + SchoolCount + ' 条记录',
			showRefresh : false,// 是否显示刷新按钮
			onSelectPage : function(pageNumber, pageSize) {
				pageN = pageNumber;
				pageS = pageSize;
				listSchool(pageNumber, pageSize);
				$(this).pagination('loaded');
			}
		});
	}
	// 修改学校窗口
	function showUpdateSchool(id,sName,prov,city,county,town,schoolType){
		//$('#address').remove();
		showAddress(prov,city,county,town,"provView","cityView","countyView","townView");
		
		
		document.getElementById("editsID").value=id;
		document.getElementById("editsName").value=sName;
		document.getElementById("schoolTypeEdit").value=schoolType;
		document.getElementById("editSchoolWindow").style.display = "";
		$('#editSchoolWindow').window({
			title : "修改学校信息",
			width : 500,
			height : 180,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			modal : true
		});
	}
	// 地址定位
	function showAddress(provinceLocation,cityLocation,countyView,townView,prov,city,county,town){
	    //init(remote_ip_info["province"],remote_ip_info["city"],"","","","");
	    init(provinceLocation,cityLocation,countyView,townView,prov,city,county,town);
	}
	// 添加学校
	function addSchool(){
		var sName= document.getElementById("sName").value;
		var schoolType=$("#schoolType  option:selected").text();
		var schoolType2=$("#schoolType2  option:selected").text();
		var prov=$("#prov  option:selected").text();
		var city=$("#city  option:selected").text();
		var county=$("#county  option:selected").val();
		var town=$("#town  option:selected").val();
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : 'schoolManager.do?action=checkSchool&schoolName=' + encodeURIComponent(sName)
					+ '&prov=' + encodeURIComponent(prov)+'&city='+encodeURIComponent(city),
			success : function(json) {
				if (json) {
					alert('学校名称已经存在!');
				} else {
					if (sName == "") {
						alert("学校名称不能为空!");
					}if(county==0){
						alert("请选择县/区");
						return;
					}else {
						$.ajax({
							type : "post",
							async : false,
							dataType : "json",
							url : 'schoolManager.do?action=addSchool&schoolName=' + encodeURIComponent(sName)
									+ '&prov=' + encodeURIComponent(prov)+'&city='+encodeURIComponent(city)+'&county='+encodeURIComponent(county)+'&town='+encodeURIComponent(town)+'&schoolType='+encodeURIComponent(schoolType)+'&schoolType2='+encodeURIComponent(schoolType2),
							success : function(json) {
								if (json) {
									$('#addSchoolWindow').window('close');
									listSchool(pageN, pageS);
								} else {
									alert('信息保存失败，请重试！');
								}
							}
						});
					}
				}
			}
		});
	}
function editSchool(){
	var editsID= $("#editsID").val();
	var editsName= $("#editsName").val();
	var schoolType=$("#schoolTypeEdit  option:selected").text();
	var schoolType2=$("#schoolType2Edit  option:selected").text();
	var prov=$("#provView  option:selected").text();
	var city=$("#cityView  option:selected").text();
	var county=$("#countyView  option:selected").val();
	var town=$("#townView  option:selected").val();
	if (editsName == "") {
		alert("学校名称不能为空!");
	}if(county==0){
		alert("请选择县/区");
		return;
	}else {
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : 'schoolManager.do?action=modifySchool&sid='+editsID+'&schoolName=' + encodeURIComponent(editsName)
					+ '&prov=' +encodeURIComponent(prov)+'&city='+encodeURIComponent(city)+'&county='+encodeURIComponent(county)+'&town='+encodeURIComponent(town)+'&schoolType='+encodeURIComponent(schoolType)+'&schoolType2='+encodeURIComponent(schoolType2),
			success : function(json) {
				if (json) {
					$('#editSchoolWindow').window('close');
					listSchool(pageN, 10);
				} else {
					alert('信息保存失败，请重试！');
				}
			}
		});
	}
}