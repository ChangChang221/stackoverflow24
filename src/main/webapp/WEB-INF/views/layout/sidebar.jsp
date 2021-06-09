<aside id="sidebar">
    <ul>
        <li><a href="/">Home</a></li>
        <li>
            PUBLIC
            <ul style="padding-left: 0px">
                <c:choose>
                    <c:when test="${sidebar == 1}">
                        <li style="display: flex; align-items: center" onclick="questions()">
                            <img
                                    src="${pageContext.request.contextPath}/asset/earth-icon.png"
                                    style="height: 15px; width: 15px; margin-right: 10px"
                            />Questions
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="menu-item-sidebar" onclick="questions()">
                            Questions
                        </li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${sidebar == 2}">
                        <li tyle="display: flex; align-items: center" onclick="tags()" >
                            <img
                                    src="${pageContext.request.contextPath}/asset/earth-icon.png"
                                    style="height: 15px; width: 15px; margin-right: 10px"
                            />Tags
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="menu-item-sidebar" onclick="tags()" >Tags</li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${sidebar == 3}">
                        <li tyle="display: flex; align-items: center" onclick="users()" >
                            <img
                                    src="${pageContext.request.contextPath}/asset/earth-icon.png"
                                    style="height: 15px; width: 15px; margin-right: 10px"
                            />Users
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="menu-item-sidebar" onclick="users()" >Users</li>
                    </c:otherwise>
                </c:choose>

            </ul>
        </li>
        <li>
            FIND A JOB
            <ul style="padding-left: 0px">
                <li class="menu-item-sidebar">Jobs</li>
                <li class="menu-item-sidebar">Company</li>
            </ul>
        </li>
    </ul>
</aside>
<script>
    const questions = () => {
        window.location.href = "http://localhost:8000/questions"
    }
    const users = () => {
        window.location.href = "http://localhost:8000/users"
    }
    const tags = () => {
        window.location.href = "http://localhost:8000/tags"
    }
</script>