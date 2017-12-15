<%@ page import="bugs.SelectAllBugsProject" %>
<%@ page import="bugs.StatisticsBug" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="createissue.SelectAllUsers" %>
<%@ page import="createissue.SelectPriorityIssue" %>
<%@ page import="createissue.SelectTypeIssue" %>
<%@ page import="projectpage.ProjectPage" %>
<%@ page import="userpage.SelectAllYourProject" %>
<%@ page import="userpage.SelectUserInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="cookie.CheckCookie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Project page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="resources/css/createissue.css" rel="stylesheet">
    <script src="resources/script/formissue.js"></script>
    <script>
        $(document).ready(function () {
            $("#bugsInput").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#bugsTable tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
    </script>
</head>
<body>
<%
    ProjectPage projectPage = new ProjectPage(request, response);
    SelectAllBugsProject selectAllBugsProject = new SelectAllBugsProject();
    StatisticsBug statisticsBug = null;
    ParseCookie parseCookie = new ParseCookie(request);
    CheckCookie checkCookie = new CheckCookie();
    SelectUserInfo selectUserInfo = null;
    SelectAllYourProject selectAllYourProject = null;
    SelectTypeIssue selectTypeIssue = null;
    SelectPriorityIssue selectPriorityIssue = null;
    SelectAllUsers selectAllUsers = null;
    try {
        selectAllBugsProject.returnIdSelectedProject(request.getParameter("nameproject"));
        selectAllBugsProject.showBugs();
        selectUserInfo = new SelectUserInfo();
        selectTypeIssue = new SelectTypeIssue();
        selectPriorityIssue = new SelectPriorityIssue();
        selectAllUsers = new SelectAllUsers();
        selectAllYourProject = new SelectAllYourProject();
        statisticsBug = new StatisticsBug(selectAllBugsProject.returnIdSelectedProject(request.getParameter("nameproject")));
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
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
</div>
<div class="container">
    <p>
        <b>Name project: </b> <%=projectPage.getNameProject()%>
        <br>
        <b>Key name: </b><%=projectPage.getKeyProject()%>
        <br>
        <b>Leader: </b><a href="/userpage.jsp?login=<%=projectPage.getUserLogin()%>"><%=projectPage.getLeaderName()%>
    </a>

    </p>
    <p>
    <div class="panel panel-warning">
        <div class="panel-heading" style="text-align: center;"><h4>Statistics Bug</h4>
        </div>
    </div>
    <div class="container">
        <div style="text-align: center;" class="row">
            <div class="col-sm-4">
                <h3>Status</h3>
                <hr/>
                <%
                    if (statisticsBug != null) {
                        for (int i = 0; i < statisticsBug.getBugStatStatusArrayList().size(); i++) {
                            String name = statisticsBug.getBugStatStatusArrayList().get(i).getName();
                            int count = statisticsBug.getBugStatStatusArrayList().get(i).getCount();
                %>
                <span><b><%=name%></b>: <span class="badge"> <%=count%></span></span>
                <br>
                <%
                        }
                    }
                %>
            </div>
            <div class="col-sm-4">
                <h3>Priority</h3>
                <hr/>
                <%
                    for (int i = 0; i < statisticsBug.getBugStatPriorityArrayList().size(); i++) {
                        String name = statisticsBug.getBugStatPriorityArrayList().get(i).getName();
                        int count = statisticsBug.getBugStatPriorityArrayList().get(i).getCount();
                %>
                <span><b><%=name%></b>: <span class="badge"> <%=count%></span></span>
                <br>
                <%
                    }
                %>
            </div>
            <div class="col-sm-4">
                <h3>Type</h3>
                <hr/>
                <%
                    for (int i = 0; i < statisticsBug.getBugStatTypeArrayList().size(); i++) {
                        String name = statisticsBug.getBugStatTypeArrayList().get(i).getName();
                        int count = statisticsBug.getBugStatTypeArrayList().get(i).getCount();
                %>
                <span><b><%=name%></b>: <span class="badge"> <%=count%></span>
            <br>
            <%
                }
            %>
            </div>
        </div>
    </div>
    <br>
    <div class="panel panel-success">
        <a href="#spoilerBugs" class="btn btn-success btn-md btn-block" data-toggle="collapse"
           style="text-align: center;">
            <h4>Bugs</h4>
        </a>
        <div id="spoilerBugs" class="collapse">
            <div class="panel-body">
                <input class="form-control" id="bugsInput" type="text" placeholder="Search..">
                <br>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Priority</th>
                        <th>Assignee</th>
                        <th>Reporter</th>
                        <th>Date Create</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Sub task</th>
                    </tr>
                    </thead>
                    <%
                        for (int i = 0; i < selectAllBugsProject.getBugArrayList().size(); i++) {
                            String id = selectAllBugsProject.getBugArrayList().get(i).getIdBug();
                            String type = selectAllBugsProject.getBugArrayList().get(i).getIdType();
                            String status = selectAllBugsProject.getBugArrayList().get(i).getIdStatus();
                            String priority = selectAllBugsProject.getBugArrayList().get(i).getIdPriority();
                            String assignee = selectAllBugsProject.getBugArrayList().get(i).getIdUserAssagniee();
                            String reporter = selectAllBugsProject.getBugArrayList().get(i).getIdUserReporter();
                            String date = selectAllBugsProject.getBugArrayList().get(i).getDateCreate();
                            String title = selectAllBugsProject.getBugArrayList().get(i).getTitle();
                            String description = selectAllBugsProject.getBugArrayList().get(i).getDescription();
                            String environment = selectAllBugsProject.getBugArrayList().get(i).getEnvironment();
                    %>
                    <tbody id="bugsTable">
                    <tr>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=id%>
                        </a>
                        </td>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=type%>
                        </a>
                        </td>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=status%>
                        </a>
                        </td>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=priority%>
                        </a>
                        </td>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=assignee%>
                        </a>
                        </td>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=reporter%>
                        </a>
                        </td>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=date%>
                        </a>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=title%>
                        </a>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=description%>
                        </a>
                        <td><a href="/viewbug.jsp?idbug=<%=id%>"><%=environment%>
                        </a>
                        </td>
                    </tr>
                    </tbody>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
