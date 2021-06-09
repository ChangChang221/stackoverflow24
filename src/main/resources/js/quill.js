const formats = [
    "header",
    "link",
    "image",
    "align",
    "font",
    "size",
    "bold",
    "italic",
    "underline",
    "strike",
    "blockquote",
    "list",
    "bullet",
    "indent",
    "video",
    "code-block",
    "color",
    "background",
    "emoji",
];

const handlerImageInput = (editor) => {
    const input = document.createElement("input");
    input.setAttribute("type", "file");
    input.setAttribute("accept", "image/*");
    input.click();
    input.onchange = async (event) => {
        const url = await uploadImage(input.files);
        console.log("url", url);
        const range = editor.getSelection(true);
        editor.insertEmbed(range.index, "image", url);
    };
};

const Size = Quill.import("attributors/style/size");
Size.whitelist = [
    "12px",
    "14px",
    "16px",
    "18px",
    "20px",
    "30px",
    "40px",
    "50px",
    "60px",
    "70px",
    "80px",
];

const modules = {
    imageDrop: true,
    ImageResize: {
        parchment: Quill.import("parchment"),
        modules: ["Resize", "DisplaySize", "Toolbar"],
    },
    VideoResize: {
        modules: ["Resize", "DisplaySize", "Toolbar"],
        tagName: "iframe", // iframe | video
    },
    syntax: {
        highlight: (text) => hljs.highlightAuto(text).value,
    },
    toolbar: {
        container: [
            [{ header: [1, 2, 3, 4, 5, 6, false] }],
            [{ size: Size.whitelist }],
            ["bold", "italic", "underline", "strike", "blockquote"],
            [
                { align: "" },
                { align: "center" },
                { align: "right" },
                { align: "justify" },
            ],
            [{ indent: "-1" }, { indent: "+1" }],
            ["clean"],
            [
                { list: "ordered" },
                { list: "bullet" },
                {
                    color: [
                        "#000000",
                        "#e60000",
                        "#ff9900",
                        "#ffff00",
                        "#008a00",
                        "#0066cc",
                        "#9933ff",
                        "#ffffff",
                        "#facccc",
                        "#ffebcc",
                        "#ffffcc",
                        "#cce8cc",
                        "#cce0f5",
                        "#ebd6ff",
                        "#bbbbbb",
                        "#f06666",
                        "#ffc266",
                        "#ffff66",
                        "#66b966",
                        "#66a3e0",
                        "#c285ff",
                        "#888888",
                        "#a10000",
                        "#b26b00",
                        "#b2b200",
                        "#006100",
                        "#0047b2",
                        "#6b24b2",
                        "#444444",
                        "#5c0000",
                        "#663d00",
                        "#666600",
                        "#003700",
                        "#002966",
                        "#3d1466",
                        "custom-color",
                    ],
                },
                { background: [] },
            ],
            ["code-block"],
            ["Font"],
        ],
        handlers: {
        },
        clipboard: {
            matchVisual: true,
        },
        keyboard: {
            bindings: {
                tab: false,
                custom: {
                    key: 13,
                    shiftKey: true,
                    handler: function () {
                        /** do nothing */
                    },
                },
                handleEnter: {
                    key: 13,
                    handler: function () {
                        /** do nothing */
                    },
                },
            },
        },
        "emoji-toolbar": true,
        "emoji-textarea": true,
        "emoji-shortname": true,
    },
};
const options = {
    debug: "info",
    modules: modules,
    placeholder: "Compose an epic...",
    readOnly: true,
    theme: "snow",
};
const editor = new Quill(document.getElementById("editor"), options);






