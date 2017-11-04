<%@ page import="userpage.SelectAllYourProject" %>
<%@ page import="userpage.UserPage" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User page</title>
</head>
<body>
<%
    UserPage userPage = new UserPage();
    SelectAllYourProject selectAllYourProject = new SelectAllYourProject();
    try {
        selectAllYourProject.selectAllYouProject();
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<p>
    <a href="createissue.jsp">Create issue</a>
</p>
<p>
<h4>Your projects</h4>
<%
    for (int i = 0; i < selectAllYourProject.getProjectArrayList().size(); i++) {
        String infoProject = "Name: " + selectAllYourProject.getProjectArrayList().get(i).getNameProject() + ", Key: " +
                selectAllYourProject.getProjectArrayList().get(i).getKeyNameProject() + ", Leader: " +
                selectAllYourProject.getProjectArrayList().get(i).getIdUserLead();
%>
<%=infoProject%>
<br/>
<%
    }
%>
</p>
</body>
</html>
