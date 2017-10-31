<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>    
    <title>巴菲特知识点列表</title>
    
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
 	<link href="Module/buffet/css/buffetLoreListCss.css" type="text/css" rel="stylesheet" />
 	<link href="Module/chapter/css/comSeleListCss.css" type="text/css" rel="stylesheet" />
 	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css" rel="stylesheet" type="text/css"/>   
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/loreManager/flashPlayer/images/swfobject.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/buffet/js/commonList.js"></script>
	<script type="text/javascript">
	$(function(){
		hoverListColor("conMidBox","tr","#F0ECBD");
	});
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
	//封装关闭窗口（点击窗口关闭按钮时的事件）
	function closeWindowBySystemIcon(windowObj,url){
		$("#"+windowObj).window({
	        onBeforeClose: function () {
	        	window.location.href =  url;
	        }
	    });
	}
	//显示包含巴菲特窗口
	function showBuffet(loreId){
		showWindow("referBuffetWindow","包含巴菲特",580,415);
		$.ajax({
			  type:"post",
			  async:false,
			  dataType:"json",
			  url:"buffetLoreManager.do?action=showReferBuffet&loreId="+loreId,
			  success:function (json){ 
				  showBuffetList(json);
			  }
		});
		$(".conTr:odd").addClass("oddColor");
	}
	//根据知识点获取该知识点下的巴菲特题库
	function showBuffetList(list){
		var tableText = "<table id='hasBuffetBox' cellpadding='0' cellspacing='0' class='hasBuffetTable'><tr class='headTab'>";
		var tText = "<td width='120' align='center'>名称</td><td  width='180' align='center'>思维</td><td  width='180' align='center'>能力</td><td  width='60' align='center'>状态</td>";
		var trEnd = "</tr>";
		var dateText = "";
		var tableEnd = "</table>";
		if(list != null){
			for(var i = 0 ; i < list.length; i++){
				var inUseText = "";
				if(list[i].buffet.inUse == 0){
					inUseText = "<font color='green'>启用</font>";
				}else{
					inUseText = "<font color='red'>未启用</font>";
				}
				dateText += "<tr class='conTr'><td align='center'>"+list[i].buffet.title+"</td><td align='center'>"+list[i].buffetMindTypeNameStr+"</td><td align='center'>"+list[i].buffetAbilityTypeNameStr+"</td><td align='center'>"+inUseText+"</td></tr>"; 
			}
		}
		$('#referBuffetWindow').html(tableText+tText+trEnd+dateText+tableEnd);
	}
	</script>
  </head>
  
  <body>
    <div id="parentWrap" class="listWrap">
  		<div id="listContent" class="listCon">
  			<div class="conTop">
  				<ul>
  					<li class="widthOne">学科</li>
  					<li class="ml widthOne">年级</li>
  					<li class="ml widthOne">教材</li>
  					<li class="ml widthTwo">章节</li>
  					<li class="ml widthTwo">知识点</li>
  					<li class="ml widthOne">状态</li>
  					<li class="ml widthTwo">操作</li>
  				</ul>
  			</div>
  			<div id="midCon" class="conMid no_select" unselectable="none" onselectstart="return false">
  				<table id="conMidBox" cellpadding="0" cellspacing="0">
  					<c:forEach items="${requestScope.loreList}" var="lore">
  						<tr>
  							<td class="widthOne" align="center"><c:out value="${lore.educationVO.subject.subName}"/></td>
  							<td class="widthOne" align="center"><c:out value="${lore.educationVO.grade.gradeName}"/></td>
  							<td class="widthOne" align="center"><c:out value="${lore.educationVO.volume}"/></td>
  							<td class="widthTwo" align="center" title="${lore.chapter.chapterName}"><c:out value="${lore.chapter.chapterName}"/></td>
  							<td class="widthTwo" align="center" title="${lore.loreName}"><c:out value="${lore.loreName}"/></td>
  							<td class="widthOne" align="center">
  								<c:if test="${lore.inUse == 0}">启用</c:if>
  								<c:if test="${lore.inUse == 1}"><span class="red">未启用</span></c:if>
  							</td>
  							<td class="widthTwo fix" align="center">		
 								<a href="javascript:void(0)" class="viewLore" onclick="showBuffet('${lore.id}')">包含巴菲特</a> 
  							</td>
  						</tr>
  					</c:forEach>
  				</table>
 				<div id="boxScroll" class="scrollBox">
  					<div id="scrollBar" class="scrollBar"></div>
  				</div>
  			</div>
			<!-- 翻页盒子  -->
			<c:if test="${requestScope.currentPage != '-1'}">
				<div class="turnPageBoxBuffer">
					<div class="markLayer"></div>
					<div class="turnPageParent">
					<p>第${requestScope.currentPage}页&nbsp;</p>
					<p>共${requestScope.pageCount}页</p>
					<a href="buffetManager.do?action=queryBuffet&chapterId=${requestScope.chapterId}&chapterName=${requestScope.chapterName}&editionName=${requestScope.editionName}" class="indexPage">首页</a>
					<logic:greaterThan name="currentPage" scope="request" value="1">
						<a href="buffetManager.do?action=queryBuffet&pageNo=${requestScope.currentPage - 1}&chapterId=${requestScope.chapterId}&chapterName=${requestScope.chapterName}&editionName=${requestScope.editionName}">
					</logic:greaterThan>上一页
					<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
					<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}">
					    <a href="buffetManager.do?action=queryBuffet&pageNo=${requestScope.currentPage + 1}&chapterId=${requestScope.chapterId}&chapterName=${requestScope.chapterName}&editionName=${requestScope.editionName}">
					</logic:lessThan>下一页
					<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}"></a></logic:lessThan>
					<a href="buffetManager.do?action=queryBuffet&pageNo=${requestScope.pageCount}&chapterId=${requestScope.chapterId}&chapterName=${requestScope.chapterName}&editionName=${requestScope.editionName}">尾页</a>
					</div>
				</div>
			</c:if>
  		</div>
  	</div>
  	<div id="referBuffetWindow" style="display:none;"></div>
  </body>
</html>
