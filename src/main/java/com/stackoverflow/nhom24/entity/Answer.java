package com.stackoverflow.nhom24.entity;

import com.stackoverflow.nhom24.entity.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;
import java.util.List;

import com.stackoverflow.nhom24.entity.Vote;
import org.springframework.data.mongodb.core.mapping.Field;
import org.springframework.format.annotation.DateTimeFormat;

@Setter
@Getter
@Document(collection = "answer")
public class Answer extends BaseEntity {
    private ObjectId userId;
    private String body;
    private Date createdOn;
    private ObjectId questionId;
    private Integer score;
}
