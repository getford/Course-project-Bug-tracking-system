<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create issue</title>
</head>
<body>
<h1>Create issue</h1>
<form action="/createissue" method="post">
    <p>Project* <select name="nameProject">
        <option>test</option>
        <option>test1</option>
    </select></p>
    <p>Type issue* <select name="nameTypeIssue">
        <option>Bug</option>
        <option>Task</option>
        <option>Improvement</option>
        <option>New Feature</option>
    </select>
    </p>
    <p>Priority* <select name="namePriority">
        <option>Blocker</option>
        <option>Critical</option>
        <option>Major</option>
        <option>Minor</option>
        <option>Trivial</option>
    </select>
    </p>
    <p>User assignee*<select name="userAssigne">

    </select>
    </p>
    <p>Title* <input type="text" name="title_in" size="7" placeholder="Title"/></p>
    <p>Due Date* <input type="date" name="date_in" size="7" placeholder="Date create"/></p>
    <p>Description* <input type="text" name="desctiption_in" size="7" placeholder="Description"/></p>
    <p>Enviroment* <input type="text" name="enciroment_in" size="7" placeholder="Enviroment"/></p>
    <hr>
    <input type="submit" title="Create">
</form>
</body>
</html>
