<%@ page contentType="text/html;charset=GBK" %> 
<html>
<head>
<title>head</title>
</head>

<%
String real_name = session.getAttribute("real_name").toString();
//System.out.println(real_name);
%>
<body>
	<div style="float: right;margin-right: 10%;">
		<h1 style="font-size: 1.5em">»¶Ó­Äú:
		<label style="color: red"><%=real_name %></label>
		<a href="login_out.jsp"><label style="margin-left: 5px;">ÍË³ö</label></a>
		</h1>
	</div>
</body>
</html> 