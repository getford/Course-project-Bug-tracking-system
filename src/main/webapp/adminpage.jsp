<%@ page import="userpage.ParseCookie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin page</title>
    <%
        ParseCookie parseCookie = new ParseCookie(request);
        if (parseCookie.getPositionIdFromToken() != 0) {
            response.sendRedirect("/index.jsp");
        }
    %>

    <link href="resources/admin.css" rel="stylesheet">
    <script src="resources/formuser.js"></script>
    <script src="resources/formproject.js"></script>

</head>
<body>
<body id="body" style="overflow:hidden;">

<p>
    Hello,
    <b><%=parseCookie.getLoginFromToken()%>
    </b>
</p>
<div id="project">
    <div id="popupProject">
        <h2 class="heading_pr">Add project
        </h2>
        <div class="popup-content">
            <form action="/createproject" method="post" id="form" name="formus">
                <div class="form-body_pr">
                    <div class="content">
                        <div class="field-group">
                            <label>Name</label>
                            <input type="text" name="namePr" class="long_in">
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
            </form>
        </div>
        <div class="bottom_container">
            <div class="buttons">
                <input type="submit" onclick="div_hide_pr()" value="Create"/>
                <a href="#" onclick="div_hide_pr()">Cancel</a>
            </div>
        </div>

        </form>
    </div>
</div>

<div id="user">
    <div id="popupUser">
        <h2 class="heading_us">Add user
        </h2>
        <div class="popup-content">
            <form action="/createuser" method="post" id="formus" name="formus">
                <div class="form-body_us">
                    <div class="content">
                        <div class="field-group">
                            <label>Position</label>
                            <select name="position">
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
                            <input type="password" name="passwordV"/>
                        </div>
                        <div class="field-group">
                            <label>Email</label>
                            <input type="email" name="email"/>
                        </div>
                        <div class="field-group">
                            <label>Firstname</label>
                            <input type="text" name="Fname"/>
                        </div>
                        <div class="field-group">
                            <label>Lastname</label>
                            <input type="text" name="Lname"/>
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

<p>
    <a href="">Log out</a>
</p>
</body>
</body>
</html>
