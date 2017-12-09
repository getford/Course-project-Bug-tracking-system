<%@ page import="bugs.SelectAllBugsProject" %>
<%@ page import="bugs.StatisticsBug" %>
<%@ page import="projectpage.ProjectPage" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="helpinfo.SelectUserInfo" %>
<%@ page import="userpage.ParseCookie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Project page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%--<link href="resources/table.css" rel="stylesheet">--%>

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
    SelectUserInfo selectUserInfo = new SelectUserInfo();
    try {
        selectAllBugsProject.returnIdSelectedProject(request.getParameter("nameproject"));
        selectAllBugsProject    .showBugs();
        statisticsBug = new StatisticsBug(selectAllBugsProject.returnIdSelectedProject(request.getParameter("nameproject")));
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
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
                    <li><a href="profile.jsp">Profile</a></li>
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

<p>
    <b>Name project: </b> <%=projectPage.getNameProject()%>
    <br>
    <b>Key name: </b><%=projectPage.getKeyProject()%>
    <br>
    <b>Leader: </b><a href="/userpage.jsp"><%=projectPage.getLeaderName()%>
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
                for (int i = 0; i < statisticsBug.getBugStatStatusArrayList().size(); i++) {
                    String name = statisticsBug.getBugStatStatusArrayList().get(i).getName();
                    int count = statisticsBug.getBugStatStatusArrayList().get(i).getCount();
            %>
            <span><b><%=name%></b>: <span class="badge"> <%=count%></span></span>
            <br>
            <%
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
    <div class="panel-heading" style="text-align: center;"><h4>Bugs</h4></div>
    <div class="panel-body">
        <input class="form-control" id="bugsInput" type="text" placeholder="Search..">
        <br>
        <table class="table table-striped">
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
                <th>Environment</th>
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
</body>
</html>
