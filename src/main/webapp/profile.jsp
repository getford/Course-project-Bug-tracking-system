<%@ page import="bugs.SelectAllYourBug" %>
<%@ page import="cookie.CheckCookie" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="userpage.SelectUniqueUserInfo" %>
<%@ page import="userpage.SelectUserInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%
        ParseCookie parseCookie = new ParseCookie(request);
        CheckCookie checkCookie = new CheckCookie();
        SelectUserInfo selectUserInfo = null;
        SelectAllYourBug selectAllYourBug = null;
        SelectUniqueUserInfo selectUniqueUserInfo = null;
        int idUser = 0;
        try {
            selectUserInfo = new SelectUserInfo();
            idUser = selectUserInfo.selectUserIdFromLogin(request.getParameter("login"));
            selectUniqueUserInfo = new SelectUniqueUserInfo(request);

            selectAllYourBug = new SelectAllYourBug(idUser);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    %>
    <title>Profile</title>
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
                    <li><a href="userpage.jsp">Dashboard</a></li>
                    <li class="disabled"><a href="profile.jsp?login=<%=parseCookie.getLoginFromToken()%>">Profile</a>
                    </li>
                    <hr/>
                    <li><a href="/logout">Exit</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-sm-4">
            <div class="panel panel-warning">
                <div class="panel-heading" style="text-align: center;"><h3>Profile info</h3>
                </div>
            </div>
            <table class="table table-condensed">
                <thead></thead>
                <tbody>
                <tr>
                    <td>
                        <b>Name: </b><%=selectUniqueUserInfo.getUserInfoByLoginArrayList().get(0).getFirstname() + " " + selectUniqueUserInfo.getUserInfoByLoginArrayList().get(0).getLastname()%>
                    </td>
                </tr>
                <tr>
                    <td><b>Position: </b><%=selectUniqueUserInfo.getUserInfoByLoginArrayList().get(0).getPosition()%>
                    </td>
                </tr>
                <tr>
                    <td><b>Email: </b><%=selectUniqueUserInfo.getUserInfoByLoginArrayList().get(0).getEmail()%>
                    </td>
                </tr>
                </tbody>
            </table>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th><b>Created bugs</b></th>
                    <th><b>Open bugs</b></th>
                    <th><b>Closed bugs</b></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <%=selectUserInfo.selectCountAllYourBugs(idUser)%>
                    </td>
                    <td>
                        <%=selectUserInfo.selectCountOpenYourBugs(idUser)%>
                    </td>
                    <td>
                        </b><%=selectUserInfo.selectCountCloseYourBugs(idUser)%>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
        <div></div>
        <div class="col-sm-7">
            <div class="panel panel-warning">
                <div class="panel-heading" style="text-align: center;"><h3>Your added bugs</h3>
                </div>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID bug</th>
                        <th>Summary</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        assert selectAllYourBug != null;
                        for (int i = 0; i < selectAllYourBug.getYourBugArrayList().size(); i++) {
                            String id = selectAllYourBug.getYourBugArrayList().get(i).getId();
                            String title = selectAllYourBug.getYourBugArrayList().get(i).getTitle();
                    %>
                    <tr>
                        <td>
                            <a href="/viewbug.jsp?idbug=<%=id%>"><%=id%>
                            </a>
                        </td>
                        <td>
                            <a href="/viewbug.jsp?idbug=<%=id%>"><%=title%>
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>