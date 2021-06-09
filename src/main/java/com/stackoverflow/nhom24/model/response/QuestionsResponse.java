package com.stackoverflow.nhom24.model.response;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
@NoArgsConstructor
public class QuestionsResponse {
    List<QuestionResponse> questions;
}
