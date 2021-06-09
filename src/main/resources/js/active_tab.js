const urlParams = new URLSearchParams(window.location.search);
const myParam = urlParams.get('tab');
console.log("myParam", myParam)
const tabs = document.getElementsByClassName("tab");
if (myParam) {
    for (let i = 0; i < tabs.length; i++) {
        const tab = tabs[i];
        const href = tab.children[0].getAttribute("href")
        console.log("href", href)
        const urlParams_a = new URLSearchParams(href);
        const tab_a = urlParams_a.get('tab');
        console.log("tab_a", tab_a)
        if (tab_a === myParam) {
            tab.setAttribute("class", "tab active_tab")
        }
    }
} else {
    tabs[0].setAttribute("class", "tab active_tab")
}

