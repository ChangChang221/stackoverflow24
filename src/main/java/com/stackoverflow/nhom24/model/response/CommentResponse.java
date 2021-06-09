package com.stackoverflow.nhom24.model.response;

import com.stackoverflow.nhom24.entity.User;
import com.stackoverflow.nhom24.entity.Vote;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;
import java.util.List;

@Setter
@Getter
public class CommentResponse {
    private ObjectId id;
    private ObjectId userId;
    private String name;
    private String body;
    private ObjectId answerId;
    private Date createdOn;
}
