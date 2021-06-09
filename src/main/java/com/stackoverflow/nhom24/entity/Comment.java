package com.stackoverflow.nhom24.entity;

import com.stackoverflow.nhom24.entity.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.util.Date;

@Setter
@Getter
@Document(collection = "comment")
public class Comment extends BaseEntity {
    private ObjectId userId;
    private String name;
    private String body;
    private ObjectId answerId;
    private Date createdOn;
}
