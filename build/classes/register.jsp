<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<h1>User Registration</h1>
<form action="register" method="post">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br>

    <label for="fullName">Full Name:</label>
    <input type="text" id="fullName" name="fullName" required><br>

    <label for="address">Address:</label>
    <textarea id="address" name="address" required></textarea><br>

    <label for="nic">NIC:</label>
    <input type="text" id="nic" name="nic" required><br>

    <label for="phoneNumber">Phone Number:</label>
    <input type="text" id="phoneNumber" name="phoneNumber" required><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email"><br>

    <button type="submit">Register</button>
</form>

<p><a href="login.jsp">Already have an account? Log in here.</a></p>
</body>
</html>
