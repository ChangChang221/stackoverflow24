<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="hasRole('ROLE_ADMIN')" var="isUser" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewpost" content="width=device-width, initial-scale=1">
    <title>StackOverFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/orange.css" type="text/css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css" />
    <!-- StyleSwitcher -->

</head>
<body>
<%@include file="layout/header.jsp"%>
<!-- Main container  -->
<div class="main-container">
    <!-- Aside -->
    <div class="aside">
        <!-- logo -->
        <div class="logo">
            <a href="#">Admin</a>
        </div>
        <!-- Nav Toggler Btn -->
        <div class="nav-toggler">
            <span></span>

        </div>
        <!-- Nav  -->
        <ul class="nav">
            <li><a href="#" class="active" onclick="location.href='/admin/home';"><i class="fa fa-home"></i>Home</a></li>
            <li><a href="#"  onclick="location.href='/admin/about';"><i class="fa fa-user"></i>About</a></li>
            <li><a href="#" onclick="location.href='/admin/user';"><i class="fa fa-users"></i>User Manage</a></li>
            <li><a href="#" onclick="location.href='/admin/post';"><i class="fa fa-question"></i>Post Manage</a></li>
     <!--       <li><a href="#" onclick="location.href='/';"><i class="fa fa-sign-out"></i>Logout</a></li> -->

        </ul>
        <!-- copyright  -->
        <div class="copyright-text">
            &copy; 2021 The Stackoverflow Website
        </div>
    </div>
    <!-- Aside end -->

    <!-- Main content -->

    <div class="main-content">
        <!--  Home Section -->

        <section class="home section active" id="home">
            <div class="container">
                <div class =intro>
                    <img src="${pageContext.request.contextPath}${user.photo}"  alt="profile" class="shadow-dark"/>
                    <h1>${user.name}</h1>
                    <p>I'm a web Developer</p>
                    <div class="social-link">
                        <a href="https://www.facebook.com/trang.nt.2201/" class="fa fa-facebook"></a>
                        <a href="https://www.instagram.com/accounts/login/" class="fa fa-instagram"></a>
                        <a href="https://twitter.com/TrangNguynTh8" class="fa fa-twitter"></a>
                    </div>
                </div>

            </div>
        </section>
        <!--  Home Section End-->
    </div>
    <!-- Main content end -->
</div>

<!-- Main container  -->


</body>
</html>