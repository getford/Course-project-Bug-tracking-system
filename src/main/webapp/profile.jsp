<%@ page import="bugs.SelectAllYourBug" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="userpage.SelectUniqueUserInfo" %>
<%@ page import="userpage.SelectUserInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="cookie.CheckCookie" %>
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
        try {
            selectUniqueUserInfo = new SelectUniqueUserInfo(request);
            selectUserInfo = new SelectUserInfo();
            selectAllYourBug = new SelectAllYourBug(parseCookie.getUserIdFromToken());
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
    <div class="row">
        <div class="col-sm-4">
            <div class="panel panel-warning">
                <div class="panel-heading" style="text-align: center;"><h3>Profile info</h3>
                </div>
            </div>
            <p>
                <b>Name: </b><%=selectUniqueUserInfo.getUserInfoByLoginArrayList().get(0).getFirstname() + " " + selectUniqueUserInfo.getUserInfoByLoginArrayList().get(0).getLastname()%>
            </p>
            <p><b>Position: </b><%=selectUniqueUserInfo.getUserInfoByLoginArrayList().get(0).getPosition()%>
            </p>
            <p><b>Email: </b><%=selectUniqueUserInfo.getUserInfoByLoginArrayList().get(0).getEmail()%>
            </p>
            <hr>
            <p><b>All you created bug: </b><%=selectUserInfo.selectCountAllYourBugs(parseCookie.getUserIdFromToken())%>
            </p>
            <p><b>Open bug: </b><%=selectUserInfo.selectCountOpenYourBugs(parseCookie.getUserIdFromToken())%>
            </p>
            <p><b>Close bug: </b><%=selectUserInfo.selectCountCloseYourBugs(parseCookie.getUserIdFromToken())%>
            </p>
        </div>
        <div></div>
        <div class="col-sm-7">
            <div class="panel panel-warning">
                <div class="panel-heading" style="text-align: center;"><h3>Your added bugs</h3>
                </div>
            </div>
            <%
                assert selectAllYourBug != null;
                for (int i = 0; i < selectAllYourBug.getYourBugArrayList().size(); i++) {
                    String id = selectAllYourBug.getYourBugArrayList().get(i).getId();
                    String title = selectAllYourBug.getYourBugArrayList().get(i).getTitle();
            %>
            <p><%=id%> <%=title%>
            </p>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
</html>