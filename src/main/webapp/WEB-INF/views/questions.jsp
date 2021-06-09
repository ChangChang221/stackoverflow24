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
            <span style="font-size: 24px">All Questions</span>
            <button
                    class="btn-primary"
                    style="font-weight: normal; font-size: 14px"
                    onclick="location.href='/questions/askQuestion';"
            >
                Ask Question
            </button>
        </div>
        <div id="question-filter">
            <div>
                <span>${total} questions </span>
                <div>
                    <ul style="margin-right: 0px" class="filter-questions-list">
                        <li class="tab"><a href="${pageContext.request.contextPath}?tab=newest">Newest</a>
                        </li>
                        <li class="tab">
                            <a href="${pageContext.request.contextPath}?tab=trend" style="color: #3c4146">Trend</a>
                        </li>
                        <li class="tab"><a href="${pageContext.request.contextPath}?tab=week">Week</a></li>
                        <li
                                style="
                  border-top-right-radius: 5px;
                  border-bottom-right-radius: 5px;
                "
                                class="tab"
                        >
                            <a href="${pageContext.request.contextPath}?tab=month">Month</a>
                        </li>
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
<%--                                            src="https://www.gravatar.com/avatar/9d380711c6cdebb4864551fdb7d566ad?s=32&d=identicon&r=PG&f=1"--%>
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
                    <a href="${pageContext.request.contextPath}?page=${page - 1}&tab=${tab}">Prev</a>
                </c:if>
                <c:if test="${page == (i+1) && i != endPagination}">
                    <a href="${pageContext.request.contextPath}?page=${i+1}&tab=${tab}" class="active">${i+1}</a>
                </c:if>
                <c:if test="${page != (i+1) && i != endPagination}">
                    <a href="${pageContext.request.contextPath}?page=${i+1}&tab=${tab}">${i+1}</a>
                </c:if>
                <c:if test="${page != pagination && i == endPagination}">
                    <a href="${pageContext.request.contextPath}?page=${page + 1}&tab=${tab}">Next</a>
                </c:if>
            </c:forEach>

        </div>
    </div>

</main>
<script src="${pageContext.request.contextPath}/js/active_tab.js"></script>
<script src="${pageContext.request.contextPath}/js/time.js"></script>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
</body>
<%@include file="layout/footer.jsp"%>

</html>
