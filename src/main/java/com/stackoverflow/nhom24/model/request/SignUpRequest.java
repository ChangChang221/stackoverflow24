package com.stackoverflow.nhom24.model.request;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
public class SignUpRequest {
    private String nameSignUp;
    private String emailSignUp;
    private String passwordSignUp;
}
