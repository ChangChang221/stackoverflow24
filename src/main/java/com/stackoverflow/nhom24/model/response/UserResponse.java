package com.stackoverflow.nhom24.model.response;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Setter
@Getter
public class UserResponse {
    private String id;
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
