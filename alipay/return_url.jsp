<%
/* *
 功能：支付宝页面跳转同步通知页面
 版本：3.2
 日期：2011-03-17
 说明：
 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 //***********页面功能说明***********
 该页面可在本机电脑测试
 可放入HTML等美化页面的代码、商户业务逻辑程序代码
 TRADE_FINISHED(表示交易已经成功结束，并不能再对该交易做后续操作);
 TRADE_SUCCESS(表示交易已经成功结束，可以对该交易做后续操作，如：分润、退款等);
 //********************************
 * */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.kpoint.alipay.util.*"%>
<%@ page import="com.kpoint.alipay.config.*"%>
<%@ page import="com.kpoint.service.*" %>
<%@ page import="com.kpoint.factory.AppFactory" %>
<%@ page import="com.kpoint.util.Constants" %>
<html>
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝页面跳转同步通知页面</title>
	<script type="text/javascript">
		    var left = 5;
		    function show() {
		        var showtime = document.getElementById("showtime");
		        showtime.innerHTML = "支付完成将在" + left + "秒后自动关闭页面";
		        left--;
		        if (left == 0) {
		            window.opener = null;
		            window.close();
		        }
		        else {
		            setTimeout("show()", 1000);
		        }
		    }
	</script>
  </head>
  <body onload="show()">
  <center>
    <div id="showtime"></div>
 </center>
<%
	//获取支付宝GET过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map requestParams = request.getParameterMap();
	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
		 valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		params.put(name, valueStr);
	}
	
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	//商户订单号	String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
	String order_number[] = out_trade_no.split("-");
	//助学网订单编号
	String onumber=order_number[0];
	//网络导师学生主键
	String ntsID= order_number[1];
	//支付宝交易号	//String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
	
	//订单名称
	String subject = new String(request.getParameter("subject").getBytes("ISO-8859-1"),"UTF-8");
	//String ntssub[] = subject.split("-");
	//网络导师学生主键
	//String ntsID= ntssub[1];
	//科目编号
	//String subID="";
	//if(ntssub.length>=3){
	//	 subID=ntssub[2];
	//}
	
	//订单描述
	String body = new String(request.getParameter("body").getBytes("ISO-8859-1"),"UTF-8");
	//String module[] =body.split("-");
	//String moduleID="";
	//if(module.length>=2){
	//	moduleID=module[1];
	//}
	//交易状态
	String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");

	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
	
	//计算得出通知验证结果
	boolean verify_result = AlipayNotify.verify(params);
	
	if(verify_result){//验证成功
		/////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码
		
		//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
		if(trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")){
			//判断该笔订单是否在商户网站中已经做过处理
				//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				//如果有做过处理，不执行商户的业务程序
			NetTeacherStudentManager ntsManager =  (NetTeacherStudentManager) AppFactory.instance(null).getApp(Constants.WEB_NET_TEACHER_STUDENT);
			OrdersManager om = (OrdersManager)AppFactory.instance(null).getApp(Constants.WEB_ORDERS);
			boolean ordFlag = om.updateOrders(onumber,out_trade_no);
			boolean ntsFlag = false;
			if(ordFlag){
				ntsFlag= ntsManager.updateNetTeacherStudent(Integer.parseInt(ntsID));
				//if(ntsFlag){
				//	if(subID==""){
				//		response.sendRedirect("../../../KPoint/personalCenter.do?action=welcome&moduleId="+moduleID);
				//	}else if(moduleID==""){
				//		response.sendRedirect("../../../KPoint/netTeacher.do?action=netTeacherList&subId="+subID);
				//	}
				//}
			}
		}
		 
		//该页面可做页面美工编辑
		//out.println("验证成功<br />");
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{
		//该页面可做页面美工编辑
		
	}
%>
  </body>
  
</html>