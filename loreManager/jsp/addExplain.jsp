<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    
    <title>addExplain.jsp</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
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
	<script type="text/javascript" src="Module/loreManager/js/loreCommonJs.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="Module/commonJs/ueditor/ueditor.all.js"></script>
	<script type="text/javascript">
		var loreId = ${requestScope.loreId};
		var existFlag = "${requestScope.existFlag}";
		var editor_explain;
		$(function(){
			editTextBox();
			showOrHidImg(existFlag);
			moveQueryBox("moveWrap","top");
	    });
		//显示/隐藏存在警告图标
		function showOrHidImg(existFlag){
			if(existFlag == "no"){
				getId("warningImg").style.display = "none";
				$("#uploadVideo").attr("disabled", false);
				$("#submitButton").attr("disabled", false);
				$(".upComBtn").addClass("upunDisableBtn");
				$(".Btn").addClass("subBtn");
			}else{
				getId("warningImg").style.display = "";
				$("#uploadVideo").attr("disabled", true);
				$("#submitButton").attr("disabled", true);
				$(".upIcon").hide();
				$(".upComBtn").addClass("upDisabled");
				$(".Btn").addClass("Disabled");
			}
		}
		//文本编辑器		
		function editTextBox(){
			editor_explain = new baidu.editor.ui.Editor( {
				initialFrameWidth : 750,
				initialFrameHeight : 240,
				wordCount:true,
				textarea : 'description'
			});
			editor_explain.render("myEditor_explain");
		}
		//提交清单
		function check(){
			getId("videoFinalPath").value = getId("videoPath").value;
			getId("content_question").value = editor_explain.getContent();
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
			//执行插入动作
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
		//删除上传资源
		function videoDel(){
			var videoTempPath = getId("videoPath").value;
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
		        		
		        		//------------清空之前上传信息-------------//
			   			 hideUploadInfo();
			   			
		        	}else{
						alert("删除失败");
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
	</script>
  </head>
  
  <body>
  	<div class="addExplaineWrap clearfix">
  		<div class="comParentWrap">
		  	<h2 class="headTitle">知识典:${requestScope.loreName }</h2>
		  	<div id="explainDiv">
			   	<div class="contents">
			   		题干
				   	<div id="warningImg" class="noticeBox">
					   	<span class="warnningIcon"></span>
					   	<span class="col">该知识点已存在知识讲解，不能再进行添加，如果需要修改，请到编辑功能中去修改</span>
				   	</div>
			   	</div>
			   	<div id="myEditor_explain"></div>
		   	</div>
			<div id="videoDiv" class="clearfix">
				<input type="hidden" id="videoPath"/>
				<span class="upIcon"></span>
				<input type="button" id="uploadVideo" class="upComBtn" value="上传音频/视频" onclick="showUploadWindow()"/>
				<div id="videoInfo" style="display:none;">
					<img src="Module/loreManager/images/video.png"/>
					<a href="javascript:void(0)" hidefocus="true" class="delUpFiles" onclick="videoDel();">删除</a>
				</div>
		    </div>
		   	
		   	<div id="upLaodVideoDiv" style="display: none">
				<iframe name="upiframeFile" id="upiframeFile" height="98%" width="100%" src="loreManager.do?action=showUploadVideo&loreId=${requestScope.loreId}"  frameborder="0" scrolling="no"></iframe>
			</div>
	   	</div>
	   	<html:form action="loreManager.do">
	   		<input type="hidden" id="action" name="action" value="addExplain" />
	   		<input type="hidden" id="loreId" name="loreId" value="${requestScope.loreId}"/>
	   		<input type="hidden" id="loreType" name="loreType" value="${requestScope.loreType}"/>
	   		<input type="hidden" id="loreName" name="loreName" value="${requestScope.loreName}"/>
	   		<input type="hidden" id="content_question" name="content_question"/>
	   		<input type="hidden" id="videoFinalPath" name="videoFinalPath"/>
	   		<div class="refer">
	   			<input type="submit" value="提交" id="submitButton" class="Btn" onclick="return check()"/>
	   		</div>
	   	</html:form> 	
   	</div>
  </body>
</html>
