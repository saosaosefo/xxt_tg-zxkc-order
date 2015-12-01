<%@ page contentType="text/html;charset=GBK" %>
<html>
<head>
<title>’À∫≈—È÷§</title>
</head>
<%@ include file="/js/CMMobile_check.js"%>
<body  class=dw1 leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
  out.print("¡¨Ω” ß∞‹£°<br/>");
  out.print("</p>");
  return;
}
String account_name = request.getParameter("username");
String passwd = request.getParameter("password");

int state = 0;

if ( null == account_name || null == passwd ){
	out.print("»±…Ÿ≤Œ ˝£°");
	return;
}

Statement stmt = con.createStatement();
ResultSet rs=null;
String sql="";


account_name = account_name.trim();
account_name = account_name.replaceAll(",","£¨");
account_name = account_name.replaceAll("'","°Ø");
account_name = account_name.replaceAll("\"","°±");
passwd = passwd.trim();
passwd = passwd.replaceAll(",","£¨");
passwd = passwd.replaceAll("'","°Ø");
passwd = passwd.replaceAll("\"","°±");


try{

	sql="SELECT * FROM EDU.CUSTOMER_MANAGER WHERE ACCOUNT="+account_name;
	rs = stmt.executeQuery(sql);
	if(rs.next()){
		if(!rs.getString("passwd").equals(passwd)){
			state = 1;
		}
	}
	else{
		state = 3;
	}

    //out.println(sql);	

	if (state ==1) throw new Exception("µ«¬Ω ß∞‹£°√‹¬Î¥ÌŒÛ£°");//1
	if (state ==3) throw new Exception("µ«¬Ω ß∞‹£°”√ªß√˚≤ª¥Ê‘⁄£°");//3
	if (state == 0) {
		session.setAttribute("username",account_name);
		session.setAttribute("real_name",rs.getString("real_name"));
		response.sendRedirect("dinggou_new.jsp?manager_id="+rs.getString("id"));
	}
}
catch (Exception e){
	out.print(e.getMessage());
	System.out.println(e.getMessage());
	%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	alert("µ«¬º ß∞‹!");
	location.href="login_new.jsp";
	//-->
	</SCRIPT><%
}
finally{
	if(stmt != null)stmt.close();
	if(rs != null)rs.close();
	if(con != null)con.close();
}
%>