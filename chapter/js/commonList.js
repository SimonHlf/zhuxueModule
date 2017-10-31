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
			var t='<span>选择科目</span>&nbsp;<select id="subjectId" class="widthSele1" onchange="getGradeList(this);">';
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
		}
		//显示年级列表
		function showGradeList(list){
			var t='<span>选择年级</span>&nbsp;<select id="gradeId" class="widthSele1" onchange="getEducationList();">';
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
			var t='<span>选择出版社</span>&nbsp;<select id="editionId" class="widthSele1" onchange="getEducationList();">';
		  	//var f='<option value="0">请选择出版社</option>';
			var options = '';
			if(list==null){
				
			}else{
				for(i=0; i<list.length; i++)
				{
				  if(i == 0){
					  options +=  "<option value='"+list[i].id+"' selected>"+list[i].ediName+"</option>";
				  }else{
					  options +=  "<option value='"+list[i].id+"'>"+list[i].ediName+"</option>";  
				  }
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
		}
		//显示教材信息列表
		function showEducationList(list){
			var t='<span>选择教材</span>&nbsp;<select id="educationId" class="widthSele1">';
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