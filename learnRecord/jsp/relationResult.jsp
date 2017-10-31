<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
   <title>助学网--学习记录跟踪指导查看答卷</title>
   <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
   <link type="text/css" rel="stylesheet" href="Module/learnRecord/css/checkAns.css">
   <link type="text/css" rel="stylesheet" href="Module/learnRecord/css/relationResultCss.css">
   <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
   <script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
   <script type="text/javascript" src="Module/learnRecord/js/checkAns.js"></script>
 </head>
 <script type="text/javascript">
 var studyLogId = "${requestScope.slID}";
 var loreId = "${requestScope.loreId}";//主知识点编号
 $(function(){
	 fnTabNav($(".tabNav"),$(".tabCon"),"click");
	 getLoreTree();
 });
 
 function getLoreTree(){
 	$.ajax({
		  type:"post",
		  async:false,
		  dataType:"json",
		  url:"studyOnline.do?action=getLoreTree&loreId="+loreId+"&studyLogId="+studyLogId,
		  success:function (json){ 
			  showReviewTracebackList(json);
		  }
	});
 }
 function showReviewTracebackList(list){
	if(list != null){
		var ul_main = "<ul id='ul_0' class='ulParent'><li class='treeIcon'></li><li id='li_0'><span class='bigTit'>"+list[0].text+"</span></li></ul>";
		$('#relationResultDiv').append(ul_main);
		var list_1 = list[0].children;
		var list_length_1 = 0;
		if(list_1 != undefined){
			list_length_1 = list_1.length;
		}
		for(var i = 0 ; i < list_length_1; i++){
			if(list_1[i].repeatFlag == false){
				var ul_child = "<ul id='ul_"+list_1[i].id+"' class='fristFloor'><li class='treeIcon'></li><li id='li_"+list_1[i].id+"'>";
				var zdxzdFlag = list_1[i].zdxzdFlag;
				var studyFlag = list_1[i].studyFlag;
				var zczdFlag = list_1[i].zczdFlag;
				var studyTimes = list_1[i].studyTimes;
				var zczdTimes = list_1[i].zczdTimes;
				ul_child += "<span class='smallTit'>"+list_1[i].text+getStatus(zdxzdFlag,"诊断",studyTimes,list_1[i].id,list_1[i].text)+getStatus(studyFlag,"学习",studyTimes,list_1[i].id,list_1[i].text)+getStatus(zczdFlag,"再次诊断",zczdTimes,list_1[i].id,list_1[i].text)+"</span>";
				ul_child += "</li></ul>";
				$('#li_0').append(ul_child);
				var list_child = list_1[i].children;
				showNextTreeList(list_child,list_1[i].id);
			}
		}
	}
 }
 
 function showNextTreeList(list,preLoreId){
	 if(list != undefined){
		 for(var i = 0 ; i < list.length; i++){
			 if(list[i].repeatFlag == false){
				 var ul = "<ul id='ul_"+list[i].id+"' class='secondFloor'><li class='sonTreeIcon'></li><li id='li_"+list[i].id+"'>";
				 var zdxzdFlag = list[i].zdxzdFlag;
				 var studyFlag = list[i].studyFlag;
				 var zczdFlag = list[i].zczdFlag;
				 var studyTimes = list[i].studyTimes;
				 var zczdTimes = list[i].zczdTimes;
				 ul += "<span class='smallTit'>"+list[i].text+getStatus(zdxzdFlag,"诊断",studyTimes,list[i].id,list[i].text)+getStatus(studyFlag,"学习",studyTimes,list[i].id,list[i].text)+getStatus(zczdFlag,"再次诊断",zczdTimes,list[i].id,list[i].text)+"</span>";
				 ul += "</li></ul>";
				 $('#li_'+preLoreId).append(ul);
				 var list_child = list[i].children;
				 showNextTreeList(list_child,list[i].id);
			 }
		 }
	 }
 }
 
 function getStatus(flagStr,option,studyTimes,currentLoreId,currentLoreName){
	 var result = "";
	if(flagStr == -1){
		result = "<span class='noPassTxt_1'>[未"+option+"]</span>";
	}else if(flagStr == 0){
		result = "<span class='noPassTxt'>["+option+"未通过]</span>";
	}else{
		if(option == "学习"){
			result = "<a href='javascript:void(0)' onclick=showStudy("+studyLogId+","+currentLoreId+",'"+currentLoreName+"')><span class='hasLearning'>[已"+option+"("+"<b>"+studyTimes+"</b>"+"次)]</span></a> ";
		}else{
			result = "<span class='passTxt'>["+option+"通过]</span>";
		}
	}
	return result;
 }
 
//创建遮罩层
 function createLayer(){
 	var oLayer=window.parent.$('<div class="layer"></div>');
 	window.parent.$('body').append(oLayer);
 	oLayer.show();
 	oLayer.animate({opacity:0.5},300);
 }
 
//div层显示
 function showDivLayer(){
 	createLayer();
 	window.parent.$("html").addClass('cancelScroll');
 	window.parent.$(".challengeBox").height(window.parent.document.documentElement.clientHeight);
 	window.parent.$(".challengeBox").show();
 	var scrollTop=window.parent.document.documentElement.scrollTop||window.parent.document.body.scrollTop;
 	window.parent.getId("challengeWin").style.top = scrollTop + 'px';
 }
 
 function showStudy(studyLogId,currentLoreId,currentLoreName){
	 showDivLayer();
	 var mainWin = window.parent.document.getElementById("questionMainCon").contentWindow;
	 mainWin.location.href = "studyOnline.do?action=showQuestionPage&loreId="+loreId+"&nextLoreIdArray="+currentLoreId+"&loreName="+encodeURIComponent(currentLoreName)+"&studyLogId="+studyLogId+"&pathType=study"+"&option=relationStudy";
 }
 </script>
 <body>
	<div class="nowPosition">
		<c:if test="${sessionScope.roleName == '学生' || sessionScope.roleName == '家长'}">
			<p><span>助学网 &gt; 学习记录&gt; 查看学习详情</span></p>
		</c:if>
		 <c:if test="${sessionScope.roleName == '网络导师'}">
		 	<p><span>助学网 &gt; 跟踪指导&gt; 查看学习详情</span></p>
		 </c:if>
	</div>
	<div class="checkAnsWrap clearfix">
		<div class="checkAnsNav">
		   <ul class="tabNav">
	            <li  id="typeName" onclick="study(${requestScope.slID},${requestScope.loreId},'针对性诊断')">针对性诊断结果</li>
	            <li  onclick="study(${requestScope.slID},${requestScope.loreId},'再次诊断')">再次诊断结果</li>
	            <li onclick="study(${requestScope.slID},${requestScope.loreId},'巩固训练')">巩固训练结果</li>
	            <li class="active" onclick="study(${requestScope.slID},${requestScope.loreId},'关联诊断结果')">关联诊断结果</li>
	        </ul>
	        <span class="backIcon"></span>
	         <c:if test="${sessionScope.roleName == '学生' || sessionScope.roleName == '家长'}">
	              <input type="hidden" id="xsSubID" value="${requestScope.xsSubID}">
	              <input type="hidden" id="xsTex" value="${requestScope.xsTex}">
	              <input type="hidden" id="xsstime" value="${requestScope.xsstime}">
	              <input type="hidden" id="xsetime" value="${requestScope.xsetime}">
	              <input type="hidden" id="xsyn" value="${requestScope.xsyn}">
				 <a href="javascript:void(0)" onclick="goStudyRecord()">返回学习记录</a>
			</c:if>
			<input type="hidden" id="rName" value="${sessionScope.roleName}">
			 <c:if test="${sessionScope.roleName == '网络导师' || sessionScope.roleName == '老师'}">
			  <input type="hidden" id="stuID" value="${requestScope.stuID}">
			  <input type="hidden" id="SubID" value="${requestScope.SubID}">
			  <input type="hidden" id="Tex" value="${requestScope.Tex}">
			  <input type="hidden" id="status" value="${requestScope.status}">
			  <input type="hidden" id="stime" value="${requestScope.stime}">
			  <input type="hidden" id="etime" value="${requestScope.etime}">
			  <input type="hidden" id="ntyn" value="${requestScope.ntyn}">
			  <a href="javascript:void(0)" onclick="goGuideManager()">返回跟踪指导</a>
			</c:if>
		</div>
		<div id="relationResultDiv" class="treeParent"></div>
	</div>
 </body>
</html>
