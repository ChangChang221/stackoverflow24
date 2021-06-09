
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewpost" content="width=device-width, initial-scale=1">
    <title>StackOverFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/orange.css" type="text/css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css" />

</head>
<body>
<%@include file="layout/header.jsp"%>
<!-- Main container  -->
<div class="main-container">
    <!-- Aside -->
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
            <li><a href="#" onclick="location.href='/admin/home';"><i class="fa fa-home"></i>Home</a></li>
            <li><a href="#" class="active" onclick="location.href='/admin/about';"><i class="fa fa-user"></i>About</a></li>
            <li><a href="#" onclick="location.href='/admin/user';"><i class="fa fa-users"></i>User Manage</a></li>
            <li><a href="#" onclick="location.href='/admin/post';"><i class="fa fa-question"></i>Post Manage</a></li>
    <!--        <li><a href="#" onclick="location.href='/';"><i class="fa fa-sign-out"></i>Logout</a></li> -->

        </ul>
        <!-- copyright  -->
        <div class="copyright-text">
            &copy; 2021 The Stackoverflow Website
        </div>
    </div>
    <!-- Main content -->

    <!-- Aside end -->
    <!-- Main content -->

    <div class="main-content">

        <!-- About Section End-->
        <section class="about section active" id="about">
            <div class="container">
                <div class="row">
                    <div class="section-title padd-15">
                        <h2>About Me</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="about-content padd-15">
                        <div class="row">
                            <div class="about-text padd-15">
                                <h3> I'm Trang and <span>Web Developer</span></h3>
                                <p>Hi! My name is Trang. I am a Web Developer, and I'm very passionate and dedicated to my mork. With 1 year
                                    experience as a professional Web developer, T have acquired the skills and knowledge necessary to make
                                    your project a success. I enjoy every step of the
                                    design process, from discussion and collaboration. </p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="personal-info padd-15">
                                <div class="row">
                                    <div class="info-item padd-15">
                                        <p>Birthday: <span>22 June 2000</span></p>
                                    </div>
                                    <div class="info-item padd-15">
                                        <p>Age: <span>21</span></p>
                                    </div>
                                    <div class="info-item padd-15">
                                        <p>Degree: <span>Student</span></p>
                                    </div>
                                    <div class="info-item padd-15">
                                        <p>Email: <span>trangbg20@gmail.com</span></p>
                                    </div>
                                    <div class="info-item padd-15">
                                        <p>Phone: <span>0867238735</span></p>
                                    </div>
                                    <div class="info-item padd-15">
                                        <p>City: <span>Bac Giang</span></p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="buttons padd-15">
                                        <a href="#" class="btn">Download CV</a>
                                        <a href="#" class="btn">Hire Me</a>
                                    </div>

                                </div>
                            </div>

                            <div class="skills padd-15">
                                <div class="row">
                                    <div class="skill-item padd-15" >
                                        <h5>JavaScript</h5>
                                        <div class="process">
                                            <div class="process-in" style="width:70%"></div>
                                            <div class="skill-percent">70%</div>
                                        </div>
                                    </div>
                                    <div class="skill-item padd-15" >
                                        <h5>Css</h5>
                                        <div class="process">
                                            <div class="process-in" style="width:50%"></div>
                                            <div class="skill-percent">50%</div>
                                        </div>
                                    </div>
                                    <div class="skill-item padd-15" >
                                        <h5>Html</h5>
                                        <div class="process">
                                            <div class="process-in" style="width: 76%"></div>
                                            <div class="skill-percent">76%</div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- About Section End -->
    </div>
    <!-- Main content end -->
</div>
<!-- javscript End-->


<!-- Live Style Switcher - Demo Only -->


<!-- Live Style Switcher - Demo Only End-->
<!-- Main container  -->
<script src="${pageContext.request.contextPath}/js/styleSwitcher.js"></script>

</body>
</html>