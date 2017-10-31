<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    
    <title>questionList.jsp</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/studyOnline/css/traceBackListCss.css" type="text/css" rel="stylesheet" />
	<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
	<script type="text/javascript">
		var loreId = "${requestScope.loreId}";
		var tracebackType = "${requestScope.tracebackType}";
		var totalMoney = "${requestScope.totalMoney}";
		var stepComplete = "${requestScope.stepComplete}";
		var nextLoreIdArray = "${requestScope.nextLoreIdArray}";
		var option = "${requestScope.option}";
		var path = "${requestScope.path}";
		var studyPath = "${requestScope.studyPath}";
		var success = "${requestScope.success}";
		var successStep = "${requestScope.successStep}";
		var currentloreName_study = "${requestScope.currentloreName_study}";
		$(function(){
			if(option == "1"){//诊断
				if(totalMoney == "-1"){//未开始做题
					getLoreTree(tracebackType);
					$("#resultNoUsedDiv").attr("style","display:no-ne;");
					$(".noUseDiv").show();
				}else{
					$("#resultUsedDiv").attr("style","display:no-ne;");
					$(".useLineDiv").show();
					if(success == "0"){//本节题未做完或者未进行最后提交
						$("#noComplete").attr("style","display:no-ne;");
						getLoreTree1(path);
					}else if(success == "1"){
						$("#noSuccess").attr("style","display:no-ne;");
						getLoreTree1(path);
					}else{
						$("#success").attr("style","display:no-ne;");
						getLoreTree1(path);
					}
				}
			}else{//学习
				if(success == "6"){//全部正确，诊断学习结束
					$("#resultStudyDiv").attr("style","display:no-ne;");
					$("#allSuccess").attr("style","display:no-ne;");
					$(".studyLineBox").show();
				}else if(success == "5"){//再次诊断全部做对
					$("#resultStudyDiv").attr("style","display:no-ne;");
					$("#studySuccess").attr("style","display:no-ne;");
					$(".studyLineBox").show();
				}else if(success == "4"){//5步学习完成，即将进入再次诊断
					$("#resultUsedDiv").attr("style","display:no-ne;");
					$(".useLineDiv").show();
					$("#studySucc").attr("style","display:no-ne;");
					$("#common").html("恭喜你，完成任务");
				}else if(success == "3"){
					$("#resultStudyDiv").attr("style","display:no-ne;");
					$("#zdSuccess").attr("style","display:no-ne;");
					$(".studyLineBox").show();
				}else if(success == "2"){//没通过，学习一下这些知识
					$("#resultStudyDiv").attr("style","display:no-ne;");
					$(".studyLineBox").show();
					$("#partSuccess").attr("style","display:no-ne;");
				}else if(success == "1"){//5步学习法通过
					$("#resultUsedDiv").attr("style","display:no-ne;");
					$(".useLineDiv").show();
					$("#common").html("恭喜你，完成任务");
				}else if(success == "0"){
					$("#resultUsedDiv").attr("style","display:no-ne;");
					$(".useLineDiv").show();
					$("#common").attr("style","display:no-ne;");
					$("#zczdNoSuccess").attr("style","display:no-ne;");
				}
				getStudyLoreTree(studyPath);
			}
			$(".mainTreeWrap").height($(window).height() - $(".traceBackTop").height());
			//动态计算知识树父级的高度
			$("#loreTreePar").height($(".mainTreeWrap").height() - $(".resultDivBox").height() - 10);
			$(".parentScroll").height($(window).height()- 88);
			scrollBar("loreTreePar","loreTreeDiv","scrollParent","scrollSon",25);
		});
		
		function getLoreTree1(path){
			if(path != ""){
				var pathArray = path.split(":");
				for(var i = 0 ; i < pathArray.length; i++){
					var alonePathArray = pathArray[i].split("|");
					for(var j = 0 ; j < alonePathArray.length ; j++){
						$.ajax({
							  type:"post",
							  async:false,
							  dataType:"json",
							  url:"studyOnline.do?action=getLoreQuestionList&loreId="+alonePathArray[j],
							  success:function (json){ 
								  showPathList(json,i,pathArray.length - 1);
							  }
						});
					}
				}
				setLoreColoreStudy(path,nextLoreIdArray,"zd");
			}
		}
		
		function showPathList(list,step,totalStep){
			var existDiv = document.getElementById("div_"+step);
			if(existDiv == null){
				if(step != 0){
					$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+step+"'><span class='numKp fl'>"+ "<span class='stepNums'>"+step+"</span>" +"级关联知识点:</span><div class='nowKpBox fl' id='sonDiv_"+step+"'></div></div>");
				}else{
					$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+step+"'><span class='numKp fl'>本知识点:</span><div class='nowKpBox fl' id='sonDiv_"+step+"'></div></div>");
				}
				
			}
			
			$('#sonDiv_'+step).append("<span class='nowKp font14' id='span_"+list[0].id+"' title='"+ list[0].loreName +"'>"+list[0].loreName+"</span>");
			if(success != "2"){
				for(var i = 0 ; i < nextLoreIdArray.split(",").length ; i++){
					//$("#span_"+nextLoreIdArray.split(",")[i]).attr("style","background-color:#ffda8c");
					$("#span_"+nextLoreIdArray.split(",")[i]).addClass("oranges");
				}
			}
			
			if(parseInt(step + 1) != path.split(":").length){
				var exist_gx_div = document.getElementById("div_gx_"+step);
				if(exist_gx_div == null){
					$('#loreTreeDiv').append("<div class='arrowBox' id='div_gx_"+ step +"'><span class='arrowIcon'></span></div>");
				}
			}
		}
		
		function getLoreTree(tracebackType){
			$.ajax({
				  type:"post",
				  async:false,
				  dataType:"json",
				  url:"studyOnline.do?action=getLoreTree&loreId="+loreId,
				  success:function (json){ 
					  if(tracebackType == "preview"){
						  showPreviewTracebackList(json);
					  }else if(tracebackType == "review"){
						  showReviewTracebackList(json);
						  if(nextLoreIdArray != ""){
							  var array = nextLoreIdArray.split(",");
							  for(var i = 0 ; i < array.length ; i++){
								  //$("#span_"+array[i]).attr("style","background-color:#ffda8c");
								  $("#span_"+array[i]).addClass("oranges");
							  }
						  }
					  }
				  }
			});
		}
		
		
		
		function getStudyLoreTree(studyPath){
			if(studyPath != ""){
				var studyPathArray = studyPath.split(":");
				for(var i = 0 ; i < studyPathArray.length; i++){
					var alonePathArray = studyPathArray[i].split("|");
					for(var j = 0 ; j < alonePathArray.length ; j++){
						$.ajax({
							  type:"post",
							  async:false,
							  dataType:"json",
							  url:"studyOnline.do?action=getLoreQuestionList&loreId="+alonePathArray[j],
							  success:function (json){ 
								  showStudyTracebackList(json,i,studyPathArray.length - 1);
							  }
						});
					}
				}
				setLoreColoreStudy(studyPath,nextLoreIdArray,"study");
			}
		}
		//学习路线图
		function showStudyTracebackList(list,step,totalStep){
			var stepNum = totalStep - step;
			var existDiv = document.getElementById("div_"+step);
			if(existDiv == null){
				if(step != totalStep){
					$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+step+"'><span class='numKp fl'>"+"<span class='stepNums'>"+stepNum+"</span>"+"级关联知识点:</span><div class='nowKpBox fl' id='sonDiv_"+step+"'></div></div>");
				}else{
					$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+step+"'><span class='numKp fl'>本知识点:</span><div class='nowKpBox fl' id='sonDiv_"+step+"'></div></div>");
				}
				
			}
			$('#sonDiv_'+step).append("<span class='nowKp font14' id='span_"+list[0].id+"' title='"+ list[0].loreName +"'>"+list[0].loreName+"</span>");
			//$("#span_"+nextLoreIdArray).attr("style","background-color:#ffda8c;");
			$("#span_"+nextLoreIdArray).addClass("oranges");
			
			
			if(parseInt(step + 1) != studyPath.split(":").length){
				var exist_gx_div = document.getElementById("div_gx_"+step);
				if(exist_gx_div == null){
					$('#loreTreeDiv').append("<div class='arrowBox' id='div_gx_"+ step +"'><span class='arrowIcon'></span></div>");
				}
			}
		}
		//着色状态(诊断/学习过的变绿色)
		function setLoreColoreStudy(studyPath,nextLoreIdArray,type){
			var studyPathArray = studyPath.split(":");
			var flag = false;
			for(var i = 0 ; i < studyPathArray.length; i++){
				if(type == "study"){
					var alonePathArray = studyPathArray[i].split("|");
					for(var j = 0 ; j < alonePathArray.length ; j++){
						if(alonePathArray[j] != nextLoreIdArray){
							//$("#span_"+alonePathArray[j]).attr("style","background-color:#d3ec8e");
							$("#span_"+alonePathArray[j]).addClass("green");
							
						}else{
							flag = true;
							break;
						}
					}
					if(flag){
						break;
					}
				}else{//诊断时
					if(success == "2"){//本知识典直接一次性全部正确
						//$("#span_"+nextLoreIdArray).attr("style","background-color:#d3ec8e");
						$("#span_"+nextLoreIdArray).adClass("green");
					}else{
						var nextLoreArray_new = nextLoreIdArray.replace(/\,/g,"|");
						if(studyPathArray[i] != nextLoreArray_new){
							var array = studyPathArray[i].split("|");
							for(var k = 0; k < array.length ; k++){
								//$("#span_"+array[k]).attr("style","background-color:#d3ec8e");
								$("#span_"+array[k]).addClass("green");
							}
						}else{
							flag = true;
							break;
						}
					}
				}
				
			}
		}
		//顺序溯源开始
		var previewStep = 0;
		function showReviewTracebackList(list){
			var reviewStep = 0;
			if(list != null){
				$('#loreTreeDiv').append("<div id='div_0' class='numKpBox clearfix'><span class='numKp fl'>本知识点:</span><div class='nowKpBox fl'><span class='thisKp' id='span_"+list[0].id+"' title='"+ list[0].text +"'>"+list[0].text+"</span></div></div>");
				var list_1 = list[0].children;
				var list_length_1 = 0;
				if(list_1 != undefined){
					list_length_1 = list_1.length;
				}
				if(list_length_1 > 0){
					reviewStep++;
					$('#loreTreeDiv').append("<div class='arrowBox' id='div_gx_"+ reviewStep +"'><span class='arrowIcon'></span></div>");
					$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+ reviewStep +"'><span class='numKp fl'>"+"<span class='stepNums'>"+reviewStep+"</span>"+"级关联知识点:</span><div class='nowKpBox fl' id='sonDiv_"+ reviewStep +"'></div></div>");
					var nextStep = reviewStep + 1;//nextStep = 2;reviewStep = 1;
					for(var i = 0 ; i < list_length_1 ; i++){
						if(list_1[i].repeatFlag == false){
							$('#sonDiv_'+reviewStep).append("<span class='nowKp font14' id='span_"+list_1[i].id+"' title='"+ list_1[i].text +"'>"+list_1[i].text+"</span>");
							var list_10 = list_1[i].children;
							var list_length = 0;
							if(list_10 != undefined){
								list_length = list_10.length;
							}
							if(list_length > 0){
								showSubTracebackList(list_10,nextStep,"review");
							}
						}
					}
				}
			}
		}
		//顺序课后学习
		
		//顺序课前预习
		function showPreviewTracebackList(list){
			if(list != null){
				var list_1 = list[0].children;
				var list_length_1 = 0;
				if(list_1 != undefined){
					list_length_1 = list_1.length;
				}
				if(list_length_1 > 0){
					var nextLoreIdStr = "";
					for(var i = 0 ; i < list_length_1 ; i++){
						if(list_1[i].repeatFlag == false){
							nextLoreIdStr += list_1[i].id + "_";
						}	
					}
					previewStep++;
					nextLoreIdStr = nextLoreIdStr.substring(0,nextLoreIdStr.length - 1);
					$('#loreTreeDiv').append("<div class='arrowBox' id='div_gx_"+ previewStep +"'><span class='arrowIcon'></span></div>");
					$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+ nextLoreIdStr +"'><span class='numKp fl'>"+"<span class='stepNums'>"+previewStep+"</span>"+"级关联知识点:</span><div class='nowKpBox fl' id='sonDiv_"+ nextLoreIdStr +"'></div></div>");
					for(var i = 0 ; i < list_length_1 ; i++){
						if(list_1[i].repeatFlag == false){
							$('#sonDiv_'+nextLoreIdStr).append("<span class='nowKp font14' id='span_"+list_1[i].id+"' title='"+ list_1[i].text +"'>"+list_1[i].text+"</span>");
							var list_10 = list_1[i].children;
							var list_length = 0;
							if(list_10 != undefined){
								list_length = list_10.length;
							}
							if(list_length > 0){
								showSubTracebackList(list_10,nextLoreIdStr,"preview");
							}
						}
					}
				}
			}
		}
		//顺序溯源子项
		function showSubTracebackList(list,currentStep,type){			
			
			var nextStep = currentStep + 1;//currentStep = 2;nextStep = 3;
				for(var i = 0 ; i < list.length ; i++){
					if(list[i].repeatFlag == false){
						if(type == "review"){
							var existDiv = document.getElementById("div_"+currentStep);
							if(existDiv == null){
								$('#loreTreeDiv').append("<div class='arrowBox' id='div_gx_"+ currentStep +"'><span class='arrowIcon'></span></div>");
								$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+ currentStep +"'><span class='numKp fl'>"+"<span class='stepNums'>"+currentStep+"</span>"+"级关联知识点:</span><div class='nowKpBox fl' id='sonDiv_"+ currentStep +"'></div></div>");
							}
						}else{
							previewStep++;
							$('#loreTreeDiv').append("<div class='arrowBox' id='div_gx_"+ previewStep +"'><span class='arrowIcon'></span></div>");
							$('#loreTreeDiv').append("<div class='numKpBox clearfix' id='div_"+ nextLoreIdStr +"'><span>"+"<span class='stepNums'>"+previewStep+"</span>"+"级关联知识点:</span><div class='nowKpBox fl' id='sonDiv_"+ nextLoreIdStr +"'></div></div>");
						}
						$('#sonDiv_'+currentStep).append("<span class='nowKp font14' id='span_"+list[i].id+"' title='"+ list[i].text +"'>"+list[i].text+"</span>");
						var list_10 = list[i].children;
						var list_length = 0;
						if(list_10 != undefined){
							list_length = list_10.length;
						}
						if(list_length > 0){
							showSubTracebackList(list_10,nextStep,"review");
						}
					}
				}
		}
		function closeWindow(){
			window.parent.closeChallengeWin();
		}
	</script>
  </head>
  
  <body>
  <div class="traceBackWrap">
  	<span class="bottomDec"></span>
  	<div class="traceBackTop">
  		<h2>${requestScope.loreName}</h2>
  		<p>本知识点的“溯源路线图”如下，根据它能够帮你查找出你不会的根源！</p>
  		<span class="topDec"></span>
  	</div>
  	<div class="mainTreeWrap">
	  	<div class="resultDivBox">
	  		<div id="resultNoUsedDiv" style="display:none;">
	  			<!-- input type="button" value="确定" onclick="closeWindow()"/ -->
	  		</div>
	  		<div class="noUseDiv" style="display:none;">
				<!--  h6 class="infos">本知识点的“溯源路线图”如下，根据它能够帮你查找出你不会的根源！</h6-->
				<table class="stateBox" width="100%" cellspacing="0" cellpadding="0">
			    	<tbody>
				    	<tr>
				        	<td align="right"><span class="comCol col_bj1"></span>&nbsp;<span>代表已诊断</span></td>
			            	<td align="center"><span class="comCol col_bj2"></span>&nbsp;<span>代表将要诊断</span></td>
			            	<td align="left"><span class="comCol col_bj3"></span>&nbsp;<span>代表未诊断</span></td>
				        </tr>
			    	</tbody>
			    </table>
			</div>
			<!-- 
	  		success(诊断时)
	  		0：本节知识点的诊断没做完 显示noComplete
	  		1：本节知识点已做完，但没全做对，进行溯源。 显示noSuccess
	  		2：本知识点诊断全部正确。全部结束，finish=2.显示success
	  	 	-->
	  	 	<div id="resultUsedDiv" class="resultDiv clearfix" style="display:none;">
		  		<div class="leftSimilePic fl"></div>
		  		<div class="rightDetialBox fl">
			  		<p id="common" class="congra" style="display:no-ne;">
			  			恭喜你，完成任务，获得<span>${requestScope.totalMoney}</span>金币
			  		</p>
			  		<p id="zczdNoSuccess" class="studyInfos" style="display:none;">
			  			学习要持之以恒，${requestScope.successStep}还未再次诊断结束哦！继续学习直到掌握住!
			  		</p>
			  		<p id="noComplete" class="studyInfos" style="display:none;">
			  			<span>${requestScope.successStep}</span>的针对性诊断还没有结束呢,点击"继续诊断"帮你检测出本知识点的掌握情况哦！
			  		</p>
			  		<p id="noSuccess" class="studyInfos" style="display:none;">
			  			通过诊断，你对${requestScope.successStep}掌握的不是很好，需要启动溯源对下一级关联知识点进行诊断，查看下一级关联知识点的掌握情况，直到找出不会的根源！
			  		</p>
			  		<p id="success" class="studyInfos" style="display:none;">
			  			很棒哦，这个知识点的诊断题全对了！通过诊断你对这个知识点掌握的很好！不用再溯源诊断了，学习是个慢慢积累的过程，只有把每个知识点都掌握了，考试成绩自然就上去了！
			  		</p>
			  		<p id="studySucc" class="studyInfos" style="display:none;">
			  			您已对${requestScope.currentloreName_study}知识点学习完成，现在开始再次诊断吧!
			  		</p>
			  		<span class="sureBtn" onclick="closeWindow()">确定</span>
			  		<!--  input type="button" class="sureBtn" value="确定" onclick="closeWindow()"/-->
		  		</div>
	  		</div>
		  	<div class="useLineDiv" style="display:none;">
		  	  	<!--  h6 class="infos">本知识点的“溯源路线图”如下，根据它能够帮你查找出你不会的根源！</h6-->
				<table class="stateBox" width="100%" cellspacing="0" cellpadding="0">
			    	<tbody>
				    	<tr>
				        	<td align="right"><span class="comCol col_bj1"></span>&nbsp;<span>代表已诊断</span></td>
				            <td align="center"><span class="comCol col_bj2"></span>&nbsp;<span>代表将要诊断</span></td>
				            <td align="left"><span class="comCol col_bj3"></span>&nbsp;<span>代表未诊断</span></td>
				        </tr>
			    	</tbody>
			    </table>
		  	</div>
		  	<!-- 
		  		success(学习时)
		  		0：当前知识典学习通过显示studySuccess
		  		1：学习时没通过显示studyNoSuccess
		  		2：最后诊断没通过，进入学习时提示显示partSuccess
		  		3：诊断时某级诊断完全正确，进入学习提示显示zdSuccess
		  	 --> 	
		  	<div id="resultStudyDiv" class="resultDiv clearfix" style="display:none;">
		  		<div class="leftSimilePic fl"></div>
		  		<div class="rightDetialBox fl">
			  		<p id="commonStudy" class="congra">恭喜你完成任务，获得<span>${requestScope.totalMoney}</span>金币</p>
			  		<p id="studyNoSuccess" class="studyInfos" style="display:none;">
			  			学习要持之以恒，???级关联知识点 ????还未学习结束哦！继续学习直到掌握住!
			  		</p>
			  		<p id="zdSuccess" class="studyInfos" style="display:none;">
			  			很棒哦，这个知识点的${requestScope.successStep}全对了！掌握的不错，不用再往下进行溯源诊断了，跟着老师学习一下${requestScope.nextLoreStep}吧！
			  		</p>
			  		<p id="partSuccess" class="studyInfos" style="display:none;">
			  			通过诊断，你对<span>${requestScope.successStep}</span>掌握的不是很好，做题过程中是粗心马虎了？还是真的不会呢？跟着老师系统依次学习一下这些知识点吧！
			  		</p>
			  		<p id="studySuccess" class="studyInfos" style="display:none;">
			  			这个知识点通过听“视频讲解”、看“点拨指导”、背“知识清单”、学“解题示范”、做“再次诊断”，你掌握的很棒！根据学习路线图学习下一个知识点吧！
			  		</p>
			  		<p id="allSuccess" class="studyInfos" style="display:none;">
			  			这个知识点通过听“视频讲解”、看“点拨指导”、背“知识清单”、学“解题示范”、做“再次诊断”，你掌握的很棒！学习是个慢慢积累的过程，只有把每个知识点都掌握了，考试成绩自然就上去了！
			  		</p>
			  		<span class="sureBtn" onclick="closeWindow()">确定</span>
			  		<!--  input type="button" class="sureBtn" value="确定" onclick="closeWindow()"/-->
		  		</div>
		  	</div>
		  	<div class="studyLineBox" style="display:none;">
		 		<!--  h6 class="infos">根据你的诊断情况，为您生成的“学习路线图”如下，这些知识点你要依次认真学习哦！</h6-->
				<table class="stateBox" width="100%" cellspacing="0" cellpadding="0">
			    	<tbody>
				    	<tr>
				        	<td align="right"><span class="comCol col_bj1"></span>&nbsp;<span class="infoState">代表已掌握</span></td>
				            <td align="center"><span class="comCol col_bj2"></span>&nbsp;<span class="infoState">代表将要学习</span></td>
				            <td align="left"><span class="comCol col_bj3"></span>&nbsp;<span class="infoState">代表未学习</span></td>
				        </tr>
			    	</tbody>
			    </table>
			</div>	
	  	</div>
		<div class="parentTree clearfix" id="loreTreePar">
			<div id="loreTreeDiv" class="treeBox"></div>
		</div>
	</div>
	<div id="scrollParent" class="parentScroll">
			<div id="scrollSon" class="scrollBar"></div>
	</div>
  </div>

  </body>
</html>
