<%@ page import="bugs.SelectYourAssigneedBug" %>
<%@ page import="cookie.CheckCookie" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="createissue.SelectAllUsers" %>
<%@ page import="createissue.SelectPriorityIssue" %>
<%@ page import="createissue.SelectTypeIssue" %>
<%@ page import="userpage.SelectAllYourProject" %>
<%@ page import="userpage.SelectUserInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User page</title>
    <title>Create issue</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="resources/css/createissue.css" rel="stylesheet">
    <script src="resources/script/formissue.js"></script>

    <script>
        $(document).ready(function () {
            $("#bugsInput").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#bugsTable tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>

    <script>
        $(document).ready(function () {
            $("#projectInput").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#projectTable tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>

    <%
        ParseCookie parseCookie = new ParseCookie(request);
        CheckCookie checkCookie = new CheckCookie();
        SelectTypeIssue selectTypeIssue = new SelectTypeIssue();
        SelectPriorityIssue selectPriorityIssue = new SelectPriorityIssue();
        SelectAllYourProject selectAllYourProject = new SelectAllYourProject();
        SelectYourAssigneedBug selectYourAssigneedBug = null;
        SelectAllUsers selectAllUsers = null;
        SelectUserInfo selectUserInfo = new SelectUserInfo();
        try {
            selectAllUsers = new SelectAllUsers();
            selectAllYourProject.setUserId(parseCookie.getUserIdFromToken());
            selectTypeIssue.selectAllTypeIssue();
            selectPriorityIssue.selectAllPriorityIssue();
            selectAllYourProject.selectAllProjects();
            selectYourAssigneedBug = new SelectYourAssigneedBug(parseCookie.getUserIdFromToken());

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    %>
</head>
<body>

<div class="panel panel-primary">
    <div class="panel-body">
        <div class="col-sm-4">
            <div class="dropdown">
                <button class="btn btn-success dropdown-toggle btn-block" type="button" data-toggle="dropdown">
                    <%=selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken())%>
                    <span class="badge"><%=selectUserInfo.selectUserPositionNameFromToken(parseCookie.getUserIdFromToken())%></span>
                    <span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <%
                        if (checkCookie.isAdmin(request.getCookies(), parseCookie.getPositionIdFromToken())) {
                    %>
                    <li><a href="adminpage.jsp">Admin dashboard</a></li>
                    <%
                        }
                    %>
                    <li class="disabled"><a href="userpage.jsp">Dashboard</a></li>
                    <li><a href="profile.jsp?login=<%=parseCookie.getLoginFromToken()%>">Profile</a></li>
                    <hr/>
                    <li><a href="/logout">Exit</a></li>
                </ul>
            </div>
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
            <button id="create_is" onclick="div_show()" type="button" class="btn btn-danger btn-md btn-block">
                Create
                issue
            </button>
        </div>
    </div>
</div>
<div class="container">
    <div class="panel panel-warning">
        <div class="panel-heading" style="text-align: center;"><h4>Your projects</h4></div>
        <div class="panel-body">
            <input class="form-control" id="projectInput" type="text" placeholder="Search..">
            <table class="table table-hover">
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
                    <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>"
                           style="display: block"><%=name%>
                    </a>
                    </td>
                    <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>"
                           style="display: block"><%=key%>
                    </a>
                    </td>
                    <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>"
                           style="display: block"><%=leader%>
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
            <table class="table table-hover">
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
                        <div class="form-group">
                            <label for="project">Project*</label>
                            <select name="nameProject" class="form-control" id="project">
                                <%
                                    for (int i = 0; i < selectAllYourProject.getProjectArrayList().size(); i++) {
                                        String name = selectAllYourProject.getProjectArrayList().get(i).getNameProject();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="type">Type issue*</label>
                            <select name="nameTypeIssue" class="form-control" id="type">
                                <%
                                    for (int i = 0; i < selectTypeIssue.getTypeIssueArrayList().size(); i++) {
                                        String name = selectTypeIssue.getTypeIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="title">Title*</label>
                            <input class="form-control" type="text" name="title_issue" id="title"/>
                        </div>
                        <div class="form-group">
                            <label for="priority">Severity*</label>
                            <select name="namePriority" class="form-control" id="priority">
                                <%
                                    for (int i = 0; i < selectPriorityIssue.getPriorityIssueArrayList().size(); i++) {
                                        String name = selectPriorityIssue.getPriorityIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <% }%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="duedate">Due Date* </label>
                            <input class="form-control" type="date" name="date_issue" id="duedate"/>
                        </div>
                        <div class="form-group">
                            <label for="userassignee">User Assignee*</label>
                            <select name="userAssignee" class="form-control" id="userassignee">
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
                        <div class="form-group">
                            <label for="environment">Sub task</label>
                            <textarea class="form-control" rows="4" id="environment"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="description">Description*</label>
                            <textarea class="form-control" rows="4" id="description"></textarea>
                        </div>
                    </div>
                    <br>
                    <div class="bottom_container">
                        <div class="buttons">
                            <button type="submit" class="btn btn-success" onclick="div_hide()" value="Create">Create
                            </button>
                            <a class="btn btn-danger" onclick="div_hide()">Cancel</a>
                        </div>
                    </div>
                    <p></p>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
