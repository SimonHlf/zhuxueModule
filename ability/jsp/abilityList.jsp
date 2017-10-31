<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>角色权限管理</title>
  	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
  	<link href="Module/ability/css/abilityCss.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript">
		$(function load(){
			getRoleList();
			var roleID = ${requestScope.roleID};
			var obj = getId("roleID");
			selectIndex(obj,roleID);
			changeColor();
			selectAll();
			toSelAll();
		});
		
		//获取除超级管理员以外的角色用户列表
		function getRoleList(){
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"commonManager.do?action=getAllRoleList",
		        success:function (json){
		        	showRoleList(json);
		        }
		    });
		}
		//显示角色列表
		function showRoleList(list){
			var t='<span>选择角色</span><select id="roleID" style="width:100px;" onchange="getResource(this);">';
		  	var f='<option value="0">请选择角色</option>';
			var options = '';
			if(list==null){
				
			}else{
				for(i=0; i<list.length; i++)
				{
				  options +=  "<option value='"+list[i].id+"'>"+list[i].roleName+"</option>";
				}
			}
			var h='</select> ';
			$('#selectRoleDiv').html(t+f+options+h);
		}
		//选择角色动作
		function getResource(obj){
			var roleID = obj.value;
			window.location.href = "abilityManager.do?action=load&roleID="+roleID;
		}
		//按钮的全选重置 
	   function selectAll(){
		   var oBtn=getId("btn");
		   var oCan=getId("cancel");
		   var oTab=getId("tab");
		   var aInput=oTab.getElementsByTagName('input');
		   var aA=oTab.getElementsByTagName('a');

		   oBtn.onclick=function(){
			   for(var i=0;i<aA.length;i++){
				   aA[i].className="collect1";
			   }
			   for(i=0;i<aInput.length;i++){
				   aInput[i].checked=true;
			   }
		   }
		   oCan.onclick=function(){
			   for(var i=0;i<aA.length;i++){
				   aA[i].className="collect";
			   }
			   for(i=0;i<aInput.length;i++){
				   aInput[i].checked=false;
			   }
		   }
	   }
	   //单行按钮的全选取消设置  
	   function toSelAll(){
		   var oTab=getId("tab");
		   var aA=oTab.getElementsByTagName('a');
		   var tmp=0;
		   for(var i=0;i<aA.length;i++){
			   aA[i].index=i;
			   aA[i].onclick=function(){
			   var className = aA[this.index].className;
				   if(className == "collect"){
					   aA[this.index].className="collect1";
					   var aInput=oTab.tBodies[0].rows[this.index].getElementsByTagName("input");
					   for(var j=0;j<aInput.length;j++){
						   aInput[j].checked=true;	  
				       }
				   }else{
					   aA[this.index].className="collect";
					   var aInput=oTab.tBodies[0].rows[this.index].getElementsByTagName("input");
					   for(var j=0;j<aInput.length;j++){
						   aInput[j].checked=false;
				       } 
				   }
			   }
		   }
	   }
	 	//表格隔行换色 
	   function changeColor(){
		   var oTab=getId("tab");
		   var oldColor="";
		   for(var i=0;i<oTab.tBodies[0].rows.length;i++){
			   oTab.tBodies[0].rows[i].onmouseover=function(){
				   oldColor=this.style.background;
				   this.style.background="#D0E5F5";
			   }
			   oTab.tBodies[0].rows[i].onmouseout=function(){
				   this.style.background=oldColor;
			   }
	   		   if(i%2==0){
				   oTab.tBodies[0].rows[i].style.background="#fff7e8";
			   }else{
				   oTab.tBodies[0].rows[i].style.background="";
			   }
		   } 
	   }
	 	//获取选中的复选框，并执行数据库
	 	function getCheckSubmit(){
	 		var roleID = getId("roleID").value;
	 		if(roleID == 0){
	 			alert("请选择一个角色");
	 		}else{
	 			var boxes = document.getElementsByName("checkbox");
	 			var roleTypeID = new Array();
	 			var status = 0;
	 			for(var i = 0 ; i < boxes.length ; i++){
	 				if(boxes[i].checked){//选中
	 					status = 0;
	 				}else{//未选中
	 					status = 1;
	 				}
	 				var id = boxes[i].value.split(":");
 					var resActionID = id[0];
 					$.ajax({
 				        type:"post",
 				        async:false,
 				        dataType:"json",
 				        url:"abilityManager.do?action=set&roleID="+roleID+"&resActionID="+resActionID+"&status="+status,
 				        success:function (json){
 				        
 				        }
 				    });
	 			}
	 			alert("权限设置成功!");
	 			window.location.href = "abilityManager.do?action=load";
	 		}
	 	}
	</script>
  </head>
  
  <body>
    <div id="AbPar">
	   <div id="roleChoice">
		      <div class="choice_l fl">
			     <div id="selectRoleDiv"></div>
			  </div>
			  <div class="choice_r fl">
			     <a class="save" hidefocus=”true” id="btn" href="#this" title="全选所有行">全选</a>
			     <a class="save" hidefocus=”true” id="cancel" href="#this">重置</a>
			     <a href="###" onclick="getCheckSubmit();">保存</a>
			  </div>
	     </div>         
	     <div id="detailCon">
		      <table width=100%; id="tab" cellpadding="0" cellspacing="0"style="margin:5px 0px 5px 0px;background:#fff;" border=2; bordercolor="#F79937">
			      <tbody>
							<logic:present name="resourceList" scope="request">	
							   <logic:iterate id="ability" name="resourceList" type="com.kpoint.model.json.AbilityJson" scope="request">
								   <tr>
								          <td width=150>
								             <h2 class="Manager">
								              <a hidefocus=”true” title="全选该行" href="#this" class="collect"></a>
								              <bean:write name='ability' property='resource.resName'/>&nbsp;
								             </h2> 
								          </td>
								          <td>
											  <logic:iterate id="action" name="ability" property="list">	
											        	       	 <logic:match name="action" property="bool" value="true">
																     <label>
																	     <input type="checkbox" name="checkbox" checked="checked" value= <bean:write name='action' property='id'/>:<bean:write name='ability' property='resource.id'/> />
																	     <span class="NameInput"><bean:write name='action' property='name'/></span>
																     </label>	
														         </logic:match>     
														         <logic:notMatch name="action" property="bool" value="true">
														         	 <label>
															         	<input type="checkbox" name="checkbox" value= <bean:write name='action' property='id'/>:<bean:write name='ability' property='resource.id'/> />
													                    <span class="NameInput"><bean:write name='action' property='name'/></span>
												                     </label>       
														         </logic:notMatch> 	
											  </logic:iterate>
										  </td>  
								   </tr>
								 </logic:iterate>
							</logic:present>
			      </tbody>
			  </table>
	     </div>                                                  
	</div>
							
  </body>
</html>
