
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewpost" content="width=device-width, initial-scale=1">
    <title>StackOverFlow</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/orange.css" type="text/css" >
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css" type="text/css">
    <!-- StyleSwitcher -->
<!--

   <link rel="stylesheet" href="$'{pageContext.request.contextPath}/styles/header.css" />
-->

    <script type="text/javascript">
        function myFunction(){
            var x = document.getElementById("hopthoai");
            if(x.open == true){
                x.open = false;
            }else{
                x.open = true;
            }
        }
    </script>
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
            <li><a href="#" class="active" onclick="location.href='/admin/user';"><i class="fa fa-users"></i>User Manage</a></li>
            <li><a href="#" onclick="location.href='/admin/post';"><i class="fa fa-question"></i>Post Manage</a></li>
      <!--      <li><a href="#" onclick="location.href='/';"><i class="fa fa-sign-out"></i>Logout</a></li> -->

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
                        <h2>User Manage</h2>
                    </div>
                </div>
                <div class="row">
                    <!-- Service item -->
                    <div class="service-item padd-15">
                        <div class="service-item-inner">
                            <div class="icon"><i class="fa fa-users"></i></div>
                            <h4>All User</h4>
                            <p>${users.size()}</p>
                        </div>
                    </div>


                    <!--  Service item End-->
                    <!-- Service item -->
                    <div class="service-item padd-15">
                        <div class="service-item-inner">
                            <div class="icon"><i class="fa fa-calendar"></i></div>
                            <h4>Day</h4>
                            <p>12</p>
                        </div>
                    </div>


                    <!--  Service item End-->
                    <!-- Service item -->
                    <div class="service-item padd-15">
                        <div class="service-item-inner">
                            <div class="icon"><i class="fa fa-calendar"></i></div>
                            <h4>Month</h4>
                            <p>140</p>
                        </div>
                    </div>


                    <!--  Service item End-->
                    <!-- Service item -->
                    <div class="service-item padd-15">
                        <div class="service-item-inner">
                            <div class="icon"><i class="fa fa-calendar"></i></div>
                            <h4>Year</h4>
                            <p>149</p>
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
                                <th>STT</th>
                                <th>Username</th>

                                <th>Role</th>
                                <th>Name</th>

                                <th>Action</th>
                            </tr>
                            <%! private int a; %>
                            <% a=0; %>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td style="text-align: center"><%=++a%></td>
                                    <td>${user.username}</td>
                                    <td>${user.role}</td>
                                    <td>${user.name}</td>

                                    <td style=" text-align: center;">
                                        <a onclick="Delete(document.getElementById('myModal1'), `${user.id}`)"href="#">
                                            <img src="${pageContext.request.contextPath}/asset/edit.png" style="height: 18px; width: 18px"/>
                                        </a>
                                        <a onclick="Delete(document.getElementById('myModal'),`${user.id}`)" href="#">
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
</div>
<!-- Main content end -->

<div id="myModal" class="modal">
    <!-- Nội dung form đăng nhập -->
    <div class="modal-content">
        <form action="#">
            <span class="close">&times;</span>
            <div class="icon1">
                <i class="fa fa-exclamation"></i>
            </div>
            <header>Confirm</header>
            <p>Are you sure want to permanently delete user?</p>

            <div class="btns" >
                <button onclick="deleteUser()">Yes,Delete</button>
                <button onclick="closeModal()">Cancer</button>
            </div>

        </form>
    </div>
</div>


<div id="myModal1" class="modal">
    <div class="modal-content">
        <form action="#">
        <span class="close">&times;</span>
        <div class="icon1">
            <i class="fa fa-edit"></i>
        </div>
        <header>
            Edit Role
        </header>
        <div class="btns">
            <div>Role:</div>
            <input id="role" type="text" class="editrole" placeholder="Edit role">
        </div>
            <div class="btns">
                <button onclick="updateRole()">OK</button>
                <button onclick="closeModal()">Cancel</button>
            </div>
            <p id="alertRole" style="color: white;
    background: #ff4444;
    border-radius: 10px;
    padding: 0px 3px;
    margin: 12px 100px 0px 100px;">Input role failed!</p>
        </form>
    </div>

</div>



<!-- javscript-->
<script>

 //   var modal = document.getElementById('myModal');

    // Lấy phần button mở Modal

    // lấy phần Modal

    // Lấy phần span đóng Modal
    var span = document.getElementsByClassName("close")[0];
    var span1 = document.getElementsByClassName("close")[1];
    let alertRole = document.getElementById("alertRole");
    alertRole.style.display = "none";
    // Khi button được click thi mở Modal
    let id = null;

    function Delete(modal, userId){
        modal.style.display = "block";
        id = userId;
    }
    // Khi span được click thì đóng Modal
    span.onclick = function() {
        var modal = document.getElementById('myModal');

        modal.style.display = "none";
    }
    span1.onclick=function (){
        var modal1 = document.getElementById('myModal1');
        modal1.style.display="none";
    }
    // Khi click ngoài Modal thì đóng Modal
    window.onclick = function(event) {
        var modal = document.getElementById('myModal');
        var modal1 = document.getElementById('myModal1');
        if (event.target == modal) {
            modal.style.display = "none";

        }
        if(event.target==modal1){
            modal1.style.display="none";
        }
    }

    const closeModal = () => {
        var modal = document.getElementById('myModal');
        var modal1 = document.getElementById('myModal1');
        modal1.style.display="none";
        modal.style.display = "none";
    }

    const updateRole = async () => {
        const role = document.getElementById("role").value;
        console.log(role);
        if(role !== "ROLE_USER" && role !== "ROLE_ADMIN"){
            alertRole.style.display = "block";
            return;
        }
        const url = "/users/updateRole/" + id;
        const _response = await fetch(url, {
            method: 'PUT', // *GET, POST, PUT, DELETE, etc.
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
                role
            }) // body data type must match "Content-Type" header
        });
        const response = await _response.json();
        if(response.status){
            location.reload();
        }
    }
    const deleteUser = async () => {
        const url = "/users/" + id;
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
     let input, filter, table, tr, tdName,tdUsername, i, txtValueName, txtValueUsername, check = false;
     input = document.getElementById("myInput");
     filter = input.value.toUpperCase();
     table = document.getElementById("myTable");
     tr = table.getElementsByTagName("tr");

     // Loop through all table rows, and hide those who don't match the search query
     for (i = 0; i < tr.length; i++) {
         tdName = tr[i].getElementsByTagName("td")[3];
         tdUsername = tr[i].getElementsByTagName("td")[1];
         if (tdName) {
             txtValueName = tdName.textContent || tdName.innerText;
             if (txtValueName.toUpperCase().indexOf(filter) > -1 && !check) {
                 tr[i].style.display = "";
                 check = true;
             } else {
                 tr[i].style.display = "none";
             }
         }
         if (tdUsername && !check) {
             txtValueUsername = tdUsername.textContent || tdUsername.innerText;
             if(txtValueUsername.toUpperCase().indexOf(filter) > -1){
                 tr[i].style.display = "";
             } else {
                 tr[i].style.display = "none";
             }
         }
         check = false;
     }
 }
</script>
<!-- javscript End-->
<!-- Live Style Switcher - Demo Only -->

<!-- Live Style Switcher - Demo Only End-->
<!-- Main container  -->

<script src="${pageContext.request.contextPath}/js/styleSwitcher.js"></script>
</body>
</html>