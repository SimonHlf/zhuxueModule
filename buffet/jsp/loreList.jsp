<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>基础巴菲特题库列表</title>
    
    <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
 	<link href="Module/buffet/css/buffetList.css" type="text/css" rel="stylesheet" />
 	<link href="Module/loreManager/css/relatePointCss.css" type="text/css" rel="stylesheet" />
 	<link href="Module/chapter/css/comSeleListCss.css" type="text/css" rel="stylesheet" />
 	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css" rel="stylesheet" type="text/css"/>   
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/buffet/js/commonList.js"></script>
	<script type="text/javascript" src="Module/buffet/js/buffetList.js"></script>
	<script type="text/javascript">
		var chapterId = "${requestScope.chapterId}";
		var chapterName = "${requestScope.chapterName}";
		var current_lore_id = 0;
		var current_lore_name = "";
		var editionId = "${requestScope.editionId}";
		var editionName = "${requestScope.editionName}";
		var currLoreId = 0;
		$(function(){
			hoverListColor("conMidBox","tr","#F0ECBD");
		});
		//检查页面传递的章节和当前选择的章节是否一致
		function checkCurrentSelectChapter(curr_select_chapter_id){
			if(chapterId != curr_select_chapter_id){
				return true;
			}else{
				return false;
			}
		}
		function delBuffet(buffetId){
			if(confirm("删除该记录会导致与之相关联的数据都将被删除，是否确定?")){
				$.ajax({
			        type:"post",
			        async:false,
			        dataType:"json",
			        url:"buffetManager.do?action=delBuffet&id="+buffetId,
			        success:function (json){
			        	if(json){
			        		alert("删除成功!");
			        	}else{
			        		alert("删除失败!");
			        	}
			        }
			    });
			}
			window.parent.queryInfo();
		}
		//判断当前知识点是否是合并知识点中最后一个知识点
		function checkEndJoinLoreId(loreId){
			var flag = false;
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"buffetManager.do?action=showReferLoreIdArray&loreId="+loreId,
		        success:function (json){
		        	flag = json;
		        }
		    });
			return flag;
		}
		//转向上传巴菲特界面
		function showAddBuffet(loreId,loreName){
			if(checkCurrentSelectChapter(window.parent.$("#chapterId").val())){
				alert("请先点击查询按钮后再进行增加!");
			}else{
				//if(checkEndJoinLoreId(loreId)){
					window.location.href = "buffetManager.do?action=newBuffet&loreId="+loreId+"&loreName="+encodeURIComponent(loreName);
					window.parent.$(".iframeWrap").height(1310);
					window.top.$(".rightPart").height(1365);
				//}else{
					//alert("请选择最后一个合并知识点进行操作!");
					//window.location.reload();
				//}
			}
		}
		//编辑巴菲特导向该知识点下巴菲特列表
		function showBuffetDetail(loreId){
			if(checkCurrentSelectChapter(window.parent.$("#chapterId").val())){
				alert("请先点击查询按钮后再进行操作!");
			}else{
				//if(checkEndJoinLoreId(loreId)){
					window.location.href = "buffetManager.do?action=queryBuffetByLoreId&loreId="+loreId+"&chapterId="+chapterId+"&editionId="+editionId+"&editionName="+encodeURIComponent(editionName);	
				//}else{
					//alert("请选择最后一个合并知识点进行操作!");
					//window.location.reload();
				//}
			}		
		}
		//显示合并知识点记录窗口
		function showJoinLoreView(loreId,loreName){
			if(checkCurrentSelectChapter(window.parent.$("#chapterId").val())){
				alert("请先点击查询按钮后再进行操作!");
			}else{
				getId("viewReferLoreWindow").style.display="";
				$("#viewReferLoreWindow").window({  
				   title:"["+loreName+"]对应知识点", 
				   width:435,   
				   height:415, 
				   collapsible:false,
				   minimizable:false,
				   maximizable:false,
				   resizable:false,
				   modal:true  
				});
				closeWindowBySystemIcon("viewReferLoreWindow");
				$("#loreDiv").html("");
				currLoreId = 0;
				getReferLoreList(loreId);
				currLoreId = loreId;
			}
		}
		//获取合并知识点列表
		function getReferLoreList(loreId){
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"buffetManager.do?action=showReferLoreList&loreId="+loreId+"&chapterId="+chapterId,
		        success:function (json){
		        	showReferLoreList(loreId,json);
		        	hoverListColor("showReferUl","li","#F0ECBD");
		        }
		    });
		}
		//显示涉及知识点列表
		function showReferLoreList(loreId,list){
			var ul_s = "<ul id='showReferUl'>";
			var ul_e = "</ul>";
			var li = "";
			var input = "";
			var jlrId = 0;
			if(list != null){
				for(i=0; i<list.length; i++){
					if(loreId != list[i].loreId){
						if(list[i].referFlag){//存在知识点共用巴菲特题
							li += "<li><input type='checkbox' name='lore_refer' id='inp_"+ list[i].loreId +"' value='"+list[i].loreId+"' checked>&nbsp;" + "<label for='inp_"+ list[i].loreId +"' class='referLabel'>" + list[i].loreName + "</label>" + "</li>";
						}else{
							li += "<li><input type='checkbox' name='lore_refer' id='inp_"+ list[i].loreId +"' value='"+list[i].loreId+"'>&nbsp;" + "<label for='inp_"+ list[i].loreId +"' class='referLabel'>" + list[i].loreName + "</label>" + "</li>";
						}
					}else{
						li += "<li><input type='checkbox' name='lore_refer' id='inp_"+ list[i].loreId +"' value='"+list[i].loreId+"' checked disabled>&nbsp;" + "<label for='inp_"+ list[i].loreId +"' class='referLabel'>" + list[i].loreName + "</label>" + "</li>";
						jlrId = list[i].jlrId;
					}
				}
				input += "<input type='button' class='referLoreSetBtn' value='设置' onclick='referLore("+jlrId+")'/>";
			}
			$("#loreDiv").html(ul_s + li + ul_e + input);
		}
		//设置对应知识点
		function referLore(jlrId){
			var selectOptions = document.getElementsByName("lore_refer"); 
			var loreIdArray = "";
			var checkNumber = 0;
			for(var i = 0 ; i < selectOptions.length ; i++){
				if(selectOptions[i].checked){
					checkNumber += 1;
					loreIdArray += selectOptions[i].value + ",";
				}
			}
			if(loreIdArray != ""){
				loreIdArray = loreIdArray.substring(0,loreIdArray.length - 1);
			}
			//checkNumber == 1说明是该知识点没有其他的合并知识点（多选没选中）
			//jlrId == 0时不执行操作
			//jlrId > 0时删除合并知识点记录

			//checkNumber > 1说明是该知识点有其他的合并知识点（多选选中）
			//jlrId == 0时表示之前没记录，现在需增加
			//jlrId > 0时表示修改记录
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"buffetManager.do?action=setReferLoreByLoreId&loreId="+currLoreId+"&jlrId="+jlrId+"&checkNumber="+checkNumber+"&loreIdArray="+loreIdArray,
		        success:function (json){
		        	if(json){
		        		alert("修改成功!");
		        	}else{
		        		alert("修改失败");
		        	}
		        	$("#viewReferLoreWindow").window("close");
		        	window.location.reload();
		        }
		    });
		}
		//封装关闭窗口（点击窗口关闭按钮时的事件）
		function closeWindowBySystemIcon(windowObj){
			$("#"+windowObj).window({
		        onBeforeClose: function () {
		        	window.location.reload();
		        }
		    });
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
 								<c:if test="${requestScope.editionName == '通用版'}">
 									<a href="javascript:void(0)" class="upLoad" onclick="showAddBuffet('${lore.id}','${lore.loreName}')">上传</a>
	  							</c:if>		
	  							<a href="javascript:void(0)" class="editlore" onclick="showBuffetDetail('${lore.id}')">编辑</a>
	  							<a href="javascript:void(0)" class="editlore" onclick="showBuffetView('${lore.id}','${lore.loreName}')">浏览</a>	
	  							<c:if test="${requestScope.editionName == '通用版'}">
 									<a href="javascript:void(0)" class="editlore" onclick="showJoinLoreView('${lore.id}','${lore.loreName}')" title="与之合并知识点采用同一巴菲特">合并知识点</a>
	  							</c:if>	
	  									
  							</td>
  						</tr>
  					</c:forEach>
  				</table>
 				<!-- 翻页盒子  -->
				<c:if test="${requestScope.currentPage != '-1'}">
					<div class="turnPageBoxBuffer">
						<div class="markLayer"></div>
						<div class="turnPageParent">
						<p>第${requestScope.currentPage}页&nbsp;</p>
						<p>共${requestScope.pageCount}页</p>
						<a href="buffetManager.do?action=queryLore&chapterId=${requestScope.chapterId}&chapterName=${requestScope.chapterName}&editionName=${requestScope.editionName}" class="indexPage">首页</a>
						<logic:greaterThan name="currentPage" scope="request" value="1">
							<a href="buffetManager.do?action=queryLore&pageNo=${requestScope.currentPage - 1}&chapterId=${requestScope.chapterId}&chapterName=${requestScope.chapterName}&editionName=${requestScope.editionName}">
						</logic:greaterThan>上一页
						<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
						<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}">
						    <a href="buffetManager.do?action=queryLore&pageNo=${requestScope.currentPage + 1}&chapterId=${requestScope.chapterId}&chapterName=${requestScope.chapterName}&editionName=${requestScope.editionName}">
						</logic:lessThan>下一页
						<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}"></a></logic:lessThan>
						<a href="buffetManager.do?action=queryLore&pageNo=${requestScope.pageCount}&chapterId=${requestScope.chapterId}&chapterName=${requestScope.chapterName}&editionName=${requestScope.editionName}">尾页</a>
						</div>
					</div>
				</c:if>
 				<div id="boxScroll" class="scrollBox">
  					<div id="scrollBar" class="scrollBar"></div>
  				</div>
  			</div>
  		</div>
  	</div> 	
  	<!-- 浏览基础巴菲特  -->
    <div id="viewBuffetListWindow" style="display:none;">
    	<div id="viewWrap" class="viewPointWrap">
			<!-- 头部导航  -->    	
	    	<div id="navTop" class="topNav">
	    		<ul>
	    			<li class="bg1">
	    				<a href="#xqkfListDiv">兴趣激发</a>
	    			</li>
	    			<li class="bg2">
	    				<a href="#ffgnDiv">方法归纳</a>
	    			</li>
	    			<li class="bg3">
	    				<a href="#swxlDiv">思维训练</a>
	    			</li>
	    			<li class="bg4">
	    				<a href="#zlkfDiv">智力开发</a>
	    			</li>
	    			<li class="bg5">
	    				<a href="#nlpyDiv">能力培养</a>
	    			</li>
	    			<li class="bg6">
	    				<a href="#gkslDiv">高考涉猎</a>
	    			</li>
	    		
	    		</ul>
	    	</div>
	    	<!-- 主体内容  -->
	    	<div class="mainContent">
	    		<!-- 兴趣开发  -->
	    		<div id="xqkfListDiv" class="listLoreWrap"></div>
	    		<!-- 方法归纳 -->
	    		<div id="ffgnDiv" class="loreGuideWrap margT"></div>
	    		<!-- 思维训练  -->
	    		<div id="swxlDiv" class="loreExampleWrap margT"></div>
	    		<!-- 智力开发  -->
	    		<div id="zlkfDiv" class="loreConSolidWrap margT"></div>
	    		<!-- 能力培养  -->
	    		<div id="nlpyDiv" class="loreTargetWrap margT"></div>
	    		<!-- 高考涉猎  -->
	    		<div id="gkslDiv" class="loreAgainWrap margT"></div>
	    	</div>
    	</div>	
      </div>
      <div id="viewReferLoreWindow" style="display:none;">
      	<div id="loreDiv"></div>
      </div>
  </body>
</html>
