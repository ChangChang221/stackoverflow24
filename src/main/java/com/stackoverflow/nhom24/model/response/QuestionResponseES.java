package com.stackoverflow.nhom24.model.response;

import com.stackoverflow.nhom24.elasticsearch.entity.UserES;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class QuestionResponseES {
    private String id;
    private String title;
    private Date createdOn;
    private List<String> tags;
    private Integer views;
    private int answers;
    private UserES user;
}
