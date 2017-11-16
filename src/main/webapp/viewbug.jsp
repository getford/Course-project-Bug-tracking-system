<%@ page import="bugs.ViewBug" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bug</title>
</head>
<body>
<%
    ViewBug viewBug = null;

    try {
        viewBug = new ViewBug(request.getParameter("idbug"));
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>


</body>
</html>
