package com.stackoverflow.nhom24.model.response;

import com.stackoverflow.nhom24.entity.Answer;
import com.stackoverflow.nhom24.entity.Tag;
import com.stackoverflow.nhom24.entity.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;
import java.util.List;

@Setter
@Getter
@NoArgsConstructor
public class QuestionDetailResponse {
    private String id;
    private String title;
    private String userId;
    private String body;
    private Date createdOn;
    private List<String> tags;
    private Integer views;
    private int answers;
    private User user;
}
