package com.stackoverflow.nhom24.entity;

import com.stackoverflow.nhom24.entity.base.BaseEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.format.annotation.DateTimeFormat;
import java.util.Date;
import java.util.List;

@Setter
@Getter
@Document(collection = "user")
@NoArgsConstructor
public class User extends BaseEntity{
    private String name;
    private String username;
    private String password;
    private String photo;
    private Date createdOn;
    private String role;
    private String location;
    private String badges;
    private Integer views;
    private String link;
    private String social;
    private List<String> tags;
    private Number reputationScore;
    private Number questions;
    private Number answers;
    private String title;
    private String description;
    private String website;
}
