<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/post_manage.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/clear.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/question.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css" />
</head>
<body style="background-color: #fff">
<%@include file="layout/header.jsp"%>
<main class="main-container">
    <aside id="sidebar">
        <ul>
            <li>Home</li>
            <li>
                PUBLIC
                <ul style="padding-left: 0px">
                    <li style="display: flex; align-items: center">
                        <img
                                src="${pageContext.request.contextPath}/asset/earth-icon.png"
                                style="height: 15px; width: 15px; margin-right: 10px"
                        />Questions
                    </li>
                    <li class="menu-item-sidebar">Tag</li>
                    <li class="menu-item-sidebar">Users</li>
                </ul>
            </li>
            <li>
                MANAGE
                <ul style="padding-left: 0px">
                    <li style="display: flex; align-items: center">
                        <img
                                src="${pageContext.request.contextPath}/asset/boy.png"
                                style="height: 15px; width: 15px; margin-right: 10px"
                        />
                        User Management
                    </li>
                    <li style="display: flex; align-items: center">

                        <img
                                src="${pageContext.request.contextPath}/asset/presentation.png"
                                style="height: 15px; width: 15px; margin-right: 10px"
                        />
                        Post Management
                    </li>
                </ul>
            </li>
        </ul>
    </aside>
    <div class="row" >
        <form class="rectangle">
            <img style="margin-top: 50px;margin-left: 15px" src="${pageContext.request.contextPath}/asset/analytics.png" height="50" width="50"/>


            <div class="rectangle1">
                <h1 style=" text-align: left; font-family: inherit">ALL POST</h1>
                <div style=" text-align: left; font-size: 24px; font-family: inherit">21,123,340</div>
            </div>


        </form>
        <form class="rectangle">

            <img style="margin-top: 50px;margin-left: 15px" src="${pageContext.request.contextPath}/asset/24-hours.png" height="50" width="50"/>
            <div class="rectangle1">
                <h1 style=" text-align: left; font-family: inherit">DAY</h1>
                <div style=" text-align: left;  font-size: 24px; font-family: inherit">210</div>
            </div>

        </form>
        <form class="rectangle">
            <img style="margin-top: 50px;margin-left: 15px" src="${pageContext.request.contextPath}/asset/new-years-eve.png" height="50" width="50"/>
            <div class="rectangle1">
                <h1 style=" text-align: left; font-family: inherit">MONTH</h1>
                <div style=" text-align: left;  font-size: 24px; font-family: inherit">2100</div>
            </div>

        </form>
        <form class="rectangle">
            <img style="margin-top: 50px;margin-left: 15px" src="${pageContext.request.contextPath}/asset/annual.png" height="50" width="50"/>
            <div class="rectangle1">
                <h1 style=" text-align: left; font-family: inherit">YEAR</h1>
                <div style=" text-align: left;  font-size: 24px; font-family: inherit">21000</div>
            </div>
        </form>
    </div>
    <div > Quan lý bai dang</div>
    <div class="row1" >
        <div class="container-header">
            <h1>POST MANAGEMENT</h1>
            <div style="width: 50px"></div>
            <div class="search-container">
                <img src="${pageContext.request.contextPath}/asset/search-icon.png" height="15" width="15"/>

                <input id="userFilter"type="text" placeholder="Filter by post" >
            </div>
        <!--    <div class="button-container">
                <button class="ok">
                    <img src="$'{pageContext.request.contextPath}/asset/add.png" height="10" width="10"/> Add Post
                </button>
            </div> -->
        </div>
        <table class="table">
            <tr>
                <th>ID</th>
                <th>UserId</th>
                <th>CreatedOn</th>
                <th>Title</th>
                <th>Action</th>
            </tr>
            <c:forEach var="question" items="${questions}">
                <tr>
                    <td>${question.id}</td>
                    <td>${question.userId}</td>
                    <td  style=" text-align: center;">${question.createdOn}</td>
                    <td>${question.title}</td>
                    <td style=" text-align: center;">
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/asset/edit.png" style="height: 18px; width: 18px"/>
                        </a>
                        <a href="#">
                            <img src="${pageContext.request.contextPath}/asset/clear.png" style="height: 15px; width: 15px"/>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>

    </div>
</main>
</body>
</html>
