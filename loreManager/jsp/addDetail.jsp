<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <title>addDetail.jsp</title>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
  </head>
  
  <body>
    <input type="button" value="知识清单"/>
    <input type="button" value="点拨指导"/>
    <input type="button" value="解题示范"/>
    <input type="button" value="巩固训练"/>
    <input type="button" value="针对性诊断"/>
    <input type="button" value="再次诊断"/>
    <input type="button" value="知识讲解"/><br>
    <iframe id="detailFrame" width="100%" src=""></iframe>
  </body>
</html>
