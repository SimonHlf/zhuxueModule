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
	var t='<span>选择科目</span><select id="subjectId" style="width:100px;" onchange="getGradeList(this);">';
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
	var t='<span>选择年级</span><select id="gradeId" style="width:100px;" onchange="getEducationList();">';
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
	var t='<span>选择出版社</span><select id="editionId" style="width:100px;" onchange="getEducationList();">';
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
	var t='<span>选择教材</span><select id="educationId" style="width:300px;" onchange="getChapterList();">';
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
	var t='<span>选择章节</span><select id="chapterId" style="width:315px;">';
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
	var t='<span>选择科目</span><select id="subjectId1" style="width:100px;" onchange="getGradeList1(this);">';
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
function getGradeList1(obj){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"commonManager.do?action=getGradeListBySubjectId&subjectId="+obj.value,
        success:function (json){
        	showGradeList1(json);
        }
    });
    //重载教材列表
	getEducationList1();
	//重载章节列表
	getChapterList1();
}
//显示年级列表
function showGradeList1(list){
	var t='<span>选择年级</span><select id="gradeId1" style="width:100px;" onchange="getEducationList1();">';
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
	var t='<span>选择出版社</span><select id="editionId1" style="width:112px;" onchange="getEducationList1();">';
	var f='<option value="0">请选择出版社</option>';
	var options = '';
	if(list==null){
		
	}else{
		for(i=0; i<list.length; i++){
		  if(list[i].ediName == "通用版"){
			  continue;
		  }
		  options +=  "<option value='"+list[i].id+"'>"+list[i].ediName+"</option>";
		}
	}
	var h='</select> ';
	$('#selectEditionDiv1').html(t+f+options+h);
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
}
//显示教材信息列表
function showEducationList1(list){
	var loreName = $("#showChapterDiv1").html();
	var t='<span>选择教材</span><select id="educationId1" style="width:112px;" onchange="getChapterList1();">';
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
}
//显示章节列表
function showChapterList1(list){
	var loreName = $("#loreName1").html();
	var t='<span>选择章节</span><select id="chapterId1" style="width:320px;">';
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