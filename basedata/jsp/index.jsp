<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>

		<title>基础数据管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
		<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
		<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
		<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
		<link rel="stylesheet" type="text/css"href="Module/basedata/css/basedata.css">
		<script type="text/javascript"  src="Module/basedata/js/basedata.js"></script>
		<script type="text/javascript"  src="Module/basedata/js/commonList.js"></script>
		<script type="text/javascript">
			//初始化加载
			$(function load(){
				getEditionCount();
				getSubjectCount();
				getEducationCount();
				getGradeCount();
				listEdition(1, 10);
				listSubject(1, 10);
				listEducation(1,10);
				listGrade(1,10);
				getSubjectList("subjectId","databaseSubjectDiv","","");
				getSubjectList("subjectID1","dbSubjectDiv","","");
				getSubjectList("subjectID2","SubjectDiv","gradeId","gradeDiv");
				showGradeList(null,"gradeId","gradeDiv","","");
				getAllEditionList("editionId","EditionDiv");
				getSubjectList("subjectID_edit","EducSubjectDiv","gradeId_edit","educgradeDiv");
				getAllEditionList("editionId_edit","EducEditionDiv");
				
				//条件教材
				getSubjectList("subIDOption","subOptionDiv","gIdOption","greadeOptionDiv");
				getAllEditionList("editionId_option","EducOptionDiv");
			});
		</script>
	</head>

	<body>
	<%--基础数据选项卡--%>
		<div class="easyui-tabs" style="width: 1000px; height: 500px;">
			<div title="出版社管理" style="padding: 10px;">
				<table id="listEdition"></table>
				<div id="ee"
					style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
			<div title="科目管理" style="padding: 10px;">
				<table id="listSubject"></table>
				<div id="ss"
					style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
			<div title="教材管理" style="padding: 10px;">
				<table id="listEducation"></table>
				<div id="educ"
					style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
			<div title="年级科目管理" style="padding: 10px;">
				<table id="listGrade"></table>
				<div id="gg"
					style="width: 100%; background: #efefef; border: 1px solid #ccc;"></div>
			</div>
		</div>
		<%--添加出版社窗口--%>
		<div id="addEditionWindow"  style="display: none">
			<div>
				<label>
					出版社名称:
				</label>
				<input id="ediName" type="text" name="ediName">
				<br>
				<label>
					顺&nbsp;&nbsp;序:
				</label>
				<input id="ordEdition" type="text" name="ordEdition">
			</div>
			<div>
				<input type="button" value="确定" onclick="addEdition()" />
				<input type="button" value="取消" onclick="closeEditionWindow()" />
			</div>
		</div>
		<%--编辑出版社窗口--%>
		<div id="editEditionWindow"  style="display: none">
			<div>
				<label>
					出版社名称:
				</label>
				<input id="ediIDedit" type="hidden">
				<input id="ediNameEdit" type="text" name="ediNameEdit">
				<br>
				<label>
					顺&nbsp;&nbsp;序:
				</label>
				<input id="ordEditionEdit" type="text" name="ordEditionEdit">
			</div>
			<div>
				<input type="button" value="确定" onclick="updateEdition()" />
				<input type="button" value="取消" onclick="closeEditionEditWindow()" />
			</div>
		</div>
		
		<%--添加科目窗口--%>
		<div id="addSubjectWindow"  style="display: none">
			<div>
				<label>
					科目名称:
				</label>
				<input id="subName" type="text" name="subName">
				<br>
				<label>
					顺&nbsp;&nbsp;序:
				</label>
				<input id="ordSub" type="text" name="ordSub"><br>
				<label>是否可见</label>
				<input type="radio" name="inDisSub" value="0" checked="checked">可见<input type="radio" name="inDisSub" value="1">不可见<br>
			</div>
			<div>
				<input type="button" value="确定" onclick="addSubject()" />
				<input type="button" value="取消" onclick="closeSubjectWindow()" />
			</div>
		</div>
		<%--编辑科目窗口--%>
			<div id="EditSubjectWindow"  style="display: none">
			<div>
				<label>
					科目名称:
				</label>
				<input type="hidden" id="subID" name="subID">
				<input id="subNameedit" type="text" name="subNameedit">
				<br>
				<label>
					顺&nbsp;&nbsp;序:
				</label>
				<input id="ordSubedit" type="text" name="ordSubedit"><br>
				<label>是否可见</label>
				<input type="radio" name="inDisSubedit" value="0" checked="checked">可见<input type="radio" name="inDisSubedit" value="1">不可见<br>
			</div>
			<div>
				<input type="button" value="确定" onclick="updateSubject()" />
				<input type="button" value="取消" onclick="closeSubjecteditWindow()" />
			</div>
		</div>
		<%--添加教材窗口--%>
		<div id="addEducationWindow"  style="display:none">
		 <div id="SubjectDiv"></div><div id="gradeDiv"></div>
		<div id="EditionDiv"></div>
		是否启用:
		<input type="radio" name="educ_in_use" value="0" checked="checked">启用<input type="radio" name="educ_in_use" value="1">未启用<br>
		卷册:
		<input type="radio" name="educ_vol" value="上册" checked="checked">上册<input type="radio" name="educ_vol" value="下册">下册
		<div>
			<input type="button" value="确定" onclick="addEducation()" />
			<input type="button" value="取消" onclick="closeeductionWindow()" />
		</div>
		</div>
		<%--编辑教材窗口--%>
		<div id="editEducationWindow" style="display:none">
			<div id="EducSubjectDiv"></div><div id="educgradeDiv"></div><div id="EducEditionDiv"></div>
		  <input id="educID_edit" type="hidden">
	
		 是否启用:
		<input type="radio" name="educ_in_use_edit" value="0">启用<input type="radio" name="educ_in_use_edit" value="1">未启用<br>
		卷册:
		<input type="radio" name="educ_vol_edit" value="上册">上册<input type="radio" name="educ_vol_edit" value="下册">下册
		 <div>
				<input type="button" value="确定" onclick="editEducation()" />
				<input type="button" value="取消" onclick="closeEducationEditWindow()" />
			</div>
		</div>
		<%--添加年级科目窗口--%>
		<div id="addGradeWindow" style="display:none">
			<label>学校类型:</label>
			<select id="GradeSchoolType" onchange="gradeList('GradeSchoolType','gName');">
				<option value="0">请选择学校类型</option>
				<option value="小学">小学</option>
				<option value="初中">初中</option>
				<option value="高中">高中</option>
			</select>
			<label>
				年级名称:
			</label>
			<select id="gName">
				<option value="0">请选择年级</option>
			</select>
			<div id="databaseSubjectDiv"></div>
			<label>顺&nbsp;&nbsp;序:</label>
			<input id="ordGrade" type="text" name="ordGrade">
			<br>
			<label>是否可见</label>
			<input type="radio" name="inDisGrade" value="0">
			可见
			<input type="radio" name="inDisGrade" value="1">
			不可见
			<div>
				<input type="button" value="确定" onclick="addGrade()" />
				<input type="button" value="取消" onclick="closeGradeWindow()" />
			</div>

		</div>
		<%--修改年级科目窗口--%>
		<div id="editGradeWindow"  style="display:none">
			<label>学校类型:</label>
			<select id="GradeSType" onchange="gradeList('GradeSType','gNameEdit');">
				<option value="0">请选择学校类型</option>
				<option value="小学">小学</option>
				<option value="初中">初中</option>
				<option value="高中">高中</option>
			</select>
			<label>年级名称:</label>
			<input id="gID" type="hidden">
			<select id="gNameEdit">
				<option value="0">请选择年级</option>
			</select>
			<div id="dbSubjectDiv"></div>
			<label>顺&nbsp;&nbsp;序:</label>
			<input id="gOrdersEdit" type="text" name="gOrdersEdit">
			<br>
			<label>
				是否可见
			</label>
			<input type="radio" name="gInDisplayEdit" value="0">
			可见
			<input type="radio" name="gInDisplayEdit" value="1">
			不可见
			<div>
				<input type="button" value="确定" onclick="editGrade()" />
				<input type="button" value="取消" onclick="closeGradeEditWindow()" />
			</div>
		</div>
		<%--年级科目工具栏--%>
		<div id="searchgrade">
			<div class="Button">
				<span>年级名称:<select id="selectGrade">
					  <option value="一年级">一年级</option>
					  <option value="二年级">二年级</option>
					  <option value="三年级">三年级</option>
					  <option value="四年级">四年级</option>
					  <option value="五年级">五年级</option>
					  <option value="六年级">六年级</option>
					  <option value="七年级">七年级</option>
					  <option value="八年级">八年级</option>
					  <option value="九年级">九年级</option>
					  <option value="高一">高一</option>
					  <option value="高二">高二</option>
					  <option value="高三">高三</option>
				</select>
			</span>
				<a id="searchGrade" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
					 onclick="getGradeByNameCount()" >搜索</a>
				<a id="addShowGrade" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-add'"
					 onclick="showAddGradeWindow()">添加年级</a>
				<a id="allShowGrade" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-undo'"
					 onclick="showAllGrade()">全部年级</a>
			</div>
		</div>
		<%--教材工具栏 --%>
		<div id="searchEducs">
			<div style="float: left;" id="EducOptionDiv"></div> <div style="float: left;" id="subOptionDiv"></div> <div style="float: left;" id="greadeOptionDiv"></div>
			<a id="searchEduc" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="getEducByOptionCount()">搜索</a>
			<a id="addShowEduc" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-add'"  onclick="showAddEducWindow()" >添加教材</a>
			<a id="allShowEduc" href="###" class="easyui-linkbutton" data-options="iconCls:'icon-undo'"  onclick="showAllEducation( )" >全部教材</a>
		</div>
	</body>
</html>
