<%@ page contentType="text/html;charset=GBK" %> 
<html>
<head>
<title></title>
</head>
<body>
<%//Ȩ�޿���
    if (session!=null&&(session.getAttribute("username") == null))
    {
        %>
    <SCRIPT LANGUAGE="JavaScript">
    <!--
        alert("ϵͳ����ʱ���������µ�¼!");
        window.top.location.href ='/login_new.jsp';
    -->
    </SCRIPT>
        <%
        return;
    }    
%>
</body>
</html>