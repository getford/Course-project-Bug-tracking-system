<%@ page import="projectpage.ProjectPage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Project page</title>
    <%
        ProjectPage projectPage = new ProjectPage(request, response);
    %>
</head>
<body>
<p>
    <b>Name project:</b> <%=projectPage.getNameProject()%>
</p>
<p>
    <b>Key name:</b> <%=projectPage.getKeyProject()%>
</p>
<p>
    <b>Leader:</b> <%=projectPage.getLeaderName()%>
</p>
</body>
</html>
