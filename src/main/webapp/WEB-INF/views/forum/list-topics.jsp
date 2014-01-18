<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Name Category</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <h1><a href="../">Forum</a></h1>
                    <p class="lead">discussion on any topic</p>
                </div>
                <div class="col-lg-4 panel-body">
                    <div class="btn-group">
                        <a href="./users/new" class="btn btn-default">Sign up</a>
                        <a href="/" class="btn btn-default">Log in</a>
                        <a href="/" class="btn btn-default">About project</a>
                      </div>
                </div>
            </div>
        </div>
        <hr>
        <div class="container">
            <ol class="breadcrumb">
                <li><small><a href="../">Home</a></small></li>
                <li class="active"><small>Name Category</small></li>
            </ol>
        </div>
        <div class="container">
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
                            <td><p>${t.title}</p></td>
                            <td><p> username(${t.authorId})</p></td>
                            <td><p>${t.posts}</p></td>
                            <td><p>>> date, username(${t.lastPosterId})</p></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
