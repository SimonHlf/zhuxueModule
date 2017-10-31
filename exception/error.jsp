<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="exception.jsp"%>
<%@ include file="../taglibs/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<title>===课堂信息反馈系统===</title>
<link href="CSS/Style.css" rel="stylesheet" type="text/css">
</head>

<body>
<div align="center">
<table width="777" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="border: 2px solid #008000; padding: 0px" height="478">
  <!--tr>
    <td height="136" align="justify" valign="bottom" background="images/2.jpg" style="border-bottom: 1px solid #008000; padding: 0">　</td>
  </tr-->
  <tr>
    <td height="275" align="center">
  <div align="center"><font color="#FF0000" size="+1"><b>系统处理过程中发生了一个错误，信息如下：</b></font></div>
  <logic:messagesPresent>
   <p color="red">
   <ul>
   <html:messages id="exception">
      <li><bean:write name="exception"/></li>
   </html:messages>
   </ul><hr />
   </p>
</logic:messagesPresent>	
<div align="center">请您先核对输入，如果再次出现该错误，请与站长联系。sandy.com 谢谢。</div>	
	</td>
  </tr>  
</table>
<%@include file="../foot/footer.jsp"%> 
</div>

</body>
</html>


