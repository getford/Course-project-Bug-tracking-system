<%@ page import="bugs.SelectInfoEditBug" %>
<%@ page import="cookie.CheckCookie" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="createissue.SelectAllUsers" %>
<%@ page import="createissue.SelectPriorityIssue" %>
<%@ page import="createissue.SelectStatusIssue" %>
<%@ page import="createissue.SelectTypeIssue" %>
<%@ page import="userpage.SelectUserInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="resources/css/createissue.css" rel="stylesheet">
    <script src="resources/script/formissue.js"></script>
    <%
        String userName = null;
        String position = null;

        SelectAllUsers selectAllUsers = null;
        SelectUserInfo selectUserInfo = null;
        SelectTypeIssue selectTypeIssue = new SelectTypeIssue();
        SelectPriorityIssue selectPriorityIssue = new SelectPriorityIssue();
        SelectStatusIssue selectStatusIssue = null;
        SelectInfoEditBug selectInfoEditBug = null;

        ParseCookie parseCookie = new ParseCookie(request);
        CheckCookie checkCookie = new CheckCookie();

        if (!checkCookie.isAuthorized(request.getCookies()))
            response.sendRedirect("/");
        String id = null;
        if (checkCookie.isAuthorized(request.getCookies()) && parseCookie.getPositionIdFromToken() != 0)
            response.sendRedirect("/userpage.jsp");
        else {
            try {
                id = request.getParameter("id");

                selectInfoEditBug = new SelectInfoEditBug(Integer.parseInt(id.substring(4)));
                selectStatusIssue = new SelectStatusIssue();
                selectAllUsers = new SelectAllUsers();
                selectUserInfo = new SelectUserInfo();
                selectTypeIssue.selectAllTypeIssue();
                selectPriorityIssue.selectAllPriorityIssue();
                userName = selectUserInfo.selectUserNameFromToken(parseCookie.getUserIdFromToken());
                position = selectUserInfo.selectUserPositionNameFromToken(parseCookie.getUserIdFromToken());

            } catch (SQLException | ClassNotFoundException e) {
                response.sendRedirect("/");
            }
        }%>
    <title>Edit project</title>
</head>
<body>


    <div class="panel panel-primary">
        <div class="panel-body">
            <div class="col-sm-4">
                <div class="dropdown">
                    <button class="btn btn-success dropdown-toggle btn-block" type="button" data-toggle="dropdown">
                        <%=userName%>
                        <span class="badge"><%=position%></span>
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu">
                        <li><a href="adminpage.jsp">Admin dashboard</a></li>
                        <li><a href="userpage.jsp">Dashboard</a></li>
                        <li><a href="profile.jsp?login=<%=parseCookie.getLoginFromToken()%>">Profile</a></li>
                        <hr/>
                        <li><a href="/logout">Exit</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-sm-4">
            </div>
            <div class="col-sm-4">
            </div>
        </div>
    </div>
    <div class=container>
    <div class="panel panel-success">
        <a href="#" class="btn btn-warning btn-md btn-block" style="text-align: center">
            <h4>Edit user</h4>
        </a>
        <div class="panel-body">
                <form action="/editbug" method="post" id="form" name="form">
                    <input type="hidden" name="idBug" value="<%=id%>">
                    <div class="form-body">
                        <div class="form-group">
                            <label for="type">Type issue*</label>
                            <select name="nameTypeIssue" class="form-control" id="type">
                                <%
                                    for (int i = 0; i < selectTypeIssue.getTypeIssueArrayList().size(); i++) {
                                        int idType = selectTypeIssue.getTypeIssueArrayList().get(i).getId();
                                        String name = selectTypeIssue.getTypeIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=idType%>"><%=name%>
                                </option>
                                <%
                                    }
                                    assert selectInfoEditBug != null;
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="title">Title*</label>
                            <input class="form-control" type="text" name="title_issue" id="title"
                                   value="<%=selectInfoEditBug.getBugInfoArrayList().get(0).getTitle()%>"/>
                        </div>
                        <div class="form-group">
                            <label for="priority">Severity*</label>
                            <select name="namePriority" class="form-control" id="priority">
                                <%
                                    for (int i = 0; i < selectPriorityIssue.getPriorityIssueArrayList().size(); i++) {
                                        int idPriority = selectPriorityIssue.getPriorityIssueArrayList().get(i).getId();
                                        String name = selectPriorityIssue.getPriorityIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=idPriority%>"><%=name%>
                                </option>
                                <% }%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="priority">Status*</label>
                            <select name="statusName" class="form-control" id="status">
                                <%
                                    for (int i = 0; i < selectStatusIssue.getStatusIssueArrayList().size(); i++) {
                                        int idStatus = selectStatusIssue.getStatusIssueArrayList().get(i).getId();
                                        String name = selectStatusIssue.getStatusIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=idStatus%>"><%=name%>
                                </option>
                                <% }%>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="duedate">Due Date* </label>
                            <input class="form-control" type="date" name="date_issue" id="duedate"
                                   value="<%=selectInfoEditBug.getBugInfoArrayList().get(0).getDateCreate()%>"/>
                        </div>
                        <div class="form-group">
                            <label for="userassignee">User Assignee*</label>
                            <select name="userAssignee" class="form-control" id="userassignee">
                                <%
                                    for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                                        String idUser = selectAllUsers.getUserArrayList().get(i).getId();
                                        String infoUser = selectAllUsers.getUserArrayList().get(i).getFirstname() + " "
                                                + selectAllUsers.getUserArrayList().get(i).getLastname() + ", "
                                                + selectAllUsers.getUserArrayList().get(i).getEmail();
                                        String email = selectAllUsers.getUserArrayList().get(i).getEmail();
                                %>
                                <option value="<%=email%>"><%=infoUser %>
                                </option>
                                <%} %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="environment">Sub task</label>
                            <textarea name="environment" class="form-control" rows="4"
                                      id="environment"><%=selectInfoEditBug.getBugInfoArrayList().get(0).getEnvironment()%>
                            </textarea>
                        </div>

                        <div class="form-group">
                            <label for="description">Description*</label>
                            <textarea name="description" class="form-control" rows="4"
                                      id="description"><%=selectInfoEditBug.getBugInfoArrayList().get(0).getDescription()%></textarea>
                        </div>
                    </div>
                    <br>
                    <div class="buttons">
                        <button type="submit" class="btn btn-success" value="Create">Edit
                        </button>
                        <a href="adminpage.jsp" class="btn btn-danger">Cancel</a>
                    </div>
                </form>
                <br/>

        </div>
    </div>
</div>
</body>
</html>