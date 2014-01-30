<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings</title>
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
                                <li><a href="${contextPath}/j_spring_security_logout"><span class="glyphicon glyphicon glyphicon-off"></span></a></li>
                            </ul>
                        </security:authorize>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="container">
            <ol class="breadcrumb">
                <li><small><a href="${contextPath}">Home</a></small></li>
                <li><small><a href="${contextPath}/user/profile/${user.login}">Profile</a></small></li>
                <li class="active"><small>Settings</small></li>
            </ol>
        </div>
        <div class="container">
            <security:authorize access="hasAnyRole('USER','ADMIN')">
                <h2>Settings</h2>
                <form:form method="post" modelAttribute="settingsForm">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <form:hidden path="id" cssClass="form-control" />
                        <form:input path="name" cssClass="form-control" />
                        <form:errors path="name">
                            <div class="alert alert-danger"><form:errors path="name" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                    <div class="form-group">
                        <label for="surname">Surname</label>
                        <form:input path="surname" cssClass="form-control" />
                        <form:errors path="surname">
                            <div class="alert alert-danger"><form:errors path="surname" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <form:input path="address" cssClass="form-control" />
                        <form:errors path="address">
                            <div class="alert alert-danger"><form:errors path="address" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                    <div class="form-group">
                        <label for="city">City</label>
                        <form:input path="city" cssClass="form-control" />
                        <form:errors path="city">
                            <div class="alert alert-danger"><form:errors path="city" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-default">Submit</button>
                    </div>
                </form:form>
            </security:authorize>
        </div>
        <hr>
        <footer>
            <div class="container">
                <p class="text-right"><small>©2014 <a href="https://github.com/piecia">Piotr Baran</a> - <a href="https://github.com/piecia/forum">Code</a></small></p>
            </div>
        </footer>
    </body>
</html>
