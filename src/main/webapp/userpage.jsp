<%@ page import="createissue.SelectAllUsers" %>
<%@ page import="createissue.SelectPriorityIssue" %>
<%@ page import="createissue.SelectTypeIssue" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="userpage.ParseCookie" %>
<%@ page import="userpage.SelectAllYourProject" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User page</title>
    <title>Create issue</title>
    <link href="resources/createissue.css" rel="stylesheet">
    <link href="resources/table.css" rel="stylesheet">
    <script src="formissue.js"></script>
</head>
<body id="body" style="overflow:hidden;">
<%
    ParseCookie parseCookie = new ParseCookie(request);
    SelectAllUsers selectAllUsers = new SelectAllUsers();
    SelectTypeIssue selectTypeIssue = new SelectTypeIssue();
    SelectPriorityIssue selectPriorityIssue = new SelectPriorityIssue();
    SelectAllYourProject selectAllYourProject = new SelectAllYourProject();
    try {
        selectAllYourProject.setUserId(parseCookie.getUserIdFromToken());
        selectAllUsers.selectAll();
        selectTypeIssue.selectAllTypeIssue();
        selectPriorityIssue.selectAllPriorityIssue();
        selectAllYourProject.selectAllProjects();

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<p>
    Hello,
    <b><%=parseCookie.getLoginFromToken()%>
    </b>
    <%--ID: <%=parseCookie.getUserIdFromToken()%>--%>
    <%--Position: <%=parseCookie.getPositionIdFromToken()%>--%>
</p>

<div id="issue">
    <div id="popupIssue">
        <h2 class="heading_is">Creare Issue
        </h2>
        <div class="popup-content">
            <form action="/createissue" method="post" id="form" name="form">

                <div class="form-body">
                    <div class="setting_pr">
                        <div class="field-group">
                            <label>Project*</label>
                            <select name="nameProject">
                                <%
                                    for (int i = 0; i < selectAllYourProject.getProjectArrayList().size(); i++) {
                                        String name = selectAllYourProject.getProjectArrayList().get(i).getNameProject();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                        <div class="field-group">
                            <label>Type issue*</label>
                            <select name="nameTypeIssue">
                                <%
                                    for (int i = 0; i < selectTypeIssue.getTypeIssueArrayList().size(); i++) {
                                        String name = selectTypeIssue.getTypeIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="content">
                        <div class="field-group">
                            <label>Title*</label>
                            <input type="text" name="title_issue" class="long_in"/>
                        </div>
                        <div class="field-group">
                            <label>Severity*</label>
                            <select name="namePriority">
                                <%
                                    for (int i = 0; i < selectPriorityIssue.getPriorityIssueArrayList().size(); i++) {
                                        String name = selectPriorityIssue.getPriorityIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <% }%>
                            </select>
                        </div>
                        <div class="field-group">
                            <label>Due Date* </label>
                            <input type="date" name="date_issue" size="7"
                                   placeholder="Date create"/>
                        </div>
                        <div class="field-group">
                            <label>Assignee</label>
                            <select class="assignee" name="userAssignee">
                                <%
                                    for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                                        String infoUser = selectAllUsers.getUserArrayList().get(i).getFirstname() + " "
                                                + selectAllUsers.getUserArrayList().get(i).getLastname() + ", "
                                                + selectAllUsers.getUserArrayList().get(i).getEmail();
                                        String email = selectAllUsers.getUserArrayList().get(i).getEmail();
                                %>
                                <option value="<%=email%>"><%=infoUser %>
                                </option>
                                <%} %>
                            </select>
                        </div>
                        <div class="field-group">
                            <label>Environment</label>
                            <textarea class="env_text" name="environment_issue"></textarea>
                        </div>
                        <div class="field-group">
                            <label>Description*</label>
                            <textarea class="desc_text" name="description_issue"></textarea>
                        </div>
                    </div>
                </div>
                <div class="bottom_container">
                    <div class="buttons">
                        <input type="submit" onclick="div_hide()" value="Create"/>
                        <a href="#" onclick="div_hide()">Cancel</a>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
<a href="#" id="create_is" onclick="div_show()">Create Issue</a>
<p>
<h4>Your projects</h4>
<table>
    <tr>
        <th>Name</th>
        <th>Key</th>
        <th>Leader</th>
    </tr>
    <%
        for (int i = 0; i < selectAllYourProject.getProjectArrayList().size(); i++) {
            String name = selectAllYourProject.getProjectArrayList().get(i).getNameProject();
            String key = selectAllYourProject.getProjectArrayList().get(i).getKeyNameProject();
            String leader = String.valueOf(selectAllYourProject.getProjectArrayList().get(i).getIdUserLead());
    %>
    <tbody>
    <tr>
        <td><a href="/projectpage.jsp" name="<%=name%>" style="display: block"><%=name%>
        </a>
        </td>
        <td><%=key%>
        </td
        >
        <td><%=leader%>
        </td>
    </tr>
    </tbody>
    <%
        }
    %>
</table>
</p>
<p>
    Log out
</p>
</body>
</html>
