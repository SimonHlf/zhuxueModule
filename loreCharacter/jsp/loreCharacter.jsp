<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>头衔设置</title>
     <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
     <link href="Module/loreCharacter/css/loreCharacter.css" type="text/css" rel="stylesheet" />
     <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
     <script type="text/javascript" src="Module/loreCharacter/js/loreCharacher.js"></script>
  </head>
  <script type="text/javascript">
  	$(function(){
  		checkZindex();
  	});
  	function checkZindex(){
  		$(".radioBtn").each(function(i){
  			$(this).click(function(){
  				$(".imgBox").hide().stop().animate({opacity:0.5}).eq(i).stop().animate({opacity:1},500).show();
  				$(".nowState").removeClass("choiceActive_on").eq(i).addClass("choiceActive_on");
  			});
  		});
  	}
  </script>
<body>
  <!-- 当前位置  -->
  <div class="nowPosition">
    <P><span>头</span>衔设置</P>
  </div>
  <div class="tuoxianTxt">
 	 每个用户都会有一套属于自己的经验值、金币、头衔和能力值。我们特地为您定做了四套头衔系列，您可以注册登录后选择一个最喜欢的头衔，您可以通过学习知识点不断增加经验值，您的金币、头衔和能力值也会不断增加和晋升
  </div>
  
<div class="headNameWrap clearfix">
	<c:forEach items="${requestScope.lclist}" var="lc" end="3">
		<c:choose>
			<c:when test="${lc.id == requestScope.lcID}">
				<div class="radionBox">
					<input class="radioBtn" type="radio" value="${lc.id }" name="lcName" checked="checked"> ${lc.name }
					<img class="imgIcon" src="Module/loreCharacter/images/${lc.portrait_new }">
						 
					<span class="nowState choiceActive_on"></span>
				</div>
				<div class="imgBox" style="display:block;opacity:1;filter:alpha(opacity=100);">
					<img src="Module/loreCharacter/images/D${lc.id }.gif">
				</div>
			</c:when>
			<c:otherwise>
				<div class="radionBox">  
					<input class="radioBtn" type="radio" value="${lc.id }"  name="lcName"> ${lc.name }
					<img class="imgIcon" src="Module/loreCharacter/images/${lc.portrait_new }">
					<span class="nowState"></span>
				</div>
				<div class="imgBox" style="display:none;opacity:0.5;filter:alpha(opacity=50);">
					<img src="Module/loreCharacter/images/D${lc.id }.gif">
				</div>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<div class="subButton">
		<input type="hidden" id="lcuID" value="${requestScope.lcuID }">
		<span class="tijiaoBtn" onclick="updateLC()">提交</span>
	</div>
</div>
</body>
</html>
