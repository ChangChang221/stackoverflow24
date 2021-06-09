package com.stackoverflow.nhom24.service;

import com.stackoverflow.nhom24.entity.Answer;
import com.stackoverflow.nhom24.entity.Question;
import com.stackoverflow.nhom24.entity.User;
import com.stackoverflow.nhom24.entity.Vote;
import com.stackoverflow.nhom24.model.response.AnswerResponse;
import com.stackoverflow.nhom24.model.response.CommentResponse;
import com.stackoverflow.nhom24.model.response.QuestionDetailResponse;
import com.stackoverflow.nhom24.model.response.VoteResponse;
import com.stackoverflow.nhom24.repository.AnswerRepository;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.LookupOperation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

@Repository
public class AnswerService {

    @Autowired
    private MongoTemplate mongoTemplate;

    private CommentService commentService;

    @Autowired
    private AnswerRepository answerRepository;

    private AnswerResponse AnswerToAnswerResponse(Answer answer) {
        try {
            Aggregation _aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("_id").is(answer.getUserId())));
            CompletableFuture<User> user = CompletableFuture.supplyAsync(() -> mongoTemplate.aggregate(_aggregation, "user", User.class).getUniqueMappedResult());
//            User user = mongoTemplate.aggregate(_aggregation, "user", User.class).getUniqueMappedResult();
//            System.out.println("answerResponse.getId(): " + answer.getId());
            Aggregation __aggregation = Aggregation.newAggregation(
                    Aggregation.match(Criteria.where("answerId").is(answer.getId()))
            );
//            System.out.println("id" + answer.getId());
//            List<CommentResponse> comments = mongoTemplate.aggregate(__aggregation, "comment", CommentResponse.class).getMappedResults();
            CompletableFuture<List<CommentResponse>> comments = CompletableFuture.supplyAsync(() -> mongoTemplate.aggregate(__aggregation, "comment", CommentResponse.class).getMappedResults());
            List<VoteResponse> votes = getVotesByAnswerId(answer.getId());
//            System.out.println("comments: " + comments);
            AnswerResponse answerResponse = new AnswerResponse();
            answerResponse.setVotes(votes);
            answerResponse.setUser(user.get());
            answerResponse.setComments(comments.get());
            answerResponse.setId(answer.getId());
            answerResponse.setQuestionId(answer.getQuestionId());
            answerResponse.setBody(answer.getBody());
            answerResponse.setCreatedOn(answer.getCreatedOn());
            answerResponse.setScore(answer.getScore());
            answerResponse.setUserId(answer.getUserId());
            return answerResponse;
        } catch (Exception e) {
            //System.out.println("AnswerService AnswerToAnswerResponse error: " + e.getMessage());
            return new AnswerResponse();
        }
    }

//    public List<AnswerResponse> getAnswerResponsesByQuestionId(ObjectId questionId) {
//        try {
//            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("questionId").is(questionId)));
//            List<AnswerResponse> results = mongoTemplate.aggregate(aggregation, "answer", Answer.class).getMappedResults()
//                    .stream().map(answer -> {
//                        return AnswerToAnswerResponse(answer);
//                    }).collect(Collectors.toList());
//            return results;
//        } catch (Exception e) {
//            System.out.println("AnswerService getByQuestionId error: " + e.getMessage());
//            return List.of();
//        }
//    }

    public List<AnswerResponse> getAnswerResponsesByQuestionId(ObjectId questionId) {
        try {
            LookupOperation lookupOperationUser = LookupOperation.newLookup()
                    .from("user")
                    .localField("userId")
                    .foreignField("_id")
                    .as("user");
            LookupOperation lookupOperationAnswer = LookupOperation.newLookup()
                    .from("comment")
                    .localField("_id")
                    .foreignField("answerId")
                    .as("comments");
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("questionId").is(questionId)), lookupOperationUser, lookupOperationAnswer);
            List<AnswerResponse> results = mongoTemplate.aggregate(aggregation, "answer", AnswerResponse.class).getMappedResults();
//                    .stream().map(answer -> {
//                        return AnswerToAnswerResponse(answer);
//                    }).collect(Collectors.toList());
            return results;
        } catch (Exception e) {
            //System.out.println("AnswerService getByQuestionId error: " + e.getMessage());
            return List.of();
        }
    }

//    public List<AnswerResponse> getAnswerResponsesByUserId(ObjectId userId) {
//        try {
//            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("userId").is(userId)));
//            List<AnswerResponse> results = mongoTemplate.aggregate(aggregation, "answer", Answer.class).getMappedResults().stream().map(answer -> {
//                return AnswerToAnswerResponse(answer);
//            }).collect(Collectors.toList());
//            return results;
//        } catch (Exception e) {
//            return List.of();
//        }
//    }

    public List<VoteResponse> getVotesByAnswerId(ObjectId answerId) {
        try {
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("answerId").is(answerId)));
            List<VoteResponse> results = mongoTemplate.aggregate(aggregation, "vote", Vote.class).getMappedResults().stream().map(vote -> {
                VoteResponse voteResponse = new VoteResponse();
                voteResponse.setId(vote.getId());
                voteResponse.setAnswerId(vote.getAnswerId());
                voteResponse.setStatus(vote.getStatus());
                voteResponse.setUserId(vote.getUserId());
                return voteResponse;
            }).collect(Collectors.toList());
            return results;
        } catch (Exception e) {
            return List.of();
        }
    }

    public VoteResponse getVotesByAnswerIdAndUserId(ObjectId answerId, ObjectId userId) {
        try {
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("answerId").is(answerId)), Aggregation.match(Criteria.where("userId").is(userId)));
            Vote vote = mongoTemplate.aggregate(aggregation, "vote", Vote.class).getUniqueMappedResult();
            VoteResponse voteResponse = new VoteResponse();
            voteResponse.setId(vote.getId());
            voteResponse.setAnswerId(vote.getAnswerId());
            voteResponse.setStatus(vote.getStatus());
            voteResponse.setAnswerId(vote.getAnswerId());
            return voteResponse;
        } catch (Exception e) {
            return new VoteResponse();
        }
    }

    public void updateAnswerScore(ObjectId answerId) {
        try {
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("answerId").is(answerId)));
            List<Vote> votes = mongoTemplate.aggregate(aggregation, "vote", Vote.class).getMappedResults();
            Integer score = 0;
            for (int i = 0; i < votes.size(); i++) {
                Vote vote = votes.get(i);
                if (vote.getStatus()) {
                    score += 2;
                } else {
                    score -= 1;
                }
            }
            score = score < 0 ? 0 : score;
            //System.out.println("score: " + score);
            Aggregation _aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("_id").is(answerId)));
            Answer answer = mongoTemplate.aggregate(_aggregation, "answer", Answer.class).getUniqueMappedResult();
            Answer _answer = new Answer();
            _answer.setScore(score);
            _answer.setBody(answer.getBody());
            _answer.setCreatedOn(answer.getCreatedOn());
            _answer.setUserId(answer.getUserId());
            _answer.setQuestionId(answer.getQuestionId());
            _answer.setId(answer.getId());
            //System.out.println("updateAnswerScore: " + answer);
            //System.out.println("updateAnswerScore score: " + score);
            answerRepository.save(_answer);
        }catch (Exception e){
            //System.out.println("AnswerService updateAnswerScore: " + e);
        }
    }

    public void deleteAllByUserId(ObjectId userId){
        try {
            Query query = new Query(Criteria.where("userId").is(userId));
            mongoTemplate.remove(query,  Answer.class, "answer");
        } catch (Exception e){
            System.out.print("error :" + e.getMessage() + "\n");
        }
    }

    public void deleteAllByQuestionId(ObjectId questionId){
        try {
            Query query = new Query(Criteria.where("questionId").is(questionId));
            mongoTemplate.remove(query,  Answer.class, "answer");
        } catch (Exception e){
            System.out.print("error :" + e.getMessage() + "\n");
        }
    }
}
