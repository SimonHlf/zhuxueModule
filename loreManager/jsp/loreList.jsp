<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>知识点信息</title>
    <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript">
		$(function load(){
			getSubjectList();
			showGradeList(null);
		});
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
		}
		//显示年级列表
		function showGradeList(list){
			var t='<span>选择年级</span><select id="gradeId" style="width:100px;" onchange="getEditionList(this);">';
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
	</script>  
  </head>
  
  <body>
     <div id="selectSubjectDiv"></div>
     <div id="selectGradeDiv"></div>
  </body>
</html>
