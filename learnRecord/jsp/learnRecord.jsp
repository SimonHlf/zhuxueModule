<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>助学网--学习记录</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="Module/learnRecord/css/learnRecordCss.css"/>
<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css">
<link type="text/css" rel="stylesheet" href="Module/commonJs/jquery-easyui-1.3.0/themes/icon.css">
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/learnRecord/js/learnRecord.js"></script>
<script type="text/javascript">
var stuLogId = "${requestScope.stuLogId}";
var loreId = "${requestScope.loreId}";
var stuID = "${requestScope.stuID}";
var status = "${requestScope.status}";
var stime = "${requestScope.stime}";
var etime = "${requestScope.etime}";
var subID = "${requestScope.subID}";
var roleName = "${sessionScope.roleName}";
$(function(){
	getStuSubjectrList(subID);
	getNTtoStu(stuID);
	if(stuLogId != "0"){
		showStuLog(stuLogId,loreId);
	}
	$('#gstatus').val(status);
	//document.getElementsByName("sTime")[0].value = stime;
	//document.getElementsByName("eTime")[0].value = etime;
	$("input[name='startTime']").val(stime);
	$("input[name='endTime']").val(etime);
	$('#startTime').datebox('setValue',stime);
	$('#endTime').datebox('setValue',etime);
	addMarginLeft();
});
function addMarginLeft(){
	if(roleName == "网络导师"){
		$(".selSubTimeBox").addClass("marginLTime");
		$("#queryBtn").addClass("searchBtnNet").html("查询");
	}else if(roleName == "学生" || roleName == "家长"){
		$("#queryBtn").addClass("searchBtn");
	}
}

</script>
</head>

<body style="height:1010px;">
	<div class="nowPosition">
		<c:if test="${sessionScope.roleName == '学生'  || sessionScope.roleName == '家长'}">
			<p><span>学</span>习记录</p>
		</c:if>
        <c:if test="${sessionScope.roleName == '网络导师'}">
        	<p><span>跟</span>踪指导</p>
        </c:if>
    </div>
    <!-- 科目时间条件筛选盒子 -->
    	<div class="optionBox">
  			<!-- 选择学科  -->
  			<div class="selSubTimeBox_1 fl">
  				<span class="selSubIcon pl"></span>
  				<!-- 学生身份下的选择科目下拉框 -->
  				<c:if test="${sessionScope.roleName == '学生'  || sessionScope.roleName == '家长'}">
	  				<div class="subBoxStud clearfix">
		                <span id="subjectInfo" class="txtChoice fl">选择科目：</span>
		                <select id="StuSubject" class="fl"></select> 
		            </div>
		            <input type="hidden" id="xsyn" value="YN">
  				</c:if>
  				<!-- 网络导师身份下的选择学生 指导状态的下拉框 -->
  				<c:if test="${sessionScope.roleName == '网络导师'}">
		            <div class="subBoxNet fl">
		            	<div class="seleSubBox fl">
		                    <span class="ptNet fl netMl">选择学生 </span>
		                    <select id="stu" class="fl"></select> 
		                </div>
		                <div class="selStateBox fl">
		                	<span class="ptNet fl">指导状态 </span>
		                    <select id="gstatus" class="fl">
		                        <option value="-1">全部</option>
		                        <option value="1">已指导</option>
		                        <option value="0">未指导</option>
		                    </select> 
		                </div>
		            </div>
		            <input type="hidden" id="ntSubID" value="${requestScope.subID }">
           			<input type="hidden" id="ntyn" value="YN">
            	</c:if>
  			</div>
  			<div class="selSubTimeBox fl">
  				<span class="selSubIcon pr"></span>
           		<div class="timeBox fl">
           			<span class="timeMl">从</span>&nbsp;<input type="text" id="startTime" class="easyui-datebox" />
           			<span class="till">至</span><input type="text" class="easyui-datebox" id="endTime"  />
           		</div>
           		<input type="hidden" id="rname" value="${sessionScope.roleName}" >
           		<a href="javascript:void(0)" title="查询" id="queryBtn" onclick="showStuLogList()"></a>
            </div>
    	</div>
    <!-- 学习记录的主题盒子 -->
    <div class="recordWrap">
    	<!-- 头部提示状态以及知识点列表的盒子 -->
    	<div class="recordTop">
            <!-- 提示说明盒子 -->
            <div class="recordTip">
           		<c:if test="${sessionScope.roleName == '学生'}">
	            	<div class="studentsTip comTipBox fl">
	            	<c:choose>
	            	   <c:when test="${requestScope.xsyn== 'YN'}">
	            	   		<p><span id="xsdays"></span>你学习过的<strong id="sname" class="subName"> ${requestScope.subName }</strong>&nbsp;知识点如下，点击任意一个知识点名称可以查看学习情况！</p>
	            	   </c:when>
	            	   <c:otherwise>
	            	  		 <p><span id="xsdays">最近&nbsp;<strong class="learnTime" id="days">${requestScope.days }</strong>&nbsp;天</span>你学习过的&nbsp;<strong id="sname" class="subName"> ${requestScope.subName }</strong>&nbsp;知识点如下，点击任意一个知识点名称可以查看学习情况！</p>
	            	   </c:otherwise>
	            	</c:choose>
	                </div>
                </c:if>
                <c:if test="${sessionScope.roleName == '家长'}">
	            	<div class="studentsTip comTipBox fl">
	            	<c:choose>
	            	<c:when test="${requestScope.xsyn== 'YN'}">
	            		<p><span id="xsdays"></span>您的孩子学习过的&nbsp;<strong id="sname" class="subName"> ${requestScope.subName }</strong>&nbsp;知识点如下，点击任意一个知识点名称可以查看学习情况！</p>
	            	</c:when>
	            	<c:otherwise>
	            		<p><span id="xsdays">最近&nbsp;<strong class="learnTime" id="days">${requestScope.days }</strong>&nbsp;天</span>您的孩子学习过的&nbsp;<strong id="sname" class="subName"> ${requestScope.subName }</strong>&nbsp;知识点如下，点击任意一个知识点名称可以查看学习情况！</p>
	            	</c:otherwise>
	            	</c:choose>
	                </div>
                </c:if>
                	<input type="hidden" id="slID" value="">
                	<input type="hidden" id="sl_lore_id" value="">
                <c:if test="${sessionScope.roleName == '网络导师'}">
	                <div class="netTeaTip comTipBox fl">
	                <c:choose>
	                 <c:when test="${requestScope.ntyn== 'YN'}">
               				 <p><span id="ntdays"></span><strong class="stusName" id="uname">${requestScope.stuName }</strong>学习过的&nbsp;知识点如下，点击任意一个知识点名称可以查看学习情况！</p>
               		 </c:when>
               		 <c:otherwise>
	                	<p><span id="ntdays">最近&nbsp;<strong class="learnTime" id="days">${requestScope.days }</strong>&nbsp;天</span><strong class="stusName" id="uname">${requestScope.stuName }</strong>学习过的&nbsp;知识点如下，点击任意一个知识点名称可以查看学习情况！</p>
	                </c:otherwise>
	                </c:choose>
	                </div>
	            </c:if>
	            <!-- 状态盒子 -->
	            <div class="tipIcon">
	            	<span class="one"></span>
	                <span class="complete">代表已完成</span>
	            	<span class="two"></span>
	                <span class="nocomplete">代表未完成</span>
	            </div>
            </div>
            <!-- 底部知识点列表盒子 -->
            <div id="kpListBox" class="listBox">
                <ul id="recordListCon">
	                 <c:forEach items="${requestScope.slList}" var="stulog">
	                 	<c:choose>
		                  <c:when test="${stulog.isFinish ==2}">
		                		<li class="status1" id="${stulog.id}"  onclick="showStuLog(${stulog.id},${stulog.lore.id})">${stulog.lore.loreName }</li>
		                	</c:when>
		                	<c:otherwise>
		                		<li class="status2" id="${stulog.id}" onclick="showStuLog(${stulog.id},${stulog.lore.id})" title="${stulog.lore.loreName }">${stulog.lore.loreName }</li>
		                	</c:otherwise>
	                	</c:choose>
					</c:forEach>
                </ul>
            </div>
            <div id="parenScroll" class="scrollPar">
                	<div id="sonScrollBar" class="scrollSon"></div>
             </div>
        </div>
        <!-- 底部每个知识点对应的具体诊断情况盒子 -->
        <div class="recordBot">
        	<!-- 知识点的学习情况 -->
        	<div class="learnSit">
            	<p id="cloreNameDet"></p>
            	<span class="recordIcon recBg"></span>
            </div>
            <div class="tableBox">
            <!-- 具体各个诊断的盒子 -->
            <div class="detailKpBox">
            	<table cellpadding="0" cellspacing="0">
                	<tr bgcolor="#f4f4f4" class="h35 head">
                    	<td align="center" class="lorNa borR borB">知识点名称</td>
                        <td align="center" class="borR borB learnDeta">学习明细</td>
                        <td align="center" class="borR borB com">完成情况</td>
                        <td align="center" class="borB">成绩</td>
                    </tr>
                    <tr class="h35">
                    	<td align="center" class="borR">&nbsp;</td>
                        <td align="center" class="borR borB">
                        	针对性诊断：<span id="curStep1"></span>
                        </td>
                        <td align="center" class="borR">&nbsp;</td>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <tr class="h35">
                        <td rowspan="2" align="center" class="borR" style="line-height:1.5em">
                        	&nbsp;
                            <span id="curLoreName"></span>
                        </td>
                        <td align="center" class="borR borB">
                        	关联性诊断：<span id="curStep2"></span>
                        </td>
                        <td align="center" class="borR">&nbsp;</td>
                        <td align="center">&nbsp;</td>	
                    </tr>
                    <tr class="h35">
                    	<td align="center" class="borR borB">
                        	关联知识点学习：<span id="curStep3"></span>
                        </td>
                        <td align="center" class="borR">
                        	&nbsp;
                        	<span id="curLoreComplete"></span>
                        </td>
                        <td align="center">
                        	<span id="curLoreScore"></span>
                        </td>	
                    </tr>
                    <tr class="h35">
                    	<td align="center" class="borR">&nbsp;</td>
                        <td align="center" class="borR borB">
                        	本知识点学习：<span id="curStep4"></span>
                        </td>
                        <td rowspan="2" align="center" class="borR">
	                        <c:if test="${sessionScope.roleName == '学生'}">
	                        	<a id="conLea" class="contLearn" href="javascript:void(0)">继续学习</a>
	                        </c:if>
	                        &nbsp;
                        </td>
                        <td rowspan="2" align="center">
                        	<a id="cAns" class="checkAns" onclick="goCheckAns('${sessionScope.roleName}')" href="javascript:void(0)">查看答卷</a>
                        </td>
                    </tr>
                    <tr class="h35">
                    	<td align="center" class="borR">&nbsp;</td>
                        <td align="center" class="borR">
                        	再次诊断：<span id="curStep5"></span>
                        </td>
                    </tr>
                </table>
            </div>
            </div>
        </div>
        <!-- 系统评价 -->
        <c:choose>
	        <c:when test="${empty slList}">
	        	 <div class="sysCommentBox" id="sysCom">
		        	<div class="learnSit">
		            	<p class="textAdT">系统评价</p>
		            	<span class="recordIcon recBg1"></span>
		            </div>
		            <div class="sysTxt"><div id="sysComment"></div></div>
		        </div>
		         <!-- 导师建议 -->
				<div class="teaAdviceBox" id="teaAdvice">
					<div class="learnSit">
		            	<p class="textAdT">导师建议</p>
		            	<span class="recordIcon1"></span>
			        </div>
					<div class="advice"></div>
				</div>
	        </c:when>
	        <c:otherwise>
			         <c:forEach items="${requestScope.slList}" var="stulog2" end="0" >
				        <div class="sysCommentBox" id="sysCom">
						    <div class="learnSit">
				            	<p class="textAdT">系统评价</p>
				            	<span class="recordIcon recBg1"></span>
				            </div>
				            <div class="sysTxt"><div id="sysComment">${stulog2.result }</div></div>
				        </div>
				        <!-- 导师建议 -->
				        <c:choose>
					        <c:when test="${sessionScope.roleName == '网络导师'&& stulog2.guideStatus == 1||sessionScope.roleName == '学生'  || sessionScope.roleName == '家长'}">
						        <div class="teaAdviceBox" id="teaAdvice">
						        	<div class="advice">
						            	<p><span class="textAdT">导师建议</span><br/><c:forEach items="${requestScope.ntpList}" var="ntpl" end="0">${ntpl.content }</c:forEach> </p>
						            </div>
						        </div>
					        </c:when>
					        <c:otherwise>
						        <div class="editAdviceBox" id="editAdvice">
						            <span class="editIcon"></span>
						            <p class="teachAdvice">指导建议</p>
						            <textarea id="slContent" class="editBox"></textarea>
						            <a href="javascript:void(0)" onclick="addNTP()" class="tijiao">提交</a>
						        </div>
					        </c:otherwise>
				        </c:choose>
			      </c:forEach>
	        </c:otherwise>
        </c:choose>
    </div>
</body>
</html>