<%@ page contentType="text/html;charset=GBK" %>
<%@ page import = "java.sql.*"%>
<jsp:useBean id="ConDB"  scope="page" class="com.dbutils.DbUtil" />
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "oracle.sql.*"%>
<%@ page import = "oracle.jdbc.driver.*"%>
<html>
<head>
<title>��������</title>
</head>

<body>
<%
Connection con = ConDB.getConnection();
if(con == null)
{
  out.print("<p>");
  out.print("����ʧ�ܣ�<br/>");
  out.print("</p>");
  return;
}
String pwd = "";
String account_name = request.getParameter("username");

//System.out.println("account_name:"+account_name);

ResultSet rs=null;
PreparedStatement pst=null;
String sql="SELECT passwd FROM EDU.CUSTOMER_MANAGER where account="+account_name;

try{
pst= con.prepareStatement(sql);
rs = pst.executeQuery();

if(rs.next()){
	pwd=rs.getString("passwd");
	//System.out.println(pwd+"@@@pwd");
}

CallableStatement   Prepare   =   null;  
PreparedStatement   Stmt   =   null;  
if(!"".equals(pwd)){
	String   Query="{call EXTAPP.PROC_SMS_WRITER(?,?,?,?)}";  
	Prepare   =   con.prepareCall(Query);  
	Prepare.setString(1,"106570500"); 
	Prepare.setString(2,account_name); 
	Prepare.setString(3,"00"); 
	Prepare.setString(4,"���ã������˺���"+account_name+"��������"+pwd); 
	Prepare.execute();  
}
}catch(Exception e){
	
}finally{
	if(rs!=null) rs.close();
    if(pst!=null) pst.close();
    if(con!=null) con.close();
}
%>
<%if(!"".equals(pwd)){ %>
<script language="javascript">
	alert("�����ѷ��ͣ��뼰ʱ���գ�");
	document.location.href="login_new.jsp";
</script>
<%}else{ %>
<script language="javascript">
	alert("�������û������û����������������룡");
	document.location.href="login_new.jsp";
</script>
<%} %>
</body>
</html>