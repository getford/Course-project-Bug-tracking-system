<%@ page import="adminpage.SelectAllProjects" %>
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
    <link href="resources/css/admin.css" rel="stylesheet">
    <script src="resources/script/formissue.js"></script>
    <%
        String userName = null;
        String position = null;

        SelectAllUsers selectAllUsers = null;
        SelectUserInfo selectUserInfo = null;
        SelectAllProjects selectAllProjects = null;

        ParseCookie parseCookie = new ParseCookie(request);
        CheckCookie checkCookie = new CheckCookie();

        if (!checkCookie.isAuthorized(request.getCookies()))
            response.sendRedirect("/");
        String id = null;
        if (checkCookie.isAuthorized(request.getCookies()) && parseCookie.getPositionIdFromToken() != 0)
            response.sendRedirect("/userpage.jsp");
        else {
            try {
                id = request.getParameter("id");

                selectAllUsers = new SelectAllUsers();
                selectUserInfo = new SelectUserInfo();
                selectAllProjects = new SelectAllProjects(id);
                userName = selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken());
                position = selectUserInfo.selectUserPositionNameFromToken(parseCookie.getUserIdFromToken());

            } catch (SQLException | ClassNotFoundException e) {
                response.sendRedirect("/");
            }
        }%>
    <title>Edit project</title>
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
        <a href="#" class="btn btn-info btn-md btn-block" style="text-align: center">
            <h4>Edit user</h4>
        </a>
        <div class="panel-body">
                <form action="/editproject" method="post">
                    <input type="hidden" name="idProject" value="<%=id%>">
                    <div class="from-group">
                        <label>Name</label>
                        <input class="form-control" type="text" name="pName"
                               value="<%=selectAllProjects.getProjectForEditArrayList().get(0).getProjectName()%>"/>
                    </div>
                    <div class="from-group">
                        <label>Key Name</label>
                        <input class="form-control" type="text" name="kName"
                               value="<%=selectAllProjects.getProjectForEditArrayList().get(0).getKeyName()%>"/>
                    </div>
                    <div class="from-group">
                        <label for="lead">Leader</label>
                        <select class="form-control" name="idLead" id="lead">
                            <%
                                for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                                    String idLeader = selectAllUsers.getUserArrayList().get(i).getId();
                                    String name = selectAllUsers.getUserArrayList().get(i).getFirstname() + " "
                                            + selectAllUsers.getUserArrayList().get(i).getLastname();
                                    String email = selectAllUsers.getUserArrayList().get(i).getEmail();
                            %>
                            <option value="<%=idLeader%>">
                                <%=name%>, <%=email%>
                            </option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </br>
                    <div class="buttons">
                            <button type="submit" class="btn btn-success" id="edt" name="edt">Click</button>
                            <a href="adminpage.jsp" class="btn btn-danger">Cancel</a>
                    </div>
                </form>
        </div>
    </div>
</div>
</body>
</html>
