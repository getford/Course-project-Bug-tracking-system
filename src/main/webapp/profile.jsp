<%@ page import="userpage.ParseCookie" %>
<%@ page import="helpinfo.SelectUserInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%
        ParseCookie parseCookie = new ParseCookie(request);
        SelectUserInfo selectUserInfo = new SelectUserInfo();

    %>
    <title>Profile - <%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
    </title>
</head>
<body>
<div class="panel panel-primary">
    <div class="panel-body">
        <div class="dropdown">
            <button class="btn btn-success dropdown-toggle" type="button" data-toggle="dropdown">
                <%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
                <span class="badge"><%=selectUserInfo.selectUserPositionName(parseCookie.getUserIdFromToken())%></span>
                <span class="caret"></span></button>
            <ul class="dropdown-menu">
                <li class="disabled"><a href="profile.jsp">Profile</a></li>
                <li><a href="statistic.jsp">Statistic</a></li>
                <hr/>
                <li><a href="#">Exit</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-sm-4">
            <h3>Profile info</h3>
            <p><b>Name: </b><%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
            </p>
            <p><b>Position: </b><%=selectUserInfo.selectUserPositionName(parseCookie.getUserIdFromToken())%>
            </p>
        </div>
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
            <h3>Your added bugs</h3>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
            <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
        </div>
    </div>
</div>
</body>
</html>
