<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><tiles:insertAttribute name="title" ignore="true" /></title>
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.css" />" />
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css" />" />
    </head>
    <body>
        <div id="header" class="container">
            <div class="row">
                <tiles:insertAttribute name="header" />
                <tiles:insertAttribute name="menu" />
            </div>
        </div>
        <hr>
        <div id="breadcrumb" class="container">
            <tiles:insertAttribute name="breadcrumb" />
        </div>
        <div id="content" class="container">
            <tiles:insertAttribute name="content" />
        </div>
        <hr>
        <footer id="footer">
            <tiles:insertAttribute name="footer" />
        </footer>
    </body>
</html>