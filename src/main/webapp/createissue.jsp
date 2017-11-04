<%@ page import="createissue.SelectAllUsers" %>
<%@ page import="createissue.SelectPriorityIssue" %>
<%@ page import="createissue.SelectTypeIssue" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create issue</title>
</head>
<body>
<%
    SelectAllUsers selectAllUsers = new SelectAllUsers();
    SelectTypeIssue selectTypeIssue = new SelectTypeIssue();
    SelectPriorityIssue selectPriorityIssue = new SelectPriorityIssue();
    try {
        selectAllUsers.selectAll();
        selectTypeIssue.selectAllTypeIssue();
        selectPriorityIssue.selectAllPriorityIssue();

    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<h1>Create issue</h1>
<form action="/createissue" method="post">
    <p>Project* <select name="nameProject">
        <option>test</option>
        <option>test1</option>
    </select></p>
    <p>Type issue* <select name="nameTypeIssue">
        <%
            for (int i = 0; i < selectTypeIssue.getTypeIssueArrayList().size(); i++) {
                String name = selectTypeIssue.getTypeIssueArrayList().get(i).getName();
        %>
        <option value="<%=name%>"><%=name%>
        </option>
        <%} %>
    </select>
    </p>
    <p>Priority* <select name="namePriority">
        <%
            for (int i = 0; i < selectPriorityIssue.getPriorityIssueArrayList().size(); i++) {
                String name = selectPriorityIssue.getPriorityIssueArrayList().get(i).getName();
        %>
        <option value="<%=name%>"><%=name%>
        </option>
        <% }%>
    </select>
    </p>
    <p>User assignee*<select name="userAssignee">
        <%
            for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                String infoUser = selectAllUsers.getUserArrayList().get(i).getFirstname() + " "
                        + selectAllUsers.getUserArrayList().get(i).getLastname() + ", "
                        + selectAllUsers.getUserArrayList().get(i).getEmail();
                String email = selectAllUsers.getUserArrayList().get(i).getEmail();
        %>
        <option value="<%=email %>"><%=infoUser %>
        </option>
        <%} %>
    </select>
    </p>
    <p>Title* <input type="text" name="title_issue" size="29" placeholder="Title"/></p>
    <p>Due Date* <input type="date" name="date_issue" size="7" placeholder="Date create"/></p>
    <p>Description* <input type="text" name="description_issue" size="29" placeholder="Description"/></p>
    <p>Environment* <input type="text" name="environment_issue" size="29" placeholder="Environment"/></p>
    <hr>
    <input type="submit" title="Create">
</form>
</body>
</html>
