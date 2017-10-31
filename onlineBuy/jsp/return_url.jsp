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
		<title>在线购买支付宝页面跳转同步通知页面</title>
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
  <body onload="show()" >
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
	//原订单编号
	String onumber=order_number[0];
	//购买用户编号
	String userID= order_number[1];
	//在线购买天数
	String days= order_number[2];
	//支付宝交易号	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
	
	//订单名称
	String subject = new String(request.getParameter("subject").getBytes("ISO-8859-1"),"UTF-8");
	
	
	//订单描述
	String body = new String(request.getParameter("body").getBytes("ISO-8859-1"),"UTF-8");
	
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
			UserManager um= (UserManager) AppFactory.instance(null).getApp(Constants.WEB_USER);
			OrdersManager om = (OrdersManager)AppFactory.instance(null).getApp(Constants.WEB_ORDERS);
			CouponsManager cm = (CouponsManager) AppFactory.instance(null).getApp(Constants.WEB_COUPONS);
			boolean ordFlag = om.updateOrders(onumber,out_trade_no);
			boolean umFlag = false;
			if(ordFlag){
			  umFlag=um.updateByID(Integer.parseInt(days), Integer.parseInt(userID));
			  if(umFlag){
				  if(order_number.length==4){
					 String coupID= order_number[3];
					 boolean cmFlag= cm.updateByID(1, Integer.parseInt(coupID));
				  }
			  }
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