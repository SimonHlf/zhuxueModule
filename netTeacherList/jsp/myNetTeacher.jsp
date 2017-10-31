<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

  <head>
    <title>我的导师列表</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet"/>
<link href="Module/netTeacherList/css/myNetTeacher.css" type="text/css" rel="stylesheet"/>
<link href="Module/netTeacherList/css/comPayWinCss.css" type="text/css" rel="stylesheet" />
<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/netTeaListJs.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/myNetTeacherJs.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/myHomePayJs.js"></script>
<!--[if lt IE 8]>
<style>
 .imgLayer{filter:progid:DXImageTransform.Microsoft.gradient(enabled = 'true',startColorstr = '#80000000',endColorstr = '#80000000')}
</style>
<![endif]-->
<!--[if IE 8]> 
<style>
 .imgLayer{filter:progid:DXImageTransform.Microsoft.gradient(enabled = 'true',startColorstr = '#80000000',endColorstr = '#80000000')}
</style>
<![endif]-->
<script type="text/javascript">
$(function(){
    showResumeBox1();
    showTotalStar(".scoreBox",0,0);
});

function showResumeBox1(){
	var aPerImgBox = $(".perImgBox");
	aPerImgBox.each(function(i) {
        $(this).hover(function(){
			$(".imgLayer").eq(i).show();
		},function(){
			$(".imgLayer").eq(i).hide();
		});
    });
}

</script>
  </head>
  
 <body>
   <div class="nowPosition">
		<p><span>导</span>师列表</p>
   </div>
   <!-- 我的导师列表  -->
    <div class="myNetTeacher" id="nt">
        <ul id="netTeaListWrap" class="netTeaList clearfix">
         <c:forEach items="${requestScope.uVOList}" var="user" varStatus="status">
          <c:set var="index" value="${status.index}"></c:set>
	          <li>
		          <!-- 个人头像层简介层 -->
		          <div class="imgBox">
		          	  <c:forEach items="${requestScope.subVOList}" var="subject" begin="${index}" end="${index}">
			               <img class="decImg" src="${subject.ntBackGroudImg}"/>
			          </c:forEach>
		              <div class="perImgBox">
		              	<img src="${pageContext.request.contextPath}/<c:out value="${user.portrait}"/>" alt="网络导师头像"/>
		                <div class="imgLayer">
		              	  <a class="perResTxt" href="javscript:void(0)" onclick="showPerIntro_1(${user.id})">个人简介</a>
		                </div>
		              </div>
		              <!-- 评分  -->
		              <div class="scoreBox">
		              	<dl>
		              		<dd title="1分"></dd>
		              		<dd title="2分"></dd>
		              		<dd title="3分"></dd>
		              		<dd title="4分"></dd>
		              		<dd title="5分"></dd>
		              	</dl>
		              	<c:forEach items="${requestScope.nttsVOList}" var="ntts" begin="${index}" end="${index}">
		              	   <c:if test="${ntts!=null}">
		              	     <!--  span id="totalScore${ntts.id}" class="totalScore">${ntts.totalScoreMonth}/${ntts.totalPjStuNumber}</span-->
		              	     	<span title="当月评分${ntts.totalScoreMonth}分" id="totalScore${ntts.id}" class="totalScore">${ntts.totalScoreMonth}分</span>
		              	   </c:if>
		              	   <c:if test="${ntts==null}">
		              	     <span class="totalScore">暂无评分</span>
		              	   </c:if>
		              	</c:forEach>
		              </div>
		          	  <!-- 星星评分的遮罩层  -->
		          	  <div class="starLayer"></div>
		          </div>
		          <!-- 担任课程学段层 -->
		          <div class="netTeaInfo">
		          	  <!-- 导师姓名  -->
		              <p class="relName"><c:out value="${user.realname}"/>导师</p>
		              <!-- 导师担任课程学段  -->
		              <p class="teacheGradeSubj"><span class="danren">担任学段课程:</span>
			              <c:forEach items="${requestScope.ntVOList}" var="netTeacher" begin="${index}" end="${index}">
			                <span class="academic"><c:out value="${netTeacher.schoolType }"/></span>
			              </c:forEach>&nbsp;
			              <c:forEach items="${requestScope.subVOList}" var="sub" begin="${index}" end="${index}">
			                <span class="subjects"><c:out value="${sub.subName}"/></span>
			              </c:forEach>
		              </p>
		              <!-- 我要评分，评论条数  -->
		              <p class="commentBox">
		              	<c:if test="${sessionScope.roleName == '学生'}">
		                <c:forEach items="${requestScope.ntsVOList}" var="nts" begin="${index}" end="${index}">
		                <c:forEach items="${requestScope.mList}" var="m" begin="${index}" end="${index}">
		              	 <c:forEach items="${requestScope.nttsVOList}" var="ntts" begin="${index}" end="${index}">
		              	 	<c:if test="${ntts==null}">
		              	 		<a href="netTeacherStudentAssessment.do?action=load&ntId=${nts.teacher.id}"><span class="commentNum">0</span>条评论</a>
		              	 	</c:if>
		              	 	<c:if test="${ntts!=null}">
		              	 		<a href="netTeacherStudentAssessment.do?action=load&ntId=${nts.teacher.id}"><span class="commentNum">${ntts.totalPjStuNumber}</span>条评论</a>
		              	 	</c:if>
		              	 </c:forEach>
		              	 <c:if test="${nts.bindFlag==1&&m==0}">
			              	  <span class="judgeBtn" onclick="goJudgeScore(${nts.teacher.id})">我要评分</span>
			             </c:if> 
		              	</c:forEach>
		              	</c:forEach>	
		              </c:if>
		              </p>

			          <!--  绑定此导师层 -->
			          <div class="attachBox">
			             <c:forEach items="${requestScope.ntVOList}" var="netTeacher" begin="${index}" end="${index}">
			               <c:forEach items="${requestScope.ntsVOList}" var="nts" begin="${index}" end="${index}">
			                 <c:forEach items="${requestScope.mList}" var="m" begin="${index}" end="${index}">
			                  <c:if test="${nts.bindFlag==-1&&m==0}">
			                   	<p class="nowState l2">免费试用期</p>
			                  </c:if>
			                  <c:if test="${nts.bindFlag==0&&m==0}">
			                   <c:forEach items="${requestScope.remainDaysList}" var="remainDays" begin="${index}" end="${index}">
			                   <c:if test="${sessionScope.roleName == '学生'}">
			                   		<a class="attachBtns l4" href="javascript:void(0)" onclick="showAccount('${nts.endDate}','${remainDays-1}',${nts.id},${netTeacher.id},'${netTeacher.user.realname}','${netTeacher.subject.subName}','${netTeacher.baseMoney}',${nts.bindFlag})">绑定申请成功，付款中...</a>
			                   </c:if>
			                   <c:if test="${sessionScope.roleName == '家长'}">
			                   		<a class="nowState l4">绑定申请成功，付款中...</a>
			                   </c:if>	
			                   </c:forEach>
			                  </c:if>
			                  <c:if test="${nts.bindFlag==-1&&m==1}"> 
			                  	<c:if test="${sessionScope.roleName == '学生'}">
			                   		<a href="javascript:void(0)" class="attachBtns l2" onclick="bindConfirm(${nts.id},${netTeacher.subject.id},${netTeacher.id},'${netTeacher.user.realname}','${netTeacher.subject.subName}','${netTeacher.baseMoney}')">申请绑定</a>
			                  	</c:if>
			                  	<c:if test="${sessionScope.roleName == '家长'}">
			                  		<a class="nowState l2">申请绑定</a>
			                  	</c:if>
			                  </c:if>
			                  <c:if test="${nts.bindFlag==1&&m==0}">
			                  	<c:if test="${sessionScope.roleName == '学生'}">
			                   		<a class="attachBtns l3" href="javascript:void(0)" onclick="cancelBind(${netTeacher.subject.id},${nts.id})">绑定成功，可转换其他导师</a>
			                   	</c:if>
			                   	<c:if test="${sessionScope.roleName == '家长'}">
			                   		<a class="nowState l3">绑定成功，可转换其他导师</a>
			                   	</c:if>
			                  </c:if>
			                  <c:if test="${nts.bindFlag==1&&m==1}">
			                  	<c:if test="${sessionScope.roleName == '学生'}">
			                   		<a class="attachBtns l6" href="javascript:void(0)" onclick="showAccount('${nts.endDate}','${remainDays-1}',${nts.id},${netTeacher.id},'${netTeacher.user.realname}','${netTeacher.subject.subName}','${netTeacher.baseMoney}',${nts.bindFlag})">绑定到期，请续费！</a>
			                  	</c:if>
			                  	<c:if test="${sessionScope.roleName == '家长'}">
			                  		<a class="nowState l6">绑定到期，请续费！</a>
			                  	</c:if>
			                  </c:if>
			                </c:forEach>
			               </c:forEach> 
			             </c:forEach>
			          </div>    
		          </div>
	          </li>
         </c:forEach>
        </ul>
    </div>
    
    
    <div class="layer"></div>

 </body>
</html>
