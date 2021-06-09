package com.stackoverflow.nhom24.model.response;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.bson.types.ObjectId;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor

public class LiveSearchQuestionResponse {
    private String id;
    private String title;
    private List<TagResponse> tags;
    private int answers;
}
