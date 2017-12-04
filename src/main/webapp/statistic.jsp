<%@ page import="statistic.OpenIssues" %>
<%@ page import="userpage.ParseCookie" %>
<%@ page import="helpinfo.SelectUserInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%
        OpenIssues openIssues = new OpenIssues();
        ParseCookie parseCookie = new ParseCookie(request);
        SelectUserInfo selectUserInfo = new SelectUserInfo();
    %>
    <title>Statistic - <%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
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
                <li><a href="profile.jsp">Profile</a></li>
                <li class="disabled"><a href="statistic.jsp">Statistic</a></li>
                <hr/>
                <li><a href="#">Exit</a></li>
            </ul>
        </div>
    </div>
</div>

<p>All open issue: <%=openIssues.countAllOpenIssues()%>
</p>
</body>
</html>
