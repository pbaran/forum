<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administration panel - Edit category</title>
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
                <li><small><a href="${contextPath}/admin">Administration panel</a></small></li>
                <li><small><a href="${contextPath}/admin/manage/category">Manage categories</a></small></li>
                <li class="active"><small>Edit category</small></li>
            </ol>
        </div>
        <div class="container">
            <h3>Edit category</h3>
            <form:form method="post" modelAttribute="categoryForm">
                <div class="form-group">
                    <label for="name">Name</label>
                    <form:hidden path="id" cssClass="form-control" />
                    <form:input path="name" cssClass="form-control" />
                    <form:errors path="name">
                        <div class="alert alert-danger"><form:errors path="name" htmlEscape="false" /></div>
                    </form:errors>
                </div>
                <div class="form-group">
                    <label for="nameSeo">Friendly URL</label>
                    <form:input path="nameSeo" cssClass="form-control" />
                    <form:errors path="nameSeo">
                        <div class="alert alert-danger"><form:errors path="nameSeo" htmlEscape="false" /></div>
                    </form:errors>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <form:textarea path="description" cssClass="form-control" />
                    <form:errors path="description">
                        <div class="alert alert-danger"><form:errors path="description" htmlEscape="false" /></div>
                    </form:errors>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-default">Submit</button>
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
