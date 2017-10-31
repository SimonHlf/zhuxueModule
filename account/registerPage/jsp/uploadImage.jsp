<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>    
    <title>===上传头像===</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="Module/css/reset.css">
	<link rel="stylesheet" type="text/css" href="Module/commonJs/progressBar/css/progressBar.css">
	
    <script type="text/javascript" src="Module/commonJs/jquery-1.4.2.min.js"></script> 
	<script type="text/javascript" src="Module/commonJs/jquery.form.js"></script>
	<script type="text/javascript" src="Module/commonJs/progressBar/js/progressBar.js"></script>
	<script type="text/javascript" charset="GBK" src="Module/commonJs/comMethod.js"></script>
	
	<script type="text/javascript">

	function closeWindow(){
		parent.closeWindow();
	}
	</script>

  </head>
  
  <body>
    <div id="formID1">
            <form enctype="multipart/form-data"  action="Upload.do" method="post" id="imageForm" name="imageForm">
             <table width="100%">
               <tr>
                <td>
                 <center> 
                  <input type="file" id="image1" name="image1"  style="width:300px; margin:20px 0px 10px 0px;">
                 </center>
                </td>
               </tr>
               <tr>
                <td>
                 <center>
                  <input class="sure" type="button" value="确定" id="subButton">
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
