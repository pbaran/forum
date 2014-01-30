<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administration panel</title>
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
                        <ul class="nav nav-pills">
                            <li class="active"><a href="${contextPath}/admin/manage/category"> Categories</a></li>
                            <li class="active"><a href="${contextPath}/admin/manage/user"> Users</a></li>
                            <li><a href="${contextPath}/j_spring_security_logout"><span class="glyphicon glyphicon glyphicon-off"></span></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="container">
            <ol class="breadcrumb">
                <li><small><a href="${contextPath}">Home</a></small></li>
                <li class="active"><small>Administration panel</small></li>
            </ol>
        </div>
        <div class="container">
            <h2>Adminsitration panel</h2>
            <p>You can manage categories and users. The following list of links:</p>
            <ul>
                <li><a href="${contextPath}/admin/manage/category"> manage categories</a></li>
                <li><a href="${contextPath}/admin/manage/user"> manage users</a></li>
            </ul>
        </div>
        <hr>
        <footer>
            <div class="container">
                <p class="text-right"><small>©2014 <a href="https://github.com/piecia">Piotr Baran</a> - <a href="https://github.com/piecia/forum">Code</a></small></p>
            </div>
        </footer>
    </body>
</html>
