<%@ page import="adminpage.SelectPosition" %>
<%@ page import="userpage.SelectUserInfo" %>
<%@ page import="cookie.ParseCookie" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="userpage.SelectAllYourProject" %>
<%@ page import="createissue.SelectTypeIssue" %>
<%@ page import="createissue.SelectPriorityIssue" %>
<%@ page import="createissue.SelectAllUsers" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="resources/createissue.css" rel="stylesheet">
    <script src="resources/formissue.js"></script>
    <link href="resources/admin.css" rel="stylesheet">
    <script src="resources/formuser.js"></script>
    <script src="resources/formproject.js"></script>
    <%
        ParseCookie parseCookie = new ParseCookie(request);
        SelectUserInfo selectUserInfo = null;
        if (parseCookie.getPositionIdFromToken() != 0) {
            response.sendRedirect("/index.jsp");
        }
        SelectPosition selectPosition = new SelectPosition();
        SelectAllYourProject selectAllYourProject = null;
        SelectTypeIssue selectTypeIssue = null;
        SelectPriorityIssue selectPriorityIssue = null;
        SelectAllUsers selectAllUsers = null;
        try {
            selectPosition.selectPisition();
            selectUserInfo = new SelectUserInfo();
            selectTypeIssue = new SelectTypeIssue();
            selectPriorityIssue = new SelectPriorityIssue();
            selectAllUsers = new SelectAllUsers();
            selectAllYourProject = new SelectAllYourProject();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        assert selectUserInfo != null;%>
    <title>Admin page - <%=selectUserInfo.selectUserName(parseCookie.getUserIdFromToken())%>
    </title>
</head>
<body id="body" style="overflow:hidden;">
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

<div id="project">
    <div id="popupProject">
        <h2 class="heading_pr">Add project
        </h2>
        <div class="popup-content">
            <form action="http://localhost:8080/addproject" method="post" id="form" name="formus">
                <div class="form-body_pr">
                    <div class="content">
                        <div class="field-group">
                            <label>Name</label>
                            <input type="text" name="nameProject" class="long_in">
                        </div>
                        <div class="field-group">
                            <label>Key Project</label>
                            <input type="text" name="keyProject"/>
                        </div>
                        <div class="field-group">
                            <label>Lead project</label>
                            <select name="leadProject">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="bottom_container">
                    <div class="buttons">

                        <a href="#" onclick="div_hide_pr()">Cancel</a>
                    </div>
                </div>
                <input type="submit" onclick="div_hide_pr()" value="Create"/>
            </form>
        </div>
    </div>
</div>
<div id="user">
    <div id="popupUser">
        <h2 class="heading_us">Add user
        </h2>
        <div class="popup-content">
            <form action="/adduser" method="post" id="formus" name="formus">
                <div class="form-body_us">
                    <div class="content">
                        <div class="field-group">
                            <label>Position</label>
                            <select name="position">
                                <%
                                    for (int i = 0; i < selectPosition.getUserPositionsArraylist().size(); i++) {
                                        String name = selectPosition.getUserPositionsArraylist().get(i).getName();
                                %>
                                <option value="<%=name%>">
                                    <%=name%>
                                </option>
                                <%}%>
                            </select>

                        </div>
                        <div class="field-group">
                            <label>Login</label>
                            <input type="text" name="login">
                        </div>
                        <div class="field-group">
                            <label>Password</label>
                            <input type="password" name="password"/>
                        </div>
                        <div class="field-group">
                            <label>Verify password</label>
                            <input type="password" name="passwordv"/>
                        </div>
                        <div class="field-group">
                            <label>Email</label>
                            <input type="email" name="email"/>
                        </div>
                        <div class="field-group">
                            <label>Firstname</label>
                            <input type="text" name="fname"/>
                        </div>
                        <div class="field-group">
                            <label>Lastname</label>
                            <input type="text" name="lname"/>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="bottom_container">
            <div class="buttons">
                <input type="submit" onclick="div_hide_us()" value="Create"/>
                <a href="#" onclick="div_hide_us()">Cancel</a>
            </div>
        </div>

        </form>
    </div>
</div>
<div>
    <a href="#" id="create_pr" onclick="div_show_pr()">Add Project</a>
    </br>
    <a href="#" id="create_us" onclick="div_show_us()">Add user</a>

</div>


<div id="issue">
    <div id="popupIssue">
        <h2 class="heading_is">Creare Issue
        </h2>
        <div class="popup-content">
            <form action="/createissue" method="post" id="form" name="form">

                <div class="form-body">
                    <div class="setting_pr">
                        <div class="field-group">
                            <label>Project*</label>
                            <select name="nameProject">
                                <%
                                    for (int i = 0; i < selectAllYourProject.getProjectArrayList().size(); i++) {
                                        String name = selectAllYourProject.getProjectArrayList().get(i).getNameProject();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                        <div class="field-group">
                            <label>Type issue*</label>
                            <select name="nameTypeIssue">
                                <%
                                    for (int i = 0; i < selectTypeIssue.getTypeIssueArrayList().size(); i++) {
                                        String name = selectTypeIssue.getTypeIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="content">
                        <div class="field-group">
                            <label>Title*</label>
                            <input type="text" name="title_issue" class="long_in"/>
                        </div>
                        <div class="field-group">
                            <label>Severity*</label>
                            <select name="namePriority">
                                <%
                                    for (int i = 0; i < selectPriorityIssue.getPriorityIssueArrayList().size(); i++) {
                                        String name = selectPriorityIssue.getPriorityIssueArrayList().get(i).getName();
                                %>
                                <option value="<%=name%>"><%=name%>
                                </option>
                                <% }%>
                            </select>
                        </div>
                        <div class="field-group">
                            <label>Due Date* </label>
                            <input type="date" name="date_issue" size="7"
                                   placeholder="Date create"/>
                        </div>
                        <div class="field-group">
                            <label>Assignee</label>
                            <select class="assignee" name="userAssignee">
                                <%
                                    for (int i = 0; i < selectAllUsers.getUserArrayList().size(); i++) {
                                        String infoUser = selectAllUsers.getUserArrayList().get(i).getFirstname() + " "
                                                + selectAllUsers.getUserArrayList().get(i).getLastname() + ", "
                                                + selectAllUsers.getUserArrayList().get(i).getEmail();
                                        String email = selectAllUsers.getUserArrayList().get(i).getEmail();
                                %>
                                <option value="<%=email%>"><%=infoUser%>
                                </option>
                                <%} %>
                            </select>
                        </div>
                        <div class="field-group">
                            <label>Environment</label>
                            <textarea class="env_text" name="environment_issue"></textarea>
                        </div>
                        <div class="field-group">
                            <label>Description*</label>
                            <textarea class="desc_text" name="description_issue"></textarea>
                        </div>
                    </div>
                </div>
                <div class="bottom_container">
                    <div class="buttons">
                        <input type="submit" onclick="div_hide()" value="Create"/>
                        <a href="#" onclick="div_hide()">Cancel</a>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>
</body>
</html>
