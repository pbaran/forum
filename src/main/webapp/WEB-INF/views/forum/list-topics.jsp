<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${topicList.iterator().next().category.name}</title>
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
                <li class="active"><small>${topicList.iterator().next().category.name} category</small></li>
            </ol>
        </div>
        <div class="container">
            <h2>Forum: <span>${topicList.iterator().next().category.name}</span></h2>
            <p><small>${topicList.iterator().next().category.description}</small></p>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Started by</th>
                        <th>Replies</th>
                        <th>Last post by</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${topicList}">
                        <tr>
                            <td><p><a href="${contextPath}/topic/${t.titleSeo}">${t.title}</a></p></td>
                            <td><p><a href="${contextPath}/user/profile/${t.author.login}">${t.author.login}</a></p></td>
                            <td><p>${t.posts}</p></td>
                            <td>
                                <p>
                                    <small>
                                        <c:choose>
                                            <c:when test="${empty t.lastPost}">
                                                <fmt:formatDate value="${t.startDate}" pattern="dd/MM/yyyy HH:mm"/>, <a href="${contextPath}/user/profile/${t.author.login}">${t.author.login}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatDate value="${t.lastPost}" pattern="dd/MM/yyyy HH:mm"/>, <a href="${contextPath}/user/profile/${t.lastPoster.login}">${t.lastPoster.login}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </small>
                                </p>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <hr>
        <footer>
            <div class="container">
                <p class="text-right"><small>©2014 <a href="https://github.com/piecia">Piotr Baran</a> - <a href="https://github.com/piecia/forum">Code</a></small></p>
            </div>
        </footer>
    </body>
</html>
