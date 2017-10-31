<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>    
    <title>viewLoreDetail.jsp</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/viewLoreDetailCss.css" type="text/css" rel="stylesheet"/>
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript">
	$(function(){
		hoverListColor("ulBox","li","#F0ECBD");
		moveQueryBox("moveWrap","parent");
	});
	//修改	
	function editDetail(loreId,loreQuestionId,loreTypeName){
		window.location.href = "loreManager.do?action=showDetail&loreId="+loreId+"&loreQuestionId="+loreQuestionId+"&loreTypeName="+encodeURIComponent(loreTypeName);
		if(loreTypeName=="解题示范"){
			changeHeight();
		}
	}
	//删除
	function delDetail(loreQuestionId,loreId,loreTypeName){
		if(confirm("是否真的删除该条记录?")){
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"loreManager.do?action=delDetail&loreQuestionId="+loreQuestionId+"&loreTypeName="+encodeURIComponent(loreTypeName),
		        success:function (json){
		        	if(json){
		        		alert("删除成功!");
		        	}else{
		        		alert("删除失败!");
		        	}
		        }
		    });
		}
		window.location.href = "loreManager.do?action=editDetail&loreId="+loreId;
	}
	//设置
	function setDetailStatus(loreQuestionId,loreId,status){
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        url:"loreManager.do?action=setDetailStatus&loreQuestionId="+loreQuestionId+"&inUse="+status,
	        success:function (json){
	        	if(json){
	        		alert("设置知识点状态成功!");
	        	}else{
					alert("设置知识点状态错误!");
	        	}
	        }
	    });
		window.location.href = "loreManager.do?action=editDetail&loreId="+loreId;
	}
	</script>
  </head>
  
  <body>
  	<div class="detailWrap">
  		<div class="topTitle">
  			<ul>
  				<li class="col1">
  					<span class="bg1"></span>
  					名称
  				</li>
  				<li class="col2">
  					<span class="bg2"></span>
  					题型
  				</li>
				<li class="col3">
  					<span class="bg3 special"></span>
  					是否有效
  				</li>
  				<li class="col4">
  					<span class="bg4"></span>
  					管理
  				</li>
  			</ul>
  		</div>
  		<div class="cenCon">
  			<ul id="ulBox">
  				<c:forEach items="${requestScope.lqList}" var="lq">
  					<li>
  						<p><c:out value="${lq.title}"/></p>
  						<p><c:out value="${lq.loreTypeName}"/></p>
  						<p>
  							<c:if test="${lq.inUse == 0}">
  								<span class="vaild">有效</span>
  							</c:if>
  							<c:if test="${lq.inUse == 1}">
  								<span class="invalid">无效</span>
  							</c:if>
  						</p>
  						<p>
  							<a href="javascript:void(0)" onclick="editDetail(${lq.lore.id},${lq.id},'${lq.loreTypeName}')">修改</a> 
  							<a href="javascript:void(0)" onclick="delDetail(${lq.id},${lq.lore.id},'${lq.loreTypeName}')">删除</a>
  							<c:if test="${lq.inUse == 0}">
  								<a href="javascript:void(0)" onclick="setDetailStatus(${lq.id},${lq.lore.id},1)">
  									<span class="invalid">设为无效</span>
  								</a>
  							</c:if>
  							<c:if test="${lq.inUse == 1}">
  								<a href="javascript:void(0)" onclick="setDetailStatus(${lq.id},${lq.lore.id},0)">
  									<span class="vaild">设为有效</span>
  								</a>
  							</c:if>
  						</p>
  					</li>
  				</c:forEach>
  			</ul>
  		</div>
  		<!-- 翻页盒子  -->
 		<div class="turnPageBoxs">
			<div class="markLayer"></div>
			<div class="turnPageParent">
			
				<p>第${requestScope.currentPage}页&nbsp;</p>
				<p>共${requestScope.pageCount}页</p>
				<a href="loreManager.do?action=editDetail&loreId=${requestScope.loreId}" class="indexPage">首页</a>
				<logic:greaterThan name="currentPage" scope="request" value="1">
					<a href="loreManager.do?action=editDetail&pageNo=${requestScope.currentPage - 1}&loreId=${requestScope.loreId}">
				</logic:greaterThan>上一页
				<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
				<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}">
				    <a href="loreManager.do?action=editDetail&pageNo=${requestScope.currentPage + 1}&loreId=${requestScope.loreId}">
				</logic:lessThan>下一页
				<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}"></a></logic:lessThan>
				<a href="loreManager.do?action=editDetail&pageNo=${requestScope.pageCount}&loreId=${requestScope.loreId}">尾页</a>
			</div>
 		</div>
  	</div>
  </body>
</html>
