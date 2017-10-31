	var EditionCount;
	var SubjectCount;
	var EducationCount;
	var GradeCount;
	// 获取出版社总记录数
	function getEditionCount() {
		$.ajax({
			type : "post",
			dataType : "json",
			url : "editionManager.do?action=getEditionCount",
			success : function(json) {
				PageEdition(new Number(json));
			}
		});
	}
	// 获取科目总记录数
	function getSubjectCount(){
		$.ajax({
			type:"post",
			dataType: "json",
			url:"subjectManager.do?action=getSubCountPage",
			success: function(json){
				PageSubject(new Number(json));
			}
		});
	}
	// 获取教材总记录数
	function getEducationCount(){
		$.ajax({
			type:"post",
			dataType: "json",
			url:"educationManager.do?action=getEducationCount",
			success: function(json){
				PageEducation(new Number(json));
			}
		});
	}
	// 获取年级总记录数
	function getGradeCount(){
		$.ajax({
			type:"post",
			dataType: "json",
			url:"gradeManager.do?action=getGradeCount",
			success: function(json){
				PageGrade(new Number(json));
			}
		});
	}
	// 出版社数据表生成
	function listEdition(pageNo, pageSize) {
		$('#listEdition')
				.datagrid(
						{
							title : '出版社列表',
							fit : false,
							fitColumns : true,
							nowrap : true,
							autoRowHeight : false,
							collapsible : false,// 是否可折叠的
							striped : true,
							url : "editionManager.do?action=listEdition&pageNo="
									+ pageNo + "&pageSize=" + pageSize,
							sortName : 'orders',
							remoteSort : false,
							idField : 'id', // 指定那些字段时标识字段
							rownumbers : true,// 行号
							pagination : false,// 是否显示底部分页工具栏
							singleSelect:true,
							columns : [

							[
									{
										field : 'ediName',
										title : '出版社名称',
										width : 160,
										align : 'center',
										rowspan : 2
									},
									{
										field : 'orders',
										title : '排序',
										width : 160,
										align : 'center',
										rowspan : 2
									},
									{
										field : 'id',
										title : '操作',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return '<div style="cursor:pointer"><a onclick=showUpdateEdition('+value+',"'+ rec.ediName+ '",'+rec.orders+')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png"/><span style="color:blue">编辑</span></a>&nbsp;&nbsp;<a onclick=delEdition('+ value
													+ ')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/no.png"/><span style="color:blue">删除</span></a></div>';
										}
									} ] ],
							toolbar : [ {
								text : '添加出版社',
								iconCls : 'icon-add',
								handler : function() {
									document.getElementById("addEditionWindow").style.display = "";
									$('#addEditionWindow').window({
										title : "添加出版社",
										width : 300,
										height : 150,
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
	// 科目数据表生成
	function listSubject(pageNo, pageSize) {
		$('#listSubject')
				.datagrid(
						{
							title : '科目列表',
							fit : false,
							fitColumns : true,
							nowrap : true,
							autoRowHeight : false,
							collapsible : false,// 是否可折叠的
							striped : true,
							url : "subjectManager.do?action=SubjectList&pageNo="
								+ pageNo + "&pageSize=" + pageSize,
							sortName : 'orders',
							remoteSort : false,
							idField : 'id', // 指定那些字段时标识字段
							rownumbers : true,// 行号
							pagination : false,// 是否显示底部分页工具栏
							singleSelect:true,
							columns : [

							[
									{
										field : 'subName',
										title : '科目名称',
										width : 160,
										align : 'center',
										rowspan : 2
									},
									{
										field : 'orders',
										title : '排序',
										width : 160,
										align : 'center',
										rowspan : 2
									},
									{
										field : 'inDisplay',
										title : '是否可见',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											if(value==0){
												return "可见";
											}
											return "不可见";
										}
									},
									{
										field : 'id',
										title : '操作',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return '<div style="cursor:pointer"><a onclick=showUpdateSubject('+value+',"'+ rec.subName+ '",'+rec.orders+','+rec.inDisplay+')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png"/><span style="color:blue">编辑</span></a>&nbsp;&nbsp;<a onclick=delSubject('+ value
													+ ')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/no.png"/><span style="color:blue">删除</span></a></div>';
										}
									} ] ],
									toolbar : [ {
										text : '添加科目',
										iconCls : 'icon-add',
										handler : function() {
											document.getElementById("addSubjectWindow").style.display = "";
											$('#addSubjectWindow').window({
												title : "添加科目",
												width : 300,
												height : 150,
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
	// 教材数据表生成
	function listEducation(pageNo, pageSize) {
		$('#listEducation')
				.datagrid(
						{
							title : '教材列表',
							fit : false,
							fitColumns : true,
							nowrap : true,
							autoRowHeight : false,
							collapsible : false,// 是否可折叠的
							striped : true,
							url : "educationManager.do?action=listEducation&pageNo="
								+ pageNo + "&pageSize=" + pageSize,
							sortName : 'orders',
							remoteSort : false,
							idField : 'id', // 指定那些字段时标识字段
							rownumbers : true,// 行号
							pagination : false,// 是否显示底部分页工具栏
							singleSelect:true,
							columns : [[
										{
										field : 'schoolType',
										title : '学校类型',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value ;
										}
									},{
										field : 'grade',
										title : '年级',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return value.gradeName;
										}
									},{
										field : 'subject',
										title : '科目',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return value.subName;
										}
									},{
										field : 'edition',
										title : '出版社',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value.ediName ;
										}
									},{
										field : 'orders',
										title : '排序',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value ;
										}
									},{
										field : 'inUse',
										title : '启用',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											if(value==0){
												return "启用";
											}
											return "未启用";
										}
									},
									{
										field : 'volume',
										title : '卷册',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value ;
										}
									},{
										field : 'id',
										title : '操作',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return '<div style="cursor:pointer"><a onclick=showUpdateEducation('+value+','+rec.inUse+',"'+rec.volume+'",'+ rec.subject.id +','+rec.grade.id+','+rec.edition.id+')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png"/><span style="color:blue">编辑</span></a></div>';
											}
										}
									 ] ],
									 toolbar : '#searchEducs'
						});
	}
	function getEducByOptionCount(){
		var educ_op_ediID=$("#editionId_option  option:selected").val();
		var educ_op_subID=$("#subIDOption  option:selected").val();
		var educ_op_gid=$("#gIdOption  option:selected").val();
		
			$.ajax({
    			type:"post",
    			dataType: "json",
    			url:"educationManager.do?action=getEducationOptionCount&subjectID="+educ_op_subID+"&gradeId="+educ_op_gid+"&editionId="+educ_op_ediID,
    			success: function(json){
    				pageEducationByOption(educ_op_ediID,educ_op_subID,educ_op_gid,new Number(json));
    			}
    		});
    		listOptionEducation(educ_op_ediID,educ_op_subID,educ_op_gid,1,10);	
		}
	function showAddEducWindow(){
		document.getElementById("addEducationWindow").style.display = "";
		$('#addEducationWindow').window({
			title : "添加教材",
			width : 400,
			height : 250,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			modal : true
		});
	}
	//条件 教材数据表生成
	function listOptionEducation(ediID,subID,gid,pageNo, pageSize) {
		$('#listEducation')
				.datagrid(
						{
							title : '教材列表',
							fit : false,
							fitColumns : true,
							nowrap : true,
							autoRowHeight : false,
							collapsible : false,// 是否可折叠的
							striped : true,
							url : "educationManager.do?action=listOptionEducation&editionId="+ediID+"&subjectID="+subID+"&gradeId="+gid+"&pageNo="
								+ pageNo + "&pageSize=" + pageSize,
							sortName : 'orders',
							remoteSort : false,
							idField : 'id', // 指定那些字段时标识字段
							rownumbers : true,// 行号
							pagination : false,// 是否显示底部分页工具栏
							singleSelect:true,
							columns : [[
										{
										field : 'schoolType',
										title : '学校类型',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value ;
										}
									},{
										field : 'grade',
										title : '年级',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return value.gradeName;
										}
									},{
										field : 'subject',
										title : '科目',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return value.subName;
										}
									},{
										field : 'edition',
										title : '出版社',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value.ediName ;
										}
									},{
										field : 'orders',
										title : '排序',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value ;
										}
									},{
										field : 'inUse',
										title : '启用',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											if(value==0){
												return "启用";
											}
											return "未启用";
										}
									},
									{
										field : 'volume',
										title : '卷册',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value ;
										}
									},{
										field : 'id',
										title : '操作',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return '<div style="cursor:pointer"><a onclick=showUpdateEducation('+value+','+rec.inUse+',"'+rec.volume+'",'+ rec.subject.id +','+rec.grade.id+','+rec.edition.id+')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png"/><span style="color:blue">编辑</span></a></div>';
											}
										}
									 ] ]
						});
	}
	// 年级数据表生成
	function listGrade(pageNo, pageSize) {
		$('#listGrade')
				.datagrid(
						{
							title : '年级科目列表',
							fit : false,
							fitColumns : true,
							nowrap : true,
							autoRowHeight : false,
							collapsible : false,// 是否可折叠的
							striped : true,
							url : "gradeManager.do?action=listGradePage&pageNo="
									+ pageNo + "&pageSize=" + pageSize,
							sortName : 'orders',
							remoteSort : false,
							idField : 'id', // 指定那些字段时标识字段
							rownumbers : true,// 行号
							pagination : false,// 是否显示底部分页工具栏
							singleSelect:true,
							columns : [

							[
									{
										field : 'gradeName',
										title : '年级名称',
										width : 160,
										align : 'center',
										rowspan : 2
									},{
										field : 'subject',
										title : '科目',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value.subName ;
										}
									},{
										field : 'schoolType',
										title : '学校类型',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value;
										}
									},{
										field : 'orders',
										title : '顺序',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value;
										}
									},{
										field : 'inDisplay',
										title : '是否可见',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											if(value==0){
												return "可见";
											}
											return "不可见";
										}
									},{
										field : 'id',
										title : '操作',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return '<div style="cursor:pointer"><a onclick=showUpdateGrade('+value+',"'+ rec.subject.id+ '","'+ rec.gradeName+ '","'+ rec.schoolType+ '",'+rec.orders+','+rec.inDisplay+')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png"/><span style="color:blue">编辑</span></a></div>';
											}
										}
									 ] ],
									 toolbar : '#searchgrade'
						});
	}
	//打开添加年级科目窗口
	function showAddGradeWindow(){
		document.getElementById("addGradeWindow").style.display = "";
		$('#addGradeWindow').window({
			title : "添加年级科目",
			width : 400,
			height : 200,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			modal : true
		});
	}
	//显示所有年级数据
	function showAllGrade(){
		getGradeCount();
		listGrade(1,10);
	}
	//根据年级名称获取年级记录数
	function getGradeByNameCount(){
		var gradeName=$("#selectGrade  option:selected").val();
		$.ajax({
			type:"post",
			dataType: "json",
			url:"gradeManager.do?action=getGradeByNameCount&gradeName="+encodeURIComponent(gradeName),
			success: function(json){
				PageGradeByName(gradeName,new Number(json));
			}
		});
		listGradeByName(gradeName,1, 10);
	}
	// 指定年级名称年级数据表生成
	function listGradeByName(gradeName,pageNo, pageSize) {
		$('#listGrade')
				.datagrid(
						{
							title : '年级科目列表',
							fit : false,
							fitColumns : true,
							nowrap : true,
							autoRowHeight : false,
							collapsible : false,// 是否可折叠的
							striped : true,
							url : "gradeManager.do?action=listGradeByNamePage&gradeName="+encodeURIComponent(gradeName)+"&pageNo="
									+ pageNo + "&pageSize=" + pageSize,
							sortName : 'orders',
							remoteSort : false,
							idField : 'id', // 指定那些字段时标识字段
							rownumbers : true,// 行号
							pagination : false,// 是否显示底部分页工具栏
							singleSelect:true,
							columns : [

							[
									{
										field : 'gradeName',
										title : '年级名称',
										width : 160,
										align : 'center',
										rowspan : 2
									},{
										field : 'subject',
										title : '科目',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value.subName ;
										}
									},{
										field : 'schoolType',
										title : '学校类型',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value;
										}
									},{
										field : 'orders',
										title : '顺序',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return  value;
										}
									},{
										field : 'inDisplay',
										title : '是否可见',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											if(value==0){
												return "可见";
											}
											return "不可见";
										}
									},{
										field : 'id',
										title : '操作',
										width : 160,
										align : 'center',
										rowspan : 2,
										formatter : function(value, rec) {
											return '<div style="cursor:pointer"><a onclick=showUpdateGrade('+value+',"'+ rec.schoolType+ '","'+ rec.gradeName+ '",'+rec.orders+','+rec.inDisplay+')><img class="icon" src="Module/commonJs/jquery-easyui-1.3.0/themes/icons/pencil.png"/><span style="color:blue">编辑</span></a></div>';
											}
										}
									 ] ]
									
						});
	}
	// 出版社分页
	var pageSedition;
	var pageNedition;
	function PageEdition(EditionCount) { // 分页
		$('#ee').pagination({
			total : EditionCount, // 记录总数
			pageSize : 10,
			pageNumber : 1, // 初始加载的页数
			pageList : [ 5, 10, 20 ],
			loading : false,
			showPageList : true,
			showRefresh : true,
			beforePageText : '第',
			afterPageText : '页，共{pages}页',
			displayMsg : '共 ' + EditionCount + ' 条记录',
			showRefresh : false,// 是否显示刷新按钮
			onSelectPage : function(pageNumber, pageSize) {
				pageNedition = pageNumber;
				pageSedition = pageSize;
				listEdition(pageNumber, pageSize);
				$(this).pagination('loaded');
			}
		});
	}
	// 科目分页
	var pageSub;
	var pageNoSub;
	function PageSubject(SubjectCount){
		$('#ss').pagination({
			total : SubjectCount, // 记录总数
			pageSize : 10,
			pageNumber : 1, // 初始加载的页数
			pageList : [ 5, 10, 20 ],
			loading : false,
			showPageList : true,
			showRefresh : true,
			beforePageText : '第',
			afterPageText : '页，共{pages}页',
			displayMsg : '共 ' + SubjectCount + ' 条记录',
			showRefresh : false,// 是否显示刷新按钮
			onSelectPage : function(pageNumber, pageSize) {
				pageNoSub = pageNumber;
				pageSub = pageSize;
				listSubject(pageNumber, pageSize);
				$(this).pagination('loaded');
			}
		});
	}
	// 教材分页
	var pageSEduc;
	var pageNoEduc;
	function PageEducation(EducationCount){
		$('#educ').pagination({
			total : EducationCount, // 记录总数
			pageSize : 10,
			pageNumber : 1, // 初始加载的页数
			pageList : [ 5, 10, 20 ],
			loading : false,
			showPageList : true,
			showRefresh : true,
			beforePageText : '第',
			afterPageText : '页，共{pages}页',
			displayMsg : '共 ' + EducationCount + ' 条记录',
			showRefresh : false,// 是否显示刷新按钮
			onSelectPage : function(pageNumber, pageSize) {
				pageNoEduc = pageNumber;
				pageSEduc = pageSize;
				listEducation(pageNumber, pageSize);
				$(this).pagination('loaded');
			}
		});
	}
	
	//根据条件分页教材
	var educSByOption;
	var educNByOption;
	function pageEducationByOption(ediID,subID,gID,educOptionCount){
		$('#educ').pagination({
			total : educOptionCount, // 记录总数
			pageSize : 10,
			pageNumber : 1, // 初始加载的页数
			pageList : [ 5, 10, 20 ],
			loading : false,
			showPageList : true,
			showRefresh : true,
			beforePageText : '第',
			afterPageText : '页，共{pages}页',
			displayMsg : '共 ' + educOptionCount + ' 条记录',
			showRefresh : false,// 是否显示刷新按钮
			onSelectPage : function(pageNumber, pageSize) {
				educNByOption = pageNumber;
				educSByOption = pageSize;
				listOptionEducation(ediID,subID,gID,pageNumber, pageSize);
				$(this).pagination('loaded');
			}
		});
	}
	
	// 年级科目分页
	var pageSGrade;
	var pageNoGrade;
	function PageGrade(GradeCount){
		$('#gg').pagination({
			total : GradeCount, // 记录总数
			pageSize : 10,
			pageNumber : 1, // 初始加载的页数
			pageList : [ 5, 10, 20 ],
			loading : false,
			showPageList : true,
			showRefresh : true,
			beforePageText : '第',
			afterPageText : '页，共{pages}页',
			displayMsg : '共 ' + GradeCount + ' 条记录',
			showRefresh : false,// 是否显示刷新按钮
			onSelectPage : function(pageNumber, pageSize) {
				pageNoGrade = pageNumber;
				pageSGrade = pageSize;
				listGrade(pageNumber, pageSize);
				$(this).pagination('loaded');
			}
		});
	}
	//根据年级名称分页
	var pageSGradeByName;
	var pageNoGradeByName;
	function PageGradeByName(gradeName,gradeByNameCount){
		
		$('#gg').pagination({
			total : gradeByNameCount, // 记录总数
			pageSize : 10,
			pageNumber : 1, // 初始加载的页数
			pageList : [ 5, 10, 20 ],
			loading : false,
			showPageList : true,
			showRefresh : true,
			beforePageText : '第',
			afterPageText : '页，共{pages}页',
			displayMsg : '共 ' + gradeByNameCount + ' 条记录',
			showRefresh : false,// 是否显示刷新按钮
			onSelectPage : function(pageNumber, pageSize) {
				pageNoGradeByName = pageNumber;
				pageSGradeByName = pageSize;
				listGradeByName(gradeName,pageNumber, pageSize);
				$(this).pagination('loaded');
			}
		});
	}
	// 关闭出版社添加窗口
	function closeEditionWindow() {
		$('#addEditionWindow').window('close');
	}
	// 关闭出版社修改窗口
	function closeEditionEditWindow(){
		$('#editEditionWindow').window('close');
	}
	// 关闭添加科目窗口
	function closeSubjectWindow(){
		$('#addSubjectWindow').window('close');
	}
	// 关闭更新科目窗口
	function closeSubjecteditWindow(){
		$('#EditSubjectWindow').window('close');
	}
	// 关闭添加年级科目窗口
	function closeGradeWindow(){
		$('#addGradeWindow').window('close');
	}
	// 关闭修改年级科目窗口
	function closeGradeEditWindow(){
		$('#editGradeWindow').window('close');
	}
	function closeeductionWindow(){
		$('#addEducationWindow').window('close');
	}
	function closeEducationEditWindow(){
		$('#editEducationWindow').window('close');
	}
	// 添加教材
	function addEducation(){
		var educ_subID=$("#subjectID2  option:selected").val();
		var educ_subText = $("#subjectID2  option:selected").text();
		var educ_gID=$("#gradeId  option:selected").val();
		var educ=$("#gradeId  option:selected").text();
		var educ_array =educ.split(":");
		var educ_ST=educ_array[0];
		var educ_eID=$("#editionId  option:selected").val();
		//var educ_orders = $('#educ_orders').val();
		var educ_in_use=document.getElementsByName("educ_in_use"); 
        for(var i=0;i<educ_in_use.length;i++) 
        { 
            if(educ_in_use[i].checked==true) 
            { 
               var in_use= educ_in_use[i].value; 
            } 
        }
    	var educ_vol=document.getElementsByName("educ_vol"); 
        for(var i=0;i<educ_vol.length;i++) 
        { 
            if(educ_vol[i].checked==true) 
            { 
               var vol= educ_vol[i].value;
               if(vol=='上册'){
            	   var educ_orders=1;
               }else{
            	   educ_orders=2;
               }
            } 
        }
        if (educ_subID == 0) {
			alert("请选择科目!");
			return;
        }
        if (educ_gID==0){
        	alert("请选择年级");
        	return;
        }
        if(educ_eID==0){
        	alert("请选择出版社");
        	return;
        }
        if(educ_orders==""){
        	alert("请填写顺序");
        	return;
        }
        if(typeof(in_use)=="undefined"){
        	alert("请选择是否启用");
        	return;
        }
        if(typeof(vol)=="undefined"){
        	alert("请选择卷册");
        	return;
        }
    	$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : 'educationManager.do?action=checkEduc&gradeID=' + educ_gID+"&subID="+educ_subID+"&ediID="+educ_eID+"&in_use="+encodeURIComponent(vol),
			success : function(json) {
				if (json) {
					alert('记录已存在,请修改!');
				} else {
					$.ajax({
						type : "post",
						async : false,
						dataType : "json",
						url : 'educationManager.do?action=addEducation&educSchoolType=' +encodeURIComponent(educ_ST)+'&subjectID='+educ_subID+'&gradeId='+educ_gID+'&editionId='+educ_eID+'&educ_orders='+educ_orders+'&educ_in_use='+in_use+'&educ_vol='+encodeURIComponent(vol)+"&educ_subText="+encodeURIComponent(educ_subText)+"&educ_gradeText="+encodeURIComponent(educ),
						success : function(json) {
							if (json) {
								$('#addEducationWindow').window('close');
								listEducation(1,10);
							} else {
								alert('信息保存失败，请重试！');
							}
						}
					});
				}
			}
    	});
	}
	//显示所有教材
	function showAllEducation(){
		getEducationCount();
		listEducation(1,10);
	}
	//修改教材
	function editEducation(){
		var educ_edit_id=$('#educID_edit').val();
		var educ_edit_subID=$("#subjectID_edit  option:selected").val();
		var educ_edit_gID=$("#gradeId_edit  option:selected").val();
		var educ=$("#gradeId_edit  option:selected").text();
		var educ_array =educ.split(":");
		var educ_edit_ST=educ_array[0];
		var educ_edit_eID=$("#editionId_edit  option:selected").val();
		var educ_in_use=document.getElementsByName("educ_in_use_edit"); 
        for(var i=0;i<educ_in_use.length;i++) 
        { 
            if(educ_in_use[i].checked==true) 
            { 
               var in_use_edit= educ_in_use[i].value; 
            } 
        }
    	var educ_vol=document.getElementsByName("educ_vol_edit"); 
        for(var i=0;i<educ_vol.length;i++) 
        { 
            if(educ_vol[i].checked==true) 
            { 
               var vol_edit= educ_vol[i].value; 
               if(vol_edit=='上册'){
            	   var educ_editorders=1;
               }else{
            	    educ_editorders=2;
               }
            } 
        }
        if (educ_edit_subID == 0) {
			alert("请选择科目!");
			return;
        }
        if (educ_edit_gID==0){
        	alert("请选择年级");
        	return;
        }
        if(educ_edit_eID==0){
        	alert("请选择出版社");
        	return;
        }
        if(educ_editorders==""){
        	alert("请填写顺序");
        	return;
        }
        function updateEducation() {
            $.ajax({
                type: "post",
                async: false,
                dataType: "json",
                url: 'educationManager.do?action=modifyEducation&educID_edit=' + educ_edit_id + '&educSchoolType_edit=' + encodeURIComponent(educ_edit_ST) + '&subjectID_edit=' + educ_edit_subID + '&gradeId_edit=' + educ_edit_gID + '&editionId_edit=' + educ_edit_eID + '&educ_orders_edit=' + educ_editorders + '&educ_in_use_edit=' + in_use_edit + '&educ_vol_edit=' + encodeURIComponent(vol_edit),
                success: function (json) {
                    if (json) {
                        $('#editEducationWindow').window('close');
                        listEducation(pageNoEduc, 10);

                    } else {
                        alert('信息保存失败，请重试！');
                    }
                }
            });
        }
        if(educ_edit_subID==gl_educ_subID&&educ_edit_gID==gl_educ_grID&&educ_edit_eID==gl_educ_ediID&&in_use_edit==gl_educ_inuse&&vol_edit==gl_educ_volume){
        	$('#editEducationWindow').window('close');
        }
        if(educ_edit_subID!=gl_educ_subID||educ_edit_gID!=gl_educ_grID||educ_edit_eID!=gl_educ_ediID||vol_edit!=gl_educ_volume){
        	 $.ajax({
      			type : "post",
      			async : false,
      			dataType : "json",
      			url : 'educationManager.do?action=checkEduc&gradeID=' + educ_edit_gID+"&subID="+educ_edit_subID+"&ediID="+educ_edit_eID+"&in_use="+encodeURIComponent(vol_edit),
      			success : function(json) {
      				if(json){
      					alert("已有记录,请修改后重试!");
      					return;
      				}else{
      					updateEducation();
      				}
      			}
        	 });
     	}else{
     		updateEducation();
     	}
	}
	// 添加出版社
	function addEdition() {
		var ediname = $('#ediName').val();
		var ordEdition = $('#ordEdition').val();
		if (ediname == "") {
			alert("出版社名称不能为空!");
			return;
		} 
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : 'editionManager.do?action=getCheckByediName&ediName=' + encodeURIComponent(ediname),
			success : function(json) {
				if(json){
					alert("出版社名称已存在!");
				}else {
					$.ajax({
						type : "post",
						async : false,
						dataType : "json",
						url : 'editionManager.do?action=addEdition&ediName=' + encodeURIComponent(ediname)
								+ '&orders=' + ordEdition,
						success : function(json) {
							if (json) {
								$('#addEditionWindow').window('close');
								listEdition(1, 10);
							} else {
								alert('信息保存失败，请重试！');
							}
						}
					});
				}
			}
		});
	}
	// 删除出版社
	function delEdition(id) {
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : 'educationManager.do?action=checkEducation&eid=' + id,
			success : function(json) {
				if (json) {
					alert('出版社ID有对应的记录,不允许删除!');
				} else {
					if (confirm("您确定要删除出版社信息!") == true) {
						$.ajax({
							type : "post",
							async : false,
							dataType : "json",
							url : 'editionManager.do?action=delEdition&eid=' + id,
							success : function(json) {
								if (json) {
									listEdition(1, 10);
								} else {
									alert('信息删除失败，请重试！');
								}
							}
						});
					}
				}
			}
		});
	}
	
	// 修改教材窗口
	//var gl_educ_orders;
	var gl_educ_inuse;
	var gl_educ_volume;
	var gl_educ_subID;
	var gl_educ_grID;
	var gl_educ_ediID;
	function showUpdateEducation(id,inuse,volume,subjectId,gradeId,editionId){
		//gl_educ_orders=orders;
		gl_educ_inuse=inuse;
		gl_educ_volume=volume;
		gl_educ_subID=subjectId;
		gl_educ_grID=gradeId;
		gl_educ_ediID=editionId;
		document.getElementById("educID_edit").value=id;
		document.getElementById("subjectID_edit").value = subjectId;
		getGradeList(null,"gradeId_edit","educgradeDiv");
		document.getElementById("gradeId_edit").value = gradeId;
		document.getElementById("editionId_edit").value = editionId;
		
		var educInUse=document.getElementsByName("educ_in_use_edit"); 
        for(var i=0;i<educInUse.length;i++) 
        { 
            if(educInUse[i].value==inuse) 
            { 
            	educInUse[i].checked=true;
            } 
        }
    	var educvol=document.getElementsByName("educ_vol_edit"); 
        for(var i=0;i<educvol.length;i++) 
        { 
            if(educvol[i].value==volume) 
            { 
            	educvol[i].checked=true;
            } 
        }
		document.getElementById("editEducationWindow").style.display = "";
		$('#editEducationWindow').window({
			title : "修改教材信息",
			width : 400,
			height : 250,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			modal : true
		});
	}
	// 修改出版社窗口
	function showUpdateEdition(id,name, orders){
		document.getElementById("ediIDedit").value=id;
		document.getElementById("ediNameEdit").value=name;
		document.getElementById("ordEditionEdit").value=orders;
		document.getElementById("editEditionWindow").style.display = "";
		$('#editEditionWindow').window({
			title : "修改出版社",
			width : 300,
			height : 150,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			modal : true
		});
	}
	// 更新出版社
	function updateEdition(){
		var id = $('#ediIDedit').val();
		var ediname = $('#ediNameEdit').val();
		var ordEdition = $('#ordEditionEdit').val();
			$.ajax({
				type : "post",
				async : false,
				dataType : "json",
				url : 'editionManager.do?action=modifyEdition&eid='+id+'&ediName=' + encodeURIComponent(ediname)
						+ '&orders=' + ordEdition,
				success : function(json) {
					if (json) {
						$('#editEditionWindow').window('close');
						listEdition(pageNedition, 10);
					} else {
						alert('信息保存失败，请重试！');
					}
				}
			});
		}
	// 添加科目
	function addSubject() {
		var subname = $('#subName').val();
		var ordsub = $('#ordSub').val();
		var inDisSubject=document.getElementsByName("inDisSub"); 
        for(var i=0;i<inDisSubject.length;i++) 
        { 
            if(inDisSubject[i].checked==true) 
            { 
               var indissub= inDisSubject[i].value; 
            } 
        }
		if (subname == "") {
			alert("科目名称不能为空!");
			return;
		} 
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : 'subjectManager.do?action=getCheckBysubName&subName=' + encodeURIComponent(subname),
			success : function(json) {
				if(json){
					alert("科目名称已存在!");
				}else {
					$.ajax({
						type : "post",
						async : false,
						dataType : "json",
						url : 'subjectManager.do?action=addSubject&subName=' + encodeURIComponent(subname)
								+ '&ordSub=' + ordsub+'&inDisSub='+indissub,
						success : function(json) {
							if (json) {
								$('#addSubjectWindow').window('close');
								listSubject(1, 10);
							} else {
								alert('信息保存失败，请重试！');
							}
						}
					});
				}
			}
		});
	}
	// 添加年级科目
	function addGrade(){
		var gNameEdit=$("#gName  option:selected").val();
		var subID=$("#subjectId  option:selected").val();
		var gstype=$("#GradeSchoolType  option:selected").val();
		var ordGrade = $('#ordGrade').val();
		var inDisGrade=document.getElementsByName("inDisGrade"); 
        for(var i=0;i<inDisGrade.length;i++) 
        { 
            if(inDisGrade[i].checked==true) 
            { 
               var indisGr= inDisGrade[i].value; 
            } 
        }
        if(gstype==0){
        	alert("请选择学校类型!");
        	return;
        }
        if (gNameEdit == 0) {
			alert("请选择年级名称!");
			return;
		} 
        if(subID==0){
        	alert("请选择科目");
        	return;
        }
        if(ordGrade==""){
        	alert("请填写顺序");
        	return;
        }
        if(typeof(indisGr)=="undefined"){
        	alert("请选择是否可见");
        	return;
        }
        else {
			$.ajax({
				type : "post",
				async : false,
				dataType : "json",
				url : 'gradeManager.do?action=addGrade&grName=' + encodeURIComponent(gNameEdit)
						+ '&subjectID=' + subID+'&grSchoolType='+encodeURIComponent(gstype)+"&grorders="+ordGrade+"&grinDis="+indisGr,
				success : function(json) {
					if (json) {
						$('#addGradeWindow').window('close');
						listGrade(1,10);
					} else {
						alert('信息保存失败，请重试！');
					}
				}
			});
		}
	}
	// 修改年级学科
	function editGrade(){
		var gID = $('#gID').val();
		var gNameEdit = $("#gNameEdit option:selected").val();
		var subID=$("#subjectID1  option:selected").val();
		var gstype=$("#GradeSType  option:selected").val();
		var ordGrade = $('#gOrdersEdit').val();
		var inDisGrade=document.getElementsByName("gInDisplayEdit"); 
        for(var i=0;i<inDisGrade.length;i++) 
        { 
            if(inDisGrade[i].checked==true) 
            { 
               var indisGr= inDisGrade[i].value; 
            } 
        }
        if(gstype==0){
        	alert("请选择学校类型!");
        	return;
        }
        if (gNameEdit == 0) {
			alert("请选择学校名称!");
			return;
		} 
        if(subID==0){
        	alert("请选择科目");
        	return;
        }
        if(ordGrade==""){
        	alert("请填写顺序");
        	return;
        }
        else {
			$.ajax({
				type : "post",
				async : false,
				dataType : "json",
				url : 'gradeManager.do?action=modifyGrade&gIDedit='+gID+'&gNameedit=' + encodeURIComponent(gNameEdit)
						+ '&sIDedit=' + subID+'&gsTypeedit='+encodeURIComponent(gstype)+"&grordersedit="+ordGrade+"&grinDisedit="+indisGr,
				success : function(json) {
					if (json) {
						$('#editGradeWindow').window('close');
						listGrade(1,10);
					} else {
						alert('信息保存失败，请重试！');
					}
				}
			});
		}
	}
	// 删除科目
	function delSubject(id) {
	if (confirm("您确定要删除出版社科目信息!") == true) {
		$.ajax({
			type : "post",
			async : false,
			dataType : "json",
			url : 'subjectManager.do?action=delSubject&subID=' + id,
			success : function(json) {
				if (json) {
					listSubject(1, 10);
				} else {
					alert('信息删除失败，请重试！');
				}
			}
		});
	}
}
	// 修改科目窗口
	function showUpdateSubject(id,name, orders,inDis){
		document.getElementById("subID").value=id;
		document.getElementById("subNameedit").value=name;
		document.getElementById("ordSubedit").value=orders;
		var inDisSubject=document.getElementsByName("gInDisplayEdit"); 
        for(var i=0;i<inDisSubject.length;i++) 
        { 
            if(inDisSubject[i].value==inDis) 
            { 
            	inDisSubject[i].checked=true;
            } 
        }
		document.getElementById("EditSubjectWindow").style.display = "";
		$('#EditSubjectWindow').window({
			title : "修改科目",
			width : 300,
			height : 150,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			modal : true
		});
	}
	// 修改年级科目窗口
	function showUpdateGrade(id ,subID,gradeName,schoolType,orders,inDisplay){
		document.getElementById("gID").value=id;
		document.getElementById("GradeSType").value=schoolType;
		document.getElementById("gNameEdit").value=gradeName;
		document.getElementById("gOrdersEdit").value=orders;
		document.getElementById("subjectID1").value=subID;
		var inDisGrade=document.getElementsByName("gInDisplayEdit"); 
        for(var i=0;i<inDisGrade.length;i++) 
        { 
            if(inDisGrade[i].value==inDisplay) 
            { 
             inDisGrade[i].checked=true;
            } 
        }
		document.getElementById("editGradeWindow").style.display = "";
		$('#editGradeWindow').window({
			title : "编辑年级科目",
			width : 400,
			height : 200,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			modal : true
		});
		
	}
	// 更新科目
function updateSubject() {
	var subid = $('#subID').val();
	var subname = $('#subNameedit').val();
	var ordSub = $('#ordSubedit').val();
	var inDisSubject=document.getElementsByName("inDisSubedit"); 
    for(var i=0;i<inDisSubject.length;i++) 
    { 
        if(inDisSubject[i].checked==true) 
        { 
           var inDisSub= inDisSubject[i].value; 
        } 
    }
	$.ajax({
		type : "post",
		async : false,
		dataType : "json",
		url : 'subjectManager.do?action=modifySubject&subID=' + subid
				+ '&subName=' + encodeURIComponent(subname) + '&ordSub=' + ordSub + '&inDisSub='
				+ inDisSub,
		success : function(json) {
			if (json) {
				$('#EditSubjectWindow').window('close');
				listSubject(pageNoSub, 10);
			} else {
				alert('信息保存失败，请重试！');
			}
		}
	});
}

// 年级列表
function gradeList(id,SelectID){
	var t= document.getElementById(id);   
    var value=t.options[t.selectedIndex].value;
	$("#"+SelectID).empty();
	$("<option value=\"0\">请选择年级</option>").appendTo($("#"+SelectID));
	if(value == "小学"){
		$("<option value='一年级'>一年级</option>").appendTo($("#"+SelectID));
		$("<option value='二年级'>二年级</option>").appendTo($("#"+SelectID));
		$("<option value='三年级'>三年级</option>").appendTo($("#"+SelectID));
		$("<option value='四年级'>四年级</option>").appendTo($("#"+SelectID));
		$("<option value='五年级'>五年级</option>").appendTo($("#"+SelectID));
		$("<option value='六年级'>六年级</option>").appendTo($("#"+SelectID));
	}else if(value == "初中"){
		$("<option value='七年级'>七年级</option>").appendTo($("#"+SelectID));
		$("<option value='八年级'>八年级</option>").appendTo($("#"+SelectID));
		$("<option value='九年级'>九年级</option>").appendTo($("#"+SelectID));
	}else if(value == "高中"){
		$("<option value='高一'>高一</option>").appendTo($("#"+SelectID));
		$("<option value='高二'>高二</option>").appendTo($("#"+SelectID));
		$("<option value='高三'>高三</option>").appendTo($("#"+SelectID));
	}
}