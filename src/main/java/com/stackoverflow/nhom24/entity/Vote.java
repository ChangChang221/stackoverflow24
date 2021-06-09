package com.stackoverflow.nhom24.entity;
import com.stackoverflow.nhom24.entity.base.BaseEntity;

import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.Date;
import java.util.List;

@Setter
@Getter
public class Vote extends BaseEntity{
    private ObjectId userId;
    private Boolean status;
    private ObjectId answerId;
}
