<%@ page contentType="text/html;charset=GBK" %> 
<html>
<head>
<title>head</title>
</head>

<%
session.invalidate();

response.sendRedirect("login_new.jsp");
%>
<body>
</body>
</html>