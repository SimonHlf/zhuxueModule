//获取科目列表
		function getSubjectList(subjectId,subjectDiv,gradeId,gradeDiv){
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"commonManager.do?action=getSubjectList",
		        success:function (json){
		        	showSubjectList(json,subjectId,subjectDiv,gradeId,gradeDiv);
		        }
		    });
		}
		//显示科目列表
		function showSubjectList(list,subjectId,subjectDiv,gradeId,gradeDiv){
			var t = "";
			if(gradeId == "" && gradeDiv == ""){
				 t='<span>科目</span><select id="'+ subjectId +'" style="width:100px;">';
			}else{
				t='<span>科目</span><select id="'+ subjectId +'" style="width:100px;" onchange=getGradeList(this,"'+gradeId+'","'+ gradeDiv +'");>';
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
			$('#'+subjectDiv).html(t+f+options+h);
		}
		
		//根据科目获取年级列表
		function getGradeList(obj,gradeId,gradeDiv){
			var options;
			if(obj == null){
				options = document.getElementById("subjectID_edit").value;
			}else{
				options = obj.value;
			}
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"commonManager.do?action=getGradeListBySubjectId&subjectId="+options,
		        success:function (json){
		        	showGradeList(json,gradeId,gradeDiv);
		        }
		    });
		}
		//显示年级列表
		function showGradeList(list,gradeId,gradeDiv){
			var t='<span>年级</span><select id="'+ gradeId +'" style="width:100px;">';
		  	var f='<option value="0">请选择年级</option>';
			var options = '';
			if(list==null){
				
			}else{
				for(i=0; i<list.length; i++)
				{
				  options +=  "<option value='"+list[i].id+"' >"+list[i].schoolType+":"+list[i].gradeName+"</option>";
				}
			}
			var h='</select> ';
			$('#'+gradeDiv).html(t+f+options+h);
		}
		//获取教材版本列表
		function getAllEditionList(editionId,editionDiv){
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"commonManager.do?action=getEditionList",
		        success:function (json){
		        	showEditionList(json,editionId,editionDiv);
		        }
		    });
		}
		//显示教材版本列表
		function showEditionList(list,editionId,editionDiv){
			var t='<span>出版社</span><select id="'+editionId+'" style="width:100px;">';
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
			$('#'+editionDiv).html(t+options+h);
		}