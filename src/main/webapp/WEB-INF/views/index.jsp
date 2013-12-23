<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Strona główna</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
    </head>
    <body>
        <!-- 
        Podlaczyc tilesy - http://viralpatel.net/blogs/spring-3-mvc-tiles-plugin-tutorial-example-eclipse/
        -->
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <h1>Forum dyskusyjne</h1>
                    <p class="lead">Dyskusja na każdy temat</p>
                </div>
                <div class="col-lg-4 panel-body">
                    <div class="btn-group">
                        <a href="./users/new" class="btn btn-default">Zarejestruj się</a>
                        <a href="/" class="btn btn-default">Zaloguj się</a>
                      </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="container">
            <c:forEach var="c" items="${categoryList}">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">${c.name}</h3>
                        </div>
                        <div class="panel-footer">
                            <p>Liczba postów: ${c.posts}</p>
                            <p>Liczba tematów: ${c.topics}</p>
                        </div>
                    </div>
            </c:forEach>
        </div>
    </body>
</html>
