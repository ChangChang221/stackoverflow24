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
public class AnswerResponse {
    private ObjectId id;
    private ObjectId userId;
    private String body;
    private Date createdOn;
    private ObjectId questionId;
    private List<VoteResponse> votes;
    private Integer score;
    private User user;
    private List<CommentResponse> comments;
}
