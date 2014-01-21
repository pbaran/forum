<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
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
                <div class="col-lg-7">
                    <h1><a href="${contextPath}">Forum</a></h1>
                    <p class="lead">discussion on any topic</p>
                </div>
                <div class="col-lg-5 panel-body">
                    <div class="btn-group panel-right">
                        <security:authorize access="hasAnyRole('USER','ADMIN')">
                            <ul class="nav nav-pills">
                                <li class="active"><a href="${contextPath}/user/profile"><span class="glyphicon glyphicon-info-sign"></span> Profile</a></li>
                                <li class="active"><a href="${contextPath}/user/settings"><span class="glyphicon glyphicon-briefcase"></span> Settings</a></li>
                                <li class="active"><a href="${contextPath}/user/messages"><span class="glyphicon glyphicon-envelope"></span> Messages<span class="badge">3</span></a></li>
                                <li><a href="<c:url value="j_spring_security_logout" />"><span class="glyphicon glyphicon glyphicon-off"></span></a></li>
                            </ul>
                        </security:authorize>
                        <security:authorize access="isAnonymous()">
                            <a href="${contextPath}/signup" class="btn btn-default">Sign up</a>
                            <a href="${contextPath}/login" class="btn btn-default">Log in</a>
                            <a href="${contextPath}/about-project" class="btn btn-default">About project</a>
                        </security:authorize>
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
        <hr>
        <footer>
            <div class="container">
                <p class="text-right"><small>©2014 <a href="https://github.com/piecia">Piotr Baran</a> - <a href="https://github.com/piecia/forum">Code</a></small></p>
            </div>
        </footer>
    </body>
</html>
