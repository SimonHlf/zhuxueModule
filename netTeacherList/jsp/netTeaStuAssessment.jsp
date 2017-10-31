<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>助学网--学生评价</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="助学网,学生评论,网络导师回复">
<meta http-equiv="description" content="助学网--学生对网络导师的评论，同时网络导师也可以通过此对学生的评论进行回复">
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/netTeacherList/css/netTeaStuAssessment.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css"href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/myNetTeacherJs.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/netTeaStuAssessment.js"></script>
<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript"src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
var roleName = "${sessionScope.roleName}";
var ntId = "${requestScope.ntId}";
$(function(){
	$(".comListParent:odd").addClass("evenColor");
	if(roleName=="网络导师"){
		showTotalStar(".monthStar",0,0);
    }else if(roleName=="学生"){
		showTotalStar(".monthStar",0,ntId);
	}
	loadCheckMonth();
	displayPage(currentPage);
	showEditReplay();
	window.parent.$("#personalModu").attr("flag","true");
});
</script>
</head>
   
<body>
	<div class="nowPosition">
		<p>助学网&gt; 学生评论</p>
    </div>
    <div class="commentWrap">
    	<!-- 头部 学生印象当月评分 -->
    	<div class="commentTop clearfix">
    		<!-- 左侧导师头像  -->
    		<c:if test="${sessionScope.roleName=='学生'}">
	    		<div class="left_part fl">
	    		  <c:forEach items="${requestScope.ntlist}" var="nt">
		    		<div class="netImgBox">
		    			<img src="${nt.user.portrait}" width="100" height="100"/>
		    		</div>
		    		<p>${nt.user.realname}导师</p>
		    	  </c:forEach>
	    		</div>
	    		<!-- 右侧tag标签还有当月评分星星  -->
	    		<div class="right_part fl">
	    			<!-- 当月评分  -->
	    			<div class="monthStar clearfix">
	    				<span class="fl">当月评分：</span>
	    				<dl class="fl">
	       					<dd title="1分"></dd>
	       					<dd title="2分"></dd>
	       					<dd title="3分"></dd>
	       					<dd title="4分"></dd>
	       					<dd title="5分"></dd>
	    				</dl>
	    				<c:forEach items="${requestScope.nttsVOList}" var="ntts">
	    				 <c:if test="${ntts!=null}">
	    				  <span id="totalScore${ntts.id}" class="totalScore fl">${ntts.totalScoreMonth}分</span>
	    				 </c:if>
	    				 <c:if test="${ntts==null}">
	    				  <span  class="totalScore fl">暂无评价</span>
	    				 </c:if>
	    				</c:forEach>
	    			</div>
	    			<!-- 学生印象标签  -->
	    			<div class="monthTag">
	    				<span class="fl">学生印象：</span>
	    				<ul class="tagPar_1 fl">
	    					<li>回复速度及时<span class="totalTimes">(${requestScope.label1})</span></li>
	    					<li>回复速度一般<span class="totalTimes">(${requestScope.label2})</span></li>
	    					<li>回复速度慢<span class="totalTimes">(${requestScope.label3})</span></li>
	    					<li>回复重点明确易懂<span class="totalTimes">(${requestScope.label4})</span></li>
	    					<li>回复问题认真仔细<span class="totalTimes">(${requestScope.label5})</span></li>
	    					<li>回复问题草草了事<span class="totalTimes">(${requestScope.label6})</span></li>
	    					<li>自定义<span class="totalTimes">(${requestScope.label0})</span></li>
	    				</ul>
	    			</div>
	    		</div>
    		</c:if>
    		<c:if test="${sessionScope.roleName=='网络导师'}">
    			<!-- 右侧tag标签还有当月评分星星  -->
	    		<div class="ntTagsBox">
	    			<!-- 当月评分  -->
	    			<div class="monthStar clearfix">
	    				<span class="fl">当月评分：</span>
	    				<dl class="fl">
	       					<dd title="1分"></dd>
	       					<dd title="2分"></dd>
	       					<dd title="3分"></dd>
	       					<dd title="4分"></dd>
	       					<dd title="5分"></dd>
	    				</dl>
	    				<c:forEach items="${requestScope.nttsVOList}" var="ntts">
	    				 <c:if test="${ntts!=null}">
	    				  <span id="totalScore${ntts.id}" class="totalScore fl">${ntts.totalScoreMonth}分</span>
	    				 </c:if>
	    				 <c:if test="${ntts==null}">
	    				  <span  class="totalScore fl">暂无评价</span>
	    				 </c:if>
	    				</c:forEach>
	    			</div>
	    			<!-- 学生印象标签  -->
	    			<div class="monthTag">
	    				<span class="fl">学生印象：</span>
	    				<ul class="tagPar fl">
	    					<li>回复速度及时<span class="totalTimes">(${requestScope.label1})</span></li>
	    					<li>回复速度一般<span class="totalTimes">(${requestScope.label2})</span></li>
	    					<li>回复速度慢<span class="totalTimes">(${requestScope.label3})</span></li>
	    					<li>回复重点明确易懂<span class="totalTimes">(${requestScope.label4})</span></li>
	    					<li>回复问题认真仔细<span class="totalTimes">(${requestScope.label5})</span></li>
	    					<li>回复问题草草了事<span class="totalTimes">(${requestScope.label6})</span></li>
	    					<li>自定义<span class="totalTimes">(${requestScope.label0})</span></li>
	    				</ul>
	    			</div>
	    		</div>
    		</c:if>
    		<!-- 查看月度评论 -->
	    	<div class="checkMonthList">
	    	 <input type="text" id="month" class="easyui-datebox" value="${requestScope.checkDate}">
	    	 <input type="button" id="checkPj" value="搜索月评论" onclick="checkMonthPj()">
	    	</div>
    	</div>
    	
    	<!-- 核心评论内容盒子  -->
    	<div class="mainComment">
    		<ul class="topTit">
    			<li class="wid1 margR">评论内容</li>
    			<li class="wid2 margR">学生满意度</li>
    			<li class="wid3 margR">评论者</li>
    			<li class="wid4">评论时间</li>
    		</ul>
    		<c:forEach items="${requestScope.ntsaVOList}" var="ntsa" varStatus="status">
    		  <c:set var="index" value="${status.index}"></c:set>
    		  <div class="comListParent">
    			<!-- 评论详情盒子  -->
	    		<table id="assessTable" class="listTable" cellpadding="0" cellspacing="0">	    			
		    			<tr>
		    			  <td class="wid1">
		    			    <div class="tagsBox clearfix">
		    			      <span class="tagIcon"></span>
		    			      <p class="tags">${ntsa.assessmentTitle}</p>
		    			    </div>
		    			    <p>${ntsa.assessmentContent}</p>
		    			  </td>
		    			  <td class="wid2" align="center">
			    			   <dl class="fl">
				    			    <c:if test="${ntsa.assessmentScore==1}">
				    			      <dd class="on"></dd><dd></dd><dd></dd><dd></dd><dd></dd>
				    			    </c:if>
				    			    <c:if test="${ntsa.assessmentScore==2}">
				    			      <dd class="on"></dd><dd class="on"></dd><dd></dd><dd></dd><dd></dd>
				    			    </c:if>
				    			    <c:if test="${ntsa.assessmentScore==3}">
				    			      <dd class="on"></dd><dd class="on"></dd><dd class="on"></dd><dd></dd><dd></dd>
				    			    </c:if>
				    			    <c:if test="${ntsa.assessmentScore==4}">
				    			      <dd class="on"></dd><dd class="on"></dd><dd class="on"></dd><dd class="on"></dd><dd></dd>
				    			    </c:if>
				    			    <c:if test="${ntsa.assessmentScore==5}">
				    			      <dd class="on"></dd><dd class="on"></dd><dd class="on"></dd><dd class="on"></dd><dd class="on"></dd>
				    			    </c:if>
			    			   </dl>
		    			  </td>
		    			  <td class="wid3" align="center">${ntsa.user.realname}</td>
		    			  <td class="wid4" align="center">${ntsa.assessmentDate}</td>
		    			</tr>
	    		</table>
	    		
	    		<!-- 回复盒子  -->
	    		<div id="replayParent" class="replayBox">
	    		   <c:forEach items="${requestScope.replyNo}" var="replyNo" begin="${index}" end="${index}">
	    			<a class="replayBtn" href="javascript:void(0)" id="replyBtn" onclick="showResponse(${ntsa.id})">回复(<span id="replyNo${ntsa.id}" class="replayTimes">${replyNo}</span>)</a>
	    		   </c:forEach>
	    		</div>
	    		
	    		<!-- 隐藏的已回复的盒子  -->
	    		<div class="hasReplayBox clearfix" style="display:none;" id="replyList${ntsa.id}"></div>
	    	
	    		<!-- 隐藏的回复文本框  -->
	    		<div class="replayArea clearfix" style="display:none">
	    			<textarea id="reply${ntsa.id}" class="editArea" maxlength="200" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0, 200)"></textarea>
	    			<input type="button" class="subReplay" value="提交回复" onclick="subResponse(${ntsa.id})"/>
	    		</div>
	    		
    		</div>
    	  </c:forEach>
    	</div>
    	<!-- 暂无评论记录  -->
    	<c:if test="${sessionScope.roleName=='学生'}">
    		  <div id="noComRecords" class="noRecordBoxSt" style="display:none"></div>
    	</c:if>
    	<c:if test="${sessionScope.roleName=='网络导师'}">
    		  <div id="noComRecords" class="noRecordBoxNt" style="display:none"></div>
    	</c:if>
    	<!-- 分页  -->
    	<center>
	    	<div class="turnPageBox">
	    		<div id="Page">
		                         第<input id="current" style="width:12px;border:0px;text-align:center" readonly>页&nbsp;<a href="javascript:void(0)" onclick="First()">首页</a>
		           &nbsp;<a href="javascript:void(0)" onclick="Previous()">上一页</a>&nbsp;
		           <a href="javascript:void(0)" onclick="Next()">下一页</a>&nbsp;<a href="javascript:void(0)" onclick="Last()">尾页</a>
		                        共<input id="total" style="width:12px;border:0px;text-align:center" readonly>页
	       		</div>
	    	</div>
    	</center>
    </div>
</body>
</html>
