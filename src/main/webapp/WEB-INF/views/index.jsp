<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" />
    </head>
    <body>
        <!-- 
        Podlaczyc tilesy - http://viralpatel.net/blogs/spring-3-mvc-tiles-plugin-tutorial-example-eclipse/
        -->
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
            </ol>
        </div>
        <div class="container">
            <c:forEach var="c" items="${categoryList}">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title"><a href="${contextPath}/category/${c.id}">${c.name}</a></h3>
                        </div>
                        <div class="panel-body">
                            <div class="col-lg-8"><small>${c.description}</small></div>
                            <div class="col-lg-2">
                                <p>Threads: ${c.topics}</p>
                                <p>Posts: ${c.posts}</p>
                            </div>
                            <div class="col-lg-2">
                                <p>
                                    <c:choose>
                                        <c:when test="${c.lastActiveTopic != '-1'}">
                                            <a href="./" title="last topic in category ${c.name}">${c.lastActiveTopic}</a>
                                        </c:when>
                                        <c:otherwise>
                                            no posts
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
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
