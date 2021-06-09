<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="${bean.date}" pattern="yyyy-MM-dd HH:mm:ss"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/question.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css" />
</head>
<body style="background-color: #fff">
<%@include file="layout/header.jsp"%>
<main class="main-container">
    <%@include file="layout/sidebar.jsp"%>
    <div class="container content-container">
        <div id="questions-heading">
            <span style="font-size: 24px">Search Results</span>
            <button
                    class="btn-primary"
                    style="font-weight: normal; font-size: 14px"
                    onclick="location.href='/questions/askQuestion';"
            >
                Ask Question
            </button>
        </div>
        <div style="margin: 0 0 24px 0;
    font-size: 12px;
    color: #6a737c;
    line-height: 1;">
            <c:choose>
                <c:when test="${tag != null}">
                    <span class="mr2">Results for [tag]: <span>${tag}</span></span>
                </c:when>
                <c:otherwise>
                    <span class="mr2">Results for <span>${query}</span></span>
                </c:otherwise>
            </c:choose>

        </div>
        <div id="question-filter">
            <div>
                <span>${total} result </span>
                <div>
                    <ul class="filter-questions-list">
                        <c:choose>
                            <c:when test="${statusTabRelevance}">
                                <c:if test="${query != null}">
                                    <li class="tab active_tab">
                                        <a style="color: #3c4146" href="${pageContext.request.contextPath}/questions/search?page=${page}&search=${query}&tab=Relevance">Relevance</a>
                                    </li>
                                    <li class="tab"><a href="${pageContext.request.contextPath}/questions/search?page=${page}&search=${query}&tab=Newest">Newest</a></li>
                                </c:if>
                                <c:if test="${tag != null}">
                                    <li class="tab active_tab">
                                        <a style="color: #3c4146" href="${pageContext.request.contextPath}/questions/search?page=${page}&tag=${tag}&tab=Relevance">Relevance</a>
                                    </li>
                                    <li class="tab"><a href="${pageContext.request.contextPath}/questions/search?page=${page}&tag=${tag}&tab=Newest">Newest</a></li>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${query != null}">
                                    <li class="tab"><a href="${pageContext.request.contextPath}/questions/search?page=${page}&search=${query}&tab=Relevance">Relevance</a></li>
                                    <li class="tab active_tab">
                                        <a style="color: #3c4146" href="${pageContext.request.contextPath}/questions/search?page=${page}&search=${query}&tab=Newest">Newest</a>
                                    </li>
                                </c:if>
                                <c:if test="${tag != null}">
                                    <li class="tab"><a href="${pageContext.request.contextPath}/questions/search?page=${page}&tag=${tag}&tab=Relevance">Relevance</a></li>
                                    <li class="tab active_tab">
                                        <a style="color: #3c4146" href="${pageContext.request.contextPath}/questions/search?page=${page}&tag=${tag}&tab=Newest">Newest</a>
                                    </li>
                                </c:if>
                            </c:otherwise>
                        </c:choose>

                        <%--                        <li--%>
                        <%--                                style="--%>
                        <%--                    border-top-right-radius: 5px;--%>
                        <%--                    border-bottom-right-radius: 5px;--%>
                        <%--                  "--%>
                        <%--                        >--%>
                        <%--                            More<img--%>
                        <%--                                src="https://cdn1.iconfinder.com/data/icons/ios-11-ui-elements-vol-1/29/25_dropdown_menu_down_arrow-512.png"--%>
                        <%--                                style="height: 10px; width: 10px"--%>
                        <%--                        />--%>
                        <%--                        </li>--%>
                    </ul>
                </div>
            </div>
        </div>
        <div id="questions">
            <c:forEach var="question" items="${questions}">
                <div class="question">
                    <div class="info-question">
                        <div>
                            <p>${question.answers}</p>
                            <p>answers</p>
                        </div>
                        <div>
                            <p>${question.views}</p>
                            <p >views</p>
                        </div>
                    </div>
                    <div class="content-question" style="margin-left: 10px; width: 100%;">
                        <div>
                            <a href="${pageContext.request.contextPath}/questions/detail/${question.id}">${question.title}</a>
                            <div class="tags-question" style="margin-top: 20px">
                                <c:forEach var="tag" items="${question.tags}">
                                    <a href="/questions/search?tag=${tag}" class="tag">${tag}</a>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="more-info-question">
                            <div class="questioner">
                                <span class="createdOn"> <fmt:formatDate value="${question.createdOn}"
                                                                         pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                <div>
                                    <img
                                            height="32px"
                                            width="32px"
                                            src="${question.user.photo}"
                                    />
                                    <div>
                                        <a href="/users/${question.user.id}">${question.user.name}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
        <div class="pagination">

            <c:forEach begin="${startPagination}" end="${endPagination}" var="i">
                <c:if test="${page != 1 && i == startPagination}">
                    <a href="${pageContext.request.contextPath}?page=${page - 1}">Prev</a>
                </c:if>
                <c:if test="${page == (i+1) && i != endPagination}">
                    <c:if test="${query != null}">
                        <a href="${pageContext.request.contextPath}?page=${i+1}&search=${query}" class="active">${i+1}</a>
                    </c:if>
                    <c:if test="${tag != null}">
                        <a href="${pageContext.request.contextPath}?page=${i+1}&tag=${tag}" class="active">${i+1}</a>
                    </c:if>
                </c:if>
                <c:if test="${page != (i+1) && i != endPagination}">
                    <c:if test="${query != null}">
                        <a href="${pageContext.request.contextPath}?page=${i+1}&search=${query}">${i+1}</a>
                    </c:if>
                    <c:if test="${tag != null}">
                        <a href="${pageContext.request.contextPath}?page=${i+1}&tag=${tag}">${i+1}</a>
                    </c:if>
                </c:if>
                <c:if test="${page != pagination && i == endPagination}">
                    <a href="${pageContext.request.contextPath}?page=${page + 1}">Next</a>
                </c:if>
            </c:forEach>

        </div>
    </div>
</main>
<%@include file="layout/footer.jsp"%>
<script src="${pageContext.request.contextPath}/js/time.js"></script>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
</body>
</html>
