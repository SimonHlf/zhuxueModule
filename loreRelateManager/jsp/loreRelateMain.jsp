<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>知识点关联信息</title>
	<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="Module/chapter/css/comSeleListCss.css"/>
	<link rel="stylesheet" type="text/css" href="Module/loreManager/css/relatePointCss.css"/>
    <link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css"/>   
    <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/loreRelateManager/js/commonList.js"></script>
	<script type="text/javascript">
		var currentLoreId = "";
		$(function load(){
			getSubjectList();
			showGradeList(null);
			getAllEditionList();
			showEducationList(null);
		});
		window.top.onscroll = function(){
			return false;
		};
		function showTree(){
			var educationId = getId("educationId").value;
			getId("viewLoreTreeWindow").style.display="";
			$('#tt').tree({  
				url: "loreRelateManager.do?action=showLoreSimpleTree&educationId="+educationId,
				loadFilter: function(data){  
					if (data.d){  
						return data.d;  
					} else {  
						return data;  
					}  
				}  
		 	});
		}
		function showDetailView(attributeObj){
			if(attributeObj){
				var loreId = attributeObj.loreId;
				var loreName = attributeObj.loreName;
				showRelationView(loreId,loreName);
			}
		}
		//封装打开窗口
		function showWindow(windowDiv,title,width,height){
			getId(windowDiv).style.display="";
			$("#"+windowDiv).window({  
			   title:title, 
			   width:width,   
			   height:height, 
			   collapsible:false,
			   minimizable:false,
			   maximizable:false,
			   resizable:false,
			   modal:true  
			});
		}
		//显示关联知识典窗口
		function showRelationView(loreId,loreName){
			currentLoreId = "";//每次show的时候先清空
			currentLoreId = loreId;
			$("#loreName1").html(loreName);
			showWindow("viewLoreRelateWindow","知识典关联",700,415);
			getAllEditionList1();
			getId("editionId1").value = getId("editionId").value;
			getSubjectList1();
			getId("subjectId1").value = getId("subjectId").value;
			getGradeList1();
			getId("gradeId1").value = getId("gradeId").value;
			getEducationList1();
			getId("educationId1").value = getId("educationId").value;
			getChapterList1();
			showLoreList1(null);
			
			
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"loreRelateManager.do?action=showRelationList&loreId="+loreId,
				  success:function (json){ 
					  showRootLoreList(json);
				  }
			});
			//点击窗口关闭按钮时的事件
			$('#viewLoreRelateWindow').window({
		        onBeforeClose: function () {
		        	showTree();
		        }
		    });
			
		}
		//显示所有子节点
		function showRootLoreList(list){
			var title = "<span class='relateTit'>本知识点关联知识点:</span>";
			var loreInfo = "";
			for(var i = 0 ; i < list.length; i++){
				var loreRelateId = list[i].id;
				loreInfo += "<div id='div"+ loreRelateId +"' class='activeCreateDiv'>"+list[i].rootLoreName + "<a href='javascript:void(0)' title='删除' class='delPoint' onclick=delRelate('"+ loreRelateId +"','div"+ loreRelateId +"')></a></div>";
			}
			$('#relateLoreDiv').html(title+loreInfo);
		}
		//删除一个关联知识点
		function delRelate(loreRelationId,divObj){
			if(confirm("确定要删除该关联知识典么?")){
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"loreRelateManager.do?action=delRelate&loreRelationId="+loreRelationId,
					  success:function (json){ 
						  if(json){
							  //移除一项
							  $("#"+divObj).remove();
						  }else{
							  alert("删除失败!");
						  }
					  }
				});	
			}
		}
		//增加一个关联知识点
		function addLoreRelate(){
			var newRootLoreId = $("#loreId1").val();
			var newRootLoreName = $("#loreId1").find("option:selected").text();
			if(newRootLoreId > 0){
				//先查询该知识点下面有没有新选择的关联知识点
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"loreRelateManager.do?action=checkExistRelateByLoreId&loreId="+currentLoreId+"&rootLoreId="+newRootLoreId,
					  success:function (json){ 
						  if(json){
							  alert("已存在该关联子知识点!");
						  }else if(currentLoreId == newRootLoreId){
							  alert("当前知识点和需要绑定的知识点相同，请重新选择知识点!");
						  }else{
							//向关联表中插入一条数据
							$.ajax({
								  type:"post",
								  async:false,
								  dataType:"json",
								  url:"loreRelateManager.do?action=addRelate&loreId="+currentLoreId+"&rootLoreId="+newRootLoreId,
								  success:function (json){ 
									  if(json > 0){
										  var newRootLoreDiv = "<div id='div"+ json +"' class='activeCreateDiv'>"+newRootLoreName + "<a href='javascript:void(0)' title='删除' class='delPoint' onclick=delRelate('"+ json +"','div"+ json +"')></a></div>";
										  $("#relateLoreDiv").append(newRootLoreDiv); 
									  }else{
										  alert("增加失败!");
									  }
								  }
							});	
							
						  }
					  }
				});	
			}else{
				alert("请先选择需要关联的知识典");
			}
		}
	</script>
  </head>
  
  <body>
  <div class="mainWrap">
  	<div class="top">
	  	 <div id="showChapterDiv" class="comNowSeleDiv"></div>
	     <div id="selectSubjectDiv" class="comNowSeleDiv comWiDiv Left"></div>
	     <div id="selectGradeDiv" class="comNowSeleDiv comWiDiv Left"></div>
	     <div id="selectEditionDiv" class="comNowSeleDiv comWiDiv Left1"></div>
	     <div id="selectEducationDiv" class="comNowSeleDiv comWiDiv Left"></div>
	      <a class="viewBtn" onclick="showTree();"><span class="searchIcon"></span>查询</a>
     </div>
     <div class="relateConBox">
         <div id="viewLoreTreeWindow" style="display:none;">
   			<ul id="tt" class="easyui-tree" data-options="animate:true,lines:true,onClick:function(node){showDetailView(node.attributes);}"></ul>
   	     </div>
     </div>

     <div id="viewLoreRelateWindow" style="display:none;">
    	<div class="viewParent">
    		<h2 class="nowLore">当前知识典:<span id="loreName1"></span></h2>
    		 <div class="topDiv">
		    	 <div id="selectSubjectDiv1" class="comNowSeleDiv1 comWiDiv1"></div>
			     <div id="selectGradeDiv1" class="comNowSeleDiv1 comWiDiv1"></div>
			     <div id="selectEditionDiv1" class="comNowSeleDiv1 comWiDiv2"></div>
			     <div id="selectEducationDiv1" class="comNowSeleDiv1 comWiDiv1"></div>
		     </div> 
		     <div class="topDiv">
			     <div id="selectChapterDiv1" class="comNowSeleDiv1 comWiDiv1"></div>
		    	 <div id="selectLoreDiv1" class="comNowSeleDiv1 lorDiv1"></div>
	    	 </div>
	    	 <div id="relateLoreDiv"></div>
	    	 <input type="button" class="addRealteBtn" value="添加" onclick="addLoreRelate()"/>
    	 </div>  	 
      </div>
    </div>
  </body>
</html>
