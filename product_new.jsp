<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*"%>
<%@ include file="login_interceptor.jsp"%>
<jsp:useBean id="ConDB"  scope="page" class="com.dbutils.DbUtil" />
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "oracle.sql.*"%>
<%@ page import = "oracle.jdbc.driver.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.5; minimum-scale=1;" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="/css/index.css" rel="stylesheet" type="text/css" />
<link href="/css/public.css" rel="stylesheet" type="text/css" />
<%@ include file="/js/CMMobile_check.js"%>
<title>产品</title>
</head>
<%
Connection con = ConDB.getConnection();
if(con == null)
{
  out.print("<p>");
  out.print("连接失败！<br/>");
  out.print("</p>");
  return;
}

String mobile_no = request.getParameter("phoneNum");
String manager_id = request.getParameter("manager_id");
String area_code = request.getParameter("area");
String ecid = request.getParameter("sub_area");
//request.removeAttribute("sub_area");
//System.out.println(area_code+"area_code");
//System.out.println(manager_id+"manager_id");

//System.out.println(ecid+"ecid");


String ecid_sql = "SELECT DISTINCT ECNAME,CODE,ECID,area_code FROM (SELECT C.ECNAME,C.CODE,B.ECID,c.AREA_CODE FROM EDU.MANAGER_SUB M,EXTAPP.SUBAREA_CODE_DIC C,ORDMAN.BOSS_EC_INFO B WHERE M.SUB_ID=C.SUB_CODE AND C.CODE=SUBSTR(B.SERVICECODE,10,5) "
	   +" AND M.TYPE =2"
	   +" AND C.TYPE=1"
	   +" AND B.STATUS=1"
	   +" AND C.AREA_CODE="+area_code
	   +" AND MANAGER_ID="+manager_id
	   +" and ecid="+ecid
	   +" UNION ALL"
	   +" SELECT C.ECNAME,C.CODE,B.ECID,c.AREA_CODE"
	   +" FROM EDU.MANAGER_SUB M,EXTAPP.SUBAREA_CODE_DIC C,ORDMAN.BOSS_EC_INFO B"
	   +" WHERE M.SUB_ID=C.AREA_CODE AND C.CODE=SUBSTR(B.SERVICECODE,10,5) "
	   +" AND M.TYPE =1 AND C.TYPE=1 AND B.STATUS=1 "
	   +" AND C.AREA_CODE="+area_code
	   +" AND MANAGER_ID="+manager_id
	   +" and ecid="+ecid
	   +" UNION ALL "
	   +" SELECT C.ECNAME,C.CODE,B.ECID,c.AREA_CODE "
	   +" FROM EDU.MANAGER_SUB M,EDU.ORGANIZATION O,EXTAPP.SUBAREA_CODE_DIC C,ORDMAN.BOSS_EC_INFO B "
	   +" WHERE M.SUB_ID=o.id "
	   +" and o.SUB_AREA=c.SUB_CODE "
	   +" AND C.CODE=SUBSTR(B.SERVICECODE,10,5) "
	   +" AND M.TYPE =3 "
	   +" AND C.TYPE=1 "
	   +" AND B.STATUS=1 "
	   +" and ecid="+ecid
	   +" AND C.AREA_CODE="+area_code
	   +" AND MANAGER_ID="+manager_id+")";





String code = ""; 
ResultSet ecid_rs=null;
PreparedStatement ecid_pst=null;
ecid_pst= con.prepareStatement(ecid_sql);
ecid_rs = ecid_pst.executeQuery();
if(ecid_rs.next()){
	code=ecid_rs.getString("code");
}


String mobile_sql = "select b.ecid,b.serviceid,a.prod_name,a.fee_type "
	+"from ORDMAN.BOSS_USER_INFO b,EDU.CUSTOMER_MANAGER c,ORDMAN.ADC_SERVICE_DICTIONARY a "
	+"where b.mobile=c.mobile_no "
	+"and a.service_id=b.serviceid "
	+"and c.mobile_no="+mobile_no;

ResultSet mobile_rs=null;
PreparedStatement mobile_pst=null;

mobile_pst= con.prepareStatement(mobile_sql);

ResultSet all_rs=null;
Statement all_st=null;
all_st=con.createStatement();

String all_sql = "SELECT prod_name,fee_type,sign_flag,service_id,service_code,signature "
	+"FROM ORDMAN.ADC_SERVICE_DICTIONARY where service_code in(106570502,106570503) ";




try{
%>
<body>
	<div id="pcTop"></div>
	<div id="pcLogo">
		<img src="/images/xxt_logo_20150830.gif" class="img1 img2" />
	</div>
	<div id="first" style="height: 10%">
		<%@ include file="head.jsp"%>
	</div>
	<div class="second">
	
		<form action="" name="pro_form">
				<input id="area_code" name="area_code" type="hidden" value="<%=area_code %>"/>
				<input id="serviceid" name="serviceid" type="hidden" value="" >
				<input id="ecid" name="ecid" type="hidden" value="<%=ecid %>" >
				<input id="servicecode" name="servicecode" type="hidden" value="">
				<input id="mobile" name="mobile" type="hidden" value="">
				<input id="srctype" name="srctype" type="hidden" value="">
				<input id="prodid" name="prodid" type="hidden" value="">
				<input id="optype" name="optype" type="hidden" value="">
				<input id="ordertype" name="ordertype" type="hidden" value="">
				<input id="manager_id" name="manager_id" type="hidden" value="<%=manager_id %>">
				<h4 style="font-size:1.5em;">请选择套餐<label style="float: right;">订购用户：<%=mobile_no %></label></h4>
				
				<div>
					<h5 style="font-size:1.5em;">在线课程</h5>
					<%
					all_rs = all_st.executeQuery(all_sql);
					while(all_rs.next()){
						mobile_rs = mobile_pst.executeQuery();
						
						if(Integer.parseInt(all_rs.getString("service_id").substring(8,10))>10){
					%>
					<div>
						<table style="width: 100%" id="tab">
							<tr>
								<td><%=all_rs.getString("prod_name") %>&nbsp;&nbsp;</td>
								<td><%=all_rs.getString("fee_type") %></td>
								<td><input type="submit" 
									<%while(mobile_rs.next()){
										%>
										<%if(mobile_rs.getString("serviceid").equals(all_rs.getString("service_id"))){
											%> disabled="disabled" <%
										}
									} %>
								style="float: right;height: 25px;" value="订购" onclick="form_submit('<%=all_rs.getString("service_id")%>')"/></td>
							</tr>
						</table>
						<%} }%>
					</div>
			      
			      
			      <h5 style="font-size:1.5em;">题谷</h5>
					<%
					all_rs = all_st.executeQuery(all_sql);
					while(all_rs.next()){
						mobile_rs = mobile_pst.executeQuery();
						
						if(Integer.parseInt(all_rs.getString("service_id").substring(8,10))<10){
					%>
					<div>
						<table style="width: 100%" id="tab">
							<tr>
								<td><%=all_rs.getString("prod_name") %>&nbsp;&nbsp;</td>
								<td><%=all_rs.getString("fee_type") %></td>
								<td><input type="submit" 
									<%while(mobile_rs.next()){
										%>
										<%if(mobile_rs.getString("serviceid").equals(all_rs.getString("service_id"))){
											%> disabled="disabled" <%
										}
									} %>
								style="float: right;height: 25px;" value="订购" onclick="form_submit('<%=all_rs.getString("service_id")%>')"/></td>
							</tr>
						</table>
						<%} }%>
					</div>
		        </div>
			</form>
			<a href="dinggou_new.jsp?phoneNum=<%=mobile_no%>&manager_id=<%=manager_id%>"><input class="a_demo_one" type="button" value="返回"></input></a>
	</div>
	 <div class="pcLine2"></div>
	<div class="foot1">
	客服热线：1255068<br />
	版权所有：内蒙古校信通教育科技有限公司
	</div>
</body>
<%
}catch(Exception e){
	
}finally{
	if(all_rs!=null) all_rs.close();
    if(all_st!=null) all_st.close();
    if(mobile_rs!=null) mobile_rs.close();
    if(mobile_pst!=null) mobile_pst.close();
    
    if(ecid_rs!=null) ecid_rs.close();
    if(ecid_pst!=null) ecid_pst.close();
    if(con!=null) con.close();
}
%>

<script type="text/javascript">
var serviceid = "";
var prodid = "";
var servicecode = "";

	function form_submit(serviceid){
		//alert(serviceid);
		var mobile="<%=mobile_no%>";
		var code="<%=code%>";
		//alert(serviceid+"$$$"+ecid);
		if(parseInt(serviceid.substring(8,10))>10){
			servicecode="106570503"+code;
			prodid="5";
		}else{
			servicecode="106570502"+code;
			prodid="6";
		}
		
		document.getElementById("serviceid").value=serviceid;
		document.getElementById("srctype").value="5";
		document.getElementById("prodid").value=prodid;
		document.getElementById("servicecode").value=servicecode;
		document.getElementById("mobile").value=mobile;
		document.getElementById("optype").value="1";
		document.getElementById("ordertype").value="1";
		pro_form.action="order.jsp";
		pro_form.submit();
	}
	function change(){
		var New=document.getElementsByName("rad");
		for(var i=0;i<New.length;i++)
		{
			if(New.item(i).checked) 
			{
				serviceid=New.item(i).getAttribute("id"); 
				ecid=New.item(i).getAttribute("value");
				break;
			}
			else
			{
				continue;
			}
		}  
	}
</script>
</html>