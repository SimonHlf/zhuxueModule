<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>助学网联系我们</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/contractUs/css/contractUsCss.css" type="text/css" rel="stylesheet" />
<link href="Module/contractUs/css/commonTitCss.css" type="text/css" rel="stylesheet" />
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script type="text/jscript">
$(function(){
	topMove();
});
function topMove(){
	$(".detailConTxt li").each(function(i){
		$(this).hover(function(){
			$(".decIcon").eq(i).stop().animate({"top":18});
		},function(){
			$(".decIcon").eq(i).stop().animate({"top":24});
		});
	});
}
</script>
  </head>
  
<body>
	<!-- 联系我们中间内容  -->
	<div class="contractWrap w1000">
		<!-- 头部面包屑导航 -->
		<div class="navTit">
			<span class="decPic"></span>
			<p class="aPar">您当前的位置 <a href="http://www.zhu-xue.cn" target="_top">首页</a> | <a href="index.do?action=fourParts">关于我们</a> | 联系我们</p>
		</div>
		<!-- 联系我们  -->
		<div class="contracts clearfix">
			<h2 class="comH2 contractTxt">联系我们</h2>
			<!-- 引入百度地图  -->
			<div class="mapWrap">
                <!--  iframe src="Module/contractUs/jsp/map.html" width="994" height="306" frameborder="0" scrolling="no"></iframe-->
                <a href="http://j.map.baidu.com/n8RV1" target="_blank" title="上海市黄浦区陆家浜路976号富南大厦2007室上海圆培网络科技有限公司">
                	<img src="Module/contractUs/images/map.gif" alt="上海市黄浦区陆家浜路976号富南大厦2007室上海圆培网络科技有限公司"/>
                </a>
            </div>
            <div id="detailBox" class="detailConTxt">
            	<ul class="clearfix">
            		<li class="mlLi">
            			<span class="decIcon addIcon"></span>
            			<p class="address comTxtDec">上海市黄浦区陆家浜路976号富南大厦2007室上海圆培网络科技有限公司</p>
            		</li>
            		<li>
            			<span class="decIcon telIcon"></span>
            			<p class="tel comTxtDec">电话：021-53530930</p>
					</li>
            		<li class="mlLi">
            			<span class="mailNum decIcon"></span>
            			<p class="email comTxtDec">邮编：200001</p>
            		</li>
            		<li>
            			<span class="webSite decIcon"></span>
            			<p class="webTxt comTxtDec">网址：<a href="http://www.zhu-xue.cn" target="_blank">http://www.zhu-xue.cn</a></p>
            		</li>
            		<li class="mlLi">
            			<span class="hour24 decIcon"></span>
            			<p class="service comTxtDec">全国统一服务热线：400-99-62559
            		</li>
            		<li>
            			<span class="kefuIcon decIcon"></span>
            			
            		</li>
            	</ul>
            </div>
		</div>
	</div>
</body>
</html>
