<%@ page import="bugs.SelectYourAssigneedBug" %>
<%@ page import="createissue.SelectAllUsers" %>
<%@ page import="createissue.SelectPriorityIssue" %>
<%@ page import="createissue.SelectTypeIssue" %>
<%@ page import="userpage.SelectUserInfo" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="userpage.SelectAllYourProject" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User page</title>
    <title>Create issue</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="resources/createissue.css" rel="stylesheet">
    <script src="resources/formissue.js"></script>

    <script>
        $(document).ready(() => {
            $("#bugsInput").on("keyup", () => {
                var value = $(this).val().toLowerCase();
                $("#bugsTable tr").filter(() => {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>

    <script>
        $(document).ready(() => {
            $("#projectInput").on("keyup", () => {
                var value = $(this).val().toLowerCase();
                $("#projectTable tr").filter(() => {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>
</head>
<body id="body" style="overflow:hidden;">
<%
    ParseCookie parseCookie = new ParseCookie(request);
    SelectAllUsers selectAllUsers = new SelectAllUsers();
    SelectTypeIssue selectTypeIssue = new SelectTypeIssue();
    SelectPriorityIssue selectPriorityIssue = new SelectPriorityIssue();
    SelectAllYourProject selectAllYourProject = new SelectAllYourProject();
    SelectYourAssigneedBug selectYourAssigneedBug = null;
    SelectUserInfo selectUserInfo = new SelectUserInfo();
    try {
        selectAllYourProject.setUserId(parseCookie.getUserIdFromToken());
        selectAllUsers.selectAll();
        selectTypeIssue.selectAllTypeIssue();
        selectPriorityIssue.selectAllPriorityIssue();
        selectAllYourProject.selectAllProjects();
        selectYourAssigneedBug = new SelectYourAssigneedBug(parseCookie.getUserIdFromToken());

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<div class="panel panel-primary">
    <div class="panel-body">
        <div class="col-sm-7">
            <div class="dropdown">
                <button class="btn btn-success dropdown-toggle" type="button" data-toggle="dropdown">
                    <%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
                    <span class="badge"><%=selectUserInfo.selectUserPositionName(parseCookie.getUserIdFromToken())%></span>
                    <span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <li class="disabled"><a href="userpage.jsp">Dashboard</a></li>
                    <li><a href="profile.jsp">Profile</a></li>
                    <li><a href="statistic.jsp">Statistic</a></li>
                    <hr/>
                    <li><a href="#">Exit</a></li>
                </ul>
            </div>
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
            <button id="create_is" onclick="div_show()" type="button" class="btn btn-danger btn-sm btn-block">
                Create
                issue
            </button>
        </div>
    </div>
</div>

<div class="panel panel-warning">
    <div class="panel-heading" style="text-align: center;"><h4>Your projects</h4></div>
    <div class="panel-body">
        <input class="form-control" id="projectInput" type="text" placeholder="Search..">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Name</th>
                <th>Key</th>
                <th>Leader</th>
            </tr>
            </thead>
            <%
                for (int i = 0; i < selectAllYourProject.getProjectArrayList().size(); i++) {
                    String name = selectAllYourProject.getProjectArrayList().get(i).getNameProject();
                    String key = selectAllYourProject.getProjectArrayList().get(i).getKeyNameProject();
                    String leader = selectAllYourProject.getProjectArrayList().get(i).getFirstLastNameLead();
            %>
            <tbody id="projectTable">
            <tr>
                <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>" style="display: block"><%=name%>
                </a>
                </td>
                <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>" style="display: block"><%=key%>
                </a>
                </td>
                <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>" style="display: block"><%=leader%>
                </a>
                </td>
            </tr>
            </tbody>
            <%
                }
            %>
        </table>
    </div>
</div>
<div class="panel panel-success">
    <div class="panel-heading" style="text-align: center;"><h4>Your tasks</h4></div>
    <div class="panel-body">
        <input class="form-control" id="bugsInput" type="text" placeholder="Search..">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Type</th>
                <th>Priority</th>
                <th>Date create</th>
                <th>Title</th>
            </tr>
            </thead>
            <%
                assert selectYourAssigneedBug != null;
                for (int i = 0; i < selectYourAssigneedBug.getAssigneedBugArrayList().size(); i++) {
                    String idKey = selectYourAssigneedBug.getAssigneedBugArrayList().get(i).getId();
                    String type = selectYourAssigneedBug.getAssigneedBugArrayList().get(i).getType();
                    String priority = selectYourAssigneedBug.getAssigneedBugArrayList().get(i).getPriority();
                    String dateCreate = selectYourAssigneedBug.getAssigneedBugArrayList().get(i).getDateCreate();
                    String title = selectYourAssigneedBug.getAssigneedBugArrayList().get(i).getTitle();
            %>
            <tbody id="bugsTable">
            <tr>
                <td><a href="/viewbug.jsp?idbug=<%=idKey%>"><%=idKey%>
                </a>
                </td>
                <td><a href="/viewbug.jsp?idbug=<%=idKey%>"><%=type%>
                </a>
                </td>
                <td><a href="/viewbug.jsp?idbug=<%=idKey%>"><%=priority%>
                </a>
                </td>
                <td><a href="/viewbug.jsp?idbug=<%=idKey%>"><%=dateCreate%>
                </a>
                </td>
                <td><a href="/viewbug.jsp?idbug=<%=idKey%>"><%=title%>
                </a>
                </td>
            </tr>
            </tbody>
            <%
                }
            %>
        </table>
    </div>
</div>

<%-- Create issue --%>
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
<%--<a href="#" id="create_is" onclick="div_show()">Create Issue</a>--%>
</body>
</html>
