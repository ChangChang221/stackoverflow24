package com.stackoverflow.nhom24.elasticsearch.entity;

import lombok.Data;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Data
public class UserES {
    private String id;
    private String name;
    private String username;
    private String photo;
    private Long createdOn;
    private List<String> tags;
    private Integer views;
}
