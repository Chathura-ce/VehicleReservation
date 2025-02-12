<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Error Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        .error-box {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            width: 50%;
            margin: auto;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #d9534f;
        }
        p {
            margin: 10px 0;
        }
        .stack-trace {
            font-family: monospace;
            color: #555;
            background-color: #eee;
            padding: 10px;
            border-radius: 5px;
            text-align: left;
            overflow-x: auto;
        }
    </style>
</head>
<body>
<div class="error-box">
    <h1>An Error Occurred</h1>
    <p>Sorry, something went wrong while processing your request.</p>

    <!-- Display detailed error if available (for debugging purposes) -->
    <c:if test="${not empty exception}">
        <h3>Error Details:</h3>
        <div class="stack-trace">
                ${exception.message}<br>
            <c:forEach var="trace" items="${exception.stackTrace}">
                ${trace}<br>
            </c:forEach>
        </div>
    </c:if>

    <p><a href="index.jsp">Return to Home</a></p>
</div>
</body>
</html>
