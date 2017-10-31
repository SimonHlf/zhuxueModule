<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="../../exception/exception.jsp"%>
<%@include file="../../taglibs/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="true">

  <head>
    
    <title>网络导师个人账户</title>
    
	<link rel="stylesheet" type="text/css" href="Module/css/reset.css">
	<link href="Module/commonJs/jquery-easyui-1.3.0/themes/default/easyui.css" type="text/css" rel="stylesheet"/>
	<link href="Module/bankAccount/css/selfAccount.css" type="text/css" rel="stylesheet"/>
	
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Module/commonJs/comMethod.js"></script>
	<script type="text/javascript" src="Module/commonJs/jquery-easyui-1.3.0/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="Module/bankAccount/js/selfAccount.js"></script>
	<script type="text/javascript">
	
	 $(function(){
		 fnTabNav($(".detailTab"),$(".detailTabCon"),'click');
		 tableSort($("#totalTable"),3);
		 $("#totalTable .conTr:odd").addClass("oddColor");
		 checkBankNameVal();
		 bankNumPattern();
	 });	
	//table排序
	function tableSort(id,index){
		var tb = id.find("tr");
		var rows = tb.length;
		for(var i = 1;i<rows;i++){
			for(var j=i+1;j<rows;j++){
				var time1 = $(tb).eq(i).find("td").eq(index).text();
				var time2 = $(tb).eq(j).find("td").eq(index).text();
				if(time1<time2){
					$(tb).eq(j).insertBefore($(tb).eq(i));
					$(tb).eq(i).insertAfter($(tb).eq(j));
					tb = id.find("tr");
				}
			}
		}
		return;
	}	
	</script>

  </head>
<body>
	<div class="nowPosition">
		<p><span>我</span>的账户</p>
	</div>
	<div class="selfAccountWrap">
		<!--  我的账户头部导航选项卡  -->
		<ul id="detailTab" class="detailTab">
			<li id="detailTab1" class="active">我的账户</li>
			<!--li id="detailTab2">收益构成</li-->
			<li id="detailTab3" onclick="displayPage(1)">收支明细</li>
			<li id="detailTab4" onclick="txRecord(1,10)">提现记录</li>
			<li id="detailTab5" onclick="paidNTSRecord(1,10)">学生购买记录</li>
		</ul>
		<!--  导航选项卡对应的内容  -->
		<div class="con">
			<!-- 我的账户  -->
			<div id="myAccount" class="detailTabCon">
				<div class="accPar">
					<!-- 基本信息  -->
					<div class="comAccBox clearfix borBot">
						<div class="decBox"></div>
						<span class="iconPersonal"></span>
						<span class="fl infoTit">基本信息：</span>
						<div class="fl detailInfo">
							<c:forEach items="${requestScope.ntVOList}" var="netTeacher">
								<p class="zIn">累计收入：${netTeacher.totalMoney}元</p>
								<p class="zIn">可提现金额：<span class="expedCrash">${netTeacher.returnMoney}</span>元</p>
								<p class="zIn">等待到账金额：${requestScope.onPaying}元</p>
								<p class="zIn">已提现金额：${requestScope.txMoney}元</p>
							</c:forEach>
						</div>
					</div>
					<!-- 账户信息  -->
					<div class="comAccBox clearfix">
						<span class="iconAccount"></span>
						<span class="fl infoTit">账户信息：</span>
						<div class="detailInfo fl">
							<c:forEach items="${requestScope.ntVOList}" var="netTeacher">
								<p>
									<span>银行名称：</span>
									<span class="selBankTxt">请选择银行</span>
									<input type="text" id="bankName" class="bankInp" value="${netTeacher.bankName}" readonly>
									<!-- 显示选择银行的盒子  -->
									<a class="triBox" onclick="showBankBox();">
										<span class="selTriangles botTri"></span>
									</a>
								</p>
								<p>
									<span>银行账号：</span>
									<input type="text" id="bankNo" class="bankInp" maxlength="19" value="${netTeacher.bankNumber}" onkeyup="clearWord()">
								</p>
							</c:forEach>
							<input type="text" id="pattbBankNum" readonly />
							<input type="button" id="submit" value="保存" onclick="saveMyAccount()">
						</div>
					</div>
				</div>
				<!-- 银行选择  -->
				<div class="bankBox">
					<div class="topWin">
			    		<p class="shenqing txind">选择银行</p>
			    		<a href="javascript:void(0)" class="closeWins" onclick="closeBankWin();"></a>
			    	</div>
			    	<div class="bankMidWin">
			    		<ul>
			    			<li class="hotBank-list ICBC" title="中国工商银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国工商银行"/>
			    			</li>
			    			<li class="hotBank-list ABC" title="中国农业银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国农业银行"/>
			    			</li>
			    			<li class="hotBank-list CCB" title="中国建设银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国建设银行"/>
			    			</li>
			    			<li class="hotBank-list CMB" title="招商银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="招商银行"/>
			    			</li>
			    			<li class="hotBank-list BOC" title="中国银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国银行"/>
			    			</li>
			    			<li class="hotBank-list PSBC" title="中国邮政储蓄银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国邮政储蓄银行"/>
			    			</li>
			    			<li class="hotBank-list COMM" title="交通银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="交通银行"/>
			    			</li>
			    			<li class="hotBank-list CITIC" title="中信银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中信银行"/>
			    			</li>
			    			<li class="hotBank-list CMBC" title="中国民生银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国民生银行"/>
			    			</li>
			    			<li class="hotBank-list CEB" title="中国光大银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国光大银行"/>
			    			</li>
			    			<li class="hotBank-list CIB" title="兴业银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="兴业银行"/>
			    			</li>
			    			<li class="hotBank-list SPDB" title="浦发银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="浦发银行"/>
			    			</li>
			    			<li class="hotBank-list GDB" title="广发银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="广发银行"/>
			    			</li>
			    			<li class="hotBank-list HXBANK" title="华夏银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="华夏银行"/>
			    			</li>
			    			<li class="hotBank-list SHBANK" title="上海银行">
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="上海银行"/>
			    			</li>
			    		</ul>
			    	</div>
				</div>
				<input type="button" value="申请提现" class="aplayCashBtn" onclick="showApplyWithdrawWindow()">
			</div>
			<!-- 收支明细  -->
			<div id="inAndOut" class="detailTabCon">
				<!-- 备注说明  -->
				<div class="noteBox"></div>
				<table id="totalTable" class="comTable" cellpadding="0" cellspacing="0">
				    <tr class="topTr">
				         <td class="wid1" align="center">项目</td>
				         <td class="wid1" align="center">收入（元）</td>
				         <td class="wid1" align="center">支出（元）</td>
				         <td class="wid2" align="center">操作时间</td>
				         <td class="wid1" align="center">备注</td>
       				</tr>
			        <!-- 提现  -->
			        <c:forEach items="${requestScope.ntrrVOList}" var="ntrr">
				        <tr class="conTr">
				          <td class="wid1" align="center">返现</td>
				          <td class="wid1 income" align="center">${ntrr.returnMoney}</td>
				          <td class="wid1" align="center">&nbsp;</td>
				          <td class="wid2" align="center">${ntrr.returnDate}</td>
				          <td class="wid1" align="center">${ntrr.user.realname}</td>
				        </tr>
			        </c:forEach>
			        <!-- 返现  -->
			        <c:forEach items="${requestScope.nttrVOList}" var="nttr">
				        <tr class="conTr">
				          <td class="wid1" align="center">提现</td>
				          <td class="wid1" align="center">&nbsp;</td>
				          <td class="wid1 expend" align="center">-${nttr.txMoney}</td>
				          <td class="wid2" align="center">${nttr.txDate}</td>
				          <td class="wid1" align="center">&nbsp;</td>
				        </tr>
			        </c:forEach>
		       </table>
		       <!-- 暂无收支记录  -->
		       <div class="noShouzhi" style="display:none;"></div>
		       <center>
			       <div id="tPage" class="comPages">
			                         第<input id="current" style="width:12px;border:0px;text-align:center" readonly>页&nbsp;<a href="javascript:void(0)" onclick="tFirst()">首页</a>
			           &nbsp;<a href="javascript:void(0)" onclick="tPrevious()">上一页</a>&nbsp;
			           <a href="javascript:void(0)" onclick="tNext()">下一页</a>&nbsp;<a href="javascript:void(0)" onclick="tLast()">尾页</a>
			                        共<input id="total" style="width:12px;border:0px;text-align:center" readonly>页
			       </div>
		       </center>
			</div>
			<!-- 提现记录  -->
			<div id="withdraw" class="detailTabCon">
		        <table id="txTable" class="comTable" cellpadding="0" cellspacing="0">
		        	<tr class="topTr">
				         <td class="wid3" align="center">提现金额</td>
				         <td class="wid4" align="center">申请时间</td>
				         <td class="wid3" align="center">状态</td>
				         <td class="wid4" align="center">处理时间</td>
				         <td class="wid3" align="center">备注</td>
       				</tr>
		        </table>
		        <div class="noTixianRecord" style="display:none;"></div>
		       <center><div id="page" class="comPages"></div></center>
			</div>
			<!-- 学生购买记录  -->
			<div id="buyRecord" class="detailTabCon">
		       <table id="ntsTable"  class="comTable" cellpadding="0" cellspacing="0">
		       		<tr class="topTr">
				         <td class="wid5" align="center">学生姓名</td>
				         <td class="wid4" align="center">购买时间</td>
				         <td class="wid5" align="center">购买价格</td>
				         <td class="wid4" align="center">到期时间</td>
       				</tr>
		       </table>
		       <!-- 暂无收支记录  -->
		       <div class="noBuyRecord" style="display:none;"></div>
		       <center><div id="page1" class="comPages"></div></center>
			</div>
		</div>
	</div>
	<!-- 申请提现窗口 -->
    <div id="applyWithdrawWindow">
    	<div class="topWin">
    		<span class="iconDo"></span>
    		<p class="shenqing txind1">申请提现</p>
    		<a href="javascript:void(0)" class="closeWins" onclick="closeWindow();"></a>
    	</div>
    	<div class="midWin">
    		<span class="cashIcon"></span>
    		<div class="tixianBox">
    			<p>可提现金额：￥<input type="text" id="availableMoney" readonly></p>
    			<p>提现方式：银行转账</p>
    			<p>提现金额：￥<input type="text" id="txMoney" style="width:80px"></p>
    		</div>
    		<input type="button" id="applyWithdraw" value="申请提现" onclick="applyWithdraw()">
    	</div>
    	<div class="botWin">
    		<p>注：单次提现金额最低100元，最高10000元，提现金额不能大于可提现金额！</p>
    	</div>
    </div>
	<div class="layer"></div>
</body>
</html>
