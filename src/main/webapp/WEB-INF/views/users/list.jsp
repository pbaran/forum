<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Lista użytkowników</h1>
        <c:forEach var="c" items="${userList}">
            <p>${c.login}</p>
        </c:forEach>
    </body>
</html>
