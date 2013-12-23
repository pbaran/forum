<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" />
    </head>
    <body>
        <h1>Sign up</h1>
        <form:form action="." modelAttribute="account" cssClass="form-horizontal" id="sign-up-form">
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
        </form>
        </form:form>

    </body>
</html>
