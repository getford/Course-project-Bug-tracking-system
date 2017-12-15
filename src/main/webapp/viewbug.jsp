<%@ page import="adminpage.SelectAllProjects" %>
<%@ page import="adminpage.SelectPosition" %>
<%@ page import="bugs.SelectAllBugsProject" %>
<%@ page import="bugs.ViewBug" %>
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
                    <hr/>
                    <li><a href="/logout">Exit</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
    </div>
    <div class="col-sm-4">
    </div>
</div>

<div class="container">

    <div class="panel panel-default">
            <a style="text-align: center" href="/editbug.jsp?id=<%=viewBug.getBugArrayList().get(0).getIdBug()%>">
                <img border="0" src="resources/image/edit.png">
            </a>
        <div class="modal-header">
            <h3><%=viewBug.getBugArrayList().get(0).getIdBug()%>
            </h3>
            <h2><b><%=viewBug.getBugArrayList().get(0).getTitle()%>
            </b></h2>
        </div>

        <div class="panel panel-info">
            <a href="#details" class="btn btn-info btn-md btn-block" data-toggle="collapse"><h4>Details</h4>
            </a>
            <div id="details" class="collapse">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th><b>Type</b></th>
                        <th><b>Priority</b></th>
                        <th><b>Status</b></th>
                        <th><b>Sub task</b></th>
                    </tr>
                    </thead>
                    <tbody id="detailsTable">
                    <tr>
                        <td><%=viewBug.getBugArrayList().get(0).getIdType()%>
                        </td>
                        <td><%=viewBug.getBugArrayList().get(0).getIdPriority()%>
                        </td>
                        <td><%=viewBug.getBugArrayList().get(0).getIdStatus()%>
                        </td>
                        <td><%=viewBug.getBugArrayList().get(0).getEnvironment()%>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="panel panel-info">
            <a href="#people" class="btn btn-info btn-md btn-block" data-toggle="collapse"
            ><h4>People</h4>
            </a>
            <div id="people" class="collapse">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th><b>Assignee</b></th>
                        <th><b>Reporter</b></th>
                    </tr>
                    </thead>
                    <tbody id="peopleTable">
                    <tr>
                        <td><%=viewBug.getBugArrayList().get(0).getIdUserAssagniee()%>
                        </td>
                        <td><%=viewBug.getBugArrayList().get(0).getIdUserReporter()%>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="panel panel-info">
            <a href="#date" class="btn btn-info btn-md btn-block" data-toggle="collapse"
            ><h4>Date</h4>
            </a>
            <div id="date" class="collapse">
                <table class="table table-hover">
                    <thead>
                    </thead>
                    <tbody id="dateTable">
                    <tr>
                        <td><%=viewBug.getBugArrayList().get(0).getDateCreate()%>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="panel panel-info">
            <a href="#description" class="btn btn-info btn-md btn-block" data-toggle="collapse"
            ><h4>Description</h4>
            </a>
            <div id="description" class="collapse">
                <table class="table table-hover">
                    <thead>
                    </thead>
                    <tbody id="projectTable">
                    <tr>
                        <td><%=viewBug.getBugArrayList().get(0).getDescription()%>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</div>
</body>
</html>
