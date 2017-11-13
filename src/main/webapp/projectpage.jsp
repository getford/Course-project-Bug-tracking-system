<%@ page import="bugs.SelectAllBugsProject" %>
<%@ page import="projectpage.ProjectPage" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="bugs.StatisticsBug" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Project page</title>
    <link href="resources/table.css" rel="stylesheet">
</head>
<body>
<%
    ProjectPage projectPage = new ProjectPage(request, response);
    SelectAllBugsProject selectAllBugsProject = new SelectAllBugsProject();
    StatisticsBug statisticsBug = new StatisticsBug();
    try {
        selectAllBugsProject.returnIdSelectedProject(request.getParameter("nameproject"));
        selectAllBugsProject.showBugs();
        statisticsBug.setIdProject(selectAllBugsProject.returnIdSelectedProject(request.getParameter("nameproject")));
        statisticsBug.showStatisticsBugs();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<p>
    <b>Name project: </b> <%=projectPage.getNameProject()%>
</p>
<p>
    <b>Key name: </b><%=projectPage.getKeyProject()%>
</p>
<p>
    <b>Leader: </b><a href="/userpage.jsp"><%=projectPage.getLeaderName()%>
</a>
</p>
<p>
<h4>Bugs</h4>
<table>
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
    <tbody>
    <tr>
        <td><%=id%>
        </td>
        <td><%=type%>
        </td>
        <td><%=status%>
        </td>
        <td><%=priority%>
        </td>
        <td><%=assignee%>
        </td>
        <td><%=reporter%>
        </td>
        <td><%=date%>
        <td><%=title%>
        <td><%=description%>
        <td><%=environment%>
        </td>
    </tr>
    </tbody>
    <%
        }
    %>
</table>
<p>
<h4>Statistics Bug</h4>
<hr>
<h6></h6>
</p>
</body>
</html>
