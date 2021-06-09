package com.stackoverflow.nhom24.model.response;

import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;

@Setter
@Getter
public class VoteResponse {
    private ObjectId id;
    private ObjectId userId;
    private Boolean status;
    private ObjectId answerId;
}
