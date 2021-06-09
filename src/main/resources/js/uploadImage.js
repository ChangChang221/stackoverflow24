const config = {
    bucketName: `deviot`,
    dirName: `webs` /* optional */,
    region: `ap-southeast-1`,
    accessKeyId: `AKIAJOK4VUXT2WRSZQOQ`,
    secretAccessKey: `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`,
};

AWS.config.update({
    region: config.region,
    credentials: new AWS.Credentials({
        accessKeyId: config.accessKeyId,
        secretAccessKey: config.secretAccessKey,
    }),
});

function insert(str, index, value) {
    return str.substr(0, index) + value + str.substr(index);
}

const generate_id = () => {
    let id = "";
    for (let i = 0; i < 8; i++) {
        id += Math.floor(Math.random() * 10).toString();
    }
    return id;
};

function after_rename(file, newName) {
    const new_file = new File([file], newName, { type: file.type });
    return new_file;
}

const uploadImage = (files) => {
    console.log("files", files);
    const name = files[0].name;
    const dotIndex = name.lastIndexOf(".");
    const new_file = after_rename(
        files[0],
        insert(name, dotIndex, generate_id())
    );

    var upload = new AWS.S3.ManagedUpload({
        params: {
            Bucket: config.bucketName,
            Key: `web/${name}`,
            Body: new_file,
            ContentEncoding: "base64",
            ContentType: "image/jpeg",
            ACL: "public-read",
        },
    });
    console.log("upload", upload);
    var promise = upload.promise();

    return promise
        .then((res) => {
            alert("Successfully uploaded photo.");
            console.log("res.location", res);
            return res.Location;
        })
        .catch((err) => {
            console.log("err", err);
            return null;
        });
    //   return S3FileUpload.uploadFile(new_file, config)
};
