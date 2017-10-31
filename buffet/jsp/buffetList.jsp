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
		var current_buffet_id = 0;
		var current_buffet_name = "";
		var chapterId = "${requestScope.chapterId}";
		var editionId = "${requestScope.editionId}";
		var editionName = "${requestScope.editionName}";
		var currLoreId = "${requestScope.loreId}";
		var sousuoFlag = true;
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
		function delBuffet(buffetId,loreId){
			var curr_select_chapeter_id = window.parent.$("#chapterId").val();
			if(checkCurrentSelectChapter(curr_select_chapeter_id)){
				alert("请先点击查询按钮后再进行操作!");
			}else{
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
				window.location.href = "buffetManager.do?action=queryBuffetByLoreId&loreId="+loreId+"&chapterId="+chapterId+"&editionName="+encodeURIComponent(editionName);
			}
		}
		//根据知识点查询除通用版以外的其他版本的该知识点
		function queryInfoByLoreName(){
			var searchRelateLoreName = $("#searchRelateLoreName").val();
			if(searchRelateLoreName == "请输入您要搜索的知识点"){
				alert("请输入知识点名称");
				getId("searchRelateLoreName").focus();
			}else{
				if(searchRelateLoreName.length >= 2){
					$.ajax({
				        type:"post",
				        async:false,
				        dataType:"json",
				        url:"loreManager.do?action=findLoreByName&loreName="+encodeURIComponent(searchRelateLoreName),
				        success:function (json){
				        	showLoreList(json);
				        	createScrolls();
				        	hoverListColor("loreListUl","li","#F0ECBD");
				        }
				    });
				}else{
					alert("为了不影响查询速度，请至少输入两个或以上的关键字!");
					getId("searchRelateLoreName").focus();
				}
			}
		}
		//根据搜索内容的多少来判断是否需要动态创建模拟滚动条
		function createScrolls(){
			var oScroll = "<div id='scrollPar' class='parScroll'><div id='scrollSon' class='sonScroll'></div></div>"
			if($("#loreListUl").height() > $(".sousuoUlBox").height()){
				if(sousuoFlag){
					$(".sousuoUlBox").append(oScroll);	
				}
				scrollBar("ulBoxSousuo","loreListUl","scrollPar","scrollSon",10);
				$(".sousuoUl").animate({"top":0});
				$(".sonScroll").animate({"top":0});
				sousuoFlag = false;
			}else{
				sousuoFlag = true;
				$(".sousuoUl").animate({"top":0});
				$(".parScroll").remove();
				getId("ulBoxSousuo").onmousewheel = function(){
					return false;
				};
			}
		}
		//模糊列出知识点列表
		function showLoreList(list){
			var li = "";
			if(list==null){
				
			}else{
				for(i=0; i<list.length; i++){
				  var inUse = "";
				  li += "<li>"+"<p class='seaWid1'>"+list[i].educationVO.grade.gradeName+"</p>";
				  li += "<p class='seaWid2 searchMl ellip' title='"+ list[i].educationVO.subject.subName +"'>"+list[i].educationVO.subject.subName+"</p>";
				  li += "<p class='seaWid3 searchMl ellip' title='"+ list[i].educationVO.edition.ediName +"'>"+list[i].educationVO.edition.ediName+"</p>";
				  li += "<p class='seaWid4 searchMl ellip' title='" + list[i].chapter.chapterName + "'>"+list[i].chapter.chapterName+"</p>";
				  li += "<p class='seaWid4 searchMl ellip' title='"+ list[i].loreName +"'>"+list[i].loreName+"</p>";
				  if(list[i].inUse == "0"){
					  inUse = "<font color='green'>启用</font>";
				  }else{
					  inUse = "<font color='red'>未启用</font>";
				  }
				  li += "<p class='seaWid1 searchMl'>"+inUse+"</p>";
				  li += "<p onclick='addLoreRelate("+list[i].educationVO.edition.id+","+list[i].id+")' class='seaWid1 searchMl addBtns'>增加</p></li>";
				}
			}
			$('#loreListUl').html(li);
		}
		function addLoreRelate(selectEditionId,relationLoreId){
			var flag = false;
			if(relationLoreId == 0){
				alert("请选择一个或多个关联知识点添加!");
			}else if(editionId != selectEditionId){
				if(confirm("系统检测到当前所选出版社和当前知识点出版社不一致，是否继续!")){
					flag = true;
				}
			}else{
				flag = true;
			}
			if(flag){
				if(!checkExistRelationByBuffetAndLore(current_buffet_id,currLoreId,relationLoreId)){
					$.ajax({
						  type:"post",
						  async:false,
						  dataType:"json",
						  url:"blrManager.do?action=addBuffetLoreRelate&buffetId="+current_buffet_id+"&loreId="+relationLoreId+"&currLoreId="+currLoreId+"&editionId="+editionId,
						  success:function (json){ 
							 if(json){
								 alert("增加涉及知识点成功!");
								 getBuffetLoreRelation(current_buffet_id,currLoreId);//刷新当前巴菲特关联知识点列表
								 showBuffetTree(currLoreId);
								 $("#loreRelationListUl li:odd").addClass("oddColorLi");
							 }
						  }
					});
				}else{
					alert("已关联了该知识点，请另外选择需要关联的知识点!");
				}
			}
		}
		//回车事件
	  	function enterPress(e){
	 		var e = e || window.event;
	  		if(e.keyCode == 13){
	  			queryInfoByLoreName();
	  		}
	  	}
	</script>
  </head>
  
  <body>
    <div id="parentWrap" class="listWrap">
  		<div id="listContent" class="listCon">
  			<div class="conTop">
  				<ul>
  					<li class="widthOne">类型</li>
  					<li class="ml widthTwo">知识点</li>
  					<li class="ml widthThree">名称</li>
  					<li class="ml widthFour">思维</li>
  					<li class="ml widthFour">能力</li>
  					<li class="ml widthOne">状态</li>
  					<li class="ml widthTwo">操作</li>
  				</ul>
  			</div>
  			<div id="midCon" class="conMid no_select" unselectable="none" onselectstart="return false">
  				<table id="conMidBox" cellpadding="0" cellspacing="0">
  					<c:forEach items="${requestScope.buffetList}" var="buffet">
  						<tr>
  							<td class="widthOne" align="center"><c:out value="${buffet.buffet.buffetType.types}"/></td>
  							<td class="widthTwo" align="center" title="${buffet.buffet.lore.loreName}"><c:out value="${buffet.buffet.lore.loreName}"/></td>
  							<td class="widthThree" align="center"><c:out value="${buffet.buffet.title}"/></td>
  							<td class="widthFour" align="center"><c:out value="${buffet.buffetMindTypeNameStr}"/></td>
  							<td class="widthFour" align="center"><c:out value="${buffet.buffetAbilityTypeNameStr}"/></td>
  							<td class="" align="center">
  								<c:if test="${buffet.buffet.inUse == 0}"><font color="green">启用</font></c:if>
  								<c:if test="${buffet.buffet.inUse == 1}"><span class="red">未启用</span></c:if>
  							</td>
  							<td class="widthTwo fix" align="center">
  								<c:if test="${requestScope.editionName == '通用版'}">
  									<a href="javascript:void(0)" class="editlore" onclick="showDetail(${buffet.buffet.id})">修改</a>
	 								<c:if test="${buffet.buffet.inUse == 0}">
	 									<a href="javascript:void(0)" class="viewLore" onclick="setUseFlag(${buffet.buffet.id},${buffet.buffet.lore.id},${buffet.buffet.inUse})"><span class="red">设置未启用</span></a>
	 								</c:if>
	 								<c:if test="${buffet.buffet.inUse == 1}">
	 								<a href="javascript:void(0)" class="viewLore" onclick="setUseFlag(${buffet.buffet.id},${buffet.buffet.lore.id},${buffet.buffet.inUse})"><font color="green">设置启用</font></a>
 								</c:if>				 
  								</c:if>
 								<c:if test="${requestScope.editionName == '通用版'}">
 									<a href="javascript:void(0)" class="viewLore">关联词条 </a>
 									<a href="javascript:void(0)" class="delLore" onclick="delBuffet('${buffet.buffet.id}','${buffet.buffet.lore.id}')">删除 </a>
 								</c:if>
 								<c:if test="${requestScope.editionName != '通用版'}">
 									<a href="javascript:void(0)" class="viewLore" onclick="showRelationView(${buffet.buffet.id},'${buffet.buffet.title}','${requestScope.loreId}')" title="设置巴菲特溯源知识点">关联知识点</a>
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
							<a href="buffetManager.do?action=queryBuffetByLoreId&loreId=${requestScope.loreId}&chapterId=${requestScope.chapterId}&editionName=${requestScope.editionName}" class="indexPage">首页</a>
							<logic:greaterThan name="currentPage" scope="request" value="1">
								<a href="buffetManager.do?action=queryBuffetByLoreId&pageNo=${requestScope.currentPage - 1}&loreId=${requestScope.loreId}&chapterId=${requestScope.chapterId}&editionName=${requestScope.editionName}">
							</logic:greaterThan>上一页
							<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
							<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}">
							    <a href="buffetManager.do?action=queryBuffetByLoreId&pageNo=${requestScope.currentPage + 1}&loreId=${requestScope.loreId}&chapterId=${requestScope.chapterId}&editionName=${requestScope.editionName}">
							</logic:lessThan>下一页
							<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}"></a></logic:lessThan>
							<a href="buffetManager.do?action=queryBuffetByLoreId&pageNo=${requestScope.pageCount}&loreId=${requestScope.loreId}&chapterId=${requestScope.chapterId}&editionName=${requestScope.editionName}">尾页</a>
	 					</div>
	 				</div>
 				</c:if>
 				<div id="boxScroll" class="scrollBox">
  					<div id="scrollBar" class="scrollBar"></div>
  				</div>
  			</div>
  		</div>
  	</div>
    <!--  关联知识点 -->
    <div id="viewRelationWindow" style="display:none;">
    	 <h2 class="nowLore txtAlign">当前巴菲特题:<span id="currentBuffetName"></span></h2>
    	 <!-- 左侧选择知识点并添加  -->
    	 <div class="leftChoicePoint fl">
    	 	 <ul class="nowTabNav clearfix">
    	 		<li class="nowTits active">选择知识点</li>	
    	 		<li class="nowTits nowMl">搜索知识点</li>
    	 	 </ul>
    	 	 <div class="choiceBox selTabCon" style="display:block;">
	    	 	 <div id="selectSubjectDiv2" class="buffSelWid1"></div>
			     <div id="selectGradeDiv2" class="buffSelWid1"></div>
			     <div id="selectEditionDiv2" class="buffSelWid2"></div>
			     <div id="selectEducationDiv2" class="buffSelWid2"></div>
		    	 <div id="selectChapterDiv2" class="buffSelWid3"></div>
		    	 <div id="selectLoreDiv2" class="buffSelWid4"></div> 
		    	 <span class="addBuffetBtn" onclick="addBuffetLoreRelation()">添加</span>
    	 	 </div>
    	 	 <div class="choiceBox selTabCon" style="display:none;">
    	 	 	<div class="searchBtnBox">
    	 	 		<input type="text" class="txts" id="searchRelateLoreName"/>
    	 	 		<input type="button" class="btns" value="查询" onclick="queryInfoByLoreName()"/>
    	 	 	</div>
    	 	 	<ul class="searchNavBox">
	    	 		<li class="seaWid1">年级</li>
					<li class="seaWid2 searchMl">学科</li>
					<li class="seaWid3 searchMl">出版社</li>
					<li class="seaWid4 searchMl">章节</li>
					<li class="seaWid4 searchMl">知识点</li>
					<li class="seaWid1 searchMl">状态</li>
					<li class="seaWid1 searchMl">操作</li>
	    	 	</ul>
	    	 	<div id="ulBoxSousuo" class="sousuoUlBox">
	    	 		<ul class="sousuoUl" id="loreListUl"></ul>
	    	 	</div>
    	 	 </div>
    	 	 <div id="buffetLoreRelationWindow" class="clearfix"></div>
    	 </div>
    	 <!-- 右侧知识树  -->
    	 <div class="rightTree fr">
    	 	<p class="nowTits pBg2">知识树<p>
    	 	<div class="treeBox bor_r">
	    	 	<div id="buffetLoreTreeWindow">
			  		<ul id="tt" class="easyui-tree" data-options="animate:true,lines:true"></ul>
			  	</div>
    	 	</div>
    	 </div>
	  	<!-- 分界线  -->
	  	<div class="line"></div>
  	</div>
  </body>
</html>
