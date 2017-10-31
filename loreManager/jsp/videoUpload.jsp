<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>===上传页面===</title>
	<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
 	<link href="Module/commonJs/progressBar/css/progressBar.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery.form.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/commonJs/progressBar/js/progressBar.js"></script>
	
<script type="text/javascript">

 function closeWindow(){
	 parent.closeWindow();
 }
</script>
  </head>
  
  <body>
  <div id="formID">
	<form  enctype="multipart/form-data" action="uploadVideo.do" method="post" id="videoForm" name="videoForm">
	    <table width="100%">
		    <tr>
		     <td>
		       <center>
		          <input type="file" name="videoPath" id="videoPath" style="width:300px;margin:15px 0px 10px 0px;">
		       </center> 
		     </td>
		   </tr>
		   <tr>
		      <td>
		          <center>
			          <INPUT class="Sborder sure" type="button" value="上传"  id="uploadVideoButton">    
			          <INPUT class="Sborder cancel" type=button value="取 消"  onclick="closeWindow()">
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
   		<center><span id="timeStr" style="display:none;">窗口将在<span id="endtime">2</span>后关闭</span></center>
    </div>
  </body>
</html>
