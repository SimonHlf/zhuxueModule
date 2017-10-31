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
function getSubjectList1(){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getSubjectList",
        success:function (json){
        	showSubjectList1(json);
        }
    });
}
//显示角色列表
function showSubjectList1(list){
	var t='<span>选择科目</span><select id="subjectId1" class="widthSele2" onchange="getGradeList1();">';
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
function getGradeList1(){
	var subjectId = getId("subjectId1").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getGradeListBySubjectId&subjectId="+subjectId,
        success:function (json){
        	showGradeList1(json);
        }
    });
    //重载教材列表
	getEducationList1();
	//重载章节列表
	getChapterList1();
	//重载知识典列表
	getLoreList1();
}
//显示年级列表
function showGradeList1(list){
	var t='<span>选择年级</span><select id="gradeId1" class="widthSele2" onchange="getEducationList1();">';
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
function getAllEditionList1(){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getEditionList",
        success:function (json){
        	showEditionList1(json);
        }
    });
}
//获取基础教材版本列表
function getBasicEditionList1(){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getBasicEditionList",
        success:function (json){
        	showEditionList1(json);
        }
    });
}
//显示教材版本列表
function showEditionList1(list){
	var t='<span>选择出版社</span><select id="editionId1" class="widthSele2" onchange="getEducationList1();">';
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
	$('#selectEditionDiv1').html(t+options+h);
}
//获取教材信息列表
function getEducationList1(){
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
        	showEducationList1(json);
        }
    });
    //重载章节列表
	getChapterList1();
	//重载知识典列表
	getLoreList1();
}
//显示教材信息列表
function showEducationList1(list){
	var loreName = $("#showChapterDiv1").html();
	if(loreName != null){
		var t='<span>选择教材</span><select id="educationId1" class="widthSele2">';
	}else{
		var t='<span>选择教材</span><select id="educationId1" class="widthSele2" onchange="getChapterList1();">';
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
function getChapterList1(){
	var educationId = getId("educationId1").value;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getChapterListByEducationId&educationId="+educationId,
        success:function (json){
        	showChapterList1(json);
        }
    });
	//重载知识典列表
	getLoreList1();
}
//显示章节列表
function showChapterList1(list){
	var loreName = $("#loreName1").html();
	if(loreName != null){
		var t='<span>选择章节</span><select id="chapterId1" class="widthSele1" onchange="getLoreList1();">';
	}else{
		var t='<span>选择章节</span><select id="chapterId1" class="widthSele2">';
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