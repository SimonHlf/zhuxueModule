<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">
  <head>
<title>助学网网络导师列表</title>
<link href="Module/css/reset.css" type="text/css" rel="stylesheet" />
<link href="Module/netTeacherList/css/netTeaListCss.css" type="text/css" rel="stylesheet" />
<link href="Module/netTeacherList/css/comPayWinCss.css" type="text/css" rel="stylesheet" />
<link href="Module/studyOnline/css/studyOnlineHeadCom.css" type="text/css" rel="stylesheet" />
<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/netTeaListJs.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/payJs.js"></script>
<script type="text/javascript" src="Module/personalCen/js/pay.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
<script type="text/javascript" src="Module/netTeacherList/js/myNetTeacherJs.js"></script>
<!--[if IE]>
<style>
 .imgMarker{filter:progid:DXImageTransform.Microsoft.gradient(enabled = 'true',startColorstr = '#80000000',endColorstr = '#80000000')}
</style>
<![endif]-->
<script type="text/javascript">
var currentSubId = "${requestScope.subId}";
$(function(){
	fnTab($(".tabNav"),'click');
	autoHeight("perResumeFrame");
	showResumeBox();
	initSubIdSelect();
	wheelImg("originPic");
	checkScreenWidth(".head");
	showTotalStar(".showStarBox",currentSubId,0);
	moveLeftRight(273);
});

function initSubIdSelect(){
	$("#alisubID").val(currentSubId);
	if(getId(currentSubId) != null){
		$("#"+currentSubId).addClass("current");
	}else{
		
	}
}
//查询按钮
function findNetTeacher(subId){
	//var subId = document.getElementById("sub").value;
	var netTName = "";
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"netTeacherStudent.do?action=checkDuration&subId="+subId+"&netTName="+encodeURIComponent(netTName),
		success:function(json){
			if(json==true){
				alert("您对该科目网络导师的绑定已到期！如有需要，请续费或重新绑定！");
				window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
			}else if(json==1){
				alert("您申请成功的未付款绑定已到期！如有需要，请重新申请！");
				window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
			}else if(json==2){
				alert("您的免费试用已到期！如有需要，请绑定网络导师！");
				window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
			}else{
				window.location.href="netTeacher.do?action=netTeacherList&subId="+subId;
			}
		}
	});
}

//试用限制函数
function freeBind(ntId,subId,ntName,subName,baseMoney){
	if(confirm("确认绑定此导师?")){
		$.ajax({
	        type:"post",
			async:false,
			dataType:"json",
			url:"commonManager.do?action=getSubjectAndNT",
			success:function(json){
					for(var i=0;i<json.length;i++){
						if(json[i].subId==subId&&json[i].netTeacherName=="暂无导师"){
							//判断是否绑定或试用过该科目其他导师
							$.ajax({
								type:"post",
								async:false,
								dataType:"json",
								url:"netTeacherStudent.do?action=checkNTSBySubject&subId="+subId,
								success:function(json){
									if(json==true||json==-1){
										$.ajax({
											type:"post",
											async:false,
											dataType:"json",
											url:"netTeacherStudent.do?action=addNTS&nID="+ntId+"&subId="+subId,
											success:function(json){
												if(json){
													bindConfirm(json,subId,ntId,ntName,subName,baseMoney,false);
												}
											}
										});
									}else{
										$.ajax({
											type:"post",
											async:false,
											dataType:"json",
											url:"netTeacherStudent.do?action=addNTS&nID="+ntId,
											success:function(json){
												if(json){
													alert("试用绑定成功！试用期限为7天，期间您可以免费咨询该导师！");
													window.location.reload(true);
												}
											}
										});
									}
								}
							});
							break;
						}else if(json[i].subId==subId&&json[i].netTeacherName!="暂无导师"){
							$.ajax({
								type:"post",
								async:false,
								dataType:"json",
								url:"netTeacherStudent.do?action=checkDuration&subId="+subId+"&netTName="+encodeURIComponent(json[i].netTeacherName),
							    success:function(json){
							    	if(json!=2){
							    		alert("您已试用或绑定该科目导师，不能同时试用其他导师！");
							    	}else{//试用到期后可绑定其他导师
							    		$.ajax({
											type:"post",
											async:false,
											dataType:"json",
											url:"netTeacherStudent.do?action=addNTS&nID="+ntId+"&subId="+subId,
											success:function(json){
												if(json){
													alert("您只有一次试用机会，请直接申请绑定！");
													window.location.reload(true);
												}
											}
										});
							    	}
							    }
							});
							break;
						}
					}
			}
		});
	}
}

</script>
</head>

<body>
	<!-- 头部 -->
	<div class="headWrap">
    	<div class="head">
            <div class="logo">
            	<img src="Module/images/logo.png" alt="助学网--中小学生课堂信息反馈系统网络导师列表" />
            </div>
            <div class="nav">
            	<ul class="tabNav">
            		<li id="markLayer" style="left:273px;"></li>
                	<li class="navList"><a href="userManager.do?action=goPage">首页</a></li>
                    <li class="navList"><a href="studyOnline.do?action=load">在线答题</a></li>
                    <li class="navList"><a href="personalCenter.do?action=welcome">个人中心</a></li>
                    <li class="navList active"><a href="javascript:void(0)" onclick="ntList()">导师列表</a></li>
                    <li class="navList"><a href="onlineBuy.do?action=load">在线购买</a></li>
                    <li class="navList"><a href="shopManager.do?action=welcome">金币商城</a></li>
                </ul>
            </div>
			<div id="userCenter" class="userCenter">
				<span class="userChanel">${sessionScope.roleName}频道</span>
				|
				<a href="javascript:void(0)" onclick="loginOut()">退出</a>
				<span class="decTriangle"></span>
			</div>
        </div>
        <span class="decoration"></span> 
    </div>
    <!-- main内容 -->
    <input type="hidden" id="alisubID">         
            <!-- 导师列表 -->              
                <!-- 网络导师列表主体内容部分 -->
                <div class="conCenMainPart w1000 clearfix" id="nt">
                		<!--  左侧科目选择  -->
                		<div class="leftSubBox fl">
                			<!-- 个人头像  -->
                			<div class="leftImgBox">
                				<input id="uid" type="hidden" value="${sessionScope.userId}"/>
                				<c:forEach items="${requestScope.uVOList}" var="user">
					            	<div class="userImg">
					                	<img src="${pageContext.request.contextPath}/<c:out value="${user.portrait}"/>" width="68" height="68"/>
					                </div>
					                <h3 class="userNames"><c:out value="${user.realname}"></c:out></h3>
					             </c:forEach>
                			</div>
                			<div class="subBox">
	                			<c:forEach items="${requestScope.gVOList}" var="grade">
	                				<a id="${grade.subject.id}" class="subNames" href="javascript:void(0)" onclick="findNetTeacher(${grade.subject.id})" >${grade.subject.subName}</a>
	                			</c:forEach>
                			</div>
                		</div>
                		<div id="cenBox" class="cenList clearfix fl">
		                	  <c:forEach items="${requestScope.uList}" var="user" varStatus="status">
		                	   <c:set var="index" value="${status.index}"></c:set>
		                        <div class="netListBox">
		                        	<span class="dec_Triangle"></span>
		                        	<!-- 网络导师头像  -->
		                        	<div class="netTeaImg">
		                        		<div class="imgMarker">
		                        			 <input type="hidden" id="ntId" value="${user.id}">
		                        			<a href="javascript:void(0)" onclick="showPerIntro(${user.id})">个人简介</a>
		                        		</div>
		                        		<img src="${pageContext.request.contextPath}/<c:out value="${user.portrait}"/>" width="100" height="100" />
		                        	</div>
		                        	<!-- 网络导师信息  -->
		                        	<div class="netInfoBox">
		                        		<div class="netTeaName">
		                        			<c:out value="${user.realname}"/>导师
		                        		</div>
		                        		<div class="showStarBox">
		                        		 <span class="fl">当月总分：</span>
		                        		 <dl class="fl">
	                        					<dd title="1分"></dd>
	                        					<dd title="2分"></dd>
	                        					<dd title="3分"></dd>
	                        					<dd title="4分"></dd>
	                        					<dd title="5分"></dd>
	                        				</dl>
		                        		  <c:forEach items="${requestScope.nttsVOList}" var="ntts" begin="${index}" end="${index}">
		                        			<c:if test="${ntts!=null}">
	                        				<span id="totalScore${ntts.id}" class="totalScore fl">${ntts.totalScoreMonth}&nbsp;分</span>
	                        				</c:if>
	                        				<c:if test="${ntts==null}">
	                        				<span class="totalScore fl">暂无评分</span> 
	                        				</c:if>
		                        		  </c:forEach>
		                        		</div>
		                        		<div class="teacheGradeSubj">
		                        			担任学段课程:
		                        			<c:forEach items="${requestScope.ntVOList}" var="netTeacher" begin="${index}" end="${index}">
		                        				<span class="academic"><c:out value="${netTeacher.schoolType }"/></span>
		                        			</c:forEach>&nbsp;
		                        			<c:forEach items="${requestScope.subList}" var="sub" begin="${index}" end="${index}">
		                        				<span class="subjects"><c:out value="${sub.subName}"/></span>
		                        			</c:forEach>
		                        		</div>
		                        		<!-- 绑定导师层  -->
		                        		<div class="attachBox">
		                        		  <span class="triangles"></span>
                                          <c:forEach items="${requestScope.ntVOList}" var="netTeacher" begin="${index}" end="${index}">
                                            <c:forEach items="${requestScope.ntslist}" var="nts" begin="${index}" end="${index}">
                                              <c:forEach items="${requestScope.mList}" var="m" begin="${index}" end="${index}">
	                                            <c:if test="${nts==null}">
	                                              <a href="javascript:void(0)" onclick="freeBind(${netTeacher.id},${netTeacher.subject.id},'${netTeacher.user.realname}','${netTeacher.subject.subName}','${netTeacher.baseMoney}')">试用</a>
	                                            </c:if>
	                                            <c:if test="${nts!=null}">
	                                             <c:if test="${nts.bindFlag==-1&&m==0}">
	                                             <a href="javascript:void(0)">免费试用期</a>
	                                             </c:if>
	                                             <c:if test="${nts.bindFlag==0&&m==0}">
	                                             <input type="hidden" id="addDate1" value="${nts.addDate}">
	                                             <a href="javascript:void(0)" onclick="showPayAccount(${nts.id},${netTeacher.id},'${netTeacher.user.realname}','${netTeacher.subject.subName}','${netTeacher.baseMoney}',${nts.bindFlag})">绑定申请成功，付款中...</a>
	                                             </c:if>
	                                             <c:if test="${nts.bindFlag==-1&&m==1}"> 
	                                              <a href="javascript:void(0)" onclick="bindConfirm(${nts.id},${netTeacher.subject.id},${netTeacher.id},'${netTeacher.user.realname}','${netTeacher.subject.subName}','${netTeacher.baseMoney}',true)">申请绑定</a>
	                                             </c:if>
	                                             <c:if test="${nts.bindFlag==1&&m==0}">
	                                              <a href="javascript:void(0)" onclick="cancelBind(${netTeacher.subject.id},${nts.id})">绑定成功，可转换其他导师</a>
	                                             </c:if>
	                                             <c:if test="${nts.bindFlag==1&&m==1}">
	                                              <a href="javascript:void(0)" onclick="showPayAccount(${nts.id},${netTeacher.id},'${netTeacher.user.realname}','${netTeacher.subject.subName}','${netTeacher.baseMoney}',${nts.bindFlag})">绑定到期，请续费！</a>
	                                             </c:if>
	                                             <c:if test="${nts.bindFlag==2&&m==0}">
	                                              <a href="javascript:void(0)">已取消该导师绑定！</a>
	                                             </c:if>
	                                             <c:if test="${nts.bindFlag==2&&m==1}">
	                                              <a href="javascript:void(0)" onclick="secondBind(${nts.id},${netTeacher.subject.id},'${netTeacher.user.realname}')">再次绑定</a>
	                                             </c:if>
	                                           </c:if>
	                                         </c:forEach>
                                           </c:forEach> 
                                         </c:forEach>
                                      </div>
		                        	</div>
		                        </div>
		                      </c:forEach>
	                    </div>
	                    
                    
                </div>
  
    
	<!-- ----底部foot部分---------->
	<%@include file="../../foot/footer.jsp"%>
    <!-- 网络导师个人简介的弹窗 -->
    <div id="parentTeaBox" class="teaResumeBox">
    	<iframe id="perResumeFrame" name="perResumeFrame" src="" width="100%" height="100%" frameborder="0" scrolling="no" allowtransparency="true" ></iframe>
    </div>
    <!-- 遮罩层 -->
    <div class="layer"></div>
    <!-- 新遮罩层呈现点击个人荣誉图片的时候出现大图下的遮罩层 -->
    <div id="newlayer" class="newLayer"></div>
    <!-- 呈现个人荣誉头像的原图的弹窗 -->
    <div id="bigImgBox" class="perGloryBigImgBox">
    	<img id="originPic" alt="" src=""/>
    	<div class="tipBox">
			<p class="tipInfo fl">滚动鼠标滚轮用以缩放图片</p>
		</div>
		<span id="closeBox" class="closeBigBox" title="关闭" onclick="closeImgOrgBox()"></span>
    </div> 

    <!-- 支付窗口对应的遮罩层  -->
    <div class="payLayer"></div>
    
    <!-- 支付窗口 -->
    <div id="showPayDiv" class="showPayDiv">
    	<div class="payParent">
	    	<div class="payHeadTit">
	    		<span class="payWinIcon"></span>
	    		<h2>支付窗口</h2>
	    	</div>	
	    	<span class="closePayWin" onclick="closeWindow()"></span>
	    	<div class="navTop">
			    <ul id="payTab" class="tab clearfix">
			       <li id="payTab1">
			       		<span>1</span>
			       		<em></em>
			       </li>
			       <li id="payTab2">
			       		<span>2</span>
			       		<em></em>
			       </li>
			       <li id="payTab3">
			       		<span>3</span>
			       		<em></em>
				   </li>
			    </ul>
			    <div class="line"></div>
			    <div id="smallLine" class="smallLine"></div>
			    <div id="movebox" class="moveBox">1</div>
			    <p class="detachInfo" id="sureInfo">确定绑定信息</p>
			    <p class="choicePayWay" id="choiceStyle">选择支付方式</p>
			    <p class="detachSuc" id="succ">绑定成功</p>
		    </div>
		    <!--01 确认绑定信息 -->
		    <div class="tabCon mt" style="display:block" id="pay1">
		    <!-- 	<div class="comInfos bg0">导师学生关系编号：<input type="text" class="inpCons" id="ntsId" readonly/></div> -->
		    	<input type="hidden" class="inpCons" id="ntsId" />
		        <div class="comInfos bg1">您要绑定的网络导师：<input type="text" class="inpCons" id="ntName" name="ntName" readonly></div>
		        <div class="comInfos bg2">绑定科目：<input type="text" class="inpCons" id="subName" name="subName" readonly></div>
		        <div class="comInfos bg3">导师价格：<input type="text" class="inpCons" id="baseMoney" name="baseMoney" readonly><span class="yuan">元</span></div>
		        <c:forEach items="${requestScope.uVOList}" var="student">
			        <div class="comInfos bg1">您的姓名：<c:out value="${student.username}"/></div>
			        <div class="comInfos bg4">您的联系方式：<c:out value="${student.mobile}"/></div>
		        </c:forEach>
		        <span class="nowNum">01</span>
		        <input type="hidden" id="neteaId">
		        <input type="hidden" id="subId">
		        <input class="bindBtn" type="button" id="bind" name="bind" value="绑定" onclick="bindNetTeacher()">
		     </div>
	     
		     <!--02 选择支付方式 -->
		     <div class="tabCon mt" id="pay2" style="display:none">
		     	<div class="payFastBox clearfix">
		     		<div class="payStyeNav fl">
		     			<ul class="payWayTab">
		     				<li class="mR active" title="支付宝快捷支付">
		     					<img class="imgIcon" src="Module/netTeacherList/images/payFast1.png"/>
		     					<input type="radio" id="payType" name="payType" class="inpRadio" value="快捷支付" checked="checked">
		     					<span class="triangle">
		     						<em></em>
		     					</span>
		     				</li>
		     				<li title="银行汇款">
		     					<img class="imgIcon1" src="Module/netTeacherList/images/payFast2.png"/>
		     					<input type="radio" id="payType" name="payType" class="inpRadio" value="银行汇款">
		     				</li>
		     			</ul>
		     		</div>
		     		<!--  div class="payFastCon fl">
		     			
		     		</div-->
		     	</div>
		     	<!-- 账号提示窗口 -->
	  			<div id="account" style="display:none">
	  				<span class="warnIcon"></span>
	   				注意：绑定截至日期为：<span id="dueDate">${requestScope.endDate}</span>,请在<span id="remainDay">${requestScope.remainDays-1}</span>天内付款,否则,系统将会自动删除该绑定关系！
	  			</div>	
		     	<input type="hidden" id="bindFlag">
      			<input class="payCon" type="button" id="pay" name="pay" value="去支付" onclick="pay()">
		        <span class="nowNum">02</span>
		    </div>
	    
		    <!-- 03支付成功 -->
		    <div class="tabCon" id="pay3" style="display:none">
		      <center>
		      <br><span><font size="3">绑定费用支付成功！请<a href="userManager.do?action=goPage">点击这里</a>继续学习！</font></span></center>
		      <br><br>
		      <input class="successPay" type="button" id="success" name="success" value="确定" onclick="closeWindow()">
		      <span class="nowNum mb">03</span>
		    </div>
    	</div>
   </div>
 
</body>
</html>
