package com.stackoverflow.nhom24.service;

import com.stackoverflow.nhom24.entity.Answer;
import com.stackoverflow.nhom24.entity.Question;
import com.stackoverflow.nhom24.model.response.*;
import com.stackoverflow.nhom24.repository.QuestionRepository;
import org.bson.types.ObjectId;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.GroupOperation;
import org.springframework.data.mongodb.core.aggregation.LookupOperation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.TextCriteria;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.group;

@Repository
public class QuestionService {

    @Autowired
    private MongoTemplate mongoTemplate;

    private QuestionRepository questionRepository;

    @DateTimeFormat(pattern = "yyyy-mm-dd'T'hh:mm:ss.SSS'Z'")
    public List<QuestionResponse> findAllQuestionAndItem(long page, String tab) {
        try {
            //System.out.println("page - tab: " + page + " - " + tab);
            LookupOperation lookupOperationUser = LookupOperation.newLookup()
                    .from("user")
                    .localField("userId")
                    .foreignField("_id")
                    .as("user");
//            LookupOperation lookupOperationAnswer = LookupOperation.newLookup()
//                    .from("answer")
//                    .localField("_id")
//                    .foreignField("questionId")
//                    .as("answers");
            GroupOperation groupOperation = group("_id").sum("answer").as("answer");
            Aggregation aggregation = null;
            Date date = new Date();
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date);
            switch (tab) {
                case "newest": {
                    aggregation = Aggregation.newAggregation(
                            Aggregation.sort(Sort.Direction.DESC, "createdOn"),
                            lookupOperationUser,
//                        lookupOperationAnswer,
                            Aggregation.skip((page - 1) * 15),
                            Aggregation.limit(15));
                    break;
                }
                case "trend": {
                    aggregation = Aggregation.newAggregation(
                            Aggregation.sort(Sort.Direction.DESC, "views"),
                            lookupOperationUser,
//                        lookupOperationAnswer,
                            Aggregation.skip((page - 1) * 15),
                            Aggregation.limit(15));
                    break;
                }
                case "unanswers": {
                    aggregation = Aggregation.newAggregation(
                            Aggregation.match(Criteria.where("answers").is(0)),
                            lookupOperationUser,
                            Aggregation.skip((page - 1) * 15),
                            Aggregation.limit(15));
                    break;
                }
                case "week": {
                    Calendar _calendar = new GregorianCalendar();
                    Date _date = new Date();
                    _calendar.setTime(_date);
                    _calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH) - 7);
                    aggregation = Aggregation.newAggregation(
                            Aggregation.sort(Sort.Direction.DESC, "views"),
                            Aggregation.match(Criteria.where("createdOn").gt(_calendar.getTime())),
                            lookupOperationUser,
                            Aggregation.skip((page - 1) * 15),
                            Aggregation.limit(15)
                    );
                    break;
                }
                case "month": {
                    Calendar _calendar = new GregorianCalendar();
                    Date _date = new Date();
                    _calendar.setTime(_date);
                    _calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) - 1, calendar.get(Calendar.DAY_OF_MONTH));
                    aggregation = Aggregation.newAggregation(
                            Aggregation.sort(Sort.Direction.DESC, "views"),
                            Aggregation.match(Criteria.where("createdOn").gt(_calendar.getTime())),
                            lookupOperationUser,
                            Aggregation.skip((page - 1) * 15),
                            Aggregation.limit(15)
                    );
                    break;
                }
                default: {
                    aggregation = Aggregation.newAggregation(
                            lookupOperationUser,
//                        lookupOperationAnswer,
                            Aggregation.skip((page - 1) * 15),
                            Aggregation.limit(15));
                    break;
                }
            }
            List<QuestionResponse> results = mongoTemplate
                    .aggregate(aggregation, "question", QuestionResponse.class)
                    .getMappedResults();
            return results;
        } catch (Exception e) {
            System.out.print("error :" + e.getMessage() + "\n");
            return List.of();
        }

    }

    public int findCountOfQuestionAndItem(String tab) {
        try {
            Aggregation aggregation = null;
            Date date = new Date();
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date);
            switch (tab) {
                case "newest": {
                    aggregation = Aggregation.newAggregation(Aggregation.sort(Sort.Direction.DESC, "createdOn"));
                    break;
                }
                case "unanswers": {
                    aggregation = Aggregation.newAggregation(
                            Aggregation.match(Criteria.where("answers").is(0)));
                    break;
                }
                case "trend": {
                    aggregation = Aggregation.newAggregation(Aggregation.sort(Sort.Direction.DESC, "views"));
                    break;
                }
                case "week": {
                    Calendar _calendar = new GregorianCalendar();
                    Date _date = new Date();
                    _calendar.setTime(_date);
                    _calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH) - 7);
                    aggregation = Aggregation.newAggregation(
                            Aggregation.sort(Sort.Direction.DESC, "views"),
                            Aggregation.match(Criteria.where("createdOn").gt(_calendar.getTime()))
                    );
                    break;
                }
                case "month": {
                    Calendar _calendar = new GregorianCalendar();
                    Date _date = new Date();
                    _calendar.setTime(_date);
                    _calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) - 1, calendar.get(Calendar.DAY_OF_MONTH));
                    aggregation = Aggregation.newAggregation(
                            Aggregation.sort(Sort.Direction.DESC, "views"),
                            Aggregation.match(Criteria.where("createdOn").gt(_calendar.getTime()))
                    );
                    break;
                }
            }
            List<QuestionResponse> results = mongoTemplate.aggregate(aggregation, "question", QuestionResponse.class).getMappedResults();
            return results.size();
        } catch (Exception e) {
            return 0;
        }
    }


    public QuestionDetailResponse findQuestionAndItemById(String id) {
        try {
            ObjectId objId = new ObjectId(id);
            LookupOperation lookupOperationUser = LookupOperation
                    .newLookup().from("user")
                    .localField("userId")
                    .foreignField("_id")
                    .as("user");
//        LookupOperation lookupOperationAnswer = LookupOperation.newLookup()
//                .from("answer")
//                .localField("_id")
//                .foreignField("questionId")
//                .as("answer");
//        GroupOperation groupOperation = group("_id").sum("answer").as("answer");

            Aggregation aggregation = Aggregation.newAggregation(
                    Aggregation.match(Criteria.where("_id").is(objId)),
                    lookupOperationUser
            );
            QuestionDetailResponse results = mongoTemplate
                    .aggregate(aggregation, "question", QuestionDetailResponse.class)
                    .getUniqueMappedResult();
//        query.
            return results;
        } catch (Exception e) {
            //System.out.println("exception: " + e.getMessage());
            return new QuestionDetailResponse();
        }
    }


    public List<QuestionResponse> getByUserId(ObjectId userId) {
        try {
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("userId").is(userId)));
            List<QuestionResponse> results = mongoTemplate.aggregate(aggregation, "question", QuestionResponse.class).getMappedResults();
            return results;
        } catch (Exception e) {
            return List.of();
        }
    }

    public List<QuestionResponse> getQuestionOfAnswerByUserId(ObjectId userId) {
        try {
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("userId").is(userId)));
            List<QuestionResponse> results = mongoTemplate.aggregate(aggregation, "answer", Answer.class).getMappedResults().stream().map(answer -> {
                Aggregation _aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("_id").is(answer.getQuestionId())));
                QuestionResponse question = mongoTemplate.aggregate(_aggregation, "question", QuestionResponse.class).getUniqueMappedResult();
                return question;
            }).collect(Collectors.toList());
            return results;
        } catch (Exception e) {
            return List.of();
        }
    }

    public List<QuestionResponse> getByTag(String tag, long page) {
        try {
            LookupOperation lookupOperationUser = LookupOperation.newLookup().from("user").localField("userId").foreignField("_id").as("user");
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("tags").is(tag)),
                    lookupOperationUser,
                    Aggregation.skip((page - 1) * 15),
                    Aggregation.limit(15));
            List<QuestionResponse> results = mongoTemplate.aggregate(aggregation, "question", QuestionResponse.class).getMappedResults();
//                    .stream().map(answerResponse -> {
//                        Aggregation _aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("_id").is(answerResponse.getUserId())));
//                        User user = mongoTemplate.aggregate(_aggregation, "user", User.class).getUniqueMappedResult();
//                        answerResponse.setUser(user);
//                        return answerResponse;
//                    }).collect(Collectors.toList());
            return results;
        } catch (Exception e) {
            return List.of();
        }
    }

    public List<LiveSearchQuestionResponse> getQuestions(String query) {
        try {
            Aggregation aggregation = Aggregation.newAggregation(Aggregation.match(Criteria.where("title").regex(".*" + query + ".*")), Aggregation.sort(Sort.Direction.ASC, "views"), Aggregation.limit(5));
            List<LiveSearchQuestionResponse> results = mongoTemplate.aggregate(aggregation, "question", QuestionResponse.class).getMappedResults()
                    .stream().map(questionResponse -> {
                        Aggregation aggregationAnswer = Aggregation.newAggregation(Aggregation.match(Criteria.where("questionId").is(new ObjectId(questionResponse.getId()))));
                        Integer answers = mongoTemplate.aggregate(aggregationAnswer, "answer", Answer.class).getMappedResults().size();
                        LiveSearchQuestionResponse result = new LiveSearchQuestionResponse();
                        result.setId(questionResponse.getId());
                        result.setTitle(questionResponse.getTitle());
                        ArrayList<TagResponse> tags = new ArrayList<TagResponse>();
                        questionResponse.getTags().forEach(tag_name -> {
                            TagResponse tag = new TagResponse();
                            tag.setName(tag_name);
                            tags.add(tag);
                        });
                        result.setTags((List<TagResponse>) tags);
                        result.setAnswers(answers);
                        return result;
                    }).collect(Collectors.toList());
            return (List<LiveSearchQuestionResponse>) results;
        } catch (Exception e) {
            //System.out.println("error: " + e);
            return List.of();
        }
    }

    public List<QuestionResponse> findAllByCondition(long page, String query, String tag, boolean isCount) {
        try {

            LookupOperation lookupOperationUser = LookupOperation.newLookup()
                    .from("user")
                    .localField("userId")
                    .foreignField("_id")
                    .as("user");
            LookupOperation lookupOperationAnswer = LookupOperation.newLookup()
                    .from("answer")
                    .localField("_id")
                    .foreignField("questionId")
                    .as("answers");
            Aggregation aggregation = null;
            if(query != null) {
                if(isCount == true){
                    aggregation = Aggregation.newAggregation(
                            Aggregation.match(Criteria.where("title").regex(query)),
                            lookupOperationUser
//                            lookupOperationAnswer
                    );
                } else {
                    aggregation = Aggregation.newAggregation(
                            Aggregation.match(Criteria.where("title").regex(query)),
                            lookupOperationUser,
//                            lookupOperationAnswer,
                            Aggregation.skip((page - 1) * 15),
                            Aggregation.limit(15));
                }
            } else {
                if(isCount == true){
                    aggregation = Aggregation.newAggregation(
                            Aggregation.match(Criteria.where("tags").is(tag)),
                            lookupOperationUser
//                            lookupOperationAnswer
                    );
                } else {
                    aggregation = Aggregation.newAggregation(
                            Aggregation.match(Criteria.where("tags").is(tag)),
                            lookupOperationUser,
//                            lookupOperationAnswer,
                            Aggregation.skip((page - 1) * 15),
                            Aggregation.limit(15));
                }
            }

            List<QuestionResponse> results = mongoTemplate
                    .aggregate(aggregation, "question", QuestionResponse.class)
                    .getMappedResults();
            return results;
        } catch (Exception e) {
            System.out.print("error :" + e.getMessage() + "\n");
            return List.of();
        }

    }

    public void deleteAllByUserId(ObjectId userId){
        try {
            Query query = new Query(Criteria.where("userId").is(userId));
            mongoTemplate.remove(query,  Question.class, "question");
        } catch (Exception e){
            System.out.print("error :" + e.getMessage() + "\n");
        }
    }

    public List<QuestionResponse> getAllQuestionAndItem(){
            try {
                LookupOperation lookupOperationUser = LookupOperation
                        .newLookup().from("user")
                        .localField("userId")
                        .foreignField("_id")
                        .as("user");

                Aggregation aggregation = Aggregation.newAggregation(
                        lookupOperationUser
                );
                List<QuestionResponse> results = mongoTemplate
                        .aggregate(aggregation, "question", QuestionResponse.class)
                        .getMappedResults();
//        query.
                return results;
            } catch (Exception e) {
                System.out.println("exception: " + e.getMessage());
                return new ArrayList<>();
            }
    }

}
