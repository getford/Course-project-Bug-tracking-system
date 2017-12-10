<%@ page import="bugs.SelectAllYourBug" %>
<%@ page import="helpinfo.SelectUserInfo" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%
        ParseCookie parseCookie = new ParseCookie(request);
        SelectUserInfo selectUserInfo = new SelectUserInfo();
        SelectAllYourBug selectAllYourBug = null;
        try {
            selectAllYourBug = new SelectAllYourBug(parseCookie.getUserIdFromToken());
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    %>
    <title>Profile - <%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
    </title>
</head>
<body>
<div class="panel panel-primary">
    <div class="panel-body">
        <div class="col-sm-7">
            <div class="dropdown">
                <button class="btn btn-success dropdown-toggle" type="button" data-toggle="dropdown">
                    <%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
                    <span class="badge"><%=selectUserInfo.selectUserPositionName(parseCookie.getUserIdFromToken())%></span>
                    <span class="caret"></span></button>
                <ul class="dropdown-menu">
                    <li><a href="userpage.jsp">Dashboard</a></li>
                    <li class="disabled"><a href="profile.jsp">Profile</a></li>
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

<div class="container">
    <div class="row">
        <div class="col-sm-4">
            <div class="panel panel-warning">
                <div class="panel-heading" style="text-align: center;"><h3>Profile info</h3>
                </div>
            </div>
            <p><b>Name: </b><%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
            </p>
            <p><b>Position: </b><%=selectUserInfo.selectUserPositionName(parseCookie.getUserIdFromToken())%>
            </p>
            <p><b>Email: </b><%=selectUserInfo.selectUserEmail(parseCookie.getUserIdFromToken())%>
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
            <p><%=id%> <%=title%></p>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
</html>
