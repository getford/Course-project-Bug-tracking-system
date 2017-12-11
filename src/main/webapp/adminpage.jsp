<%@ page import="adminpage.SelectAllProjects" %>
<%@ page import="adminpage.SelectPosition" %>
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

        ParseCookie parseCookie = new ParseCookie(request);
        Cookie[] cookies = request.getCookies();
        boolean flag = false;
        for (Cookie cooky : cookies) {
            if (cooky.getName().equals("auth")) {
                flag = true;

            }
        }

        if (!flag)
            response.sendRedirect("/");
        if (flag && parseCookie.getPositionIdFromToken() != 0)
            response.sendRedirect("/userpage.jsp");
        else {
            try {
                selectPosition = new SelectPosition();
                selectUserInfo = new SelectUserInfo(request);
                selectTypeIssue = new SelectTypeIssue();
                selectPriorityIssue = new SelectPriorityIssue();
                selectAllUsers = new SelectAllUsers();
                selectAllYourProject = new SelectAllYourProject();
                selectAllProjects = new SelectAllProjects();
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
                    <li><a href="userpage.jsp">Dashboard</a></li>
                    <li><a href="profile.jsp?login=<%=parseCookie.getLoginFromToken()%>">Profile</a></li>
                    <li><a href="statistic.jsp">Statistic</a></li>
                    <hr/>
                    <li><a href="/logout">Exit</a></li>
                </ul>
            </div>
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
            <button id="create_is" onclick="div_show()" type="button" class="btn btn-danger btn-md btn-block">
                Create issue
            </button>
        </div>
    </div>
    <div class="panel-body">
        <div class="col-sm-4">
            <button id="prj" onclick="div_show_pr()" type="button" class="btn btn-warning btn-md btn-block">
                Add project
            </button>
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
            <button id="usr" onclick="div_show_us()" type="button" class="btn btn-warning btn-md btn-block">
                Add user
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
                    <a href="#">
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
<div class="panel panel-primary">
    <div class="panel-heading" style="text-align: center;"><h4>All users</h4></div>
    <div class="panel-body">
        <input class="form-control" id="userInput" type="text" placeholder="Search..">
        <table class="table table-striped">
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
                <td><a href="/profile.jsp?logim=<%=login%>" name="<%=login%>"><%=lastName%>
                </a>
                </td>
                <td>
                    <a href="#">
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

<div id="project">
    <div id="popupProject">
        <h2 class="heading_pr">Add project
        </h2>
        <div class="popup-content">
            <form action="/addproject" method="post" id="form" name="formus">
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

                        <a href="#" onclick="div_hide_pr()">Cancel</a>
                    </div>
                </div>
                <input type="submit" onclick="div_hide_pr()" value="Create"/>
            </form>
        </div>
    </div>
</div>
<div id="user">
    <div id="popupUser">
        <h2 class="heading_us">Add user
        </h2>
        <div class="popup-content">
            <form action="/adduser" method="post" id="formus" name="formus">
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
                        <input type="submit" onclick="div_hide_us()" value="Create"/>
                        <a href="#" onclick="div_hide_us()">Cancel</a>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

</body>
</html>
