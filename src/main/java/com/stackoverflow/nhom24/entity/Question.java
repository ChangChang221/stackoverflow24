package com.stackoverflow.nhom24.entity;

import com.stackoverflow.nhom24.entity.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;
import java.util.List;

@Setter
@Getter
@Document(collection = "question")
public class Question extends BaseEntity {
    private String title;
    private ObjectId userId;
    private String body;
    private Date createdOn;
    private List<String> tags;
    private Integer views;
    private int answers;
}
