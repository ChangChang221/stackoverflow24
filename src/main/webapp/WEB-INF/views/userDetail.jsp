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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/ask_question.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/user.css" />
    <!-- Bootstrap CSS -->
</head>
<body>
<%@include file="layout/header.jsp"%>
<main class="main-container">
    <%@include file="layout/sidebar.jsp"%>
    <div class="content-container">
        <div class="user-heading-container">
            <div>
                <a class="menu-user-active" href="#">Profile</a>
                <a class="menu-user" href="#">Activity</a>
                <c:if test="${statusEdit}">
                    <a class="menu-user" href="/users/edit/${userDetail.id}">Edit profile</a>
                </c:if>
            </div>
            <div>
            <span>
              <img width="16px" height="16px" src="${pageContext.request.contextPath}/asset/tag.webp" />
              <a href="#">Meta User</a>
            </span>
                <span>
              <img width="16px" height="16px" src="${pageContext.request.contextPath}/asset/stackexchange.png" />
              <a href="https://stackexchange.com/">Network profiles</a>
            </span>
            </div>
        </div>
        <div class="user-profiles-container">
            <div class="user-main-profiles">
                <div class="user-avatar">
                    <div>
                        <img
                                width="164px"
                                height="164px"
                                src="${userDetail.photo}"
                        />
                        <div
                                style="
                    margin-top: 15px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                  "
                        >
                  <span
                          style="color: #0c0d0e; font-size: 18px; font-weight: 500"
                  >${userDetail.reputationScore}</span
                  >
                            <span
                                    style="font-size: 12px; color: #6a737c; margin-left: 5px"
                            >REPUTATION</span
                            >
                        </div>
                        <div class="user-challenge">
                            <div>
                    <span class="dot" style="background: #f1b600"></span
                    ><span>16</span>
                            </div>
                            <div>
                    <span class="dot" style="background-color: #9a9c9f"></span
                    ><span>95</span>
                            </div>
                            <div>
                    <span class="dot" style="background-color: #ab825f"></span
                    ><span>139</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="user-description">

                    <h2>
                        ${userDetail.name}
                        <%--                        <a href="#"--%>
                        <%--                        >top <span style="font-weight: 600">0.01%</span> this year</a--%>
                        <%--                        >--%>
                    </h2>
                    <div class="editor">

                    </div>
                    <%--                    <p>Open for R freelance work.</p>--%>
                    <%--                    <p>Contact - shahronak47@yahoo.in</p>--%>
                    <%--                    <br />--%>
                    <%--                    <p>--%>
                    <%--                        If my answers helped you can <a href="#">buy me a coffee.</a>--%>
                    <%--                    </p>--%>
                </div>
            </div>
            <div class="user-more-profiles">
                <div class="user-more-challenge">
                    <div>
                        <h3>${userDetail.answers}</h3>
                        <p>answers</p>
                    </div>
                    <div>
                        <h3>${userDetail.questions}</h3>
                        <p>questions</p>
                    </div>
                    <div>
                        <h3>~4.5M</h3>
                        <p>people reached</p>
                    </div>
                </div>
                <div class="user-more-social">
                    <table>
                        <tbody>
                        <c:choose>
                            <c:when test="${ userDetail.location != null }">
                                <tr>
                                    <td>
                                        <svg
                                                aria-hidden="true"
                                                class="svg-icon iconLocation"
                                                width="18"
                                                height="18"
                                                viewBox="0 0 18 18"
                                        >
                                            <path
                                                    d="M2 6.38C2 9.91 8.1 17.7 8.1 17.7c.22.29.58.29.8 0 0 0 6.1-7.8 6.1-11.32A6.44 6.44 0 008.5 0 6.44 6.44 0 002 6.38zm9.25.12a2.75 2.75 0 11-5.5 0 2.75 2.75 0 015.5 0z"
                                            ></path>
                                        </svg>
                                    </td>
                                    <td>
                      <span>
                              ${userDetail.location}
                      </span>
                                    </td>
                                </tr>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${ userDetail.social != null }">
                                <tr>
                                    <td>
                                        <svg
                                                aria-hidden="true"
                                                class="svg-icon iconTwitter"
                                                width="18"
                                                height="18"
                                                viewBox="0 0 18 18"
                                        >
                                            <path
                                                    d="M17 4.04c-.59.26-1.22.44-1.88.52a3.3 3.3 0 001.44-1.82c-.64.37-1.34.64-2.09.79a3.28 3.28 0 00-5.6 2.99A9.3 9.3 0 012.12 3.1a3.28 3.28 0 001.02 4.38 3.28 3.28 0 01-1.49-.4v.03a3.29 3.29 0 002.64 3.22 3.34 3.34 0 01-1.48.06 3.29 3.29 0 003.07 2.28 6.58 6.58 0 01-4.85 1.36 9.33 9.33 0 005.04 1.47c6.04 0 9.34-5 9.34-9.33v-.42a6.63 6.63 0 001.63-1.7L17 4.04z"
                                                    fill="#2AA3EF"
                                            ></path>
                                        </svg>
                                    </td>
                                    <td><a href="${userDetail.social}">${userDetail.social}</a></td>
                                </tr>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${userDetail.link != null}">
                                <tr>
                                    <td>
                                        <svg
                                                aria-hidden="true"
                                                class="svg-icon iconGitHub"
                                                width="18"
                                                height="18"
                                                viewBox="0 0 18 18"
                                        >
                                            <path
                                                    d="M9 1a8 8 0 00-2.53 15.59c.4.07.55-.17.55-.38l-.01-1.49c-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82a7.42 7.42 0 014 0c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48l-.01 2.2c0 .21.15.46.55.38A8.01 8.01 0 009 1z"
                                                    fill="#010101"
                                            ></path>
                                        </svg>
                                    </td>
                                    <td>
                                        <a href="${userDetail.link}">${userDetail.link}</a>
                                    </td>
                                </tr>
                            </c:when>
                            <c:when test="${userDetail.website != null}">
                                <tr>
                                    <td>
                                        <div class="grid--cell fc-black-350">
                                            <svg
                                                    aria-hidden="true"
                                                    class="svg-icon iconLink"
                                                    width="18"
                                                    height="18"
                                                    viewBox="0 0 18 18"
                                            >
                                                <path
                                                        d="M7.22 11.83a6 6 0 001.62.85l.61-1.8a4.1 4.1 0 114.04-.8l1.26 1.42a6 6 0 10-7.53.33zm3.43-5.6a6 6 0 00-1.6-.87L8.4 7.15a4.1 4.1 0 11-4.05.73L3.12 6.43a6 6 0 107.53-.2z"
                                                ></path>
                                            </svg>
                                        </div>
                                    </td>
                                    <td><a href="${userDetail.website}">${userDetail.website}</a></td>
                                </tr>
                            </c:when>
                            <c:when test="${ 1 == 1 }">
                                <tr>
                                    <td>
                                        <svg
                                                aria-hidden="true"
                                                class="svg-icon iconHistory"
                                                width="19"
                                                height="18"
                                                viewBox="0 0 19 18"
                                        >
                                            <path
                                                    d="M3 9a8 8 0 113.73 6.77L8.2 14.3A6 6 0 105 9l3.01-.01-4 4-4-4h3L3 9zm7-4h1.01L11 9.36l3.22 2.1-.6.93L10 10V5z"
                                            ></path>
                                        </svg>
                                    </td>
                                    <td>
                                        <span> Member for <span>${userDetail.createdOn}</span> </span>
                                    </td>
                                </tr>
                            </c:when>
                            <c:when test="${userDetail.views != null}">
                                <tr>
                                    <td>
                                        <svg
                                                aria-hidden="true"
                                                class="svg-icon iconEye"
                                                width="18"
                                                height="18"
                                                viewBox="0 0 18 18"
                                        >
                                            <path
                                                    d="M9.06 3C4 3 1 9 1 9s3 6 8.06 6C14 15 17 9 17 9s-3-6-7.94-6zM9 13a4 4 0 110-8 4 4 0 010 8zm0-2a2 2 0 002-2 2 2 0 00-2-2 2 2 0 00-2 2 2 2 0 002 2z"
                                            ></path>
                                        </svg>
                                    </td>
                                    <td><span>${userDetail.views} profile views</span></td>
                                </tr>
                            </c:when>
                        </c:choose>
                        <tr>
                            <td>
                                <svg
                                        aria-hidden="true"
                                        class="svg-icon iconClock"
                                        width="18"
                                        height="18"
                                        viewBox="0 0 18 18"
                                >
                                    <path
                                            d="M9 17c-4.36 0-8-3.64-8-8 0-4.36 3.64-8 8-8 4.36 0 8 3.64 8 8 0 4.36-3.64 8-8 8zm0-2c3.27 0 6-2.73 6-6s-2.73-6-6-6-6 2.73-6 6 2.73 6 6 6zM8 5h1.01L9 9.36l3.22 2.1-.6.93L8 10V5z"
                                    ></path>
                                </svg>
                            </td>
                            <td>
                                <span>Last seen <span>3 hours ago</span></span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div>
            <div
                    class="d-flex justify-content-between align-items-center"
                    style="margin-top: 30px"
            >
                <h4>Top posts <span>( ${total} )</span></h4>
                <div class="d-flex justify-content-between">
                    <ul class="filter-questions-list">
                        <li class="tab">
                            <a href="?" style="color: #3c4146">All</a>
                        </li>
                        <li class="tab"><a href="?tab=questions">Questions</a></li>
                        <li class="tab"><a href="?tab=answers">Answers</a></li>
                    </ul>
                    <%--                    <ul class="filter-questions-list" style="margin-right: 0px">--%>
                    <%--                        <li class="tab">--%>
                    <%--                            <a style="color: #3c4146">Votes</a>--%>
                    <%--                        </li>--%>
                    <%--                        <li class="tab"><a>Newest</a></li>--%>
                    <%--                    </ul>--%>
                </div>
            </div>
            <div>
                <c:forEach var="question" items="${questions}">
                    <div
                            class="d-flex justify-content-between user-my-question-container"
                    >
                        <div class="user-my-question">
                            <svg width="18" height="18" viewBox="0 -2 512 512" xmlns="http://www.w3.org/2000/svg">
                                <path d="m32 0h384c17.671875 0 32 14.328125 32 32v288c0 17.671875-14.328125 32-32 32h-384c-17.671875 0-32-14.328125-32-32v-288c0-17.671875 14.328125-32 32-32zm0 0"
                                      fill="#448aff"/>
                                <path d="m416 508.878906-148.59375-92.878906h-171.40625c-17.671875 0-32-14.328125-32-32v-288c0-17.671875 14.328125-32 32-32h384c17.671875 0 32 14.328125 32 32v288c0 17.671875-14.328125 32-32 32h-64zm0 0"
                                      fill="#82b1ff"/>
                                <g fill="#fff">
                                    <path d="m304 288h-32v-64h16c17.671875 0 32-14.328125 32-32s-14.328125-32-32-32-32 14.328125-32 32h-32c0-33.257812 25.476562-60.976562 58.617188-63.773438 33.140624-2.796874 62.902343 20.253907 68.476562 53.042969 5.578125 32.789063-14.890625 64.382813-47.09375 72.699219zm0 0"/>
                                    <path d="m272 320h32v32h-32zm0 0"/>
                                    <path d="m128 160h-32v-64h64v32h-32zm0 0"/>
                                    <path d="m480 384h-64v-32h32v-32h32zm0 0"/>
                                </g>
                            </svg>
                            <a href="${pageContext.request.contextPath}/questions/detail/${question.id}">
                                    ${question.title}
                            </a>
                        </div>
                        <div class="user-my-question-timestamp">${question.createdOn}</div>
                    </div>
                </c:forEach>
                <c:forEach var="_answer" items="${answers}">
                    <div
                            class="d-flex justify-content-between user-my-question-container"
                    >
                        <div class="user-my-question">
                            <svg
                                    aria-hidden="true"
                                    class="svg-icon iconAnswer"
                                    width="18"
                                    height="18"
                                    viewBox="0 0 18 18"
                                    style="fill: #5eba7d"
                            >
                                <path
                                        d="M14 14H3c-1.09 0-2-.91-2-2V3c0-1.1.9-2 2-2h12c1.09 0 2 .91 2 2v14l-3-3zm-1.02-3L9.82 3H8.14l-3.06 8h1.68l.65-1.79h3.15l.69 1.79h1.73zm-2.93-3.12H7.9l1.06-2.92 1.09 2.92z"
                                ></path>
                            </svg>
                            <a href="${pageContext.request.contextPath}/questions/detail/${_answer.id}">
                                    ${_answer.title}
                            </a>
                        </div>
                        <div class="user-my-question-timestamp">${_answer.createdOn}</div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</main>

<script src="${pageContext.request.contextPath}/js/active_tab.js"></script>

<%@include file="layout/footer.jsp"%>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
</body>
</html>
