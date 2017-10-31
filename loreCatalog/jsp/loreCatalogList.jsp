<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>知识点管理</title>
    <link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
    <link href="Module/chapter/css/chapterLoreCatalogCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/loreCatalog/css/loreCatalogCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css"/>    
    <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript">
		var editionName =  "${requestScope.editionName}";
		$(function(){
			hoverListColor("conMidBox","li","#F0ECBD");
			//scrollBar("midCon","conMidBox","boxScroll","scrollBar");
		});
		var loreName_old = "";
		var orders_old = "";
		var inUse_old = "";
		function showEditWindow(){
			var chapterId = window.parent.getId("chapterId").value;
			getId("newOrders").value = getCurrentMaxOrder();
			if(chapterId == "0"){
				alert("请选择知识点所在章节!");
			}else{
				getId("newLoreCatalorWindow").style.display="";
				$("#newLoreCatalorWindow").window({  
				   title:"新增知识点", 
				   width:400,   
				   height:180, 
				   collapsible:false,
				   minimizable:false,
				   maximizable:false,
				   resizable:false,
				   modal:true  
				});
			}
		}
		//获取指定章节下知识点当前最大的排序号
		function getCurrentMaxOrder(){
			var chapterId = window.parent.getId("chapterId").value;
			var currentOrder = 1;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"loreCatalogManager.do?action=getCurrentMaxOrder&chapterId="+chapterId,
				  success:function (json){ 
					  currentOrder = json;
				  }
			});
			return currentOrder;
		}
		//指定章节下知识点名字重名判断
		function checkExist(chapterId,loreName){
			var ms = true;
			$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"loreCatalogManager.do?action=checkExist&chapterId="+chapterId+"&loreName="+encodeURIComponent(loreName),
					  success:function (msg){ 
						  ms=msg;
					   }
					});
			//true:存在  || false：不存在
			return ms;	
		}
		//取消(关闭窗口)
		function cancel(value){
			$("#"+value).window("close");
		}
		//增加知识点动作
		function addLoreCatalor(){
			var chapterId = window.parent.getId("chapterId").value;
			var loreName = getId("newLoreCatalorName").value;
			loreName = encodeURIComponent(loreName.replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,''));
			var orders = getId("newOrders").value;
			var editionObj = window.parent.getId("editionId");
			var selectIndex = editionObj.selectedIndex;
			var editionName = editionObj.options[selectIndex].text;
			if(loreName == ""){
				alert("知识点名称不能为空!");
				getId("newLoreCatalorName").focus();
			}else if(orders == ""){
				alert("排序号不能为空!");
				getId("newOrders").focus();
			}else if(checkNumber(getId("newOrders"),"必须为数字")){
				if(checkExist(chapterId,loreName)){
					alert("该知识点名已存在，请重新输入");
					getId("newLoreCatalorName").focus();
				}else{
					var newUrl = "&chapterId="+chapterId+"&orders="+orders+"&loreName="+loreName;
					$.ajax({
						  type:"post",
						  async:false,
						  dataType:"json",
						  url:"loreCatalogManager.do?action=addLoreCatalog"+newUrl,
						  success:function (json){ 
							  if(json > 0){
								  alert("增加成功!");
							  }else{
								  alert("增加失败!");
							  }
							  window.location.href="loreCatalogManager.do?action=queryLoreCatalog&chapterId="+chapterId+"&editionName="+encodeURIComponent(editionName);
						   }
						});
				}
			}
		}
		//编辑知识点窗口
		function showUpdateLoreCatalor(loreId,loreName,orders,inUse){
			loreName_old = loreName;
			orders_old = orders;
			inUse_old = inUse;
			var chapterId = window.parent.getId("chapterId").value;
			getId("loreId").value = loreId;
			getId("viewLoreCatalorName").value = loreName;
			getId("viewOrders").value = orders;
			getId("viewInUse").value = inUse;
			if(chapterId == "0"){
				alert("请选择知识点所在章节!");
			}else{
				getId("viewLoreCatalorWindow").style.display="";
				$("#viewLoreCatalorWindow").window({  
				   title:"编辑知识点", 
				   width:380,   
				   height:215, 
				   collapsible:false,
				   minimizable:false,
				   maximizable:false,
				   resizable:false,
				   modal:true  
				});
			}
			/**
			if(editionName != "通用版"){
				getId("viewInUse").disabled = true;
			}else{
				getId("viewInUse").disabled = false;
			}**/
		}
		//知识点修改
		function updateLoreCatalor(){
			var chapterId = window.parent.getId("chapterId").value;
			var loreId = getId("loreId").value;
			var loreName = getId("viewLoreCatalorName").value;
			loreName = loreName.replace(/^(\s|\u00A0)+/,'').replace(/(\s|\u00A0)+$/,'');
			var orders = getId("viewOrders").value;
			var inUse = getId("viewInUse").value;
			if(loreName == ""){
				alert("知识点名称不能为空!");
				getId("viewLoreCatalorName").focus();
			}else if(orders == ""){
				alert("排序号不能为空!");
				getId("viewOrders").value;
			}else if(loreName_old == loreName){
				if(orders_old == orders){
					if(inUse_old == inUse){
						cancel("viewLoreCatalorWindow");
					}else{
						excuteUpdate(loreId,loreName,orders,inUse);
					}
				}else{
					if(checkNumber(getId("viewOrders"),"必须为数字")){
						excuteUpdate(loreId,loreName,orders,inUse);
					}
				}
			}else if(loreName_old != loreName){
				if(orders_old == orders){
					if(checkExist(chapterId,loreName)){
						alert("该知识点名已存在，请重新输入");
						getId("viewLoreCatalorName").focus();
					}else{
						excuteUpdate(loreId,loreName,orders,inUse);
					}
				}else{
					if(checkNumber(getId("viewOrders"),"必须为数字")){
						if(checkExist(chapterId,loreName)){
							alert("该知识点名已存在，请重新输入");
							getId("viewLoreCatalorName").focus();
						}else{
							excuteUpdate(loreId,loreName,orders,inUse);
						}
					}
				}
			}
		}
		//知识点修改动作
		function excuteUpdate(loreId,loreName,orders,inUse){
			var chapterId = window.parent.getId("chapterId").value;
			var newUrl = "&loreId="+loreId+"&loreName="+encodeURIComponent(loreName)+"&orders="+orders+"&inUse="+inUse+"&isFree=-1";
			var editionObj = window.parent.getId("editionId");
			var selectIndex = editionObj.selectedIndex;
			var editionName = editionObj.options[selectIndex].text;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"loreCatalogManager.do?action=updateLoreCatalog"+newUrl,
				  success:function (json){ 
					  if(json){
						  alert("修改成功!");
					  }else{
						  alert("修改失败!");
					  }
					  window.location.href="loreCatalogManager.do?action=queryLoreCatalog&chapterId="+chapterId+"&editionName="+encodeURIComponent(editionName);
				   }
				});
		}
		//免费设置
		function setInFree(loreCatalogId,freeStatus){
			var chapterId = window.parent.getId("chapterId").value;
			var loreName = "";
			var orders = -1;
			var newUrl = "&loreId="+loreCatalogId+"&loreName="+encodeURIComponent(loreName)+"&orders=-1"+"&inUse=-1&isFree="+freeStatus;
			var editionName = $("#editionId").find("option:selected").text();
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"loreCatalogManager.do?action=updateLoreCatalog"+newUrl,
				  success:function (json){ 
					  if(json){
						  alert("修改成功!");
					  }else{
						  alert("修改失败!");
					  }
					  window.location.href="loreCatalogManager.do?action=queryLoreCatalog&chapterId="+chapterId+"&editionName="+encodeURIComponent(editionName);
				   }
				});
		}
	</script>
  </head>
  
  <body>
  <div id="parentWrap" class="listWrap">
	  	<c:if test="${requestScope.editionName == '通用版'}">
	  		<a class="addNewChap" href="javascript:void(0)" onclick="showEditWindow();">增加基础知识点</a>
	  		<!--  input type="button" value="增加基础知识点" onclick="showEditWindow();"/-->
	  	</c:if>
	  	<div id="listContent" class="listCon">
	  		<div class="conTop">
	  			<ul>
	  				<li class="col1">
	  					<span class="bg1"></span>
	  					引用知识点名称
	  				</li>
	  				<li class="col2">
	  					<span class="bg2"></span>
	  					知识点名称
	  				</li>
	  				<li class="col3">	
	  					<span class="bg3"></span>
	  					是否有效
	  				</li>
	  				<li class="col4">
	  					<span class="bg4"></span>
	  					操作
	  				</li>
	  			</ul>
	  		</div>
	  		<div id="midCon" class="conMid no_select" unselectable="none" onselectstart="return false">
	  			<ul id="conMidBox">
	  				<c:forEach items="${requestScope.loreCatalogList}" var="lc">
	  					<li>
	  						<p class="conMidTdWid" align="center" title="${lc.quoteLoreName}"><c:out value="${lc.quoteLoreName}"/></p>
	  						<p class="conMidTdWid" align="center" title="${lc.loreName}"><c:out value="${lc.loreName}"/></p>
	  						<p class="conMidTdWid1">
	  							<c:if test="${lc.inUse == 0}">
	  								<span class="vaild">有效</span>
	  							</c:if>
	  							<c:if test="${lc.inUse == 1}">
	  								<span class="invalid">无效</span>
	  							</c:if>
	  						</p>
	  						<p class="conMidTdWid2" align="center">
	  							<a href="javascript:void(0)" title="编辑" onclick="showUpdateLoreCatalor(${lc.id},'${lc.loreName}',${lc.orders},${lc.inUse})">修改</a> 
								<a title="删除" href="javascript:void(0)">删除</a>
	  							<c:if test="${lc.isFree == 0}">
	  								<a href="javascript:void(0)" onclick="setInFree(${lc.id},1)"><font color=red>取消免费</font></a>
	  							</c:if>
	  							<c:if test="${lc.isFree == 1}">
	  								<a href="javascript:void(0)" onclick="setInFree(${lc.id},0)"><font color=green>设置免费</font></a>
	  							</c:if>
	  							<c:if test="${lc.inUse == 0}">
	  								<a href="javascript:void(0)" onclick="setTestCentre(${lc.id},1)"><font color=red>取消考点</font></a>
	  							</c:if>
	  							<c:if test="${lc.inUse == 1}">
	  								<a href="javascript:void(0)" onclick="setTestCentre(${lc.id},0)"><font color=green>设置考点</font></a>
	  							</c:if>
	  						</p>
	  					</li>
	  				</c:forEach>
	  			</ul>
	  		</div>
	  		<!-- 翻页盒子  -->
	 		<div class="turnPageBox">
				<div class="markLayer"></div>
				<div class="turnPageParent">
				
				<p>第${requestScope.currentPage}页&nbsp;</p>
				<p>共${requestScope.pageCount}页</p>
				<a href="loreCatalogManager.do?action=queryLoreCatalog&chapterId=${requestScope.chapterId}&editionName=${requestScope.editionName}" class="indexPage">首页</a>
				<logic:greaterThan name="currentPage" scope="request" value="1">
					<a href="loreCatalogManager.do?action=queryLoreCatalog&pageNo=${requestScope.currentPage - 1}&chapterId=${requestScope.chapterId}&editionName=${requestScope.editionName}">
				</logic:greaterThan>上一页
				<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
				<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}">
				    <a href="loreCatalogManager.do?action=queryLoreCatalog&pageNo=${requestScope.currentPage + 1}&chapterId=${requestScope.chapterId}&editionName=${requestScope.editionName}">
				</logic:lessThan>下一页
				<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}"></a></logic:lessThan>
				<a href="loreCatalogManager.do?action=queryLoreCatalog&pageNo=${requestScope.pageCount}&chapterId=${requestScope.chapterId}&editionName=${requestScope.editionName}">尾页</a>
				</div>
	 		</div>
	  	</div>
    </div>
    <!-- 增加知识点窗口 -->
    <div id="newLoreCatalorWindow" style="display:none">
  		<div class="comDiv">
  			知识点名称:<input type="text" id="newLoreCatalorName"/>
  		</div>
  		<div class="comDiv">
  			排<span class="blank"></span>序:<input type="text" id="newOrders"/>
  		</div>
  		<div class="btnDiv">
  			<input type="button" class="fix"  value="增加" onclick="addLoreCatalor();"/>
  			<input type="button" class="cancelFix" value="取消" onclick="cancel('newLoreCatalorWindow');"/>
  		</div>
  	</div>
    <!-- 编辑知识点窗口 -->
    <div id="viewLoreCatalorWindow" style="display:none">
    	<input type="hidden" id="loreId"/>
    	<div class="comDiv">
  			知识点名称:<input type="text" id="viewLoreCatalorName"/>
  		</div>
  		<div class="comDiv">
  			排<span class="blank"></span>序:<input type="text" id="viewOrders"/>
  		</div>
  		<div class="comDiv">
  			是<span class="blank1"></span>否<span class="blank1"></span>有<span class="blank1"></span>效
  			<select id="viewInUse">
  				<option value="0">有效</option>
  				<option value="1">无效</option>
  			</select>

  		
  		</div>
  		<div class="btnDiv">
  			<center><input type="button" class="fix"  value="修改" onclick="updateLoreCatalor();"/>
  			<input type="button" class="cancelFix" value="取消" onclick="cancel('viewLoreCatalorWindow');"/>
  			</center>
  		</div>
    </div>
  </body>
</html>
