<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" style="height: 100%">
<head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8"/>
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/sign-up.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/sidebar.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css"/>
    <%--    <script type="text/javascript" src="${pageContext.request.contextPath}/js/navigate_form.js"></script>--%>

</head>
<body style="background-color: #eff0f1;height: 100%">
<%@include file="layout/header.jsp" %>
<main class="main-container" style="background-color: #f5f5f5; height: 100%;padding-top: 50px">
    <%@include file="layout/sidebar.jsp" %>
    <div class="intro content-container" style="padding-top: 140px">
        <div>
            <h2>Join the Stack Overflow community</h2>
            <ul>
                <li>
                    <img src="${pageContext.request.contextPath}/asset/question-removebg-preview.png"/>
                    <span>Get unstuck — ask a question</span>
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/asset/vote-removebg-preview.png"/>
                    <span>Unlock new privileges like voting and commenting</span>
                </li>
                <li>
                    <img src="${pageContext.request.contextPath}/asset/tag.webp"/>
                    <span>Save your favorite tags, filters, and jobs</span>
                </li>
            </ul>
        </div>
    </div>
    <div class="form-auth-container" id="signin">
        <form:form class="form-auth" modelAttribute="login" action="/login">
            <label>Email</label>
            <form:input path="username" class="input-type"/>
            <label>Password</label>
            <form:input path="password" type="password" class="input-type"/>
            <a
                    style="
              text-decoration: none;
              color: #0095ff;
              cursor: pointer;
              margin: 10px 0px;
            "
                    onclick="navigate_form('forgot_password')"
            >Forgot password ?
            </a>
            <button class="btn-primary" type="submit">Sign in</button>
        </form:form>
        <span style="font-size: 14px; color: #868585; width: 360px; text-align: center; display: block " ;
        >Don’t have an account?
        <a style="text-decoration: none; color:#0095ff; cursor:pointer"
           onclick="navigate_form('sign_up')"
        >Sign up</a></span>
    </div>
    <div class="form-auth-container" id="signup">
        <form:form class="form-auth" modelAttribute="user" action="/signup" method="post">
            <label>Display name</label>
            <form:input path="nameSignUp" class="input-type"/>
            <label>Email</label>
            <form:input path="emailSignUp" class="input-type"/>
            <label>Password</label>
            <form:input path="passwordSignUp" class="input-type"/>
            <p>
                Passwords must contain at least eight characters, including at least
                1 letter and 1 number.
            </p>
            <button class="btn-primary" type="submit">Sign up</button>
            <span>
        By clicking “Sign up”, you agree to
        <a href="#">our terms of service</a>,
        <a href="#">privacy policy </a>and
        <a href="#"> cookie policy</a>
      </span>
        </form:form>
        <span style="font-size: 14px; color: #868585; width: 360px; text-align: center; display: block"
        >Already have an account?
      <a
              style="text-decoration: none; color:#0095ff; cursor:pointer"
              onclick="navigate_form('sign_in')"
      >Log in</a>
    </span>
    </div>
    <div class="form-auth-container" id="type-code-forgot-password">
        <form class="form-auth">
            <p style="margin: 10px 0px"> Type vefify code you received.
            </p>
            <label>Code</label>
            <input/>
            <button class="btn-primary" style="margin :10px 0px">Type verify code</button>
        </form>
    </div>
    <div class="form-auth-container" id="forgot-password">
        <form class="form-auth">
            <p style="margin: 10px 0px"> Forgot your account’s password or having trouble logging into your Team? Enter
                your email address and we’ll send you a recovery code.
            </p>
            <label>Email</label>
            <input class="input-type"/>
            <button class="btn-primary" style="margin:10px 0px" onclick="navigate_form('type_code_forgot_password')">
                Send recovery email
            </button>
        </form>
        <span style="font-size: 14px; color: #868585; width: 360px; text-align: center; display: block"
        >Don’t have an account?
          <a
                  style="text-decoration: none; color: #0095ff; cursor: pointer"
                  onclick="navigate_form(`sign_up`)"
          >Sign up</a
          ></span
        >
    </div>
</main>
<%@include file="layout/footer.jsp"%>
<script>
    const signup1 = document.getElementById("signup");
    const signin = document.getElementById("signin");
    const type_code_forgot_password = document.getElementById("type-code-forgot-password");
    const forgot_password = document.getElementById("forgot-password");
    signup1.style.display = 'none';
    signin.style.display = 'block';
    type_code_forgot_password.style.display = 'none';
    forgot_password.style.display = 'none';
    const navigate_form = (to) => {
        switch (to) {
            case "sign_up": {
                signup1.style.display = 'block';
                signin.style.display = 'none';
                type_code_forgot_password.style.display = 'none';
                forgot_password.style.display = 'none';
                break;
            }

            case "sign_in": {
                signup1.style.display = 'none';
                signin.style.display = 'block';
                type_code_forgot_password.style.display = 'none';
                forgot_password.style.display = 'none';
                break;
            }
            case "forgot_password": {
                signup1.style.display = 'none';
                signin.style.display = 'none';
                type_code_forgot_password.style.display = 'none';
                forgot_password.style.display = 'block';
                break;
            }

            case "type_code_forgot_password": {
                signup1.style.display = 'none';
                signin.style.display = 'none';
                type_code_forgot_password.style.display = 'block';
                forgot_password.style.display = 'none';
                break;
            }
        }
    };
</script>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
</body>

</html>

