<%@ page import="adminpage.SelectAllProjects" %>
<%@ page import="adminpage.SelectPosition" %>
<%@ page import="bugs.SelectAllBugsProject" %>
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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="resources/css/createissue.css" rel="stylesheet">
    <script src="resources/script/formissue.js"></script>
    <link href="resources/css/admin.css" rel="stylesheet">
    <script src="resources/script/formuser.js"></script>
    <script src="resources/script/formproject.js"></script>
    <script src="resources/script/formprojectedit.js"></script>
    <script src="resources/script/formuseredit.js"></script>
    <script src="resources/script/formissue.js"></script>
    <script src="resources/script/formassign.js"></script>

    <%
        String userName = null;
        String position = null;

        SelectAllProjects selectAllProjects = null;
        SelectAllYourProject selectAllYourProject = null;
        SelectTypeIssue selectTypeIssue = null;
        SelectPriorityIssue selectPriorityIssue = null;
        SelectAllUsers selectAllUsers = null;
        SelectPosition selectPosition = null;
        SelectUserInfo selectUserInfo = null;
        SelectAllBugsProject selectAllBugsProject = null;

        ParseCookie parseCookie = new ParseCookie(request);
        CheckCookie checkCookie = new CheckCookie();

        if (!checkCookie.isAuthorized(request.getCookies()))
            response.sendRedirect("/");
        if (checkCookie.isAuthorized(request.getCookies()) && parseCookie.getPositionIdFromToken() != 0)
            response.sendRedirect("/userpage.jsp");
        else {
            try {
                selectPosition = new SelectPosition();
                selectUserInfo = new SelectUserInfo();
                selectTypeIssue = new SelectTypeIssue();
                selectPriorityIssue = new SelectPriorityIssue();
                selectAllUsers = new SelectAllUsers();
                selectAllProjects = new SelectAllProjects();
                selectAllBugsProject = new SelectAllBugsProject();
                userName = selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken());
                position = selectUserInfo.selectUserPositionNameFromToken(parseCookie.getUserIdFromToken());
            } catch (SQLException | ClassNotFoundException e) {
                response.sendRedirect("/");
            }
        }%>
    <title>Admin page</title>
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
    <script>
        $(document).ready(function () {
            $("#userInput").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#userTable tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>
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
</head>
<body id="body" style="overflow:hidden;">
<div class="panel panel-primary">
    <div class="panel-body">
        <div class="col-sm-4">
            <div class="dropdown">
                <button class="btn btn-success dropdown-toggle btn-block" type="button" data-toggle="dropdown">
                    <%=userName%>
                    <span class="badge"><%=position%></span>
                    <span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <li class="disabled"><a href="adminpage.jsp">Admin dashboard</a></li>
                    <li><a href="userpage.jsp">Dashboard</a></li>
                    <li><a href="profile.jsp?login=<%=parseCookie.getLoginFromToken()%>">Profile</a></li>
                    <hr/>
                    <li><a href="/logout">Exit</a></li>
                </ul>
            </div>
        </div>
        <div class="col-sm-4">
        </div>
    </div>
    <div class="panel-body">
        <div class="col-sm-4">
            <button id="prj" onclick="div_show_pr()" type="button" class="btn btn-warning btn-md btn-block">
                Add project
            </button>
        </div>
        <div class="col-sm-4">
            <button id="uspr" onclick="div_show_assign()" type="button" class="btn btn-warning btn-md btn-block">
                Assignee to project
            </button>
        </div>
        <div class="col-sm-4">
            <button id="usr" onclick="div_show_us()" type="button" class="btn btn-warning btn-md btn-block">
                Add user
            </button>
        </div>
    </div>
</div>
<div class="container">

    <div class="panel-group" id="accordion">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a href="#spoilerProjects" class="btn btn-info btn-md btn-block" data-toggle="collapse"
                       data-parent="#accordion"
                       style="text-align: center;"><h4>All projects</h4>
                    </a>
                </h4>

            </div>
            <div id="spoilerProjects" class="panel-collapse collapse">
                <div class="panel-body">
                    <input class="form-control" id="projectInput" type="text" placeholder="Search..">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Key</th>
                            <th>Name</th>
                            <th>Leader</th>
                            <th>Control</th>
                        </tr>
                        </thead>
                        <%
                            if (selectAllProjects != null) {
                                for (int i = 0; i < selectAllProjects.getProjectArrayList().size(); i++) {
                                    String id = selectAllProjects.getProjectArrayList().get(i).getId();
                                    String key = selectAllProjects.getProjectArrayList().get(i).getKeyName();
                                    String name = selectAllProjects.getProjectArrayList().get(i).getProjectName();
                                    String lead = selectAllProjects.getProjectArrayList().get(i).getFirstLastName();
                        %>
                        <tbody id="projectTable">
                        <tr>
                            <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>"><%=id%>
                            </a>
                            </td>
                            <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>"><%=key%>
                            </a>
                            </td>
                            <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>"><%=name%>
                            </a>
                            </td>
                            <td><a href="/projectpage.jsp?nameproject=<%=name%>" name="<%=name%>"><%=lead%>
                            </a>
                            </td>
                            <td>
                                <a href="/editproject.jsp?id=<%=id%>">
                                    <img border="0" src="resources/image/edit.png">
                                </a>

                                <a href="/deleteproject?id=<%=id%>">
                                    <img border="0" src="resources/image/delete.png">
                                </a>
                            </td>
                        </tr>
                        </tbody>
                        <%
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a href="#spoilerUsers" class="btn btn-success btn-md btn-block" data-toggle="collapse"
                       data-parent="#accordion"
                       style="text-align: center;"><h4>All Users</h4>
                    </a>
                </h4>

            </div>
            <div id="spoilerUsers" class="panel-collapse collapse">
                <div class="panel-body">
                    <input class="form-control" id="userInput" type="text" placeholder="Search..">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Login</th>
                            <th>Email</th>
                            <th>Position</th>
                            <th>First name</th>
                            <th>Last name</th>
                            <th>Control</th>
                        </tr>
                        </thead>
                        <%
                            if (selectAllProjects != null) {
                                for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                                    String id = selectAllUsers.getUserArrayList().get(i).getId();
                                    String login = selectAllUsers.getUserArrayList().get(i).getLogin();
                                    String email = selectAllUsers.getUserArrayList().get(i).getEmail();
                                    String userPosition = selectAllUsers.getUserArrayList().get(i).getPosition();
                                    String firstName = selectAllUsers.getUserArrayList().get(i).getFirstname();
                                    String lastName = selectAllUsers.getUserArrayList().get(i).getLastname();

                        %>
                        <tbody id="userTable">
                        <tr>
                            <td><a href="/profile.jsp?login=<%=login%>" name="<%=login%>"><%=id%>
                            </a>
                            </td>
                            <td><a href="/profile.jsp?login=<%=login%>" name="<%=login%>"><%=login%>
                            </a>
                            </td>
                            <td><a href="/profile.jsp?login=<%=login%>" name="<%=login%>"><%=email%>
                            </a>
                            </td>
                            <td><a href="/profile.jsp?login=<%=login%>" name="<%=login%>"><%=userPosition%>
                            </a>
                            </td>
                            <td><a href="/profile.jsp?login=<%=login%>" name="<%=login%>"><%=firstName%>
                            </a>
                            </td>
                            <td><a href="/profile.jsp?login=<%=login%>" name="<%=login%>"><%=lastName%>
                            </a>
                            </td>
                            <td>
                                <a href="/edituser.jsp?id=<%=id%>">
                                    <img border="0" src="resources/image/edit.png">
                                </a>
                                <a href="/deleteuser?id=<%=id%>">
                                    <img border="0" src="resources/image/delete.png">
                                </a>
                            </td>
                        </tr>
                        </tbody>
                        <%
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a href="#spoilerBugs" class="btn btn-warning btn-md btn-block" data-toggle="collapse"
                       data-parent="#accordion"
                       style="text-align: center;"><h4>All bugs</h4>
                    </a>
                </h4>

            </div>
            <div id="spoilerBugs" class="panel-collapse collapse">
                <div class="panel-body">
                    <input class="form-control" id="bugsInput" type="text" placeholder="Search..">
                    <br>
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Priority</th>
                            <th>Assignee</th>
                            <th>Reporter</th>
                            <th>Date Create</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Sub task</th>
                            <th>Control</th>
                        </tr>
                        </thead>
                        <%
                            for (int i = 0; i < selectAllBugsProject.getAllBugArrayList().size(); i++) {
                                String id = selectAllBugsProject.getAllBugArrayList().get(i).getIdBug();
                                String type = selectAllBugsProject.getAllBugArrayList().get(i).getIdType();
                                String status = selectAllBugsProject.getAllBugArrayList().get(i).getIdStatus();
                                String priority = selectAllBugsProject.getAllBugArrayList().get(i).getIdPriority();
                                String assignee = selectAllBugsProject.getAllBugArrayList().get(i).getIdUserAssagniee();
                                String reporter = selectAllBugsProject.getAllBugArrayList().get(i).getIdUserReporter();
                                String date = selectAllBugsProject.getAllBugArrayList().get(i).getDateCreate();
                                String title = selectAllBugsProject.getAllBugArrayList().get(i).getTitle();
                                String description = selectAllBugsProject.getAllBugArrayList().get(i).getDescription();
                                String environment = selectAllBugsProject.getAllBugArrayList().get(i).getEnvironment();
                        %>
                        <tbody id="bugsTable">
                        <tr>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=id%>
                            </a>
                            </td>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=type%>
                            </a>
                            </td>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=status%>
                            </a>
                            </td>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=priority%>
                            </a>
                            </td>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=assignee%>
                            </a>
                            </td>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=reporter%>
                            </a>
                            </td>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=date%>
                            </a>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=title%>
                            </a>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=description%>
                            </a>
                            <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=environment%>
                            </a>
                            </td>
                            <td>
                                <a href="/editbug.jsp?id=<%=id%>">
                                    <img border="0" src="resources/image/edit.png">
                                </a>
                                <a href="/deletebug?id=<%=id%>">
                                    <img border="0" src="resources/image/delete.png">
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
        </div>
    </div>

    <div id="project">
        <div id="popupProject">
            <h2 class="heading_pr">Add project
            </h2>
            <div class="popup-content">
                <form action="/addproject" method="post" id="formpr" name="formpr">
                    <div class="form-body_pr">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input class="form-control" type="text" name="nameProject" id="name"/>
                        </div>
                        <div class="form-group">
                            <label for="keyname">Key name</label>
                            <input class="form-control" type="text" name="keyProject" id="keyname"/>
                        </div>
                        <div class="form-group">
                            <label for="projectleader">Project leader</label>
                            <select name="leader" class="form-control" id="projectleader">
                                <%
                                    if (selectAllUsers != null) {
                                        for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                                            String infoUser = selectAllUsers.getUserArrayList().get(i).getFirstname() + " "
                                                    + selectAllUsers.getUserArrayList().get(i).getLastname() + ", "
                                                    + selectAllUsers.getUserArrayList().get(i).getEmail();
                                            String email = selectAllUsers.getUserArrayList().get(i).getEmail();
                                %>
                                <option value="<%=email%>"><%=infoUser %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="bottom_container">
                        <div class="buttons">
                            <button type="submit" class="btn btn-success" onclick="div_hide_pr()" value="Create">
                                Create
                            </button>
                            <a class="btn btn-danger" onclick="div_hide_pr()">Cancel</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="user">
        <div id="popupUser">
            <h2 class="heading_us">Add user</h2>
            <div class="popup-content">
                <form action="/adduser" method="post" id="formus" name="formus">
                    <div class="form-body_us">
                        <div class="form-group">
                            <label for="position">Position</label>
                            <select name="position" class="form-control" id="position">
                                <%
                                    if (selectPosition != null) {
                                        for (int i = 0; i < selectPosition.getUserPositionsArraylist().size(); i++) {
                                            String name = selectPosition.getUserPositionsArraylist().get(i).getName();
                                %>
                                <option value="<%=name%>">
                                    <%=name%>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Login</label>
                            <input class="form-control" type="text" name="login">
                        </div>
                        <div class="form-group">
                            <label>Password</label>
                            <input class="form-control" type="password" name="password"/>
                        </div>
                        <div class="form-group">
                            <label>Verify password</label>
                            <input class="form-control" type="password" name="passwordv"/>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input class="form-control" type="email" name="email"/>
                        </div>
                        <div class="form-group">
                            <label>Firstname</label>
                            <input class="form-control" type="text" name="fname"/>
                        </div>
                        <div class="form-group">
                            <label>Lastname</label>
                            <input class="form-control" type="text" name="lname"/>
                        </div>
                    </div>
                    <div class="bottom_container">
                        <div class="buttons">
                            <button type="submit" class="btn btn-success" onclick="div_hide_us()" value="Create">
                                Create
                            </button>
                            <a class="btn btn-danger" onclick="div_hide_us()">Cancel</a>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
    <div id="projectEdit">
        <div id="popupProjectEdit">
            <h2 class="heading_pr">Edit project
            </h2>
            <div class="popup-content">
                <form action="/editproject" method="post" id="formProjectEdit" name="formus">
                    <div class="form-body_pr">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input class="form-control" type="text" name="nameProject" id="nameEdit"/>
                        </div>
                        <div class="form-group">
                            <label for="keyname">Key name</label>
                            <input class="form-control" type="text" name="keyProject" id="keynameEdit"/>
                        </div>
                        <div class="form-group">
                            <label for="projectleader">Project leader</label>
                            <select name="leader" class="form-control" id="projectleaderEdit">
                                <%
                                    if (selectAllUsers != null) {
                                        for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                                            String infoUser = selectAllUsers.getUserArrayList().get(i).getFirstname() + " "
                                                    + selectAllUsers.getUserArrayList().get(i).getLastname() + ", "
                                                    + selectAllUsers.getUserArrayList().get(i).getEmail();
                                            String email = selectAllUsers.getUserArrayList().get(i).getEmail();
                                %>
                                <option value="<%=email%>"><%=infoUser %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="bottom_container">
                        <div class="buttons">
                            <button type="submit" class="btn btn-success" onclick="div_hide_prEdit()" value="Create">
                                Edit
                            </button>
                            <a class="btn btn-danger" onclick="div_hide_prEdit()">Cancel</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="userEdit">
        <div id="popupUserEdit">
            <h2 class="heading_us">Edit user
            </h2>
            <div class="popup-content">
                <form action="/edituser" method="post" id="formusEdit" name="userEdit">
                    <div class="form-body_us">
                        <div class="content">
                            <div class="field-group">
                                <label>Position</label>
                                <select name="position">
                                    <%
                                        if (selectPosition != null) {
                                            for (int i = 0; i < selectPosition.getUserPositionsArraylist().size(); i++) {
                                                String name = selectPosition.getUserPositionsArraylist().get(i).getName();
                                    %>
                                    <option value="<%=name%>">
                                        <%=name%>
                                    </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>

                            </div>
                            <div class="field-group">
                                <label>Login</label>
                                <input type="text" name="login">
                            </div>
                            <div class="field-group">
                                <label>Password</label>
                                <input type="password" name="password"/>
                            </div>
                            <div class="field-group">
                                <label>Verify password</label>
                                <input type="password" name="passwordv"/>
                            </div>
                            <div class="field-group">
                                <label>Email</label>
                                <input type="email" name="email"/>
                            </div>
                            <div class="field-group">
                                <label>Firstname</label>
                                <input type="text" name="fname"/>
                            </div>
                            <div class="field-group">
                                <label>Lastname</label>
                                <input type="text" name="lname"/>
                            </div>
                        </div>
                    </div>
                    <div class="bottom_container">
                        <div class="buttons">
                            <button type="submit" class="btn btn-success" onclick="div_hide_usEdit()" value="Create">
                                Create
                            </button>
                            <a class="btn btn-danger" onclick="div_hide_usEdit()">Cancel</a>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
    <div id="usertoproject">
        <div id="popupAssign">
            <h2 class="heading_as">Assign user</h2>
            <div class="popup-content">
                <form action="/addusertoproject" method="post" id="formas" name="formas">
                    <div class="form-body_as">
                        <div class="form-group">
                            <label for="useras">User</label>
                            <select name="useras" class="form-control" id="useras">
                                <%
                                    if (selectAllUsers != null) {
                                        for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                                            String idUser = selectAllUsers.getUserArrayList().get(i).getId();
                                            String infoUser = selectAllUsers.getUserArrayList().get(i).getFirstname() + " "
                                                    + selectAllUsers.getUserArrayList().get(i).getLastname() + ", "
                                                    + selectAllUsers.getUserArrayList().get(i).getEmail();
                                %>
                                <option value="<%=idUser%>"><%=infoUser %>
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="projectAs">Project</label>
                            <select name="projectas" class="form-control" id="projectAs">
                                <%
                                    for (int i = 0; i < selectAllProjects.getProjectArrayList().size(); i++) {
                                        String id = selectAllProjects.getProjectArrayList().get(i).getId();
                                        String name = selectAllProjects.getProjectArrayList().get(i).getProjectName() + " " +
                                                selectAllProjects.getProjectArrayList().get(i).getKeyName();
                                %>
                                <option value="<%=id%>"><%=name%>
                                </option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="bottom_container">
                        <div class="buttons">
                            <button type="submit" class="btn btn-success" onclick="div_hide_assign()" value="Create">
                                Create
                            </button>
                            <a class="btn btn-danger" onclick="div_hide_assign()">Cancel</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="issue">
        <div id="popupIssue">
            <h2 class="heading_is">Edit Issue
            </h2>
            <div class="popup-content">
                <form action="/createissue" method="post" id="formIssueEdit" name="form">
                    <div class="form-body">
                        <div class="form-group">
                            <label for="project">Project*</label>
                            <select name="nameProject" class="form-control" id="issueProjectEdit">
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
                    <div class="container">
                        <button type="submit" class="btn btn-success" onclick="div_hide()" value="Create">Create
                        </button>
                        <a class="btn btn-danger" onclick="div_hide()">Cancel</a>
                    </div>
                    <p></p>
                </form>
            </div>
        </div>
    </div>
    <div id="helper"></div>
</div>
</body>
</html>
