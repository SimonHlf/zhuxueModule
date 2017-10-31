		//编辑巴菲特
		function showDetail(buffetId){
			var curr_select_chapeter_id = window.parent.$("#chapterId").val();
			if(checkCurrentSelectChapter(curr_select_chapeter_id)){
				alert("请先点击查询按钮后再进行操作!");
			}else{
				window.location.href = "buffetManager.do?action=showBuffetDetail&buffetId="+buffetId+"&chapterId="+chapterId;
			}	
		}
		//设置启用/未启用
		function setUseFlag(buffetId,loreId,inUse){
			var curr_select_chapeter_id = window.parent.$("#chapterId").val();
			if(checkCurrentSelectChapter(curr_select_chapeter_id)){
				alert("请先点击查询按钮后再进行操作!");
			}else{
				var option = "basic";
				var editionName = "通用版";
				$.ajax({
			        type:"post",
			        async:false,
			        dataType:"json",
			        url:"buffetManager.do?action=setBuffetStatus&buffetId="+buffetId+"&inUse="+inUse,
			        success:function (json){
			        	if(json){
			        		alert("设置成功!");
			        		window.location.href = "buffetManager.do?action=queryBuffetByLoreId&loreId="+loreId+"&chapterId="+chapterId+"&editionName="+encodeURIComponent(editionName);
			        	}
			        }
			    });
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
		//封装关闭窗口（点击窗口关闭按钮时的事件）
		function closeWindowBySystemIcon(windowObj,url){
			$("#"+windowObj).window({
		        onBeforeClose: function () {
		        	window.location.href =  url;
		        }
		    });
		}
		//-----------------------涉及知识点----------------------------//
		//获取当前巴菲特题涉及到的知识点
		function getCurrentBuffetLoreRefer(buffetId){
			if($("#chapterId1").val() != 0){
				var selectReferChapterText = $("#chapterId1").find("option:selected").text().split(":")[0];
				var generalChapterText = window.parent.$("#chapterId").find("option:selected").text().split(":")[0];
				if(selectReferChapterText != generalChapterText){
					alert("涉及知识点的章节必须和巴菲特所在章节保持一致!");
					showLoreList1(null);
					showReferBufferLoreList(null);
				}else{
					$.ajax({
						  type:"post",
						  async:false,
						  dataType:"json",
						  url:"buffetLoreManager.do?action=showReferByBuffetAndChapter&buffetId="+buffetId+"&chapterId="+$("#chapterId1").val(),
						  success:function (json){ 
							  showReferBufferLoreList(json);
						  }
					});
				}
			}else{
				showLoreList1(null);
				showReferBufferLoreList(null);
			}
		}
		//显示当前巴菲特题所涉及到的知识点
		function showReferBufferLoreList(list){
			var title = "<span class='relateTit'>当前知识点对应知识点:</span>";
			var loreInfo = "";
			if(list != null){
				for(var i = 0 ; i < list.length; i++){
					var buffetLoreReferId = list[i].id;
					loreInfo += "<div id='div"+ buffetLoreReferId +"' class='activeCreateDiv'>"+list[i].lore.loreName + "<a href='javascript:void(0)' class='delPoint' title='删除' onclick=delReferLoreByBuffetAndLore('"+ buffetLoreReferId +"')></a></div>";
				}	
			}
			$('#referLoreDiv').html(title+loreInfo);
		}
		//涉及知识点显示窗口
		function showReferView(loreId,loreName){
			showWindow("viewReferWindow","对应知识点",700,415);
			$("#currentLore").html(loreName);
			current_lore_id = loreId;
			getOtherEditionList1(true);
			getSubjectList1(false);
			getId("subjectId1").value = window.parent.getId("subjectId").value;
			getGradeList1(false);
			getId("gradeId1").value = window.parent.getId("gradeId").value;
			getEducationList1(true);
			getChapterList1(true);
			getLoreList1();
			showReferBufferLoreList(null);
		}
		//增加涉及知识点
		function addLoreRefer(){
			var referLoreId = getId("loreId1").value;
			if(referLoreId != 0){
				if(checkExistByBuffetAndLore(current_lore_id,referLoreId)){
					alert("已涉及了该知识点，请另外选择需要涉及知识点!");
				}else{
					addBuffetLore(current_lore_id,referLoreId);
				}
			}else{
				alert("请选择一个或多个知识点添加!");
			}
			
			
		}
		//查询该buffetId+referLoreId是否有记录
		function checkExistByBuffetAndLore(buffetId,referLoreId){
			var existFlag = false;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"buffetLoreManager.do?action=checkExistByBuffetAndLore&buffetId="+buffetId+"&referLoreId="+referLoreId,
				  success:function (json){ 
					  existFlag = json;
				  }
			});
			return existFlag;
		}
		//增加巴菲特涉及知识点记录
		function addBuffetLore(buffetId,referLoreId){
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"buffetLoreManager.do?action=addBuffetLore&buffetId="+buffetId+"&referLoreId="+referLoreId,
				  success:function (json){ 
					 if(json){
						 alert("增加涉及知识点成功!");
						 getCurrentBuffetLoreRefer(buffetId);//刷新当前巴菲特涉及知识点列表
					 }
				  }
			});
		}
		//删除buffetId+referLoreId的记录
		function delReferLoreByBuffetAndLore(referId){
			if(confirm("是否删除该涉及知识点?")){
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"buffetLoreManager.do?action=delBuffetLoreById&id="+referId,
					  success:function (json){ 
						  if(json){
							  alert("删除成功!");
							  getCurrentBuffetLoreRefer(current_buffet_id);
						  }
					  }
				});
			}
		}
		//-----------------------关联知识点----------------------------//
		//关联知识点窗口
		function showRelationView(buffetId,buffetName,currLoreId){
			if(checkCurrentSelectChapter(window.parent.$("#chapterId").val())){
				alert("请先点击查询按钮后再进行操作!");
			}else{
				showWindow("viewRelationWindow","关联知识点",900,615);
				fnTabNav($('.nowTabNav'),$('.selTabCon'),'click');
				$("#currentBuffetName").html(buffetName);
				current_buffet_name = buffetName;
				current_buffet_id = buffetId;
				getOtherEditionList2(true);
				getId("editionId2").value = window.parent.getId("editionId").value;
				getBuffetLoreRelation(current_buffet_id,currLoreId);
				getSubjectList2(false);
				getId("subjectId2").value = window.parent.getId("subjectId").value;
				getGradeList2(true);
				getId("gradeId2").value = window.parent.getId("gradeId").value;
				getEducationList2(true);
				getChapterList2(true);
				getLoreList2();
				//showRelationBufferLoreList(null);
				showBuffetTree(currLoreId);
			}
		}
		//获取当前知识点下当前巴菲特题关联知识点
		function getBuffetLoreRelation(buffetId,currLoreId){
			if($("#editionId2").val() != 0){
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"blrManager.do?action=showRelationByBuffetAndLore&buffetId="+buffetId+"&currLoreId="+currLoreId,
					  success:function (json){ 
						  showRelationBufferLoreList(json);
						  $("#loreRelationListUl li:odd").addClass("oddColorLi");
					  }
				});
			}else{
				showRelationBufferLoreList(null);
			}
		}
		//显示当前巴菲特题关联的知识点
		function showRelationBufferLoreList(list){
			var pTit = "<p class='hasAdPoint'><span>已添加知识点</span></p>";
			var ulStart = "<ul id='loreRelationListUl'>";
			var ulEnd = "</ul>";
			var loreInfo = "";
			if(list != null){
				for(var i = 0 ; i < list.length; i++){
					var buffetLoreReferId = list[i].id;
					loreInfo += "<li id='li"+ buffetLoreReferId +"'>"+list[i].lore.loreName + "<a href='javascript:void(0)' class='delBuffPoint' title='删除' onclick=delRelationLoreById('"+ buffetLoreReferId +"')></a></li>";
				}	
			}
			$('#buffetLoreRelationWindow').html(pTit+ulStart+loreInfo+ulEnd);
		}
		//增加一个巴菲特关联知识点
		function addBuffetLoreRelation(){
			var relationLoreId = getId("loreId2").value;
			var selectEditionId = getId("editionId2").value;
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
		//判断当前巴菲特是否存在指定的关联知识点
		function checkExistRelationByBuffetAndLore(buffetId,currLoreId,relateLoreId){
			var existFlag = false;
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"blrManager.do?action=checkExistByBuffetAndLore&buffetId="+buffetId+"&relateLoreId="+relateLoreId+"&currLoreId="+currLoreId,
				  success:function (json){ 
					 if(json){
						 existFlag = true;
					 }
				  }
			});
			return existFlag;
		}
		//根据主键删除巴菲特关联知识点关系
		function delRelationLoreById(id){
			if(confirm("是否删除该关联知识点?")){
				$.ajax({
					  type:"post",
					  async:false,
					  dataType:"json",
					  url:"blrManager.do?action=delBuffetLoreRelateById&id="+id,
					  success:function (json){ 
						 if(json){
							 alert("删除成功!");
							 getBuffetLoreRelation(current_buffet_id,currLoreId);//刷新当前巴菲特关联知识点列表
							 showBuffetTree(currLoreId);
						 }
					  }
				});
			}
			
		}
		//显示巴菲特知识树
		function showBuffetTree(currLoreId){
			//var editionId = getId("editionId2").value;
			//if(editionId != 0){
				$('#tt').tree({  
					url: "blrManager.do?action=showBuffetLoreTree&buffetId="+current_buffet_id+"&buffetName="+encodeURIComponent(current_buffet_name)+"&currLoreId="+currLoreId,  
					loadFilter: function(data){  
						if (data.d){  
							return data.d;  
						} else {  
							return data;  
						}  
					}  
			 	});
			//}else{
				//$('#tt').html("");
			//}
		}
		//根据巴菲特基础类型和章节编号查询巴菲特列表
		function ajaxAction(buffetType,divText,loreId){
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"buffetManager.do?action=showJsonList&loreId="+loreId+"&buffetType="+encodeURIComponent(buffetType),
				  success:function (json){ 
					  showBuffetList(json,divText);
				  }
			});
		}
		//显示巴菲特题详细列表
		function showBuffetView(loreId,loreName){
			var currentSelectChapterId =  window.parent.$("#chapterId").val();
			if(currentSelectChapterId != 0){
				if(chapterId == currentSelectChapterId){
					showWindow("viewBuffetListWindow","浏览["+loreName+"]章节下的巴菲特",800,550);
					//step:1 获取兴趣激发内容
					ajaxAction("兴趣激发","xqkfListDiv",loreId);
					//step:2获取方法归纳内容
					ajaxAction("方法归纳","ffgnDiv",loreId);
					//step:3获取思维训练内容
					ajaxAction("思维训练","swxlDiv",loreId);
					//step:4获取智力开发内容
					ajaxAction("智力开发","zlkfDiv",loreId);
					//step:5获取能力培养内容
					ajaxAction("能力培养","nlpyDiv",loreId);
					//step:6获取高考涉猎内容
					ajaxAction("高考涉猎","gkslDiv",loreId);
					toFixed();
				}else{
					alert("请先点击查询按钮后再进行浏览!");		
				}
			}else{
				alert("请先选择章节!");
			}
		}
		//检查答案是否为图片
		function checkAnswerImg(answer){
			if(answer.indexOf("jpg") > 0 || answer.indexOf("gif") > 0 || answer.indexOf("bmp") > 0 || answer.indexOf("png") > 0){
				return true;
			}
			return false;
		}
		//替换所有的单引号为自定义字符
		function replaceChara(value){
			return value.replace(/&#wmd;/g,"'");
		}
		//显示巴菲特列表
		function showBuffetList(list,div){
			var content_result = "";
			if(list != null){
				for(var i = 0 ; i < list.length; i++){
					var title = "";
					var buffetMindType = "";
					var buffetAbilityType = "";
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
					title = "<div class='createDiv'><span class='createTit'>标题:"+list[i].buffet.title+"&nbsp;<span class='typeCol'>"+list[i].buffet.questionType+"</span></span>";
					buffetMindType = "<div class='createCon'><span>思维类型:&nbsp;</span>"+list[i].buffetMindTypeNameStr+"</div>";
					buffetAbilityType = "<div class='createCon'><span>能力类型:&nbsp;</span>"+list[i].buffetAbilityTypeNameStr+"</div>";
					subject = "<div class='createCon'><span>题干:</span>"+list[i].buffet.subject+"</div>";
					if(list[i].buffet.a != ""){
						if(checkAnswerImg(list[i].buffet.answer)){
							optionA = "<div class='optionDiv'><span>A、</span><img src='"+ list[i].buffet.a +"'></img></div>";
						}else{
							optionTextA = "<div class='optionDiv'><span>A、"+replaceChara(list[i].buffet.a).replace("<","&lt") + "&nbsp;&nbsp;" + "</span></div>";
						}
					}
					if(list[i].buffet.b != ""){
						if(checkAnswerImg(list[i].buffet.answer)){
							optionB = "<div class='optionDiv'><span>B、</span><img src='"+ list[i].buffet.b +"'></img></div>";
						}else{
							optionTextB = "<div class='optionDiv'><span>B、"+ replaceChara(list[i].buffet.b).replace("<","&lt") + "&nbsp;&nbsp;" +"</span></div>";
						}
					}
					if(list[i].buffet.c != ""){
						if(checkAnswerImg(list[i].buffet.answer)){
							optionC = "<div class='optionDiv'><span>C、</span><img src='"+ list[i].buffet.c +"'></img></div>";
						}else{
							optionTextC = "<div class='optionDiv'><span>C、"+ replaceChara(list[i].buffet.c).replace("<","&lt") + "&nbsp;&nbsp;" + "</span></div>";
						}
					}
					if(list[i].buffet.d != ""){
						if(checkAnswerImg(list[i].buffet.answer)){
							optionD = "<div class='optionDiv'><span>D、</span><img src='"+ list[i].buffet.d +"'></img></div>";
						}else{
							optionTextD = "<div class='optionDiv'><span>D、"+ replaceChara(list[i].buffet.d).replace("<","&lt") + "&nbsp;&nbsp;" +"</span></div>";
						}
					}
					if(list[i].buffet.e != ""){
						if(checkAnswerImg(list[i].buffet.answer)){
							optionE = "<div class='optionDiv'><span>E、</span><img src='"+ list[i].buffet.e +"'></img></div>";
						}else{
							optionTextE = "<div class='optionDiv'><span>E、"+ replaceChara(list[i].buffet.e).replace("<","&lt") + "&nbsp;&nbsp;" +"</span></div>";
						}
					}
					if(list[i].buffet.f != ""){
						if(checkAnswerImg(list[i].buffet.answer)){
							optionF = "<div class='optionDiv'><span>F、</span><img src='"+ list[i].buffet.f +"'></img></div>";
						}else{
							optionTextF += "<div class='optionDiv'><span>F、"+ replaceChara(list[i].buffet.f).replace("<","&lt") + "&nbsp;&nbsp;" +"</span></div>";
						}
					}
					var answer_pre = "<div class='createCon'><span>答案:</span>&nbsp;";
					var answer_next = "</div>";
					var answerName = "";
					var answerArray = list[i].buffet.answer.split(",");
					if(list[i].buffet.questionType == "判断题"){
						answer = answer_pre + "<span class='typeCol1'>" + replaceChara(list[i].buffet.answer)+"</span>" + answer_next;
					}else if(list[i].buffet.questionType == "单选题" || list[i].buffet.questionType == "多选题" || list[i].buffet.questionType == "填空选择题"){
						for(var j = 0 ; j < answerArray.length ; j++){
							if(answerArray[j] == list[i].buffet.a.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "A,";
							}
							if(answerArray[j] == list[i].buffet.b.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "B,";
							}
							if(answerArray[j] == list[i].buffet.c.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "C,";
							}
							if(answerArray[j] == list[i].buffet.d.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "D,";
							}
							if(answerArray[j] == list[i].buffet.e.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "E,";
							}
							if(answerArray[j] == list[i].buffet.f.replace("Module/commonJs/ueditor/jsp/lore/","")){
								answerName += "F,";
							}
						}
						answer = answer_pre + "<span class='typeCol1'>" + answerName.substring(0,answerName.length - 1)+"</span>" + answer_next;
					}else{
						answer = answer_pre + "<span class='typeCol1'>" + replaceChara(list[i].buffet.answer) +"</span>" + answer_next;
					}
					if(list[i].buffet.resolution != ""){
						resolution = "<div class='createCon'><span>解析:</span>"+list[i].buffet.resolution+"</div>";
					}
					if(list[i].buffet.tips != ""){
						tips = "<div class='createCon'><span>提示:</span>"+list[i].buffet.tips+"</div>";
					}
					
					if(checkAnswerImg(list[i].buffet.answer)){
						content_result += title + buffetMindType + buffetAbilityType + subject + optionA + optionB + optionC + optionD + optionE + optionF + answer + resolution + tips + "</div>";
					}else{
						content_result += title + buffetMindType + buffetAbilityType + subject + optionTextA +  optionTextB +  optionTextC +  optionTextD +  optionTextE +  optionTextF + answer + resolution + tips + "</div>"; 
					}
				}
			}
			if(div == "xqkfListDiv"){
				$('#'+div).html("<h2 class='partTitle'>兴趣激发</h2>"+content_result);
			}else if(div == "ffgnDiv"){
				$('#'+div).html("<h2 class='partTitle'>方法归纳</h2>"+content_result);
			}else if(div == "swxlDiv"){
				$('#'+div).html("<h2 class='partTitle'>思维训练</h2>"+content_result);
			}else if(div == "zlkfDiv"){
				$('#'+div).html("<h2 class='partTitle'>智力开发</h2>"+content_result);
			}else if(div == "nlpyDiv"){
				$('#'+div).html("<h2 class='partTitle'>能力培养</h2>"+content_result);
			}else if(div == "gkslDiv"){
				$('#'+div).html("<h2 class='partTitle'>高考涉猎</h2>"+content_result);
			}
		}
		function toFixed(){
			var oViewWrap = getId("viewWrap");
			oViewWrap.onscroll = function(){
				var scrollTop = oViewWrap.scrollTop;
				if(scrollTop>50){
					$(".topNav").addClass("fixs");
				}else{
					$(".topNav").removeClass("fixs");
				}
			};
		}