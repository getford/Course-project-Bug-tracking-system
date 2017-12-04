<%@ page import="bugs.ViewBug" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bug</title>
</head>
<body>
<%
    ViewBug viewBug = null;

    try {
        viewBug = new ViewBug(request.getParameter("idbug"));
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    assert viewBug != null;%>
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

</body>
</html>
