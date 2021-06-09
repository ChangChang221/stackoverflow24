package com.stackoverflow.nhom24.model.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class DataResponse {
//    private String code;
    private int status;
    private String message;
    private Object result;
}
