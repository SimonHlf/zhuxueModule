<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
   <title>助学网--学习记录跟踪指导查看答卷</title>
   <link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
   <link type="text/css" rel="stylesheet" href="Module/learnRecord/css/checkAns.css">
   <script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
   <script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
   <script type="text/javascript" src="Module/learnRecord/js/checkAns.js"></script>
 </head>
 <script type="text/javascript">
 $(function(){
	 fnTabNav($(".tabNav"),$(".tabCon"),"click");
	 checkImg();
 });
 </script>
 <body>
	<div class="nowPosition">
		<c:if test="${sessionScope.roleName == '学生' || sessionScope.roleName == '家长'}">
			<p><span>助学网 &gt; 学习记录&gt; 查看学习详情</span></p>
		</c:if>
		 <c:if test="${sessionScope.roleName == '网络导师'}">
		 	<p><span>助学网&gt; 跟踪指导&gt; 查看学习详情</span></p>
		 </c:if>
	</div>
	<div class="checkAnsWrap clearfix">
		<div class="checkAnsNav">
		   <ul class="tabNav">
	            <li  id="typeName" onclick="study(${requestScope.slID},${requestScope.loreId},'针对性诊断')">针对性诊断结果</li>
	            <li class="active" onclick="study(${requestScope.slID},${requestScope.loreId},'再次诊断')">再次诊断结果</li>
	            <li onclick="study(${requestScope.slID},${requestScope.loreId},'巩固训练')">巩固训练结果</li>
	            <li onclick="study(${requestScope.slID},${requestScope.loreId},'关联诊断结果')">关联诊断结果</li>
	        </ul>
	        <span class="backIcon"></span>
	         <c:if test="${sessionScope.roleName == '学生' || sessionScope.roleName == '家长'}">
	           <input type="hidden" id="xsSubID" value="${requestScope.xsSubID}">
	              <input type="hidden" id="xsTex" value="${requestScope.xsTex}">
	              <input type="hidden" id="xsstime" value="${requestScope.xsstime}">
	              <input type="hidden" id="xsetime" value="${requestScope.xsetime}">
	              <input type="hidden" id="xsyn" value="${requestScope.xsyn}">
				<a href="javascript:void(0)" onclick="goStudyRecord()">返回学习记录</a>
			</c:if>
			<input type="hidden" id="rName" value="${sessionScope.roleName}">
			 <c:if test="${sessionScope.roleName == '网络导师'}">
			  <input type="hidden" id="stuID" value="${requestScope.stuID}">
			  <input type="hidden" id="SubID" value="${requestScope.SubID}">
			  <input type="hidden" id="Tex" value="${requestScope.Tex}">
			  <input type="hidden" id="status" value="${requestScope.status}">
			  <input type="hidden" id="stime" value="${requestScope.stime}">
			  <input type="hidden" id="etime" value="${requestScope.etime}">
			  <input type="hidden" id="ntyn" value="${requestScope.ntyn}">
				<a href="javascript:void(0)" onclick="goGuideManager()">返回跟踪指导</a>
			</c:if>
		</div>
		<input type="hidden" id="slID" value="${requestScope.countPage}">
		<div id="parents" class="checkAnsBox">
		  <c:forEach items="${requestScope.sdList}" var="sdl">
				<div id="dawdiag0" class="detailAnsWrap clearfix">
					<!--  Question部分  -->
					<div id="dadiag0" class="detailAns clearfix">
						<span class="qIcon">Q</span>
						<!-- 问题   -->
						<div class="questionPart fl">
							<p>${sdl.loreQuestion.subject }</p>
							<c:if test="${sdl.a!='' }">
								<div class="opSelWord">
								A:&nbsp;
								<c:choose>
								<c:when test="${fn:contains(sdl.a, 'Module/commonJs/ueditor/jsp/lore')}">
									<img src="${sdl.a}"/>
								</c:when>
								<c:otherwise>
									${sdl.a}
								</c:otherwise>
								</c:choose>
								</div>
							</c:if>
							<c:if test="${sdl.b!='' }">
								<div class="opSelWord">
								B:&nbsp;
								<c:choose>
								<c:when test="${fn:contains(sdl.b, 'Module/commonJs/ueditor/jsp/lore')}">
									<img src="${sdl.b}"/>
								</c:when>
								<c:otherwise>
									${sdl.b}
								</c:otherwise>
								</c:choose>
								</div>
							</c:if>
							<c:if test="${sdl.c!='' }">
								<div class="opSelWord">
								C:&nbsp;
								<c:choose>
								<c:when test="${fn:contains(sdl.c, 'Module/commonJs/ueditor/jsp/lore')}">
									<img src="${sdl.c}"/>
								</c:when>
								<c:otherwise>
									${sdl.c}
								</c:otherwise>
								</c:choose>
								</div>
							</c:if>
							<c:if test="${sdl.d!='' }">
								<div class="opSelWord">
								D:&nbsp;
								<c:choose>
								<c:when test="${fn:contains(sdl.d, 'Module/commonJs/ueditor/jsp/lore')}">
									<img src="${sdl.d}"/>
								</c:when>
								<c:otherwise>
									${sdl.d}
								</c:otherwise>
								</c:choose>
								</div>
							</c:if>
							<c:if test="${sdl.e!=''}">
								<div class="opSelWord">
								E:&nbsp;
								<c:choose>
								<c:when test="${fn:contains(sdl.e, 'Module/commonJs/ueditor/jsp/lore')}">
									<img src="${sdl.e}"/>
								</c:when>
								<c:otherwise>
									${sdl.e}
								</c:otherwise>
								</c:choose>
								</div>
							</c:if>
							<c:if test="${sdl.f!='' }">
								<div class="opSelWord">
								F:&nbsp;
								<c:choose>
								<c:when test="${fn:contains(sdl.f, 'Module/commonJs/ueditor/jsp/lore')}">
									<img src="${sdl.f}"/>
								</c:when>
								<c:otherwise>
									${sdl.f}
								</c:otherwise>
								</c:choose>
								</div>
							</c:if>
						</div>
					</div>
					<!--  Answer部分  -->
					<div id="aboxdiag0" class="anBox clearfix">
						<div class="answerPart fl">
							<span class="aIcon">A</span>
							<div class="myAnBox clearfix">
								<span class="toBlock fl colMy">我的解答:</span>
								<span class="opSelWord weig fl">${sdl.myAnswer }</span>
								<c:choose>
									<c:when test="${sdl.result==0}">
										<div class='nowState'>
										  <span class='errorIcon'></span>
										</div>
									</c:when>
									<c:otherwise>
										<div class='nowState'>
										  <span class='rightIcon'></span>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="relAnBox clearfix">
								<span class="toBlock fl colRel">正确答案:</span>
								<div class="trueAnsBox weig fl">${sdl.realAnswer }</div>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				  <!-- 翻页 -->
			     <div class="turnPage pt">
					     <c:if test="${sessionScope.roleName == '学生' || sessionScope.roleName == '家长'}">
					    <div class="aParent mr1">
						    <a  href="studyDetail.do?action=load&slID=${requestScope.slID}&loreId=${requestScope.loreId}&typeName=${requestScope.typeName}&xsSubID=${requestScope.xsSubID}&xsTex=${requestScope.xsTex}&xsstime=${requestScope.xsstime}&xsetime=${requestScope.xsetime}">首页</a>
						    <logic:greaterThan name="currentPage" scope="request" value="1">
								<a class="pagePrev" href="studyDetail.do?action=load&pageNo=${requestScope.currentPage - 1}&slID=${requestScope.slID}&loreId=${requestScope.loreId}&typeName=${requestScope.typeName}&xsSubID=${requestScope.xsSubID}&xsTex=${requestScope.xsTex}&xsstime=${requestScope.xsstime}&xsetime=${requestScope.xsetime}">
							</logic:greaterThan>上一页
							<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
							<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}">
								<a  href="studyDetail.do?action=load&pageNo=${requestScope.currentPage + 1}&slID=${requestScope.slID}&loreId=${requestScope.loreId}&typeName=${requestScope.typeName}&xsSubID=${requestScope.xsSubID}&xsTex=${requestScope.xsTex}&xsstime=${requestScope.xsstime}&xsetime=${requestScope.xsetime}">
							</logic:lessThan>下一页
							<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}"></a></logic:lessThan>
		      					 <a  href="studyDetail.do?action=load&pageNo=${requestScope.countPage}&slID=${requestScope.slID}&loreId=${requestScope.loreId}&typeName=${requestScope.typeName}&xsSubID=${requestScope.xsSubID}&xsTex=${requestScope.xsTex}&xsstime=${requestScope.xsstime}&xsetime=${requestScope.xsetime}">尾页</a>
						</div>
						<div class="pageNum">
						 	 <p>第<span class="nowNum">${requestScope.currentPage }</span>页&nbsp;</p>
               				 <p>共<span class="totalNum">${requestScope.countPage }</span>页</p>
						</div>
					</c:if>
					
			 <c:if test="${sessionScope.roleName == '网络导师'}">
			  <div class="aParent mr1">
						    <a  href="studyDetail.do?action=load&slID=${requestScope.slID}&loreId=${requestScope.loreId}&typeName=${requestScope.typeName}&stuID=${requestScope.stuID}&SubID=${requestScope.SubID}&Tex=${requestScope.Tex}&status=${requestScope.status}&stime=${requestScope.stime}&etime=${requestScope.etime}">首页</a>
						    <logic:greaterThan name="currentPage" scope="request" value="1">
								<a class="pagePrev" href="studyDetail.do?action=load&pageNo=${requestScope.currentPage - 1}&slID=${requestScope.slID}&loreId=${requestScope.loreId}&typeName=${requestScope.typeName}&stuID=${requestScope.stuID}&SubID=${requestScope.SubID}&Tex=${requestScope.Tex}&status=${requestScope.status}&stime=${requestScope.stime}&etime=${requestScope.etime}">
							</logic:greaterThan>上一页
							<logic:greaterThan name="currentPage" scope="request" value="1"></a></logic:greaterThan>
							<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}">
								<a  href="studyDetail.do?action=load&pageNo=${requestScope.currentPage + 1}&slID=${requestScope.slID}&loreId=${requestScope.loreId}&typeName=${requestScope.typeName}&stuID=${requestScope.stuID}&SubID=${requestScope.SubID}&Tex=${requestScope.Tex}&status=${requestScope.status}&stime=${requestScope.stime}&etime=${requestScope.etime}">
							</logic:lessThan>下一页
							<logic:lessThan name="currentPage" scope="request" value="${requestScope.countPage}"></a></logic:lessThan>
		      					 <a  href="studyDetail.do?action=load&pageNo=${requestScope.countPage}&slID=${requestScope.slID}&loreId=${requestScope.loreId}&typeName=${requestScope.typeName}&stuID=${requestScope.stuID}&SubID=${requestScope.SubID}&Tex=${requestScope.Tex}&status=${requestScope.status}&stime=${requestScope.stime}&etime=${requestScope.etime}">尾页</a>
						</div>
						<div class="pageNum">
						 	 <p>第<span class="nowNum">${requestScope.currentPage }</span>页&nbsp;</p>
               				 <p>共<span class="totalNum">${requestScope.countPage }</span>页</p>
						</div>
			 </c:if>
				  </div>
			</div>
	</div>
 </body>
</html>
