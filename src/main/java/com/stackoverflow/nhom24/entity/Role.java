package com.stackoverflow.nhom24.entity;

import com.stackoverflow.nhom24.entity.base.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Table;

@Setter
@Getter
@Table(name = "role")
public class Role extends BaseEntity {
    private String name;
}
