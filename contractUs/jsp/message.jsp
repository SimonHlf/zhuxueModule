<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>助学网我要留言</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/contractUs/css/messageCss.css" type="text/css" rel="stylesheet" />
<link href="Module/contractUs/css/commonTitCss.css" type="text/css" rel="stylesheet" />
<script src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript"></script>
<script>
$(function(){
	checkScrollTop();
});
function checkScrollTop(){
	var oParent = window.parent;
	var scrollTop=oParent.document.documentElement.scrollTop||oParent.document.body.scrollTop;
	
}
</script>
</head>
  
<body>
	<div class="zhuXueWrap w1000">
		<div class="navTit">
			<span class="decPic"></span>
			<p class="aPar">您当前的位置 <a href="http://www.zhu-xue.cn" target="_top">首页</a> | <a href="index.do?action=fourParts">关于我们</a> | 留言板</p>
		</div>
		
		<div class="proBox clearfix">
			<h2 class="comH2 messageTxt">留言板</h2>
			<!-- 留言板盒子  -->
			<div class="messWrap">
				<!-- 头部留言回复 翻页  -->
				<div class="messTop">
					<div class="posRelat w1000">
						<span class="triangle triTop"></span>
						<strong class="messTxt cols1 fl">留言回复</strong>
					</div>
				</div>
				<!-- 留言回复中间主要内容  -->
				<div class="messMainCon">
					<span class="borLeft"></span>
					<ul class="listMessCon">
						<li>
							<span class="messIcon"></span>
							<p class="timeBox">2015-06-14 18:52:25</p>
							<!-- 发表的内容 盒子 -->
							<div class="mesConTop clearfix">
								<img src="Module/contractUs/images/pubUser.png" class="fl"/>
								<div class="mesConWrap fl">
									<div class="mesConTitBox">
										<p><strong>标题：我是发表留言标题的测试内容</strong></p>
									</div>
									<div class="mesCon">
										<p><strong>内容：</strong>我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容</p>
									</div>
								</div>
							</div>
							<!-- 管理员回复的内容盒子  -->
							<div class="mesConBot">
								<span class="triDecIcon"></span>
								<p>管理员回复：我是管理员回复的内容测试</p>
							</div>
						</li>
									<li>
							<span class="messIcon"></span>
							<p class="timeBox">2015-06-14 18:52:25</p>
							<!-- 发表的内容 盒子 -->
							<div class="mesConTop clearfix">
								<img src="Module/contractUs/images/pubUser.png" class="fl"/>
								<div class="mesConWrap fl">
									<div class="mesConTitBox">
										<p><strong>标题：我是发表留言标题的测试内容</strong></p>
									</div>
									<div class="mesCon">
										<p><strong>内容：</strong>我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容</p>
									</div>
								</div>
							</div>
							<!-- 管理员回复的内容盒子  -->
							<div class="mesConBot">
								<span class="triDecIcon"></span>
								<p>管理员回复：我是管理员回复的内容测试</p>
							</div>
						</li>
									<li>
							<span class="messIcon"></span>
							<p class="timeBox">2015-06-14 18:52:25</p>
							<!-- 发表的内容 盒子 -->
							<div class="mesConTop clearfix">
								<img src="Module/contractUs/images/pubUser.png" class="fl"/>
								<div class="mesConWrap fl">
									<div class="mesConTitBox">
										<p><strong>标题：我是发表留言标题的测试内容</strong></p>
									</div>
									<div class="mesCon">
										<p><strong>内容：</strong>我是发表留言内容我是发表留言内容我是发表我是发表留言内容我是发表我是发表留言内容我是发表我是发表留言内容我是发表我是发表留言内容我是发表我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容</p>
									</div>
								</div>
							</div>
							<!-- 管理员回复的内容盒子  -->
							<div class="mesConBot">
								<span class="triDecIcon"></span>
								<p>管理员回复：我是管理员回复的内容测试</p>
							</div>
						</li>
									<li>
							<span class="messIcon"></span>
							<p class="timeBox">2015-06-14 18:52:25</p>
							<!-- 发表的内容 盒子 -->
							<div class="mesConTop clearfix">
								<img src="Module/contractUs/images/pubUser.png" class="fl"/>
								<div class="mesConWrap fl">
									<div class="mesConTitBox">
										<p><strong>标题：我是发表留言标题的测试内容</strong></p>
									</div>
									<div class="mesCon">
										<p><strong>内容：</strong>我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容我是发表留言内容</p>
									</div>
								</div>
							</div>
							<!-- 管理员回复的内容盒子  -->
							<div class="mesConBot">
								<span class="triDecIcon"></span>
								<p>管理员回复：我是管理员回复的内容测试员回复的内容测试员回复的内容测试员回复的内容测试员回复的内容测试员回复的内容测试员回复的内容测试员回复的内容测试</p>
							</div>
						</li>
					</ul>
				</div>
				<!-- 留言回复底部  -->
				<div class="messBot posRelat">
					<span class="triangle triBot"></span>
					<strong class="messTxt cols2 fl">我要留言</strong>
											<div class="turnPageBox fl">
							<p class="fl">第1页</p>
							<p class="fl">共3页</p>
							<a href="javascript:void(0)">首页</a>
							<a href="javscript:void(0)">上一页</a>
							<a href="javscript:void(0)">下一页</a>
							<a href="javscript:void(0)">尾页</a>
						</div>
				</div>
				
			</div>
			<!-- 发表留言的文本框  -->
			<div class="pubMessBox">
				<!-- 留言标题  -->
				<div class="pubTit"><strong class="headTit fl">留言标题</strong><input class="pubTitTxt fl" type="text"/></div>
				<!-- 留言内容  -->
				<div class="pubCon">
					<strong class="conTit fl">留言内容</strong>
					<textarea class="pubTxtBox fl"></textarea>
				</div>
				<!-- 提交留言  -->
				<a class="pubMesBtn" href="javascript:void(0)">发表留言</a>
			</div>
		</div>
	</div>
</body>
</html>
