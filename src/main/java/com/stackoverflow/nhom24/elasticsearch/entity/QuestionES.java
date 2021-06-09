package com.stackoverflow.nhom24.elasticsearch.entity;

import com.stackoverflow.nhom24.entity.User;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.elasticsearch.annotations.Document;

import java.util.Date;
import java.util.List;

@Setter
@Getter
@Document(indexName = "question", createIndex = true)
public class QuestionES {
    private String id;
    private String title;
    private Long createdOn;
    private List<String> tags;
    private Integer views;
    private int answers;
    private UserES user;

}
