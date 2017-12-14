<%@ page import="adminpage.SelectPosition" %>
<%@ page import="cookie.CheckCookie" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="createissue.SelectAllUsers" %>
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
    <%
        String userName = null;
        String position = null;

        SelectAllUsers selectAllUsers = null;
        SelectPosition selectPosition = null;
        SelectUserInfo selectUserInfo = null;

        ParseCookie parseCookie = new ParseCookie(request);
        CheckCookie checkCookie = new CheckCookie();

        if (!checkCookie.isAuthorized(request.getCookies()))
            response.sendRedirect("/");
        int id = 0;
        if (checkCookie.isAuthorized(request.getCookies()) && parseCookie.getPositionIdFromToken() != 0)
            response.sendRedirect("/userpage.jsp");
        else {
            try {
                id = Integer.parseInt(request.getParameter("id"));
                selectPosition = new SelectPosition();
                selectUserInfo = new SelectUserInfo();
                selectAllUsers = new SelectAllUsers(id);
                userName = selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken());
                position = selectUserInfo.selectUserPositionNameFromToken(parseCookie.getUserIdFromToken());

            } catch (SQLException | ClassNotFoundException e) {
                response.sendRedirect("/");
            }
        }%>
    <title>Edit user</title>
</head>
<body>


<div class="panel panel-primary">
    <div class="panel-body">
        <div class="col-sm-4">
            <div class="dropdown">
                <button class="btn btn-success dropdown-toggle btn-block" type="button" data-toggle="dropdown">
                    <%=userName%>
                    <span class="badge"><%=position%></span>
                    <span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <li><a href="adminpage.jsp">Admin dashboard</a></li>
                    <li><a href="userpage.jsp">Dashboard</a></li>
                    <li><a href="profile.jsp?login=<%=parseCookie.getLoginFromToken()%>">Profile</a></li>
                    <hr/>
                    <li><a href="/logout">Exit</a></li>
                </ul>
            </div>
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
        </div>
    </div>
</div>
<div class=container>
    <div class="panel panel-success">
        <a href="#" class="btn btn-success btn-md btn-block" style="text-align: center">
            <h4>Edit user</h4>
        </a>
        <div class="panel-body">
            <form action="/edituser" method="post">
                <input type="hidden" name="idUser" value="<%=id%>">
                <div class="form-group">
                    <label>Position</label>
                    <select class="form-control" name="position">
                        <option value="<%=selectAllUsers.getUserInfoArrayList().get(0).getPosition()%>"
                                selected="selected">
                            <%=selectAllUsers.getUserInfoArrayList().get(0).getPosition()%>
                        </option>
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
                    <input class="form-control" type="text" name="login"
                           value="<%=selectAllUsers.getUserInfoArrayList().get(0).getLogin()%>"/>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input class="form-control" type="password" name="password"
                           value="<%=selectAllUsers.getUserInfoArrayList().get(0).getPassword()%>"/>
                </div>
                <div class="from-group">
                    <label>Email</label>
                    <input class="form-control" type="email" name="email"
                           value="<%=selectAllUsers.getUserInfoArrayList().get(0).getEmail()%>"/>
                </div>
                <br>
                <div class="from-group">
                    <label>Firstname</label>
                    <input class="form-control" type="text" name="fname"
                           value="<%=selectAllUsers.getUserInfoArrayList().get(0).getFirstname()%>"/>
                </div>
                <br>
                <div class="from-group">
                    <label>Lastname</label>
                    <input class="form-control" type="text" name="lname"
                           value="<%=selectAllUsers.getUserInfoArrayList().get(0).getLastname()%>"/>
                </div>
                <br>
                <div class="buttons">
                    <button type="submit" class="btn btn-success" value="Create">Edit
                    </button>
                    <a href="adminpage.jsp" class="btn btn-danger">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
