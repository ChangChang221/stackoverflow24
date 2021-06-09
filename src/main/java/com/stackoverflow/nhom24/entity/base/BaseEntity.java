package com.stackoverflow.nhom24.entity.base;

import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;

import javax.persistence.MappedSuperclass;


@Setter
@Getter
@MappedSuperclass
public class BaseEntity {
    @Id
    protected ObjectId id;
}
