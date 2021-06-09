package com.stackoverflow.nhom24.entity;

import com.stackoverflow.nhom24.entity.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

@Setter
@Getter
@Document(collection = "tag")
public class Tag extends BaseEntity {
    private String name;
    private String description;
}
