<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up</title>
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
            <h2>Sign up</h2>
            <form:form action="signup" modelAttribute="account" cssClass="form-horizontal" id="sign-up-form">
                <div class="form-group">
                    <label for="inputLogin" class="col-sm-2 control-label">Login</label>
                    <div class="col-sm-3">
                        <form:input path="login" type="text" cssClass="form-control" id="inputLogin" placeholder="Login" />
                        <form:errors path="login">
                            <div class="alert alert-danger"><form:errors path="login" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-3">
                        <form:input path="password" type="password" cssClass="form-control" id="inputPassword" placeholder="Password" />
                        <form:errors path="password">
                            <div class="alert alert-danger"><form:errors path="password" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-3">
                        <form:input path="email" type="email" cssClass="form-control" id="inputEmail" placeholder="Email" />
                        <form:errors path="email">
                            <div class="alert alert-danger"><form:errors path="email" htmlEscape="false" /></div>
                        </form:errors>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-2">
                        <div class="checkbox">
                            <label>
                                <form:checkbox id="acceptTerms" path="acceptTerms" /> I accept the terms of use
                            </label>
                            <form:errors path="acceptTerms">
                                <div class="alert alert-danger"><form:errors path="acceptTerms" htmlEscape="false" /></div>
                            </form:errors>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default">Sign up</button>
                    </div>
                </div>
            </form:form>
        </div>
        <hr>
        <footer>
            <div class="container">
                <p class="text-right"><small>©2014 <a href="https://github.com/piecia">Piotr Baran</a> - <a href="https://github.com/piecia/forum">Code</a></small></p>
            </div>
        </footer>
    </body>
</html>
