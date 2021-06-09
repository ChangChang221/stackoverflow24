package com.stackoverflow.nhom24.model.response;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
public class TagResponse {
    private String name;
    private int numberQuestion;
    private  String description;
}
