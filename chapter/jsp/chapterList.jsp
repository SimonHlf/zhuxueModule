<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>章节管理</title>
    <link rel="stylesheet" type="text/css" href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
    <link href="Module/chapter/css/chapterLoreCatalogCss.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css" type="text/css" rel="stylesheet"/>    
	<link rel="stylesheet" type="text/css" href="Module/chapter/css/chapterCss.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript">
		$(function(){
			hoverListColor("conMidBox","li","#F0ECBD");
			scrollBar("midCon","conMidBox","boxScroll","scrollBar",10);
		});
		var chapterName_old;
		var orders_old;
		function showUpdateChapter(chapterId,chapterName,orders){
			var educationId = window.parent.getId("educationId").value;
			if(educationId == "0"){
				alert("请选择教材!");
			}else{
				chapterName_old = chapterName;
				orders_old = orders;
				getId("chapterId").value = chapterId;
				getId("chapterName").value = chapterName.split(":")[1];
				getId("orders").value = orders;
				var chapterTitleObj = getId("chapterTitle");
				for(var i = 1;i < 21;i++){
					var chapterTitle = numberConvertChapterTitle(i);
					chapterTitleObj.options.add(new Option(chapterTitle,chapterTitle));
				}
				selectIndex(chapterTitleObj,chapterName.split(":")[0]);
				getId("viewChapterWindow").style.display="";
				$('#viewChapterWindow').window({  
				   title:"章节修改", 
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
		function numberConvertChapterTitle(number){
			var convertStr = "";
			var chineseStr = new Array("第一单元","第二单元","第三单元","第四单元","第五单元",
								   "第六单元","第七单元","第八单元","第九单元","第十单元",
								   "第十一单元","第十二单元","第十三单元","第十四单元","第十五单元",
								   "第十六单元","第十七单元","第十八单元","第十九单元","第二十单元");
			if(number <= chineseStr.length){
				convertStr = chineseStr[number-1];
			}
			return convertStr;
		}
		//修改章节名称
		function updateChater(){
			var educationId = window.parent.getId("educationId").value;
			//判断章节名字是否存在
			var chapterId = getId("chapterId").value;
			var chapterTitle = getId("chapterTitle").value;
			var chapterName = getId("chapterName").value.replace(/\s+/g,"").replace(":","").replace("：","");
			var chapter = chapterTitle + ":" + chapterName;
			var chapter_encode = encodeURIComponent(chapter);
			var orders = getId("orders").value.replace(/\s+/g,"");
			if(chapterName == ""){
				alert("章节名不能为空");
			}else if(orders == ""){
				alert("排序不能为空");
			}else if(chapterName_old == chapter){
				if(orders_old == orders){
					cancel("viewChapterWindow");
				}else{
					//执行修改章节名称动作
					if(checkNumber(getId("orders"),"必须为数字")){
						executeUpdateChapter(chapterId,chapter_encode,orders,educationId);
					}
					
				}
			}else if(chapterName_old != chapter){
				//进行重名判断
				if(checkExist(educationId,chapter_encode)){
					alert("该章节名已存在，请重新输入");
				}else{
					//执行修改章节名称动作
					if(checkNumber(getId("orders"),"必须为数字")){
						executeUpdateChapter(chapterId,chapter_encode,orders,educationId);
					}
				}
			}
		}
		//修改章节动作
		function executeUpdateChapter(chapterId,chapterName,orders,educationId){
			var newUrl = "&chapterId="+chapterId+"&chapterName="+chapterName+"&orders="+orders;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"chapterManager.do?action=updateChapter"+newUrl,
				  success:function (json){ 
					  if(json){
						  alert("修改成功!");
						  window.location.href="chapterManager.do?action=queryChapter&educationId="+educationId;;
					  }else{
						  alert("修改失败!");
					  }
				   }
				});
		}
		//取消(关闭窗口)
		function cancel(value){
			$("#"+value).window("close");
		}
		//章节名字重名判断（一本教材的章节名字是唯一的）
		function checkExist(educationId,chapterName){
			var ms = true;
			$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"chapterManager.do?action=checkExist&chapterName="+encodeURIComponent(chapterName)+"&educationId="+educationId,
					  success:function (msg){ 
						  ms=msg;
					   }
					});
			//true:存在  || false：不存在
			return ms;	
		}
		//打开增加新纪录窗口
		function showNewChapterWindow(){
			var educationId = window.parent.getId("educationId").value;
			if(educationId == "0"){
				alert("请选择教材!");
			}else{
				var newChapterTitleObj = getId("newChapterTitle");
				var currentOrders = getCurrentMaxOrder();//获取当前最大orders
				for(var i = 1;i < 21;i++){
					var newChapterTitle = numberConvertChapterTitle(i);
					newChapterTitleObj.options.add(new Option(newChapterTitle,newChapterTitle));
				}
				//根据当前order选择下拉列表单元
				selectIndex(newChapterTitleObj,numberConvertChapterTitle(currentOrders));
				getId("newOrders").value = currentOrders;
				getId("newChapterWindow").style.display="";
				$("#newChapterWindow").window({  
				   title:"新增章节", 
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
		//增加新纪录动作
		function addChapter(){
			var educationId = window.parent.getId("educationId").value;
			var newChapterTitle = getId("newChapterTitle").value;
			var newChapterName = getId("newChapterName").value.replace(/\s+/g,"").replace(":","").replace("：","");
			var newChapter = newChapterTitle + ":" + newChapterName;
			var newChapter_encode = encodeURIComponent(newChapter);
			var newOrders = getId("newOrders").value.replace(/\s+/g,"");
			if(newChapterName == ""){
				alert("章节名不能为空");
			}else if(newOrders == ""){
				alert("排序不能为空");
			}else if(checkNumber(getId("newOrders"),"必须为数字")){
				if(checkExist(educationId,newChapter_encode)){
					alert("该章节名已存在，请重新输入");
				}else{
					var newUrl = "&newChapterName="+newChapter_encode+"&newOrders="+newOrders+"&educationId="+educationId;
					$.ajax({
						  type:"post",
						  async:false,
						  dataType:"json",
						  url:"chapterManager.do?action=addChapter"+newUrl,
						  success:function (json){ 
							  if(json > 0){
								  alert("增加成功!");
							  }else{
								  alert("增加失败!");
							  }
							  window.location.href="chapterManager.do?action=queryChapter&educationId="+educationId;
						   }
						});
				}
			}
		}
		//获取指定教材下当前最大的排序号
		function getCurrentMaxOrder(){
			var educationId = window.parent.getId("educationId").value;
			var currentOrder = 1;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"chapterManager.do?action=getCurrentMaxOrder&educationId="+educationId,
				  success:function (json){ 
					  currentOrder = json;
				  }
			});
			return currentOrder;
		}
	</script>
  </head>
  
  <body>
  	<div id="parentWrap" class="listWrap">
  		<a class="addNewChap" href="javascript:void(0)" onclick="showNewChapterWindow();">添加新章节</a>
  		<div id="listContent" class="listCon">
  			<div class="conTop">
  				<ul>
  					<li class="col1">
  						<span class="bg1"></span>
  						章节名称
  					</li>
  					<li class="ml col2">
  						<span class="bg2"></span>
  						排序
  					</li>
  					<li class="ml col3">
  						<span class="bg3"></span>
  						操作
  					</li>
  				</ul>
  			</div>
  			<div id="midCon" class="conMid no_select" unselectable="none" onselectstart="return false">
  				<ul id="conMidBox">
  					<c:forEach items="${requestScope.cList}" var="chapter">
  						<li>
  							<p class="chapterName"><c:out value="${chapter.chapterName}"/></p>
  							<p class="chapterSort ml"><c:out value="${chapter.orders}"/></p>
  							<p class="chapterSet ml">
  								<a class="edit" title="编辑" href="javascript:void(0)" onclick="showUpdateChapter(${chapter.id},'${chapter.chapterName}',${chapter.orders})"></a>
  								<a class="dele" title="删除" href="javascript:void(0)"></a>
  							</p>
  						</li>
  					</c:forEach>
  				</ul>
  			</div>
  			<div id="boxScroll" class="scrollBox">
  				<div id="scrollBar" class="scrollBar"></div>
  			</div>
  		</div>
  	</div>
	<!-- 修改详细信息窗口 -->
  	<div id="viewChapterWindow" style="display:none">
  		<input type="hidden" id="chapterId"/>
  		<div class="comDiv">
  			章节名称:<select id="chapterTitle"></select>
  			<input type="text" id="chapterName"/>
  		</div>
  		<div class="comDiv">
  			排<span class="blank"></span>序:<input type="text" id="orders"/>
  		</div>
  		<div class="btnDiv">
	  		<input type="button" class="fix" value="修改" onclick="updateChater();"/>
	  		<input type="button" class="cancelFix" value="取消" onclick="cancel('viewChapterWindow');"/>
  		</div>
  	</div>
  	<!-- 新增详细信息窗口 -->
  	<div id="newChapterWindow" style="display:none">
  		<div class="comDiv">
  			章节名称:<select id="newChapterTitle"></select>
  			<input type="text" id="newChapterName"/>
  		</div>
  		<div class="comDiv">
  			排<span class="blank"></span>序:<input type="text" id="newOrders"/>
  		</div>
  		<div class="btnDiv">
  			<input type="button" class="fix"  value="增加" onclick="addChapter();"/>
  			<input type="button" class="cancelFix" value="取消" onclick="cancel('newChapterWindow');"/>
  		</div>
  	</div>
  </body>
</html>
