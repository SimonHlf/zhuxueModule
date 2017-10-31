<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>基础知识点信息列表</title>
    <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
 	<link href="Module/loreManager/css/loreMain.css" type="text/css" rel="stylesheet" />
 	<link href="Module/loreManager/css/relatePointCss.css" type="text/css" rel="stylesheet" />
 	<link href="Module/chapter/css/comSeleListCss.css" type="text/css" rel="stylesheet" />
 	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css" rel="stylesheet" type="text/css"/>   
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/loreManager/flashPlayer/images/swfobject.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/commonList.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript">
		$(function(){
			scrollBar("midCon","conMidBox","boxScroll","scrollBar",10);
			toScrollBlock();
			hoverListColor("conMidBox","tr","#F0ECBD");
		});
		window.top.onscroll = function(){
			return false;
		};
		var currentLoreId = "";
		//替换所有的单引号为自定义字符
		function replaceChara(value){
			return value.replace(/&#wmd;/g,"'");
		}
		//增加知识典的详细信息(7步)
		function addDetail(loreId,loreName){
			var mainWin = window.parent.document.getElementById("loreListFrame").contentWindow;
			mainWin.location.href = "loreManager.do?action=newDetail&loreId="+loreId+"&loreName="+encodeURIComponent(loreName);
		}
		//编辑知识点
		function showDetail(loreId){
			var mainWin = window.parent.document.getElementById("loreListFrame").contentWindow;
			mainWin.location.href = "loreManager.do?action=editDetail&loreId="+loreId;
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
			//closeWindowBySystemIcon(windowDiv);
		}
		//封装关闭窗口（点击窗口关闭按钮时的事件）
		function closeWindowBySystemIcon(windowObj){
			$("#"+windowObj).window({
		        onBeforeClose: function () {
		        	//window.location.href =  url;
		        	window.location.reload();
		        }
		    });
		}
		//浏览知识点
		function showDetailView(loreId,loreName){
			showWindow("viewLoreWindow","浏览知识点["+loreName+"]",800,550);
			//step:1 获取知识清单内容
			ajaxAction(loreId,"知识清单");
			//step:2获取点拨指导内容
			ajaxAction(loreId,"点拨指导");
			//step:3获取解题示范内容
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"loreManager.do?action=showExampleList&loreId="+loreId,
				  success:function (json){ 
					  showExampleList(json);
				  }
			});
			//step:4获取巩固训练内容
			ajaxAction(loreId,"巩固训练");
			//step:5获取针对性诊断内容
			ajaxAction(loreId,"针对性诊断");
			//step:6获取再次诊断内容
			ajaxAction(loreId,"再次诊断");
			//step:7获取知识讲解内容
			ajaxAction(loreId,"知识讲解");
		//	toFixed();
		}
		//知识清单/点拨指导动作
		function ajaxAction(loreId,loreTypeName){
			var newUrl = "";
			if(loreTypeName == "知识清单" || loreTypeName == "点拨指导"){
				newUrl = "loreManager.do?action=showLoreList&loreId="+loreId+"&loreTypeName="+encodeURIComponent(loreTypeName);
			}else{
				newUrl = "loreManager.do?action=showJsonList&loreId="+loreId+"&loreTypeName="+encodeURIComponent(loreTypeName);
			}
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:newUrl,
				  success:function (json){ 
					  if(loreTypeName == "知识清单"){
						  showDetailList(json);
					  }else if(loreTypeName == "点拨指导"){
						  showGuideList(json);
					  }else if(loreTypeName == "巩固训练"){
						  showPracticeList(json,"loreConsolidationDiv");
					  }else if(loreTypeName == "针对性诊断"){
						  showPracticeList(json,"loreTargetedDiv");
					  }else if(loreTypeName == "再次诊断"){
						  showPracticeList(json,"loreAgainDiv");
					  }else if(loreTypeName == "知识讲解"){
						  showVideoList(json);
					  }
				  }
			});
		}
		function showDetailList(list){
			var title = "";
			var content = "";
			var content_result = "";
			if(list != null){
				for(var i = 0 ; i < list.length; i++){
					title = "<div class='createDiv'><span class='createTit'>标题: "+list[i].subTitle.replace("<","&lt")+"</span>";
					content = "<div class='createCon'><span>内容:</span>"+list[i].subContent+"</div></div>";
					content_result += title + content;
				}
			}
			$('#loreListDiv').html("<h2 class='partTitle'>知识清单</h2>"+content_result);
		}
		function showGuideList(list){
			var loreType = "";
			var title = "";
			var content = "";
			var content_result = "";
			if(list != null){
				for(var i = 0 ; i < list.length; i++){
					if(i == 0){
						loreType = "<div class='smallTit'>"+"<span class='smallTitIcon'>"+"</span>"+"<h3>"+list[i].subType+"</h3>"+"</div>";
						title = "<div class='createDiv'><span class='createTit'>标题: "+list[i].subTitle.replace("<","&lt")+"</span>";
						content = "<div class='createCon'><span>内容:</span>"+list[i].subContent+"</div></div>";
					}else{
						if(list[i - 1].subType == list[i].subType){
							loreType = "";
							title = "<div class='createDiv'><span class='createTit'>标题: "+list[i].subTitle.replace("<","&lt")+"</span>";
							content = "<div class='createCon'><span>内容:</span>"+list[i].subContent+"</div></div>";
						}else{
							loreType = "<div class='smallTit'>"+"<span class='smallTitIcon'>"+"</span>"+"<h3>"+list[i].subType+"</h3>"+"</div>";
							title = "<div class='createDiv'><span class='createTit'>标题: "+list[i].subTitle.replace("<","&lt")+"</span>";
							content = "<div class='createCon'><span>内容:</span>"+list[i].subContent+"</div></div>";
						}
					}
					
					content_result += loreType + title + content;
				}
			}
			$('#loreGuideDiv').html("<h2 class='partTitle'>点拨指导</h2>"+content_result);
		}
		function showExampleList(list){
			var subject = "";
			var answer = "";
			var resolution = "";
			var content_result = "";
			if(list != null){
				for(var i = 0 ; i < list.length; i++){
					subject = "<div class='createDiv'><div class='createCon'><span>题干：</span>"+list[i].subject+"</div>";
					answer = "<div class='createCon'><span>答案：</span> "+list[i].answer+"</div>";
					resolution = "<div class='createCon'><span>解析：</span>"+list[i].resolution+"</div></div>";
					content_result += subject + answer + resolution;
				}
			}
			$('#loreExampleDiv').html("<h2 class='partTitle'>解题示范</h2>"+content_result);
		}
		function showPracticeList(list,div){
			var content_result = "";
			if(list != null){
				for(var i = 0 ; i < list.length; i++){
					var title = "";
					var subject = "";
					var optionA = "";
					var optionB = "";
					var optionC = "";
					var optionD = "";
					var optionE = "";
					var optionF = "";
					var optionTextA = "";
					var optionTextB = "";
					var optionTextC = "";
					var optionTextD = "";
					var optionTextE = "";
					var optionTextF = "";
					var answer = "";
					var resolution = "";
					var tips = "";
					title = "<div class='createDiv'><span class='createTit'>标题:"+list[i].title+"&nbsp;<span class='typeCol'>"+list[i].questionType+"</span>"+"&nbsp;"+"<span class='typeCol1'>"+list[i].questionType2+"</span></span>";
					subject = "<div class='createCon'><span>题干:</span>"+list[i].subject+"</div>";
					if(list[i].a != ""){
						if(checkAnswerImg(list[i].answer)){
							optionA = "<div class='optionDiv'><span>A、</span><img src='"+ list[i].a +"'></img></div>";
						}else{
							optionTextA = "<div class='optionDiv'><span>A、"+replaceChara(list[i].a).replace("<","&lt") + "&nbsp;&nbsp;" + "</span></div>";
						}
					}
					if(list[i].b != ""){
						if(checkAnswerImg(list[i].answer)){
							optionB = "<div class='optionDiv'><span>B、</span><img src='"+ list[i].b +"'></img></div>";
						}else{
							optionTextB = "<div class='optionDiv'><span>B、"+ replaceChara(list[i].b).replace("<","&lt") + "&nbsp;&nbsp;" +"</span></div>";
						}
					}
					if(list[i].c != ""){
						if(checkAnswerImg(list[i].answer)){
							optionC = "<div class='optionDiv'><span>C、</span><img src='"+ list[i].c +"'></img></div>";
						}else{
							optionTextC = "<div class='optionDiv'><span>C、"+ replaceChara(list[i].c).replace("<","&lt") + "&nbsp;&nbsp;" + "</span></div>";
						}
					}
					if(list[i].d != ""){
						if(checkAnswerImg(list[i].answer)){
							optionD = "<div class='optionDiv'><span>D、</span><img src='"+ list[i].d +"'></img></div>";
						}else{
							optionTextD = "<div class='optionDiv'><span>D、"+ replaceChara(list[i].d).replace("<","&lt") + "&nbsp;&nbsp;" +"</span></div>";
						}
					}
					if(list[i].e != ""){
						if(checkAnswerImg(list[i].answer)){
							optionE = "<div class='optionDiv'><span>E、</span><img src='"+ list[i].e +"'></img></div>";
						}else{
							optionTextE = "<div class='optionDiv'><span>E、"+ replaceChara(list[i].e).replace("<","&lt") + "&nbsp;&nbsp;" +"</span></div>";
						}
					}
					if(list[i].f != ""){
						if(checkAnswerImg(list[i].answer)){
							optionF = "<div class='optionDiv'><span>F、</span><img src='"+ list[i].f +"'></img></div>";
						}else{
							optionTextF += "<div class='optionDiv'><span>F、"+ replaceChara(list[i].f).replace("<","&lt") + "&nbsp;&nbsp;" +"</span></div>";
						}
					}
					var answer_pre = "<div class='createCon'><span>答案:</span>&nbsp;";
					var answer_next = "</div>";
					var answerName = "";
					var answerArray = list[i].answer.split(",");
					if(list[i].questionType == "判断题"){
						answer = answer_pre + "<span class='typeCol1'>" + replaceChara(list[i].answer)+"</span>" + answer_next;
					}else if(list[i].questionType == "单选题" || list[i].questionType == "多选题" || list[i].questionType == "填空选择题"){
						for(var j = 0 ; j < answerArray.length ; j++){
							if(answerArray[j] == list[i].a.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "A,";
							}
							if(answerArray[j] == list[i].b.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "B,";
							}
							if(answerArray[j] == list[i].c.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "C,";
							}
							if(answerArray[j] == list[i].d.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "D,";
							}
							if(answerArray[j] == list[i].e.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "E,";
							}
							if(answerArray[j] == list[i].f.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "F,";
							}
						}
						answer = answer_pre + "<span class='typeCol1'>" + answerName.substring(0,answerName.length - 1)+"</span>" + answer_next;
					}else{
						answer = answer_pre + "<span class='typeCol1'>" + replaceChara(list[i].answer) +"</span>" + answer_next;
					}
					if(list[i].resolution != ""){
						resolution = "<div class='createCon'><span>解析:</span>"+list[i].resolution+"</div>";
					}
					if(list[i].tips != ""){
						tips = "<div class='createCon'><span>提示:</span>"+list[i].tips+"</div>";
					}
					
					if(checkAnswerImg(list[i].answer)){
						content_result += title + subject + optionA + optionB + optionC + optionD + optionE + optionF + answer + resolution + tips + "</div>";
					}else{
						content_result += title + subject + optionTextA +  optionTextB +  optionTextC +  optionTextD +  optionTextE +  optionTextF + answer + resolution + tips + "</div>"; 
					}
				}
			}
			if(div == "loreConsolidationDiv"){
				$('#'+div).html("<h2 class='partTitle'>巩固训练</h2>"+content_result);
			}else if(div == "loreTargetedDiv"){
				$('#'+div).html("<h2 class='partTitle'>针对性诊断</h2>"+content_result);
			}else{
				$('#'+div).html("<h2 class='partTitle'>再次诊断</h2>"+content_result);
			}
			
		}
		function showVideoList(list){
			var subject = "";
			var answer = "";
			var content_result = "";
			if(list != null){
				for(var i = 0 ; i < list.length; i++){
					subject = "<div class='createDiv'><div class='createCon'><span>题干:</span>"+list[i].subject+"</div>";
					answer = "<div class='createCon'><span>视频:<span> <img src='Module/loreManager/images/video.png' onclick=showVideoPlayer('"+ list[i].answer +"')></img></div></div>";
					content_result += subject + answer;
				}
			}
			$('#loreExplainDiv').html("<h2 class='partTitle'>知识讲解</h2>"+content_result);
		}
		//显示视频播放器
		function showVideoPlayer(videoPath){
			if(videoPath.indexOf("flv") > 0){
				//videoPath = "../../../"+videoPath;
				showFlashPlayer(videoPath);
			}else{
				alert("暂不知识该视频格式播放!");
			}
		}
		//打开flv,MP4文件
		 function showFlashPlayer(url){
		     var scrollTop=window.top.document.documentElement.scrollTop||window.top.document.body.scrollTop;
		     window.top.document.getElementById("fileUrl").value = url;
			 window.top.$("#flexPaperDiv").window({	 
				  title:"视频文件播放窗口", 
				  iconCls:'',
				  width:600,   
			      height:400,
			      left:($(window.top).width()-600)/2,
			      top:($(window.top).height()-400)/2+scrollTop+'px',
			      onOpen:function(){window.top.$("#viewerPlaceHolder").show();},
			      collapsible:false,
			      minimizable:false,
			      maximizable:false,
			      resizable:false,
			      modal:true,
			      onClose:function(){
			    	  window.top.document.getElementById("viewerPlaceHolder").innerHTML="";
			      }
			 });
			//获取顶级iframe下函数调用的方法
			// window.top.window.playFile();
			 window.top.window.playFileNew();
		 }
		//检查答案是否为图片
		function checkAnswerImg(answer){
			if(answer.indexOf("jpg") > 0 || answer.indexOf("gif") > 0 || answer.indexOf("bmp") > 0 || answer.indexOf("png") > 0){
				return true;
			}
			return false;
		}
		
		//显示或隐藏div
		function showOrHideDiv(div){
			if(getId(div).style.display == "none"){
				getId(div).style.display = "";
			}else{
				getId(div).style.display = "none";
			}
		}
		//显示关联知识典窗口
		function showRelationView(loreId,loreName){
			currentLoreId = "";//每次show的时候先清空
			currentLoreId = loreId;
			$("#loreName1").html(loreName);
			showWindow("viewLoreRelateWindow","知识典关联",700,415);
			/**
			getSubjectList();
			showGradeList(null);
			getBasicEditionList();
			showEducationList(null);
			showChapterList(null);
			showLoreList(null);
			**/
			getAllEditionList1();
			getId("editionId1").value = window.parent.getId("editionId").value;
			getSubjectList1();
			getId("subjectId1").value = window.parent.getId("subjectId").value;
			getGradeList1();
			getId("gradeId1").value = window.parent.getId("gradeId").value;
			getEducationList1();
			getId("educationId1").value = window.parent.getId("educationId").value;
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
			
		}
		//显示所有子节点
		function showRootLoreList(list){
			var title = "<span class='relateTit'>本知识点关联知识点:</span>";
			
			var loreInfo = "";
			for(var i = 0 ; i < list.length; i++){
				var loreRelateId = list[i].id;
				loreInfo += "<div id='div"+ loreRelateId +"' class='activeCreateDiv'>"+list[i].rootLoreName + "<a href='javascript:void(0)' class='delPoint' title='删除' onclick=delRelate('"+ loreRelateId +"','div"+ loreRelateId +"')></a></div>";
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
		//显示知识树窗口
		function showTree(loreId,loreName){
			showWindow("viewLoreTreeWindow","知识树["+loreName+"]",400,500);
					  $('#tt').tree({  
							url: "loreRelateManager.do?action=showLoreTree&loreId="+loreId,  
							loadFilter: function(data){  
								if (data.d){  
									return data.d;  
								} else {  
									return data;  
								}  
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
	  								<a href="javascript:void(0)" class="upLoad" onclick="addDetail(${lore.id},'${lore.loreName}')">上传</a>
	 								<a href="javascript:void(0)" class="editlore" onclick="showDetail(${lore.id})">编辑</a>
	 								<a href="javascript:void(0)" class="viewLore" onclick="showDetailView(${lore.id},'${lore.loreName}')">浏览</a>
	  							</c:if>					
 								<a href="javascript:void(0)" class="viewLore" onclick="showTree(${lore.id},'${lore.loreName}')">知识树</a> 
 								<a href="javascript:void(0)" class="viewLore" onclick="showRelationView(${lore.id},'${lore.loreName}')">关联知识点</a>
 								<a href="javascript:void(0)" class="viewLore">关联词条 </a>
  							</td>
  						</tr>
  					</c:forEach>
  				</table>
 				<!-- 翻页盒子  -->
 				<c:if test="${requestScope.currentPage != '-1'}">
	 				<div class="turnPageBox1">
	 					<div class="markLayer"></div>
	 					<div class="turnPageParent">
							<p>第${requestScope.currentPage}页&nbsp;</p>
							<p>共${requestScope.pageCount}页</p>
							<a href="loreManager.do?action=queryLore&chapterId=${requestScope.chapterId}&option=basic&editionName=${requestScope.editionName}" class="indexPage">首页</a>
							<logic:greaterThan name="currentPage" scope="request" value="1">
								<a href="loreManager.do?action=queryLore&pageNo=${requestScope.currentPage - 1}&chapterId=${requestScope.chapterId}&option=basic&editionName=${requestScope.editionName}">
							</logic:greaterThan>上一页
							<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
							<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}">
							    <a href="loreManager.do?action=queryLore&pageNo=${requestScope.currentPage + 1}&chapterId=${requestScope.chapterId}&option=basic&editionName=${requestScope.editionName}">
							</logic:lessThan>下一页
							<logic:lessThan name="currentPage" scope="request" value="${requestScope.pageCount}"></a></logic:lessThan>
							<a href="loreManager.do?action=queryLore&pageNo=${requestScope.pageCount}&chapterId=${requestScope.chapterId}&option=basic&editionName=${requestScope.editionName}">尾页</a>
	 					</div>
	 				</div>
 				</c:if>
 				<div id="boxScroll" class="scrollBox">
  					<div id="scrollBar" class="scrollBar"></div>
  				</div>
  			</div>
  		</div>
  	</div>
  	
	<!-- 浏览知识点  -->
    <div id="viewLoreWindow" style="display:none;">
    	<div id="viewWrap" class="viewPointWrap">
			<!-- 头部导航  -->    	
	    	<div id="navTop" class="topNav">
	    		<ul>
	    			<li class="bg1">
	    				<a href="#loreListDiv">知识<br/>清单</a>
	    			</li>
	    			<li class="bg2">
	    				<a href="#loreGuideDiv">点拨<br/>指导</a>
	    			</li>
	    			<li class="bg3">
	    				<a href="#loreExampleDiv">解题<br/>示范</a>
	    			</li>
	    			<li class="bg4">
	    				<a href="#loreConsolidationDiv">巩固<br/>训练</a>
	    			</li>
	    			<li class="bg5">
	    				<a href="#loreTargetedDiv">针对性<br/>诊断</a>
	    			</li>
	    			<li class="bg6">
	    				<a href="#loreAgainDiv">再次<br/>诊断</a>
	    			</li>
	    			<li class="bg7">
	    				<a href="#loreExplainDiv">知识<br/>讲解</a>
	    			</li>
	    		</ul>
	    	</div>
	    	<!-- 主体内容  -->
	    	<div class="mainContent">
	    		<!-- 知识清单  --> 
	    		<div id="loreListDiv" class="listLoreWrap"></div>
	    		<!-- 点拨指导 -->
	    		<div id="loreGuideDiv" class="loreGuideWrap margT"></div>
	    		<!-- 解题示范  -->
	    		<div id="loreExampleDiv" class="loreExampleWrap margT"></div>
	    		<!-- 巩固训练  -->
	    		<div id="loreConsolidationDiv" class="loreConSolidWrap margT"></div>
	    		<!-- 针对性诊断  -->
	    		<div id="loreTargetedDiv" class="loreTargetWrap margT"></div>
	    		<!-- 再次诊断  -->
	    		<div id="loreAgainDiv" class="loreAgainWrap margT"></div>
	    		<!-- 知识讲解  -->
	    		<div id="loreExplainDiv" class="loreExplainWrap margT"></div>
	    	</div>
    	</div>	
    </div>
    
    <!-- 关联知识点  -->
    <div id="viewLoreRelateWindow" style="display:none;">
    	<div class="viewParent">
	    	 <h2 class="nowLore">当前知识典:<span id="loreName1"></span></h2>
	    	 <div class="topDiv">
		    	 <div id="selectSubjectDiv1" class="comNowSeleDiv1 comWiDiv1"></div>
			     <div id="selectGradeDiv1"class="comNowSeleDiv1 comWiDiv1"></div>
			     <div id="selectEditionDiv1" class="comNowSeleDiv1 comWiDiv2"></div>
			     <div id="selectEducationDiv1" class="comNowSeleDiv1 comWiDiv1"></div>
	    	 </div>
	    	 <div class="topDiv">
		    	 <div id="selectChapterDiv1" class="comNowSeleDiv1 comWiDiv1"></div>
		    	 <div id="selectLoreDiv1" class="comNowSeleDiv1 lorDiv1"></div>
	    	 </div>   	 
	    	 <div id="relateLoreDiv"></div>
	    	 <input type="button" value="添加" class="addRealteBtn" onclick="addLoreRelate()"/>
    	 </div>
    </div>
    <div id="viewLoreTreeWindow" style="display:none;">
    	<ul id="tt" class="easyui-tree" data-options="animate:true,lines:true,
			onClick:function(node){showDetailView(node.id,node.text);}">
		</ul>
    </div>
  </body>
</html>
