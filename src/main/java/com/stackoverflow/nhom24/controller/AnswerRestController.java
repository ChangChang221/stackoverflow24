package com.stackoverflow.nhom24.controller;

import com.stackoverflow.nhom24.business.AnswerBusiness;
import com.stackoverflow.nhom24.business.QuestionBusiness;
import com.stackoverflow.nhom24.business.UserBusiness;
import com.stackoverflow.nhom24.controller.base.BaseController;
import com.stackoverflow.nhom24.entity.Answer;
import com.stackoverflow.nhom24.entity.Comment;
import com.stackoverflow.nhom24.entity.User;
import com.stackoverflow.nhom24.model.response.DataResponse;
import com.stackoverflow.nhom24.model.response.UserResponse;
import lombok.AllArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;
import java.util.Date;
import java.util.Map;

@RestController
@AllArgsConstructor
public class AnswerRestController extends BaseController {

    private final AnswerBusiness answerBusiness;
    private final QuestionBusiness questionBusiness;
    private final UserBusiness userBusiness;

    @PostMapping("/answers/postAnswer")
    public ResponseEntity<DataResponse> postAnswer(@RequestBody Map<String, Object> data,
                                                   HttpServletRequest req,
                                                   Principal principal) {
        String body = (String) data.get("body");
        ObjectId questionId = new ObjectId((String)data.get("questionId"));
        Answer answer = new Answer();
        answer.setBody(body);
        answer.setUserId((getUserId(principal, req)));
        answer.setCreatedOn(new Date());
        answer.setScore(0);
        answer.setQuestionId(questionId);
        answerBusiness.saveAnswer(answer);
        questionBusiness.updateNumberAnswer(questionId);
        DataResponse response = new DataResponse();
        response.setStatus(1);
        return ResponseEntity.ok(response);
    }

    @PutMapping("/answers/upVote")
    public ResponseEntity<DataResponse> voteAnswer(@RequestBody Map<String, Object> data,
                                                   HttpServletRequest req,
                                                   HttpServletResponse res,
                                                   Principal principal) {
        ObjectId answerId = new ObjectId((String) data.get("answerId"));
        Boolean status = (Boolean) data.get("status");
//        System.out.println("answerId: " + answerId);
//        System.out.println("status: " + status);
        ObjectId userId = getUserId(principal, req);
//        System.out.println("userId: " + userId);
        Integer _status = answerBusiness.upVote(answerId, userId, status);
        DataResponse response = new DataResponse();
        response.setStatus(_status);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/addcomment")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> addComment(@RequestBody Map<String, Object> data, HttpServletRequest req, HttpServletResponse res, Principal principal) {
        String body = (String) data.get("body");
        ObjectId answerId = new ObjectId((String) data.get("answerId"));
        Date createdOn = new Date();
        ObjectId userId = getUserId(principal, req);
        User user = userBusiness.getById(userId.toString());
//        System.out.println("body: " + body);
//        System.out.println("answerId: " + answerId);
//        System.out.println("createdOn: " + createdOn);
//        System.out.println("userId: " + userId);
        Comment comment = new Comment();
        comment.setName(user.getName());
        comment.setBody(body);
        comment.setAnswerId(answerId);
        comment.setId(new ObjectId());
        comment.setUserId(userId);
        comment.setCreatedOn(createdOn);
        DataResponse response = answerBusiness.addComment(comment);
        return ResponseEntity.ok(response);
    }

    @PutMapping("/answer/delete")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> deleteAnswer(@RequestBody Map<String, Object> data, HttpServletRequest req, HttpServletResponse res, Principal principal) {
        try {
            String answerId = (String) data.get("answerId");
            System.out.println("answerId: " + answerId);
            answerBusiness.deleteAnswer(answerId);
            DataResponse response = new DataResponse();
            response.setStatus(1);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            DataResponse response = new DataResponse();
            response.setStatus(0);
            return ResponseEntity.ok(response);
        }
    }
}
