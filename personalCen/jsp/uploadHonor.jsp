<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
   <title>上传个人荣誉图片</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="Module/css/reset.css">
	<link rel="stylesheet" type="text/css" href="Module/commonJs/progressBar/css/progressBar.css">
	
	<script type="text/javascript" src="Module/commonJs/jquery-1.4.2.min.js"></script> 
	<script type="text/javascript" src="Module/commonJs/jquery.form.js"></script>
	<script type="text/javascript" src="Module/commonJs/progressBar/js/progressBar.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
    <script type="text/javascript">
    function uploadHonor(){
    	this.closeWindow();
    	window.parent.showUploadWindow();
    	document.getElementById("formID").style.display="none";
    	var myDate = new Date();
    	startTime = myDate.getTime();
    	if(document.getElementById("image1").value==""){
    		alert("文件上传路径不能为空！");
    	}else{
    		$("#honorForm").ajaxSubmit({
    			success:function(json){
    				var picUrlStr = json.replace(/\"/g,"");
    				var picUrl = picUrlStr.split(",");
    				if(picUrl == 0){
    					alert("上传图片格式错误，请重新上传！");
    				}else if(picUrl==1){
    					alert("上传图片太大，请不要上传5M以上的图片！");
    				}else if(picUrl==2){
    					alert("上传图片失败，请重试！");
    				}else if(picUrl==3){
    					alert("上传路径错误，请重试！");
    				}else{
    					parent.document.getElementById("imgId1").src = picUrl[0];
    					for(var i=2;i<picUrl.length+1;i++){
    						parent.document.getElementById("imgId"+i).src = picUrl[i-1];
    						parent.document.getElementById("imgId"+i).style.display="";
    					}
    					parent.document.getElementById("honorPic").value=picUrl;
    				}
    			}
    		});
    		$("#progress").show();
    		window.setTimeout("getProgressBar(3)",100);
    		$(this).attr("disabled",true);
    	}
    }
    
	function closeWindow(){
		parent.closeWindow();
	}
	
	var i = 1;
	function addElement(){
		document.getElementById('elementB').style.display="";
		if(i == 2)
		{
			document.getElementById('elementC').style.display="";
		}
		if(i == 3)
		{
			document.getElementById('elementD').style.display="";
		}
		if(i == 4)
		{
			document.getElementById('elementE').style.display="";
		}
		i += 1;
		if(i >= 5)
		{
			i = 5;
		}
	 }
	function delElement(element,img){
		document.getElementById(element).style.display="none";	
		//清空file文件路径
		var obj = document.getElementById(img);
		obj.outerHTML=obj.outerHTML;
		i -= 1;
	 }
	</script>
  </head>
  <body>
       <div id="formID">
            <form enctype="multipart/form-data"  action="uploadHonor.do" method="post" id="honorForm" name="honorForm">
             <table width="100%">
               <tr>
                <td><center><input type="file" id="image1" name="image1"  style="width:300px; margin:20px 0px 10px 0px;"></center></td> 
                <td><img src="Module/personalCen/images/add.png" onclick="addElement()" width="20" height="20"/></td>
               </tr>
               <tr id="elementB" style="display:none">
                <td><center><input type="file" id="image2" name="image2"  style="width:300px; margin:20px 0px 10px 0px;"></center></td>
                <td><img src="Module/personalCen/images/del.png" onclick="delElement('elementB','image2')" width="20" height="20"/></td>
               </tr>
               <tr id="elementC" style="display:none">
                <td><center><input type="file" id="image3" name="image3" style="width:300px;magin:20px 0px 10px 0px;"></center></td>
                <td><img src="Module/personalCen/images/del.png" onclick="delElement('elementC','image3')" width="20" height="20"/></td>
               </tr>
               <tr id="elementD" style="display:none">
                <td><center><input type="file" id="image4" name="image4" style="width:300px;magin:20px 0px 10px 0px;"></center></td>
                <td><img src="Module/personalCen/images/del.png" onclick="delElement('elementD','image4')" width="20" height="20"/></td>
               </tr>
               <tr id="elementE" style="display:none">
                <td><center><input type="file" id="image5" name="image5" style="width:300px;magin:20px 0px 10px 0px;"></center></td>
                <td><img src="Module/personalCen/images/del.png" onclick="delElement('elementE','image5')" width="20" height="20"/></td>
               </tr>
               <tr>
                <td>
                 <center>
                  <input class="sure" type="button" value="确定" id="upload" onclick="uploadHonor()">
                  <input class="cancel" type="button" value="取消" onclick="closeWindow()">
                 </center>
                </td>
               </tr>
             </table>
            </form>
       </div>
       <!-- 进度条 -->
       <div id="progress" style="display:none; background:url(Module/commonJs/progressBar/images/progre.jpg) no-repeat left top;">
            <center><div id="cloudPic" class="cloudpic"></div></center>
            <div id="progressBar">
              <div id="uploaded" class="uploadPic"></div>
            </div>
            <div id="info"></div>
            <center><span id="timeStr" style="display:none";>窗口将在<span id="endtime">2</span>秒后关闭</span></center>
       </div>
  </body>
</html>
