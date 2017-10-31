//获取科目列表
function getSubjectList(){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getSubjectList",
        success:function (json){
        	showSubjectList(json);
        }
    });
}
//显示角色列表
function showSubjectList(list){
	var t='<span>选择科目</span><select id="subjectId" class="widthSele2" onchange="getGradeList(this);">';
  	var f='<option value="0">请选择科目</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].subName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectSubjectDiv').html(t+f+options+h);
}

//根据科目获取年级列表
function getGradeList(obj){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getGradeListBySubjectId&subjectId="+obj.value,
        success:function (json){
        	showGradeList(json);
        }
    });
    //重载教材列表
	getEducationList();
	//重载章节列表
	getChapterList();
}
//显示年级列表
function showGradeList(list){
	var t='<span>选择年级</span><select id="gradeId" class="widthSele2" onchange="getEducationList();">';
  	var f='<option value="0">请选择年级</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].gradeName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectGradeDiv').html(t+f+options+h);
}
//获取教材版本列表
function getAllEditionList(){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getEditionList",
        success:function (json){
        	showEditionList(json);
        }
    });
}
//获取基础教材版本列表
function getBasicEditionList(){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getBasicEditionList",
        success:function (json){
        	showEditionList(json);
        }
    });
}
//显示教材版本列表
function showEditionList(list){
	var t='<span>选择出版社</span><select id="editionId" class="widthSele2" onchange="getEducationList();">';
  	//var f='<option value="0">请选择出版社</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].ediName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectEditionDiv').html(t+options+h);
}
//获取教材信息列表
function getEducationList(){
	var subjectId = getId("subjectId").value;
	var gradeId = getId("gradeId").value;
	var editionId = getId("editionId").value;
	var newUrl = "&subjectId="+subjectId+"&gradeId="+gradeId+"&editionId="+editionId;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getEducationList"+newUrl,
        success:function (json){
        	showEducationList(json);
        }
    });
    //重载章节列表
	getChapterList();
}
//显示教材信息列表
function showEducationList(list){
	var loreName = $("#showChapterDiv").html();
	if(loreName != null){
		var t='<span>选择教材</span><select id="educationId" class="widthSele2">';
	}else{
		var t='<span>选择教材</span><select id="educationId" class="widthSele2" onchange="getChapterList();">';
	}
	
  	var f='<option value="0">请选择教材</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].volume+"</option>";
		}
	}
	var h='</select> ';
	$('#selectEducationDiv').html(t+f+options+h);
}
//获取章节列表
function getChapterList(){
	var educationId = getId("educationId").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getChapterListByEducationId&educationId="+educationId,
        success:function (json){
        	showChapterList(json);
        }
    });
}
//显示章节列表
function showChapterList(list){
	var loreName = $("#loreName").html();
	if(loreName != null){
		var t='<span>选择章节</span><select id="chapterId" class="widthSele1" onchange="getLoreList();">';
	}else{
		var t='<span>选择章节</span><select id="chapterId" class="widthSele2">';
	}
  	var f='<option value="0">请选择章节</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].chapterName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectChapterDiv').html(t+f+options+h);
}
//获取知识典列表
function getLoreList(){
	var chapterId = getId("chapterId").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getLoreListByChapterId&chapterId="+chapterId,
        success:function (json){
        	showLoreList(json);
        }
    });
}
//显示知识典列表
function showLoreList(list){
	var t='<span>选择知识典</span><select id="loreId" class="seleListWidth">';
  	var f='<option value="0">请选择知识典</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].loreName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectLoreDiv').html(t+f+options+h);
}

//--------------------------------------第二组----------------------------------------------//

//获取科目列表
function getSubjectList1(flag){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getSubjectList",
        success:function (json){
        	showSubjectList1(json,flag);
        }
    });
}
//显示角色列表
function showSubjectList1(list,flag){
	if(flag){
		var t='<span>选择科目</span><select id="subjectId1" class="widthSele2" onchange="getGradeList1('+flag+');">';	
	}else{
		var t='<span>选择科目</span><select id="subjectId1" class="widthSele2" disabled>';
	}
  	var f='<option value="0">请选择科目</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].subName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectSubjectDiv1').html(t+f+options+h);
}

//根据科目获取年级列表
function getGradeList1(flag){
	var subjectId = getId("subjectId1").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getGradeListBySubjectId&subjectId="+subjectId,
        success:function (json){
        	showGradeList1(json,flag);
        }
    });
	if(flag){
		//重载教材列表
		getEducationList1(flag);
		//重载章节列表
		getChapterList1(flag);
		//重载知识典列表
		getLoreList1();
	}
}
//显示年级列表
function showGradeList1(list,flag){
	if(flag){
		var t='<span>选择年级</span><select id="gradeId1" class="widthSele2" onchange="getEducationList1('+flag+');">';
	}else{
		var t='<span>选择年级</span><select id="gradeId1" class="widthSele2" disabled>';
	}
  	var f='<option value="0">请选择年级</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].gradeName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectGradeDiv1').html(t+f+options+h);
}
//获取教材版本列表
function getAllEditionList1(flag){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getEditionList",
        success:function (json){
        	showEditionList1(json,flag);
        }
    });
}
//获取基础教材版本列表
function getBasicEditionList1(flag){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getBasicEditionList",
        success:function (json){
        	showEditionList1(json,flag);
        }
    });
}
//获取除通用版以外的其他版本
function getOtherEditionList1(flag){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getEditionList",
        success:function (json){
        	showOtherEditionList1(json,flag);
        }
    });
}
//显示教材版本列表
function showEditionList1(list,flag){
	if(flag){
		var t='<span>选择出版社</span><select id="editionId1" class="widthSele2" onchange="getEducationList1('+flag+');">';
	}else{
		var t='<span>选择出版社</span><select id="editionId1" class="widthSele2" disabled>';
	}
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].ediName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectEditionDiv1').html(t+options+h);
}
//显示除通用版以外的教材版本列表
function showOtherEditionList1(list,flag){
	if(flag){
		var t='<span>选择出版社</span><select id="editionId1" class="widthSele2" onchange="getEducationList1('+flag+');">';
	}else{
		var t='<span>选择出版社</span><select id="editionId1" class="widthSele2" disabled>';
	}
	var options = '';
	if(list==null){
		
	}else{
		options += "<option value='0'>请选择出版社</option>";
		for(i=0; i<list.length; i++){
		  if(list[i].ediName != "通用版"){
			  options +=  "<option value='"+list[i].id+"'>"+list[i].ediName+"</option>";
		  }
		}
	}
	var h='</select> ';
	$('#selectEditionDiv1').html(t+options+h);
}
//获取教材信息列表
function getEducationList1(flag){
	var subjectId = getId("subjectId1").value;
	var gradeId = getId("gradeId1").value;
	var editionId = getId("editionId1").value;
	var newUrl = "&subjectId="+subjectId+"&gradeId="+gradeId+"&editionId="+editionId;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getEducationList"+newUrl,
        success:function (json){
        	showEducationList1(json,flag);
        }
    });
	if(flag){
		//重载章节列表
		getChapterList1(flag);
		//重载知识典列表
		getLoreList1();	
	}
}
//显示教材信息列表
function showEducationList1(list,flag){
	if(flag){
		var t='<span>选择教材</span><select id="educationId1" class="widthSele2" onchange="getChapterList1('+flag+');">';
	}else{
		var t='<span>选择教材</span><select id="educationId1" class="widthSele2" disabled>';
	}
	
  	var f='<option value="0">请选择教材</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].volume+"</option>";
		}
	}
	var h='</select> ';
	$('#selectEducationDiv1').html(t+f+options+h);
}
//获取章节列表
function getChapterList1(flag){
	var educationId = getId("educationId1").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getChapterListByEducationId&educationId="+educationId,
        success:function (json){
        	showChapterList1(json,flag);
        }
    });
	if(flag){
		//重载知识典列表
		getLoreList1();
	}
}
//显示章节列表
function showChapterList1(list,flag){
	if(flag){
		var t='<span>选择章节</span><select id="chapterId1" class="widthSele1" onchange="getLoreList1();">';
	}else{
		var t='<span>选择章节</span><select id="chapterId1" class="widthSele1" disabled>';
	}
  	var f='<option value="0">请选择章节</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].chapterName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectChapterDiv1').html(t+f+options+h);
}
//获取知识典列表
function getLoreList1(){
	var chapterId = getId("chapterId1").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getLoreListByChapterId&chapterId="+chapterId,
        success:function (json){
        	showLoreList1(json);
        }
    });
}
//显示知识典列表
function showLoreList1(list){
	var t='<span>选择知识典</span><select id="loreId1" class="seleListWidth">';
  	var f='<option value="0">请选择知识典</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].loreName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectLoreDiv1').html(t+f+options+h);
}


//--------------------------------------第三组----------------------------------------------//

//获取科目列表
function getSubjectList2(flag){
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action=getSubjectList",
      success:function (json){
      	showSubjectList2(json,flag);
      }
  });
}
//显示角色列表
function showSubjectList2(list,flag){
	if(flag){
		var t='<span class="buffMr">选<span class="buffBlank"></span>择<span class="buffBlank"></span>科<span class="buffBlank"></span>目</span><select id="subjectId2" class="widthSele2" onchange="getGradeList2('+flag+');">';	
	}else{
		var t='<span class="buffMr">选<span class="buffBlank"></span>择<span class="buffBlank"></span>科<span class="buffBlank"></span>目</span></span><select id="subjectId2" class="widthSele2" disabled>';
	}
	var f='<option value="0" class="buffMr">选<span class="buffBlank"></span>择<span class="buffBlank"></span>科<span class="buffBlank"></span>目</span></option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].subName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectSubjectDiv2').html(t+f+options+h);
}

//根据科目获取年级列表
function getGradeList2(flag){
	var subjectId = getId("subjectId2").value;
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action=getGradeListBySubjectId&subjectId="+subjectId,
      success:function (json){
      	showGradeList2(json,flag);
      }
  });
	if(flag){
		//重载教材列表
		getEducationList2(flag);
		//重载章节列表
		getChapterList2(flag);
		//重载知识典列表
		getLoreList2();
	}
}
//显示年级列表
function showGradeList2(list,flag){
	if(flag){
		var t='<span class="buffMr">选择年级</span><select id="gradeId2" class="widthSele2" onchange="getEducationList2('+flag+');">';
	}else{
		var t='<span class="buffMr">选择年级</span><select id="gradeId2" class="widthSele2" disabled>';
	}
	var f='<option value="0" class="buffMr">请选择年级</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].gradeName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectGradeDiv2').html(t+f+options+h);
}
//获取教材版本列表
function getAllEditionList2(flag){
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action=getEditionList",
      success:function (json){
      	showEditionList2(json,flag);
      }
  });
}
//获取基础教材版本列表
function getBasicEditionList2(flag){
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action=getBasicEditionList",
      success:function (json){
      	showEditionList2(json,flag);
      }
  });
}
//获取除通用版以外的其他版本
function getOtherEditionList2(flag){
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action=getEditionList",
      success:function (json){
      	showOtherEditionList2(json,flag);
      }
  });
}
//显示教材版本列表
function showEditionList2(list,flag){
	if(flag){
		var t='<span class="buffMr">选择出版社</span><select id="editionId2" class="widthSele2">';
	}else{
		var t='<spa class="buffMr">选择出版社</span><select id="editionId2" class="widthSele2" disabled>';
	}
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].ediName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectEditionDiv2').html(t+options+h);
	getEducationList2(flag);
}
//显示除通用版以外的教材版本列表
function showOtherEditionList2(list,flag){
	if(flag){
		var t='<span class="buffMr">选择出版社</span><select id="editionId2" class="widthSele2" onchange="getEducationList2('+flag+');">';
	}else{
		var t='<span class="buffMr">选择出版社</span><select id="editionId2" class="widthSele2" disabled>';
	}
	var options = '';
	if(list==null){
		
	}else{
		options += "<option value='0'>请选择出版社</option>";
		for(i=0; i<list.length; i++){
		  if(list[i].ediName != "通用版"){
			  options +=  "<option value='"+list[i].id+"'>"+list[i].ediName+"</option>";
		  }
		}
	}
	var h='</select> ';
	$('#selectEditionDiv2').html(t+options+h);
}
//获取教材信息列表
function getEducationList2(flag){
	var subjectId = getId("subjectId2").value;
	var gradeId = getId("gradeId2").value;
	var editionId = getId("editionId2").value;
	var newUrl = "&subjectId="+subjectId+"&gradeId="+gradeId+"&editionId="+editionId;
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action=getEducationList"+newUrl,
      success:function (json){
      	showEducationList2(json,flag);
      }
  });
	if(flag){
		//重载章节列表
		getChapterList2(flag);
		//重载知识典列表
		getLoreList2();	
	}
}
//显示教材信息列表
function showEducationList2(list,flag){
	if(flag){
		var t='<span class="buffMr">选择教材</span><select id="educationId2" class="widthSele2" onchange="getChapterList2('+flag+');">';
	}else{
		var t='<span class="buffMr">选择教材</span><select id="educationId2" class="widthSele2" disabled>';
	}
	
	var f='<option value="0" class="buffMr">请选择教材</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].volume+"</option>";
		}
	}
	var h='</select> ';
	$('#selectEducationDiv2').html(t+f+options+h);
}
//获取章节列表
function getChapterList2(flag){
	var educationId = getId("educationId2").value;
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action=getChapterListByEducationId&educationId="+educationId,
      success:function (json){
      	showChapterList2(json,flag);
      }
  });
	if(flag){
		//重载知识典列表
		getLoreList2();
	}
}
//显示章节列表
function showChapterList2(list,flag){
	if(flag){
		var t='<span class="buffMr">选<span class="buffBlank"></span>择<span class="buffBlank"></span>章<span class="buffBlank"></span>节</span><select id="chapterId2" class="widChapterSel" onchange="getLoreList2();">';
	}else{
		var t='<span class="buffMr">选<span class="buffBlank"></span>择<span class="buffBlank"></span>章<span class="buffBlank"></span>节</span><select id="chapterId2" class="widChapterSel"  disabled>';
	}
	var f='<option value="0" class="buffMr">请选择章节</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].chapterName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectChapterDiv2').html(t+f+options+h);
}
//获取知识典列表
function getLoreList2(){
	var chapterId = getId("chapterId2").value;
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action=getLoreListByChapterId&chapterId="+chapterId,
      success:function (json){
      	showLoreList2(json);
      }
  });
}
//显示知识典列表
function showLoreList2(list){
	var t='<span class="buffMr">选择知识典</span><select id="loreId2" class="widChapterSel">';
	var f='<option value="0">请选择知识典</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++)
		{
		  options +=  "<option value='"+list[i].id+"'>"+list[i].loreName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectLoreDiv2').html(t+f+options+h);
}

//根据类型/思维/能力类型获取巴菲特类型
function getBuffetType(types,divObj,methods){
	var actionUrl = "";
	if(types == "类型"){
		actionUrl = "getBuffetType";
	}else if(types == "思维"){
		actionUrl = "getBuffetMindType";
	}else if(types == "能力"){
		actionUrl = "getBuffetAbilityType";
	}
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"commonManager.do?action="+actionUrl,
      success:function (json){
      	showLoreTypeList(json,types,divObj,methods);
      }
  });
}
//显示巴菲特基础类型列表
function showLoreTypeList(list,buffetType,divObj,methods){
	var t = "";
	var options = '';
	if(buffetType == '类型'){
		t = '<span>基础类型: </span>';
		if(list != null){
			if(methods == "add"){
				for(i=0; i<list.length; i++){
				  options +=  "<input name='basicType' type='radio' id='type_"+list[i].id +"'  value='"+list[i].id+"' onclick=getBasicBuffetType('"+list[i].id+"','"+list[i].types+"')>"+"<label for='type_"+list[i].id +"'>"+list[i].types+"</label>"+"&nbsp;";
				}
			}else{
				for(i=0; i<list.length; i++){
				  options +=  "<label><input name='basicType' type='radio' value='"+list[i].id+"' disabled>"+list[i].types+"&nbsp;</label>";
				}
			}
			
		}
	}else if(buffetType == '思维'){
		t = '<span>思维类型: </span>';
		if(list != null){
			for(i=0; i<list.length; i++){
			  options +=  "<label><input name='buffetTypeMind' type='checkbox' value='"+list[i].id+"' >"+list[i].mind+"&nbsp;</label>";
			}
		}
	}else if(buffetType == '能力'){
		t = '<span>能力类型: </span>';
		if(list != null){
			for(i=0; i<list.length; i++){
			  options +=  "<label><input name='buffetTypeAbility' type='checkbox' value='"+list[i].id+"' >"+list[i].ability+"&nbsp;</label>";
			}
		}
	}
	$('#'+divObj).html(t+options);
}
