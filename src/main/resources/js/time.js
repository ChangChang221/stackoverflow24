const convertCreatedOnTo = (str) => {
    const date = new Date(str);
    const month = date.toLocaleString('default', {month: 'short'});
    const year = date.getFullYear();
    const day = date.getDay();
    const minutes = date.getMinutes();
    const seconds = date.getSeconds();
    return `${month} ${day}'${year} at ${minutes}:${seconds}`
}

const convertCreatedOnToAgo = (str) => {
    const date = new Date(str);
    const seconds = Math.floor((new Date() - date) / 1000);

    let interval = seconds / 31536000;

    if (interval > 1) {
        return Math.floor(interval) + " years ago";
    }
    interval = seconds / 2592000;
    if (interval > 1) {
        return Math.floor(interval) + " months ago";
    }
    interval = seconds / 86400;
    if (interval > 1) {
        return Math.floor(interval) + " days ago";
    }
    interval = seconds / 3600;
    if (interval > 1) {
        return Math.floor(interval) + " hours ago";
    }
    interval = seconds / 60;
    if (interval > 1) {
        return Math.floor(interval) + " minutes ago";
    }
    return Math.floor(seconds) + " seconds";
}


const CreatedOns = document.getElementsByClassName("createdOn");
for (let i = 0; i < CreatedOns.length; i++) {
    CreatedOns[i].innerHTML = convertCreatedOnToAgo(CreatedOns[i].textContent)
}
