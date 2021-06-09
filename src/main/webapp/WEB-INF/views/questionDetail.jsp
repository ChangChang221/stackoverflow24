<%@ page import="java.util.stream.Collectors" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="${bean.date}" pattern="yyyy-MM-dd HH:mm:ss"/>
<sec:authorize access="hasRole('ROLE_USER')" var="isUser"/>
<sec:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>
<sec:authentication property="principal" var="userCurrent"/>
<%--<sec:authentication property="principal.name" var="user_name"/>--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/sidebar.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/question-detail.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css"/>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css"
    />
    <!-- moment js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <link
            href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
            rel="stylesheet"
    />
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <script src="https://sdk.amazonaws.com/js/aws-sdk-2.888.0.min.js"></script>
    <!-- Bootstrap CSS -->
</head>
<body>
<%@include file="layout/header.jsp" %>
<main class="main-container">
    <%@include file="layout/sidebar.jsp" %>
    <script type="text/javascript">
        const EditQuestion = (questionId) => {
            window.location.href = "/questions/askQuestion?id=" + questionId
        }

        const deleteAnswer = async (answerId) => {
            const response = await fetch("/answer/delete", {
                method: "PUT",
                mode: 'cors', // no-cors, *cors, same-origin
                cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
                credentials: 'same-origin', // include, *same-origin, omit
                headers: {
                    'Content-Type': 'application/json'
                },
                redirect: 'follow', // manual, *follow, error
                referrerPolicy: 'no-referrer',
                body: JSON.stringify({answerId})
            })
            const _response = await response.json();
            console.log("_response", _response)
            if (_response.status == 1) {
                location.reload();
            }
        }
    </script>
    <div class="content-container">
        <div class="question-detail-heading">
            <div class="topic-question-detail-container">
                <a href="#" class="topic-question-detail">
                    ${question.title}
                </a>
                <div style="flex: 1">
                    <button
                            class="btn-primary"
                            style="font-weight: normal; font-size: 14px; float: right"
                            onclick="location.href='/questions/askQuestion';"
                    >
                        Ask Question
                    </button>
                </div>
            </div>
            <div class="more-info-question-detail-container">
                <span>Asked<span class="createdOn">
                    <fmt:formatDate value="${question.createdOn}"
                                    pattern="yyyy-MM-dd HH:mm:ss"/>
                </span></span>
                <span>Active<span>today</span> </span>
                <span>Viewed<span>${question.views} times</span> </span>
            </div>
        </div>
        <div class="content-question-detail-container">
            <div class="first-answer-detail content-question-detail">
                <div class="action-option-question-detail">
                    <svg
                            aria-hidden="true"
                            class="m0 svg-icon iconArrowUpLg"
                            width="36"
                            height="36"
                            viewBox="0 0 36 36"
                    >
                        <path d="M2 26h32L18 10 2 26z"></path>
                    </svg>
                    <div style="color: #6a737c; font-size: 20px;">0</div>
                    <svg
                            aria-hidden="true"
                            class="m0 svg-icon iconArrowDownLg"
                            width="36"
                            height="36"
                            viewBox="0 0 36 36"
                    >
                        <path d="M2 10h32L18 26 2 10z"></path>
                    </svg>
                    <svg
                            aria-hidden="true"
                            class="svg-icon iconBookmark"
                            width="18"
                            height="18"
                            viewBox="0 0 18 18"
                    >
                        <path
                                d="M6 1a2 2 0 00-2 2v14l5-4 5 4V3a2 2 0 00-2-2H6zm3.9 3.83h2.9l-2.35 1.7.9 2.77L9 7.59l-2.35 1.7.9-2.76-2.35-1.7h2.9L9 2.06l.9 2.77z"
                        ></path>
                    </svg>
                    <svg
                            aria-hidden="true"
                            class="mln2 mr0 svg-icon iconHistory"
                            width="19"
                            height="18"
                            viewBox="0 0 19 18"
                    >
                        <path
                                d="M3 9a8 8 0 113.73 6.77L8.2 14.3A6 6 0 105 9l3.01-.01-4 4-4-4h3L3 9zm7-4h1.01L11 9.36l3.22 2.1-.6.93L10 10V5z"
                        ></path>
                    </svg>
                </div>
                <div class="answer-question-detail">
                    <div class="editor" style="margin: 0px -15px">
                        <c:out value="${question.body.replace('contenteditable=\"true\"','contenteditable=\"false\"')}"
                               escapeXml="false"/>
                    </div>
                    <div class="answer-question-tags">
                        <c:forEach var="tag" items="${question.tags}">
                            <a href="/questions/search?tag=${tag}" class="tag">${tag}</a>
                        </c:forEach>
                    </div>
                    <div class="answer-question-footer">
                        <div class="answer-question-footer-action">
                            <a href="#">Share</a>
                            <a href="#">Follow</a>
                            <c:if test="${isUser}">
                                <c:if test="${userCurrent.id == question.userId}">
                                    <span onclick="EditQuestion(`${question.id}` )">Edit</span>
                                </c:if>
                            </c:if>
                        </div>
                        <div class="answer-question-author">
                            <p class="createdOn"><fmt:formatDate value="${question.createdOn}"
                                                                 pattern="yyyy-MM-dd HH:mm:ss"/></p>
                            <div>
                                <img
                                        src="${question.user.photo}"
                                        height="32px"
                                        width="32px"
                                        style="border-radius: 8px"
                                />
                                <div>
                                    <a href="${pageContext.request.contextPath}/users/${question.user.id}">${question.user.name}</a>
                                    <div>
                                        <span style="font-weight: bold;  color: #ff8000">${answer.user.reputationScore}</span>
                                        <span
                                                class="dot"
                                                style="background-color: #6a737c"
                                        ></span>
                                        <span style="font-weight: bold;  color: #6a737c">${answer.user.views}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="answer-info">
                <h3>${answers.size()} Answers</h3>
            </div>
            <c:forEach var="answer" items="${answers}">
                <div class="content-question-detail" id="${answer.id}">
                    <c:if test="${isUser}">
                        <c:set var="votes" value="${answer.votes}"/>
                        <c:set var="status" value="2"/>
                        <c:forEach var="vote" items="${votes}">
                            <div>${vote.userId}</div>
                            <div>${userCurrent.id}</div>
                            <c:if test="${vote.userId eq userCurrent.id}">
                                <c:set var="status" value="${vote.status ? 1 : 0}"/>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <div class="action-option-question-detail">
                        <svg
                                onclick="upVote(`${answer.id}`, true)"
                                aria-hidden="true"
                                class="m0 svg-icon iconArrowUpLg vote"
                                width="36"
                                height="36"
                                viewBox="0 0 36 36"
                                style="fill: ${status == 1 ?  "#1b92f1" : "#bbc0c4"}"
                        >
                            <path d=" M2 26h32L18 10 2 26z
                        "></path>
                        </svg>
                        <div id="${answer.id}"
                             style="color: #6a737c; font-size: 20px;    margin: 5px 0px;">${answer.score}</div>
                        <svg
                                aria-hidden="true"
                                class="m0 svg-icon iconArrowDownLg vote"
                                width="36"
                                height="36"
                                viewBox="0 0 36 36"
                                onclick="upVote(`${answer.id}`, false)"
                                style="fill: ${status == 0 ?  "#1b92f1" : "#bbc0c4"}"
                        >
                            <path d="M2 10h32L18 26 2 10z"></path>
                        </svg>
                        <svg
                                aria-hidden="true"
                                class="svg-icon iconBookmark"
                                width="18"
                                height="18"
                                viewBox="0 0 18 18"
                        >
                            <path
                                    d="M6 1a2 2 0 00-2 2v14l5-4 5 4V3a2 2 0 00-2-2H6zm3.9 3.83h2.9l-2.35 1.7.9 2.77L9 7.59l-2.35 1.7.9-2.76-2.35-1.7h2.9L9 2.06l.9 2.77z"
                            ></path>
                        </svg>
                        <svg
                                aria-hidden="true"
                                class="mln2 mr0 svg-icon iconHistory"
                                width="19"
                                height="18"
                                viewBox="0 0 19 18"
                        >
                            <path
                                    d="M3 9a8 8 0 113.73 6.77L8.2 14.3A6 6 0 105 9l3.01-.01-4 4-4-4h3L3 9zm7-4h1.01L11 9.36l3.22 2.1-.6.93L10 10V5z"
                            ></path>
                        </svg>
                    </div>
                    <div class="answer-question-detail">
                        <div class="editor" style="padding-top: 10px;margin: 0px -15px">
                                ${answer.body.replace('contenteditable="true"', 'contenteditable="false"')}
                        </div>
                        <div class="answer-question-footer">
                            <div class="answer-question-footer-action">
                                <a href="#">Share</a>
                                <a href="#">Follow</a>
                                    <%--                                <c:if test="${status != 2}">--%>
                                    <%--                                        <span onclick="deleteAnswer(`${user.id}`, `${answer.id}`)">Delete</span>--%>
                                    <%--                                </c:if>--%>
                                <c:if test="${isUser}">
                                    <c:if test="${userCurrent.id == answer.userId}">
                                        <span onclick="deleteAnswer(`${answer.id}` )">Delete</span>
                                    </c:if>
                                </c:if>
                                    <%--                                <c:if test="${isUser}">--%>
                                    <%--                                    <c:if test="${user.id == question.userId}">--%>
                                    <%--                                        <span onclick="deleteAnswer(`${user.id}`,`${answer.id}` )">Edit</span>--%>
                                    <%--                                    </c:if>--%>
                                    <%--                                </c:if>--%>
                            </div>
                            <div class="answer-question-author">
                                <p class="createdOn"><fmt:formatDate value="${answer.createdOn}"
                                                                     pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                <div>
                                    <img
                                            src="${answer.user.photo}"
                                            height="32px"
                                            width="32px"
                                            style="border-radius: 8px"
                                    />
                                    <div>
                                        <a href="${pageContext.request.contextPath}/users/${answer.user.id}">${answer.user.name}</a>
                                        <div>
                                            <span style="font-weight: bold;  color: #ff8000">${answer.user.reputationScore}</span>
                                            <span
                                                    class="dot"
                                                    style="background-color: #6a737c"
                                            ></span>
                                            <span style="font-weight: bold;  color: #6a737c">${answer.user.views}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="comment-answer-container" id="`${answer.id}comments">
                            <c:forEach var="comment" items="${answer.comments}">
                                <div class="comment-answer">
                                    <span>${comment.body}</span>
                                    <span>-</span>
                                    <a href="#"> ${comment.name}</a>
                                    <span class="createdOn"><fmt:formatDate value="${comment.createdOn}"
                                                                            pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="add-a-comment" id="${answer.id}addcommentbtn"
                             onclick="addCommentForm(`${answer.id}`)">Add a
                            comment
                        </div>
                        <div class="form-comment" id="${answer.id}form" style="margin-top: 5px">
                            <input id="${answer.id}inputform" class="form-comment-input"
                                   placeholder="Add a comment ..."/>
                            <div style="display: flex; padding-left:25px">
                                <div class="form-comment-btn" onclick="commentbtn(`${answer.id}`)">Comment</div>
                                <div class="form-comment-btn" style="margin-left: 15px;"
                                     onclick="cancelbtn(`${answer.id}`)">Cancel
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="type-answer">
            <h2 style="font-weight: 500">Your Answer</h2>
            <div id="editor"></div>
            <c:choose>
                <c:when test="${isUser || isAdmin}">
                    <button class="btn btn-primary" style="margin-top: 40px" onclick="postAnswer(`${question.id}`)">
                        Post your answer
                    </button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-primary" style="margin-top: 40px" onclick="clickPostAnswerNoLogin()">
                        Post your answer
                    </button>
                </c:otherwise>
            </c:choose>
            <div id="alertSignin" style="display: none; margin-top: 5px">
                <div style="
                    background-color: #ea1f1f;
                    color: #fffcfc;
                    padding: 0px 10px;
                    display: inline-block;
                    border-radius: 5px;
                    transition: all 2s linear
                ">
                    <p>To answer a question, you must either sign up for an account or post as a guest.</p>
                </div>
            </div>
            <div class="note-post-your-answers">
            <span>
              By clicking "Post Your Answer", you agree to our
              <a href="#">terms of service</a>,
              <a href="#"> privacy policy</a> and
              <a>cookie policy</a>
            </span>
            </div>


        </div>
    </div>
</main>
<%@include file="layout/footer.jsp"%>
<script type="text/javascript">
    const upVote = (answerId, status) => {
        if (!${isUser}) {
            window.location.replace("${pageContext.request.contextPath}/users/auth");
        } else {
            // let numberOfVote = document.getElementById(answerId);
            console.log("call api upVote");
            const form = {
                answerId,
                status
            };
            let http = new XMLHttpRequest();
            http.open("PUT", "/answers/upVote", true);
            http.setRequestHeader('Content-type', 'application/json');
            http.setRequestHeader("Access-Control-Allow-Origin", '*');
            http.setRequestHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
            http.onload = function () {
                // do something to response
                console.log(this.responseText);
                const data = JSON.parse(this.responseText);
                console.log("data", data)
                if (data.status === 1) {
                    location.reload();
                    // numberOfVote.innerHTML = data.result.votes.length;
                }
            };
            http.send(JSON.stringify(form));
        }
    };
    const postAnswer = (questionId) => {
        console.log(questionId, "call api");
        let editor = document.getElementsByClassName("ql-editor");
        let body = editor[editor.length - 1];
        let rediret = "http://localhost:8000/questions/detail/" + questionId;
        console.log(rediret, "rediret");
        let answer = {};
        answer["body"] = body.outerHTML || new XMLSerializer().serializeToString(body);
        answer["questionId"] = questionId;
        let http = new XMLHttpRequest();
        http.open("POST", "/answers/postAnswer", true);
        http.setRequestHeader('Content-type', 'application/json');
        http.setRequestHeader("Access-Control-Allow-Origin", '*');
        http.setRequestHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
        http.onload = function () {
            // do something to response
            console.log(this.responseText);
            if (JSON.parse(this.responseText).status) {
                window.location.href = rediret;
                console.log(rediret, "response")
            }
        };
        http.send(JSON.stringify(answer));
    };

    const addCommentForm = (_id) => {
        if (!${isUser}) {
            window.location.replace("${pageContext.request.contextPath}/users/auth");
        } else {
            const form = document.getElementById(_id + "form");
            const btnaddcomment = document.getElementById(_id + "addcommentbtn");
            form.style.display = "block";
            btnaddcomment.style.display = "none";
            console.log("form", form)
        }
    }

    const commentbtn = async (_id) => {
        const body = document.getElementById(_id + "inputform").value;
        const answerId = _id;
        const url = "/addcomment";
        const _response = await fetch(url, {
            method: 'POST', // *GET, POST, PUT, DELETE, etc.
            mode: 'cors', // no-cors, *cors, same-origin
            cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
            credentials: 'same-origin', // include, *same-origin, omit
            headers: {
                'Content-Type': 'application/json'
                // 'Content-Type': 'application/x-www-form-urlencoded',
            },
            redirect: 'follow', // manual, *follow, error
            referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
            body: JSON.stringify({
                body, answerId
            }) // body data type must match "Content-Type" header
        });
        const response = await _response.json();
        if (response.status) {
            <%--const comments = document.getElementById("${_id}comments");--%>
            <%-- <div class="comment-answer">--%>
            <%--                        <span>${comment.body}</span>--%>
            <%--                        <span>-</span>--%>
            <%--                        <a href="#"> ${comment.name}</a>--%>
            <%--                        <span class="createdOn"><fmt:formatDate value="${comment.createdOn}"--%>
            <%--                                                                pattern="yyyy-MM-dd HH:mm:ss"/></span>--%>
            <%--                    </div>--%>
            <%--const _div = document.createElement("div");--%>
            <%--_div.setAttribute("class","comment-answer" );--%>
            <%--const _body = document.createElement("span");--%>
            <%--_body.innerHTML = body;--%>
            <%--const span = document.createElement("span");--%>
            <%--span.innerHTML = "-";--%>
            <%--const _a = document.createElement("a");--%>
            <%--_a.setAttribute("href", "#");--%>
            <%--_a.innerHTML = name;--%>
            <%--const _createdOn = document.createElement("span");--%>
            <%--_createdOn.innerHTML = --%>
            location.reload();
        }
    }

    const cancelbtn = (id) => {
        const form = document.getElementById(id + "form");
        const btnaddcomment = document.getElementById(id + "addcommentbtn");
        console.log("btnaddcomment", btnaddcomment)
        btnaddcomment.style.display = "block";
        form.style.display = "none"
    }

    const deleteQuestion = () => {

    }
</script>
<script type="text/javascript">
    const clickPostAnswerNoLogin = () => {
        let alert = document.getElementById("alertSignin");
        alert.style.display = "block"
    };
</script>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<%--<script src="${pageContext.request.contextPath}/js/api.js" type="text/javascript"></script>--%>
<script src="${pageContext.request.contextPath}/js/quill.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/time.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js"></script>
<!-- and it's easy to individually load additional languages -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/languages/go.min.js"></script>
<script>hljs.highlightAll();</script>
</body>
</html>
