package com.stackoverflow.nhom24.service;

import com.stackoverflow.nhom24.model.response.AnswerResponse;
import com.stackoverflow.nhom24.model.response.TagResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TagService {
    @Autowired
    private MongoTemplate mongoTemplate;

    public List<TagResponse> getByName(String query){
        try {
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("name").regex(".*" + query + ".*")), Aggregation.limit(40));
            List<TagResponse> results = mongoTemplate.aggregate(aggregation, "tag", TagResponse.class).getMappedResults();
            return results;
        } catch (Exception e) {
            return List.of();
        }
    }
}
