
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewpost" content="width=device-width, initial-scale=1">
    <title>StackOverFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/orange.css" type="text/css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css" type="text/css">

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
            <li><a href="#" onclick="location.href='/admin/home';"><i class="fa fa-home"></i>Home</a></li>
            <li><a href="#" onclick="location.href='/admin/about';"><i class="fa fa-user"></i>About</a></li>
            <li><a href="#"  onclick="location.href='/admin/user';"><i class="fa fa-users"></i>User Manage</a></li>
            <li><a href="#" class="active" onclick="location.href='/admin/post';"><i class="fa fa-question"></i>Post Manage</a></li>
   <!--         <li><a href="#" onclick="location.href='/';"><i class="fa fa-sign-out"></i>Logout</a></li> -->

        </ul>
        <!-- copyright  -->
        <div class="copyright-text">
            &copy; 2021 The Stackoverflow Website
        </div>
    </div>
    <!-- Aside end -->
    <!-- Main content -->

    <div class="main-content">
        <!-- Service User -->
        <section id="usermanage" class="section service">
            <div class="container">
                <div class="row">
                    <div class="section-title padd-15">
                        <h2>Post Manage</h2>
                    </div>
                </div>
                <div class="row">
                    <!-- Service item -->
                    <div class="service-item padd-15">
                        <div class="service-item-inner">
                            <div class="icon"><i class="fa fa-question"></i></div>
                            <h4>All Post</h4>
                            <p>${questions.size()}</p>
                        </div>
                    </div>


                    <!--  Service item End-->
                    <!-- Service item -->
                    <div class="service-item padd-15">
                        <div class="service-item-inner">
                            <div class="icon"><i class="fa fa-calendar"></i></div>
                            <h4>Day</h4>
                            <p>13</p>
                        </div>
                    </div>


                    <!--  Service item End-->
                    <!-- Service item -->
                    <div class="service-item padd-15">
                        <div class="service-item-inner">
                            <div class="icon"><i class="fa fa-calendar"></i></div>
                            <h4>Month</h4>
                            <p>200</p>
                        </div>
                    </div>


                    <!--  Service item End-->
                    <!-- Service item -->
                    <div class="service-item padd-15">
                        <div class="service-item-inner">
                            <div class="icon"><i class="fa fa-calendar"></i></div>
                            <h4>Year</h4>
                            <p>207</p>
                        </div>
                    </div>
                    <!--  Service item End-->
                </div>

                <!-- Searcher box-->
                <div class="row" style="padding-bottom: 100px">


                    <form action="" class="search-box padd-15">
                        <input id="myInput" onkeyup="myFunction()" type="text" name="" value="" placeholder="Search...">

                        <button class="search-button" type="button" name="Tìm Kiếm">
                            <i class="fa fa-search" aria-hidden="true"></i>
                        </button>
                    </form>


                </div>
                <!-- Searcher box-->



                <div class="row">
                    <div class="section-title padd-15">
                        <table id="myTable" class="table padd-15">
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

                                        <a onclick="Delete(`${question.id}`)" href="#">
                                            <img src="${pageContext.request.contextPath}/asset/clear.png" style="height: 15px; width: 15px"/>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        <!-- Service User End-->
        <!-- Service Post End-->
    </div>
    <!-- Main content end -->
</div>

<!-- test    -->

<!-- Main container  -->

<div id="myModal" class="modal">
    <!-- Nội dung form đăng nhập -->
    <div class="modal-content">
        <form action="#">
            <span class="close">&times;</span>
            <div class="icon1">
                <i class="fa fa-exclamation"></i>
            </div>
            <header>Confirm</header>
            <p>Are you sure want to permanently delete post?</p>

            <div class="btns" >
                <button onclick="deleteQuestion()">Yes,Delete</button>
                <button onclick="closeModalDelete()">Cancel</button>
            </div>

        </form>
    </div>
</div>

<!-- javscript-->
<script>
    let id = null;
    // lấy phần Modal
    var modal = document.getElementById('myModal');

    // Lấy phần button mở Modal

    // Lấy phần span đóng Modal
    var span = document.getElementsByClassName("close")[0];

    // Khi button được click thi mở Modal

    function Delete(){
        modal.style.display = "block";
    }
    // Khi span được click thì đóng Modal
    span.onclick = function() {
        modal.style.display = "none";
    }
    // Khi click ngoài Modal thì đóng Modal
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    const closeModalDelete = () => {
        modal.style.display = "none";
    }
    const deleteQuestion = async () => {
        const url = "/questions/" + id;
        const _response = await fetch(url, {
            method: 'DELETE', // *GET, POST, PUT, DELETE, etc.
            mode: 'cors', // no-cors, *cors, same-origin
            cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
            credentials: 'same-origin', // include, *same-origin, omit
            headers: {
                'Content-Type': 'application/json'
                // 'Content-Type': 'application/x-www-form-urlencoded',
            },
            redirect: 'follow', // manual, *follow, error
            referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
        });
        const response = await _response.json();
        if(response.status){
            location.reload();
        }
    }

    function myFunction() {
        // Declare variables
        let input, filter, table, tr, tdName, i, txtValueName;
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        // Loop through all table rows, and hide those who don't match the search query
        for (i = 0; i < tr.length; i++) {
            tdName = tr[i].getElementsByTagName("td")[3];
            if (tdName) {
                txtValueName = tdName.textContent || tdName.innerText;
                if (txtValueName.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>

<!-- javscript End-->
</body>
</html>