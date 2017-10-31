<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title></title> 
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/commonCss.css" type="text/css" rel="stylesheet" />
	<link href="Module/loreManager/css/addExplaineCss.css" type="text/css" rel="stylesheet" />
    <link href="Module/commonJs/ueditor/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
 	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript">
	var existFlag = "yes";
	$(function(){
		editTextBox();
		<c:forEach items="${requestScope.lqList_explain}" var="lq">
			initUeditorContent("myEditor_explain",'${lq.subject}');
			getId("videoPath").value = "${lq.answer}";
			$('#headTitleName').html("知识典:"+"${lq.lore.loreName}");
			if(getId("videoPath").value != ""){
				existFlag = "yes";
			}else{
				existFlag = "no";
			}
		</c:forEach>
		showOrHidImg(existFlag);
	});
	var myEditor_explain;
	//文本编辑器		
	function editTextBox(){
		myEditor_explain = new baidu.editor.ui.Editor( {
			initialFrameWidth : 750,
			initialFrameHeight : 240,
			wordCount:true,
			textarea : 'description'
		});
		myEditor_explain.render("myEditor_explain");
	}
	//初始化主题文本内容(从数据库中获取)
	function initUeditorContent(obj,content){
		UE.getEditor(obj).addListener("ready", function () {
	        // editor准备好之后才可以使用
	        UE.getEditor(obj).setContent(content,null);
		});
	}
	//显示/隐藏存在警告图标
	function showOrHidImg(existFlag){
		if(existFlag == "no"){
			$("#uploadVideo").attr("disabled", false);
			$("#submitButton").attr("disabled", false);
			$(".upComBtn").addClass("upunDisableBtn");
			$(".Btn").addClass("subBtn");
			getId("videoInfo").style.display = "none";
		}else{
			$("#uploadVideo").attr("disabled", true);
			$("#submitButton").attr("disabled", false);
			$(".upIcon").hide();
			$(".upComBtn").addClass("upDisabled");
			$(".Btn").addClass("subBtn");
			getId("videoInfo").style.display = "";
		}
	}
	function check(){
		getId("videoFinalPath").value = getId("videoPath").value;
		getId("content_question").value = myEditor_explain.getContent();
		if(getId("content_question").value == ""){
			alert("题干不能为空!");
			editor_explain.focus();
			return false;
		}else if(getId("videoFinalPath").value == ""){
			alert("您还未上传音频/视频文件!");
			return false;
		}else{
			return true;
		}
	}
	//清空数据库中视频地址
	//（用户删除视频后需要更新下数据库）
	//防止用户删除视频后直接退出的情况
	function removeDatabaseVideoPath(){
		var loreQuestionId = getId("loreQuestionId").value;
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        url:"loreManager.do?action=removeVideoPath&loreQuestionId="+loreQuestionId,
	        success:function (json){
				if(json){
					$.messager.alert("成功","删除成功!","info");
				}
	        }
	    });	
	}
	//清空上次上传背景
	function hideUploadInfo(){
		var window = getId("upiframeFile").contentWindow;
		window.getId("progress").style.display = "none";
		window.getId("formID").style.display="";
		window.getId("uploadVideoButton").disabled = false;
		window.getId("videoPath").value = "";
		window.getId("endtime").innerHTML = 2;
	}
	//删除上传资源
	function videoDel(){
		var videoTempPath = getId("videoPath").value;
		$.messager.confirm('删除确认', '是否确定删除该视频文件?', function(r){
			if (r){
				$.ajax({
			        type:"post",
			        async:false,
			        dataType:"json",
			        url:"loreManager.do?action=delTempVideo&videoTempPath="+videoTempPath,
			        success:function (json){
			        	if(json){//删除成功
			        		getId("videoPath").value = "";
			        		getId("videoInfo").style.display="none";
			        		getId("uploadVideo").disabled = false;
			        		$(".upComBtn").removeClass("upDisabled");
			        		$(".upComBtn").addClass("upunDisableBtn");
			        		$(".upIcon").show();
			        		//清空数据库中视频路径--防止恶意刷新
							removeDatabaseVideoPath();
			        		//------------清空之前上传信息-------------//
				   			hideUploadInfo();
				   			
			        	}else{
			        		$.messager.alert("错误","删除失败!","error");
			        	}
			        }
			    });	
			}
		});
	}
	//显示上传文件窗口
	function showUploadWindow(){
		getId("upLaodVideoDiv").style.display="";
			$("#upLaodVideoDiv").window({  
			   title:"音频/视频上传", 
               width:400,   
               height:245, 
               collapsible:false,
               minimizable:false,
               maximizable:false,
               resizable:false,
               modal:true
		});
			
	}
	//窗口关闭
	function closeWindow(){
		$('#upLaodVideoDiv').window('close');
	}
	</script>
  </head>
  
  <body>
    <div class="addExplaineWrap clearfix">
  		<div class="comParentWrap">
		  	<h2 id="headTitleName" class="headTitle"></h2>
		  	<div id="explainDiv">
			   	<div class="contents">
			   		题干
			   	</div>
			   	<div id="myEditor_explain"></div>
		   	</div>
			<div id="videoDiv" class="clearfix">
				<input type="hidden" id="videoPath"/>
				<span class="upIcon"></span>
				<input type="button" id="uploadVideo" class="upComBtn" value="上传音频/视频" onclick="showUploadWindow()"/>
				<div id="videoInfo" style="display:no-ne;">
					<img src="Module/loreManager/images/video.png"/>
					<a href="javascript:void(0)" hidefocus="true" class="delUpFiles" onclick="videoDel();">删除</a>
				</div>
		    </div>
		   	
		   	<div id="upLaodVideoDiv" style="display: none">
				<iframe name="upiframeFile" id="upiframeFile" height="98%" width="100%" src="loreManager.do?action=showUploadVideo&loreId=${requestScope.loreId}"  frameborder="0" scrolling="no"></iframe>
			</div>
	   	</div>
	   	<html:form action="loreManager.do">
	   		<input type="hidden" id="action" name="action" value="updateExplainList" />
	   		<input type="hidden" id="loreId" name="loreId" value="${requestScope.loreId}"/>
			<input type="hidden" id="loreQuestionId" name="loreQuestionId" value="${requestScope.loreQuestionId}"/>
	   		<input type="hidden" id="content_question" name="content_question"/>
	   		<input type="hidden" id="videoFinalPath" name="videoFinalPath"/>
	   		<div class="refer">
	   			<input type="submit" value="提交" id="submitButton" class="Btn" onclick="return check()"/>
	   			<input type="button" class="backBtn" value="返回上一级" onclick="backMain(${requestScope.loreId})"/>
	   		</div>
	   	</html:form> 	
   	</div>
  </body>
</html>
