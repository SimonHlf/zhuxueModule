<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@include file="../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>助学网，中小学生课堂反馈系统--在线客服</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="Module/kefu/css/kefuCss.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript">
	$(function(){
		$('.right_bar').click(function(){
			$('#kefu').show(300);
		});
		$('#kefu .close').click(function(){
			$('#kefu').hide(300);
		});
	});
	</script>
  </head>
  
  <body>
	<div id="kefu">
		<div class="top">
			在线客服<img src="Module/kefu/images/close.gif" class="close" />
		</div>
	<div class="middle">
		<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=32011823&site=qq&menu=yes"><img src="Module/kefu/images/qq.png" /></a><br />
		<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2687016781&site=qq&menu=yes"><img src="Module/kefu/images/qq.png" /></a><br />
		<b style="padding-top:8px;display:block;">客服电话</b>
		<p style="padding-bottom:6px;">400-99-62559</p>
		<b style="padding-top:6px;">售后投诉</b>
		<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=270826057&site=qq&menu=yes"><img src="Module/kefu/images/qq.png" /></a><br />
		<!-- 暂时不用阿里旺旺
		<b style="padding-top:8px;display:block;">阿里旺旺</b>
		<p>
		<a target="_blank" href="http://www.taobao.com/webww/ww.php?ver=3&touid=123456&siteid=cntaobao&status=1&charset=utf-8"><img border="0" src=	"http://amos.alicdn.com/realonline.aw?v=2&uid=123456&site=cntaobao&s=1&charset=utf-8" alt="点击这里给我发消息" /></a>
		</p>
		-->
		<div class="triangle"></div>
	</div>
	</div>
	<div class="right_bar"></div>
  </body>
</html>
