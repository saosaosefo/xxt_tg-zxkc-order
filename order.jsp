<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<title>产品订购</title>
</head>
<%@ include file="/js/CMMobile_check.js"%>
<%@ include file="login_interceptor.jsp"%>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ page import = "java.sql.*"%>
<jsp:useBean id="ConDB"  scope="page" class="com.dbutils.DbUtil" />
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "oracle.sql.*"%>
<%@ page import = "oracle.jdbc.driver.*"%>
<%
Connection con = ConDB.getConnection();
if(con == null)
{
  out.print("<p>");
  out.print("连接失败！<br/>");
  out.print("</p>");
  return;
}
String area_code = request.getParameter("area_code");
String manager_id = request.getParameter("manager_id");
String mobile=request.getParameter("mobile");
String prodid=request.getParameter("prodid");
String serviceid=request.getParameter("serviceid");
String servicecode=request.getParameter("servicecode");
String srctype=request.getParameter("srctype");
String ecid=request.getParameter("ecid");
//System.out.println(ecid+"#############");
//System.out.println(servicecode+"###@@@#####");
String optype=request.getParameter("optype");
String ordertype=request.getParameter("ordertype");

/*System.out.println("mobile:"+mobile+" prodid:"+prodid
		+" serviceid:"+serviceid+" servicecode:"+servicecode
		+" srctype:"+srctype+" ecid:"+ecid
		+" optype:"+optype+" ordertype:"+ordertype);*/

CallableStatement   Prepare   =   null;  
PreparedStatement   Stmt   =   null;  
try{
String   Query="{call EXTAPP.PROC_BOSS_HD_CONFIRM(?,?,?,?,?,?,?,?,?,?)}";  
Prepare   =   con.prepareCall(Query);  
Prepare.setInt(1,5); 
Prepare.setString(2,prodid); 
Prepare.setString(3,ecid); 
Prepare.setString(4,servicecode); 
Prepare.setString(5,serviceid); 
Prepare.setString(6,mobile); 
Prepare.setInt(7,1); 
Prepare.setInt(8,1); 
Prepare.registerOutParameter(9,java.sql.Types.INTEGER); 
Prepare.registerOutParameter(10,java.sql.Types.VARCHAR); 
Prepare.execute();  

String info = Prepare.getString(10);
if(Prepare.getString(9).equals("1"))
{
	%>
	<script language="javascript">
	alert("订购请求已发送请注意24小时内回复“中国移动”发送的确认信息。");
	document.location.href="product_new.jsp?phoneNum="+'<%=mobile%>'+"&manager_id="+'<%=manager_id%>'+"&area="+'<%=area_code%>'+"&sub_area="+'<%=ecid%>';
	</script>
	 <%
	
}
else 
{
	//System.out.println(Prepare.getString(9));
	System.out.println(Prepare.getString(10));
	%>
	<script language="javascript">
	alert('<%=info%>');
	document.location.href="product_new.jsp?phoneNum="+'<%=mobile%>'+"&manager_id="+'<%=manager_id%>'+"&area="+'<%=area_code%>'+"&sub_area="+'<%=ecid%>';
	</script>
	
   <%
}


}catch(Exception e){
	
}finally{
	if(Prepare!=null) Prepare.close();
    if(Stmt!=null) Stmt.close();
    if(con!=null) con.close();
}

%>
</body>
</html>
