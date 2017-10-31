<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8" />
<title>网络导师个人简介</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/netTeacherResumeCss.css" type="text/css" rel="stylesheet" />
<link href="Module/personalCen/css/personalInfo.css" type="text/css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/personalCen/js/personalJs.js"></script>
<script type="text/javascript" src="Module/commonJs/progressBar/js/progressBar.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript">
var onOff = true;
$(function(){
	LimitTextArea(getId("textareaBox"));
	checkLength();
});
function checkLength(){
	if($(".comUploadBox img").length == 0){
		$(".comUploadBox").hide();
		$(".picCoverBox").hide();
		$(".savaInfo2").addClass("margL");
		$(".savaInfo2").addClass("margt1");
	}else{
		$("#gloryCoverImg").attr("src",$(".comImg:first").attr("src"));
		$(".totalNum").html($(".comUploadBox img").length);
		$(".savaInfo2").addClass("margt");
		$(".savaInfo2").addClass("margL1");
		toBlockLayer();
	}
}
function toBlockLayer(){
		$(".picCoverBox").hover(function(){
				$(".lookLayer").show();
				$(".seePicBtn").animate({top:100},300);
		},function(){
				$(".lookLayer").hide();
				$(".seePicBtn").animate({top:-40},300);
		});
}
function toShowGloryImg(){
	$(".comParents").show();
	$(".comParents").animate({width:474},500,function(){
		$(".imgbox").show();
		$(".scrollPar").show();
		scrollBar("uploadBox","upImgBox","parentScroll","sonScrollBar",10);
		setSmallImg();
	});
	
}
function toHideGloryImg(){
	$(".imgbox").hide();
	$(".comParents").animate({width:0},500,function(){
		$(".comParents").hide();
	});
}
function setSmallImg(){
	$(".imgbox").each(function(i){
		$(this).hover(function(){
			$(".smallImgLayer").eq(i).show();
			$(".setImg").eq(i).show();
			showSetLayer();
		},function(){
			$(".smallImgLayer").eq(i).hide();
			$(".setImg").eq(i).hide();
			$(".setToolBox").eq(i).hide();
			
		});
	});
}

function showSetLayer(){
	$(".setImg").each(function(i){
		$(this).click(function(){
			$(".setToolBox").eq(i).slideDown();
		});
	});
}
function delImgSrc(){
	$(".fixBox").each(function(i){
		$(this).click(function(){
			//$(".imgbox").eq(i).remove();
		});
	});
}
function showUploadWindow(option){
	document.getElementById("uploadPicDiv").style.display="";
	$("#uploadPicDiv").window({
		title:"上传荣誉图片",
		width:400,
		height:245,
		collapsible:false,
		minimizable:false,
		maximizable:false,
		resizable:false,
		modal:true
	});
	if(option == 0){
		var mainWin=window.document.getElementById("upIframeFile").contentWindow;
		//mainWin.document.getElementById("progress").style.display="none";
		mainWin.document.getElementById("formID").style.display="";
		var image1=mainWin.document.getElementById("image1");
		var image2=mainWin.document.getElementById("image2");
		var image3=mainWin.document.getElementById("image3");
		var image4=mainWin.document.getElementById("image4");
		var image5=mainWin.document.getElementById("image5");
		mainWin.document.getElementById("elementB").style.display="none";
		mainWin.document.getElementById("elementC").style.display="none";
		mainWin.document.getElementById("elementD").style.display="none";
		mainWin.document.getElementById("elementE").style.display="none";
		image1.outerHTML=image1.outerHTML;
		image2.outerHTML=image2.outerHTML;
		image3.outerHTML=image3.outerHTML;
		image4.outerHTML=image4.outerHTML;
		image5.outerHTML=image5.outerHTML;
	}
}
function closeWindow(){
	$("#uploadPicDiv").window("close");
}
function saveResume(){
	var teacherIntro = document.getElementById("textareaBox").value;
	var honorPic = document.getElementById("honorPic").value;
	if(teacherIntro==""){
		alert("请填写自我介绍！");
	}else{
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			url:"userManager.do?action=saveResume&teacherIntro="+teacherIntro+"&honorPic="+honorPic,
			success:function(json){
				if(json){
					alert("个人简介保存成功！");
					window.location.reload();
				}else{
					alert("个人简介保存失败，请重试！");
				}
			}
		});
	}
}
function LimitTextArea(obj){
	var maxlimit = 2000;
	var oNowNum = getId("nowNum");
	var oMaxNum = getId("maxNum");
	if(obj.value.length>maxlimit){
		obj.value = objs.value.substring(0,maxlimit);
	}else{
		oMaxNum.innerHTML = maxlimit - obj.value.length;
		oNowNum.innerHTML = obj.value.length;
	}
}
//删除个人简介图片
function deleteHonor(honorUrl){
	var honorUrl = honorUrl;
	//var honorUrl = document.getElementById("imgId").src;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"userManager.do?action=deleteHonor&honorUrl="+honorUrl,
		success:function(json){
			if(json){
				alert("删除成功！");
				window.location.reload(true);
			}else{
				alert("删除失败！请重试！如有需要，请联系客服。");
			}
		}
	});
}
</script>
</head>
  <body>
    <div class="nowPosition">
    	<p><span class="fontSet"><span class="weightSpan">个</span>人简介</span></p>
    </div>

    <div class="resumeCon">
    	<div class="tabcon clearfix">
        	<div class="resumeBox clearfix">
        	  <c:forEach items="${requestScope.ulist}" var="user" varStatus="status">
              <c:set var="index" value="${status.index}"></c:set>
            	<!-- 个人信息 -->
            	<c:forEach items="${requestScope.ntlist}" var="netTeacher" begin="${index}" end="${index}">
            	<div class="wrap clearfix">
                    <span class="netIcon pos1"></span>
                    <div class="titleFont fl">
                        <span class="fl">基本信息</span><span class="line fl"></span>
                    </div>
                    
                    <div class="netParDiv fl">
                      <div class="netComDiv">
                                                          姓<span class="blanks"></span>名：<c:out value="${user.realname}"></c:out>
                      </div>
                      <div class="netComDiv">
                                                          性<span class="blanks"></span>别：<c:out value="${user.sex}"></c:out>
                      </div>
                      
                      <div class="netComDiv">
                        <span>担任学段</span>：<c:out value="${netTeacher.schoolType}"></c:out>
                      </div>
                      <div class="netComDiv">
                        <span>担任学科</span>：<c:out value="${netTeacher.subject.subName}"></c:out>
                      </div>
                      
                    </div> 
                </div>
                <!-- 个人介绍 -->
                <div class="wrap clearfix mb">
                    <span class="netIcon pos2"></span>
                    <div class="titleFont fl">
                        <span class="fl">个人介绍</span> <span class="line fl"></span>
                    </div>
                    <div class="personalResumeBox fl">
                    	<textarea id="textareaBox" class="textBox" onkeydown="LimitTextArea(this)" onkeypress="LimitTextArea(this)" onkeyup="LimitTextArea(this)" maxlength="2000"><c:out value="${netTeacher.teacherIntro}"/></textarea>
                    </div>
                    <div class="remainBox">
                    	当前已输入<span id="nowNum"></span>个字符，还剩<span id="maxNum"></span>个字符
                    </div>
                </div>
                <!-- 个人荣誉 -->
                <div class="wrap widths clearfix">
                	<span class="netIcon pos3"></span>
                    <div class="titleFont fl">
                        <span class="fl">个人荣誉</span><span class="line fl"></span>
                    </div>
                    
                    <!-- 这个是上传照片的盒子 -->
                    <div class="upLoadImgBox fl" id="honor">
                        <input type="hidden" id="honorPic">

                    	<img id='imgId1' width="110" height="140" class="noUpload" style="display:block" alt="双击上传荣誉图片" ondblclick="showUploadWindow(0)"/>
                    	<img id='imgId2' class="noUpload imgMl" width="110" height="140"/>
	                    <img id='imgId3' class="noUpload imgMl" width="110" height="140"/>
	                    <img id='imgId4' class="noUpload imgMl" width="110" height="140"/>
	                    <img id='imgId5' class="noUpload imgMl" width="110" height="140"/>

                     </div>

                    <!-- 上传个人荣誉iframe -->
                    <div id="uploadPicDiv" style="display:none">
	              		<iframe name="upIframeFile" id="upIframeFile" height="98%" width="100%" src="userManager.do?action=honorPic" frameborder="0" scrolling="no"></iframe>
	                </div>
	                                
	               	<!-- 上传完成后集成的相册盒子封面  -->
		            <div class="picCoverBox fl">
					   <img src="" id="gloryCoverImg" width="182" height="240"/>
	                   <div class="picNumNameLayer"></div>
	                   <div class="nameNum">个人荣誉相册<span class="totalNum"></span></div>
	                   <div class="lookLayer"></div>
	                   <span class="seePicBtn" onclick="toShowGloryImg()" title="展开相册"></span>
	                </div>
	                <!-- 上传完成后集成的相册盒子  -->
	                <div class="comParents fl">
		                <div id="uploadBox" class="comUploadBox">
		                	<div id="upImgBox">
			                	<c:forEach items="${requestScope.honorPicStr}" var="honor">
			                    	<c:if test="${honor!='0'}">
			                    		<div  class="imgbox">
			                        		<img id='imgId' width="95" height="120" class="comImg" src="${pageContext.request.contextPath}/<c:out value="${honor}"/>"/>
			                        		<span class="setImg"></span>
			                        		<div class="smallImgLayer"></div>
			                        		<div class="setToolBox">
			                        			<ul>
			                        				<li class="fixBox">
			                        					<span class="toolIcon"></span>
			                        					<a  onclick="deleteHonor('${honor}')">删除</a>
			                        				</li>
			                        			</ul>
			                        		</div>
			                        	</div>
			                        </c:if>
			                        
			                   </c:forEach>	
		                   </div>
		                </div>
		                <span class="closecomUploadBox" onclick="toHideGloryImg()" title="关闭"></span>
		                <div id="parentScroll" class="scrollPar">
		                	<div id="sonScrollBar" class="scrollSon"></div>
		                </div>
	                </div>
                </div>				
               </c:forEach>
               <div class="wrap">
               		<input class="savaInfo2" type="button" id="save" name="save" value="保存" onclick="saveResume()">
               </div>
             
              </c:forEach>
            </div>
        </div>
    </div>
  </body>
</html>
