<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/user.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/edit_profiles_user.css" />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/summernote/summernote-bs4.css" >
    <script src="https://cdn.jsdelivr.net/npm/quill-image-resize-module@3.0.0/image-resize.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js"></script>
    <!-- and it's easy to individually load additional languages -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/languages/go.min.js"></script>

    <link
            href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
            rel="stylesheet"
    />
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <script src="https://sdk.amazonaws.com/js/aws-sdk-2.888.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/summernote/summernote-bs4.js"></script>
    <script src="${pageContext.request.contextPath}/js/uploadImage.js" type="text/javascript"></script>
    <script type="text/javascript">
        const change_avatar = async (files) => {
            const url = await uploadImage(files);
            const img = document
                .querySelector(".avatar > img")
                .setAttribute("src", url);
            const postImg = document.getElementById("avatar");
            console.log("postImg", postImg)
            postImg.value = url;
            // document.getElementById("avatar")
            // document.querySelector(".avatar>img")[0].setAttribute("src", url);
        };
    </script>

    <!-- Bootstrap CSS -->

</head>
<body>
<%@include file="layout/header.jsp" %>
<main class="main-container">
    <%@include file="layout/sidebar.jsp" %>
    <div class="content-container">
        <div class="user-heading-container">
            <div>
                <a class="menu-user" href="${pageContext.request.contextPath}/users/${user.id}">Profile</a>
                <a class="menu-user" href="#">Activity</a>
                <a class="menu-user-active" href="#">Edit profile</a>
            </div>
            <div>
            <span>
              <img width="16px" height="16px" src="${pageContext.request.contextPath}/asset/tag.webp"/>
              <a href="#">Meta User</a>
            </span>
                <span>
              <img width="16px" height="16px" src="${pageContext.request.contextPath}/asset/stackexchange.png"/>
              <a href="https://stackexchange.com/">Network profiles</a>
            </span>
            </div>
        </div>
        <div class="user-edit-profile-container">
            <div class="title">Edit your profile</div>
            <form:form modelAttribute="user" action="/users/editProfile/${user.id}" enctype="multipart/form-data"
                       method="post">
            <h3 style="color: #555555">Public information</h3>
            <div class="edit-container">
                <div class="avatar">
                    <img
                        <%--                            src="https://lh3.googleusercontent.com/-n6S3A4nd7yA/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucm5G1ok5cW5xGDjLDu41wqnhhlwTw/s96-c/photo.jpg?sz=328"--%>
                            src="${user.photo}"
                            width="125px"
                            height="125px"
                    />
                    <label class="custom-file-upload">
                        <input type="file" onchange="change_avatar(this.files)"/>
                        <input type="text" id="avatar" name="postImg" style="display: none"/>
                        Change Picture
                    </label>
                </div>
                <div class="profiles">
                    <div>Display name</div>
                    <form:input path="name" type="text" value="${user.name}" class="input-type" />
                    <br />
                    <div>Location</div>
                    <form:input
                            value="${user.location}"
                            path="location"
                            type="text"
                            placeholder="Enter a location"
                            class="input-type"
                    />
                    <br />
                    <div>Title</div>
                    <form:input
                            value="${user.title}"
                            path="title"
                            type="text"
                            placeholder="No title has been set"
                            class="input-type"
                    />
                    <br />
                </div>
            </div>
<%--            <textarea id="editor"></textarea>--%>
            <br />
            <div class="social">
                <h3 style="font-weight: 500">Web presence</h3>
                <div>
                    <div>
                        <div>Website link</div>
                        <div>
                            <svg
                                    aria-hidden="true"
                                    class="s-input-icon s-input-icon__search svg-icon iconLink"
                                    width="18"
                                    height="18"
                                    viewBox="0 0 18 18"
                            >
                                <path
                                        d="M7.22 11.83a6 6 0 001.62.85l.61-1.8a4.1 4.1 0 114.04-.8l1.26 1.42a6 6 0 10-7.53.33zm3.43-5.6a6 6 0 00-1.6-.87L8.4 7.15a4.1 4.1 0 11-4.05.73L3.12 6.43a6 6 0 107.53-.2z"
                                ></path>
                            </svg>
                            <form:input value="${user.website}" path="website" class="input-type" />
                        </div>
                    </div>
                    <div>
                        <div>Twitter link or username</div>
                        <div>
                            <svg
                                    aria-hidden="true"
                                    class="s-input-icon s-input-icon__search svg-icon iconTwitter"
                                    width="18"
                                    height="18"
                                    viewBox="0 0 18 18"
                            >
                                <path
                                        d="M17 4.04c-.59.26-1.22.44-1.88.52a3.3 3.3 0 001.44-1.82c-.64.37-1.34.64-2.09.79a3.28 3.28 0 00-5.6 2.99A9.3 9.3 0 012.12 3.1a3.28 3.28 0 001.02 4.38 3.28 3.28 0 01-1.49-.4v.03a3.29 3.29 0 002.64 3.22 3.34 3.34 0 01-1.48.06 3.29 3.29 0 003.07 2.28 6.58 6.58 0 01-4.85 1.36 9.33 9.33 0 005.04 1.47c6.04 0 9.34-5 9.34-9.33v-.42a6.63 6.63 0 001.63-1.7L17 4.04z"
                                        fill="#2AA3EF"
                                ></path>
                            </svg>
                            <form:input value="${user.social}" path="social" class="input-type" />
                        </div>
                    </div>
                    <div>
                        <div>GitHub link or username</div>
                        <div>
                            <svg
                                    aria-hidden="true"
                                    class="s-input-icon s-input-icon__search svg-icon iconGitHub"
                                    width="18"
                                    height="18"
                                    viewBox="0 0 18 18"
                            >
                                <path
                                        d="M9 1a8 8 0 00-2.53 15.59c.4.07.55-.17.55-.38l-.01-1.49c-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82a7.42 7.42 0 014 0c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48l-.01 2.2c0 .21.15.46.55.38A8.01 8.01 0 009 1z"
                                        fill="#010101"
                                ></path>
                            </svg>
                            <form:input path="link" value="${user.link}" class="input-type" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="action">
                <button type="submit" class="btn-primary">Save profile</button>
                <a href="#">Cancel</a>
            </div>
        </div>
        </form:form>
    </div>
</main>
<%@include file="layout/footer.jsp" %>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="${pageContext.request.contextPath}/js/quill.js" type="text/javascript"></script>
</body>
</html>
