<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Spring Boot - Hibernate</title>
</head>
<body>
<a th:href="@{/test/user}">List Customer</a><br />
<h1>Edit Customer:</h1>
<form th:action="@{/updateUser}" method="GET" th:object="${user}">
    Id: <input th:field="*{id}" readonly="true" /> <br/> <br/>
    Name: <input th:field="${user.name}"/> <br/> <br/>
    Address: <input th:field="${user.password}"/> <br/> <br/>
    <input type="submit" value="Submit" />
</form>
</body>
</html>