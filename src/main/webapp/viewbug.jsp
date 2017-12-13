<%@ page import="adminpage.SelectAllProjects" %>
<%@ page import="adminpage.SelectPosition" %>
<%@ page import="bugs.SelectAllBugsProject" %>
<%@ page import="bugs.ViewBug" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="createissue.SelectAllUsers" %>
<%@ page import="createissue.SelectPriorityIssue" %>
<%@ page import="createissue.SelectTypeIssue" %>
<%@ page import="userpage.SelectAllYourProject" %>
<%@ page import="userpage.SelectUserInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="cookie.CheckCookie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>Bug</title>
    <%
        ViewBug viewBug = null;

        ParseCookie parseCookie = new ParseCookie(request);
        CheckCookie checkCookie = new CheckCookie();
        SelectAllProjects selectAllProjects = null;
        SelectAllYourProject selectAllYourProject = null;
        SelectTypeIssue selectTypeIssue = null;
        SelectPriorityIssue selectPriorityIssue = null;
        SelectAllUsers selectAllUsers = null;
        SelectPosition selectPosition = null;
        SelectUserInfo selectUserInfo = null;
        SelectAllBugsProject selectAllBugsProject = null;

        try {
            viewBug = new ViewBug(request.getParameter("idbug"));
            selectPosition = new SelectPosition();
            selectUserInfo = new SelectUserInfo();
            selectTypeIssue = new SelectTypeIssue();
            selectPriorityIssue = new SelectPriorityIssue();
            selectAllUsers = new SelectAllUsers();
            selectAllProjects = new SelectAllProjects();
            selectAllBugsProject = new SelectAllBugsProject();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        assert viewBug != null;%>
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
                Create
                issue
            </button>
        </div>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body">
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-body">
        <div>
            <p><b>ID: </b><%=viewBug.getBugArrayList().get(0).getIdBug()%>
            </p>
            <p><b>Type: </b><%=viewBug.getBugArrayList().get(0).getIdType()%>
            </p>
            <p><b>Status: </b><%=viewBug.getBugArrayList().get(0).getIdStatus()%>
            </p>
            <p><b>Priority: </b><%=viewBug.getBugArrayList().get(0).getIdPriority()%>
            </p>
            <p><b>Assignee: </b><%=viewBug.getBugArrayList().get(0).getIdUserAssagniee()%>
            </p>
            <p><b>Reporter: </b><%=viewBug.getBugArrayList().get(0).getIdUserReporter()%>
            </p>
            <p><b>Date create: </b><%=viewBug.getBugArrayList().get(0).getDateCreate()%>
            </p>
            <p><b>Title: </b><%=viewBug.getBugArrayList().get(0).getTitle()%>
            </p>
            <p><b>Description: </b><%=viewBug.getBugArrayList().get(0).getDescription()%>
            </p>
            <p><b>Environment: </b><%=viewBug.getBugArrayList().get(0).getEnvironment()%>
            </p>
        </div>
    </div>
</div>

</body>
</html>
