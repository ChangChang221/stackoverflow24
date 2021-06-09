package com.stackoverflow.nhom24.service;

import com.stackoverflow.nhom24.model.response.AnswerResponse;
import com.stackoverflow.nhom24.model.response.QuestionResponse;
import com.stackoverflow.nhom24.model.response.TagResponse;
import com.stackoverflow.nhom24.model.response.UserResponse;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.LookupOperation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserService {
    @Autowired
    private MongoTemplate mongoTemplate;

    public UserResponse getById(String id){
        Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("_id").is(new ObjectId(id))));
        UserResponse results = mongoTemplate.aggregate(aggregation, "user", UserResponse.class).getUniqueMappedResult();
        return results;
    }

    public List<UserResponse> getAllUser(Integer page, String tab) {
        Aggregation aggregation = null;
        switch (tab) {
            case "reputationScore": {
                aggregation = Aggregation.newAggregation(
                        Aggregation.sort(Sort.Direction.DESC, "reputationScore"),
                        Aggregation.skip((page - 1) * 40L),
                        Aggregation.limit(40)
                );
                break;
            }
            case "views": {
                aggregation = Aggregation.newAggregation(
                        Aggregation.sort(Sort.Direction.DESC, "views"),
                        Aggregation.skip((page - 1) * 40L),
                        Aggregation.limit(40)
                );
                break;
            }
            case "new": {
                aggregation = Aggregation.newAggregation(
                        Aggregation.sort(Sort.Direction.ASC, "createdOn"),
                        Aggregation.skip((page - 1) * 40L),
                        Aggregation.limit(40)
                );
                break;
            }
            default:
                break;
        }


        List<UserResponse> results = mongoTemplate
                .aggregate(aggregation, "user", UserResponse.class)
                .getMappedResults();
        return results;
    }
    public List<UserResponse> getByName(String query){
        try {
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("name").regex(query)), Aggregation.limit(40));
            List<UserResponse> results = mongoTemplate.aggregate(aggregation, "user", UserResponse.class).getMappedResults();
            return results;
        } catch (Exception e) {
            return List.of();
        }
    }
}
