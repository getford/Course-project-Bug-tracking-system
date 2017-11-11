<%@ page import="userpage.ParseCookie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin page</title>
    <%
        ParseCookie parseCookie = new ParseCookie();
        if (parseCookie.getUserIdFromCookie(request, response) != 0) {
            response.sendRedirect("/index.jsp");
        }
    %>
</head>
<body>

</body>
</html>
