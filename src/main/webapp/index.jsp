<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Index</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
</head>
<body>
<div class="jumbotron text-center">
    <h1 class="form-signin-heading">Bug tracking system</h1>
    <p>Great Bug tracking system</p>
</div>
<div class="container">
    <br/>
    <br/>
    <form class="form-signin" action="/index" method="post">
        <input style="text-align: center"
               class="form-control" size="9" type="text" name="login" placeholder="login"/>
        <br>
        <input style="text-align: center" class="form-control" size="9" type="password" name="password"
               placeholder="password"/>
        <br/>
        <button class="btn btn-lg btn-primary btn-block" type="submit" name="btnLogin">Log in</button>
    </form>
</div>
</body>
</html>