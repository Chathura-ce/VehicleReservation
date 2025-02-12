<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login..</title>
</head>
<body>
<h1>Login</h1>
<form action="login" method="post">
    <label for="username">Username:</label>
    <input value="admin" type="text" id="username" name="username" required><br>

    <label for="password">Password:</label>
    <input value="123" type="password" id="password" name="password" required><br>
    <p><a href="register.jsp">Don't have an account? Register here.</a></p>

    <button type="submit">Login</button>
</form>

<c:if test="${not empty errorMessage}">
    <p style="color: red;">${errorMessage}</p>
</c:if>
</body>
</html>
