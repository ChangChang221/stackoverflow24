package com.stackoverflow.nhom24.service;

import com.stackoverflow.nhom24.entity.Answer;
import com.stackoverflow.nhom24.entity.Comment;
import com.stackoverflow.nhom24.entity.User;
import com.stackoverflow.nhom24.model.response.AnswerResponse;
import com.stackoverflow.nhom24.model.response.CommentResponse;
import com.stackoverflow.nhom24.model.response.QuestionDetailResponse;
import com.stackoverflow.nhom24.repository.CommentRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.GroupOperation;
import org.springframework.data.mongodb.core.aggregation.LookupOperation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.stream.Collectors;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.group;

@Repository
public class CommentService {
    @Autowired
    private MongoTemplate mongoTemplate;

    public List<CommentResponse> getCommentByAnswerId(ObjectId id) {
        try {
//            System.out.println("id" + id);
            Aggregation aggregation = Aggregation.newAggregation(
                    Aggregation.match(Criteria.where("answerId").is(id))
            );
//            System.out.println("id" + id);
            List<CommentResponse> result = mongoTemplate.aggregate(aggregation, "comment", CommentResponse.class).getMappedResults();
//            System.out.println("result: " + result);
            return result;
        } catch (Exception e) {
            //System.out.println("Comment Service getCommentByAnswerId error: " + e.getMessage());
            return List.of();
        }
    }

    public void deleteAllByUserId(ObjectId userId){
        try {
            Query query = new Query(Criteria.where("userId").is(userId));
            mongoTemplate.remove(query,  Comment.class, "comment");
        } catch (Exception e){
            System.out.print("error :" + e.getMessage() + "\n");
        }
    }

    public void deleteAllByAnswerId(ObjectId answerId){
        try {
            Query query = new Query(Criteria.where("answerId").is(answerId));
            mongoTemplate.remove(query,  Answer.class, "comment");
        } catch (Exception e){
            System.out.print("error :" + e.getMessage() + "\n");
        }
    }


}
