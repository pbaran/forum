<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="c" items="${categoryList}">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title"><a href="${contextPath}/category/${c.id}">${c.name}</a></h3>
            </div>
            <div class="panel-body">
                <div class="col-lg-8"><small>${c.description}</small></div>
                <div class="col-lg-2">
                    <p>Threads: ${c.topics}</p>
                    <p>Posts: ${c.posts}</p>
                </div>
                <div class="col-lg-2">
                    <p>
                        <c:choose>
                            <c:when test="${c.lastActiveTopic != '-1'}">
                                <a href="./" title="last topic in category ${c.name}">${c.lastActiveTopic}</a>
                            </c:when>
                            <c:otherwise>
                                no posts
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>
        </div>
</c:forEach>
