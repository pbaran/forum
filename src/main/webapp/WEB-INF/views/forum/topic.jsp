<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${topic.title} :: ${topic.category.name}</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" />
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <h1><a href="${contextPath}">Forum</a></h1>
                    <p class="lead">discussion on any topic</p>
                </div>
                <div class="col-lg-4 panel-body">
                    <div class="btn-group">
                        <a href="${contextPath}/signup" class="btn btn-default">Sign up</a>
                        <a href="${contextPath}/login" class="btn btn-default">Log in</a>
                        <a href="${contextPath}/about-project" class="btn btn-default">About project</a>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="container">
            <ol class="breadcrumb">
                <li><small><a href="${contextPath}">Home</a></small></li>
                <li><small><a href="${contextPath}/category/${topic.category.id}">${topic.category.name} category</a></small></li>
                <li class="active"><small>${topic.title}</small></li>
            </ol>
        </div>
        <div class="container">
            <h2>Thread: <span>${topic.title}</span></h2>
            <p class="text-right text-info"><small><a href="${contextPath}/user/profile/${topic.author.login}">${topic.author.login}</a>, <fmt:formatDate value="${topic.startDate}" pattern="dd/MM/yyyy HH:mm"/></small></p>
            <div class="well well-sm">
                ${topic.description}
            </div>

            <c:forEach var="p" items="${postsList}">
                <p class="text-right text-info"><small><a href="${contextPath}/user/profile/${p.author.login}">${p.author.login}</a>, <fmt:formatDate value="${p.postDate}" pattern="dd/MM/yyyy HH:mm"/></small></p>
                <div class="well well-sm">
                    ${p.content}
                </div>
            </c:forEach>
            
        </div>
    </body>
</html>
