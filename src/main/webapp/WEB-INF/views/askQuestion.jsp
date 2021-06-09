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
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/styles/default.min.css"
    />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/highlight.min.js"></script>
    <!-- and it's easy to individually load additional languages -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/10.7.2/languages/go.min.js"></script>
    <link
            href="https://cdn.quilljs.com/1.3.6/quill.snow.css"
            rel="stylesheet"
    />

    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <script src="https://sdk.amazonaws.com/js/aws-sdk-2.888.0.min.js"></script>

    <!-- Bootstrap CSS -->
</head>
<body style="background-color: #eff0f1">
<%--<script src="${pageContext.request.contextPath}/js/api.js" type="text/javascript"></script>--%>
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<%@include file="layout/header.jsp" %>
<main class="main-container">
    <div class="ask-question-container">
        <div style="display: flex; justify-content: space-between">
            <h2 style="flex: 1">Ask a public question</h2>
            <div class="bg-heading-ask-question"></div>
        </div>
        <div class="ask-question-content-container">
            <div class="ask-question-form-container">
                <div class="ask-question-form-title-container">
                    <div class="ask-question-form-title">Title</div>
                    <div>
                        Be specific and imagine you are asking a question to another
                        person
                    </div>
                    <div>
                        <input id="title"
                               placeholder="e.g. Is there an R function for finding the index of an element in a vector?"
                               value="${question.title}"
                        />
                    </div>
                </div>
                <div class="ask-question-form-body-container">
                    <div class="ask-question-form-body">Body</div>
                    <div style="font-size: 13px; color: #3c4146">
                        Include all the information someone would need to answer your
                        question
                    </div>
                    <div>
                        <div id="editor"></div>
                    </div>
                </div>
                <div
                        class="ask-question-form-title-container"
                        style="margin-top: 30px"
                >
                    <div class="ask-question-form-title">Tags (max 5)</div>
                    <div>
                        <div class="tags-ask-question-container">
                            <div class="tags-question" id="tags-question">
                            </div>
                            <input
                                   id="inputTag" placeholder="e.g. (spring vba python)" onkeyup="searchTag(value)"
                            />
                        </div>
                        <div style="background-color: #fafafa; padding: 18px 10px" id="result-tags">
                            <div id="loader_2" style="display: none">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                                     style="margin: auto; display: block; shape-rendering: auto;"
                                     width="60px" height="60px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
                                    <g>
                                        <circle cx="60" cy="50" r="4" fill="#689cc5">
                                            <animate attributeName="cx" repeatCount="indefinite" dur="1s" values="95;35"
                                                     keyTimes="0;1" begin="-0.67s"></animate>
                                            <animate attributeName="fill-opacity" repeatCount="indefinite" dur="1s"
                                                     values="0;1;1" keyTimes="0;0.2;1" begin="-0.67s"></animate>
                                        </circle>
                                        <circle cx="60" cy="50" r="4" fill="#689cc5">
                                            <animate attributeName="cx" repeatCount="indefinite" dur="1s" values="95;35"
                                                     keyTimes="0;1" begin="-0.33s"></animate>
                                            <animate attributeName="fill-opacity" repeatCount="indefinite" dur="1s"
                                                     values="0;1;1" keyTimes="0;0.2;1" begin="-0.33s"></animate>
                                        </circle>
                                        <circle cx="60" cy="50" r="4" fill="#689cc5">
                                            <animate attributeName="cx" repeatCount="indefinite" dur="1s" values="95;35"
                                                     keyTimes="0;1" begin="0s"></animate>
                                            <animate attributeName="fill-opacity" repeatCount="indefinite" dur="1s"
                                                     values="0;1;1" keyTimes="0;0.2;1" begin="0s"></animate>
                                        </circle>
                                    </g>
                                    <g transform="translate(-15 0)">
                                        <path d="M50 50L20 50A30 30 0 0 0 80 50Z" fill="#93dbe9"
                                              transform="rotate(90 50 50)"></path>
                                        <path d="M50 50L20 50A30 30 0 0 0 80 50Z" fill="#93dbe9">
                                            <animateTransform attributeName="transform" type="rotate"
                                                              repeatCount="indefinite" dur="1s"
                                                              values="0 50 50;45 50 50;0 50 50"
                                                              keyTimes="0;0.5;1"></animateTransform>
                                        </path>
                                        <path d="M50 50L20 50A30 30 0 0 1 80 50Z" fill="#93dbe9">
                                            <animateTransform attributeName="transform" type="rotate"
                                                              repeatCount="indefinite" dur="1s"
                                                              values="0 50 50;-45 50 50;0 50 50"
                                                              keyTimes="0;0.5;1"></animateTransform>
                                        </path>
                                    </g>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <button class="btn btn-primary" style="margin-top: 40px" onclick="postAskQuestion()">
                Post your question
            </button>
        </div>
        <div class="ask-question-step-container">
            <div></div>
        </div>
    </div>
    </div>
</main>
<%@include file="layout/footer.jsp" %>
<%--<script src="${pageContext.request.contextPath}/js/api.js" type="text/javascript"></script>--%>
<script src="${pageContext.request.contextPath}/js/quill.js" type="text/javascript"></script>
<script type="text/javascript">
    const postAskQuestion = () => {
        let title = document.getElementById("title").value;
        const _tags = document.getElementsByClassName("tag-search");
        console.log("_tags", _tags)
        let tags = []
        for (let i = 0; i < _tags.length; i++) {
            console.log("_tags", _tags[i].textContent)
            tags.push(_tags[i].textContent)
        }
        let body = document.getElementsByClassName("ql-editor")[0];
        // let body = document.getElementById("editor");
        let question = {};
        question["title"] = title;
        question["body"] = body.outerHTML || new XMLSerializer().serializeToString(body);
        question["tags"] = tags;
        question["id"] = "${question.id}"
        const http = new XMLHttpRequest();
        console.log("question", question)
        http.open("POST", "/question/postAskQuestion", true);
        http.setRequestHeader('Content-type', 'application/json');
        http.setRequestHeader("Access-Control-Allow-Origin", '*');
        http.setRequestHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
        http.onload = function () {
            if(JSON.parse(this.responseText)['status'] == 1){
                window.location.href = "http://localhost:8000/questions/detail/" + JSON.parse(this.responseText)['result'];
            }
        };
        http.send(JSON.stringify(question));
    }

    const searchTag = async (value) => {
        console.log(value);
        controller.abort();
        controller = new AbortController();
        const signal = controller.signal;
        const loader = document.getElementById("loader_2");
        const results = document.getElementById("result-tags")
        if (value === "") {
            results.innerHTML = "";
            results.appendChild(loader);
            loader.style.display = "none"
        } else {
            results.innerHTML = "";
            results.appendChild(loader);
            loader.style.display = "block"
            const _response = await fetch("/tags/search?" + new URLSearchParams({
                query: value
            }), {signal});
            const response = await _response.json();
            console.log("response", response)
            if (response.status) {
                loader.style.display = "none";
                const _results = response.result;
                _results.forEach((_result) => {
                    console.log("_result.name", _result.name)
                    const tag = document.createElement("span")
                    tag.setAttribute("class", "tag");
                    tag.innerHTML = _result.name
                    tag.addEventListener("click", () => {
                        add_tag(_result.name);
                        document.getElementById("inputTag").value = "";
                    })
                    results.appendChild(tag)
                })
            }
        }
    }

    const add_tag = (value) => {
        const tags_question = document.getElementById("tags-question");
        if (tags_question.children.length < 5) {
            const tag = document.createElement("span");
            tag.setAttribute("class", "tag tag-search")
            const text_node = document.createTextNode(value);
            const close_node = document.createElement("img");
            close_node.setAttribute("src", "${pageContext.request.contextPath}/asset/close.png")// Create a text node// Create a text node
            close_node.addEventListener("click", () => {
                remove_tag(value)
            })
            tag.appendChild(text_node);
            tag.appendChild(close_node)
            tags_question.appendChild(tag);
        }
    }

    const remove_tag = (value) => {
        console.log("remove_tag", value)
        const tags_question = document.getElementById("tags-question");
        for (let i = 0; i < tags_question.children.length; i++) {
            if (tags_question.children[i].textContent === value) {
                tags_question.removeChild(tags_question.children[i])
            }
        }
    }

    console.log(`${question.body}`)
    if(`${question.body}` != ``){
        const editor_2 = document.getElementById("editor");
        editor_2.innerHTML = `${question.body}`
        const results = document.getElementById("result-tags")
        let _tags = "${question.tags}";
        _tags = _tags.slice(1, _tags.length - 1);
        _tags = _tags.split(",");
        console.log(_tags)
        _tags.forEach((tag) => {
            console.log("_result", tag)
            add_tag(tag)
        })
    }
</script>
</body>
</html>
