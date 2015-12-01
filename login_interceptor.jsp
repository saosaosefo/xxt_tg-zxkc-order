<%@ page contentType="text/html;charset=GBK" %> 
<html>
<head>
<title></title>
</head>
<body>
<%//权限控制
    if (session!=null&&(session.getAttribute("username") == null))
    {
        %>
    <SCRIPT LANGUAGE="JavaScript">
    <!--
        alert("系统运行时错误，请重新登录!");
        window.top.location.href ='/login_new.jsp';
    -->
    </SCRIPT>
        <%
        return;
    }    
%>
</body>
</html>