<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log in</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" />
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
                        <a href="${contextPath}/about-project" class="btn btn-default">About project</a>
                    </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="container">
            <h2>Log in</h2>
            <form:form action="login" modelAttribute="login" cssClass="form-horizontal" id="log-in-form">
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
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default">Log in</button>
                    </div>
                </div>
            </form:form>
        </div>
    </body>
</html>
