<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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