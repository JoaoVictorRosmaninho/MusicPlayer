<%-- 
    Document   : error
    Created on : Sep 27, 2021, 10:46:41 AM
    Author     : jv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String err = request.getParameter("error");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Pag</title>
    </head>
    <body>
        O error é: <%=err%>
    </body>
</html>
