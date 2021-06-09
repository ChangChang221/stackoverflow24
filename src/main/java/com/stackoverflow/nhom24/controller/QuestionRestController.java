package com.stackoverflow.nhom24.controller;

import com.stackoverflow.nhom24.business.AnswerBusiness;
import com.stackoverflow.nhom24.business.QuestionBusiness;
import com.stackoverflow.nhom24.controller.base.BaseController;
import com.stackoverflow.nhom24.entity.Comment;
import com.stackoverflow.nhom24.entity.Question;
import com.stackoverflow.nhom24.entity.Tag;
import com.stackoverflow.nhom24.model.response.DataResponse;
import com.stackoverflow.nhom24.model.response.LiveSearchQuestionResponse;
import lombok.AllArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@AllArgsConstructor
@CrossOrigin(origins = "*")
public class QuestionRestController extends BaseController {

    private final QuestionBusiness questionBusiness;

    private final AnswerBusiness answerBusiness;

    @PostMapping("/question/postAskQuestion")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> postAskQuestion(@RequestBody Map<String, Object> data, HttpServletRequest req, HttpServletResponse res, Principal principal) {
        String title = (String) data.get("title");
        String body = (String) data.get("body");
        String id = (String) data.get("id");

        List<String> tags = (List<String>) data.get("tags");
        Question question = new Question();
        question.setBody(body);
        question.setTitle(title);
        question.setCreatedOn(new Date());
        question.setViews(0);
        question.setUserId(getUserId(principal, req));
        question.setAnswers(0);
        question.setTags(tags);
        question.setId(new ObjectId());
        if (id != null && !id.equals("")) {
            Question _question = questionBusiness.getQuestionById(id);
            question.setId(new ObjectId(id));
            question.setViews(_question.getViews());
            question.setAnswers(_question.getAnswers());
            question.setCreatedOn(_question.getCreatedOn());
        }
        DataResponse response = questionBusiness.postQuestion(question);
//        DataResponse response = new DataResponse();
//        response.setStatus(1);
//        response.setResult();
        return ResponseEntity.ok(response);
    }

    @GetMapping("/search")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> questionSearch(@RequestParam String query, HttpServletRequest req, HttpServletResponse res, Principal principal) {
        //System.out.println("query: " + query);
        List<LiveSearchQuestionResponse> results = questionBusiness.getQuestions(query);
        DataResponse response = new DataResponse();
        response.setResult(results);
        response.setStatus(1);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/questions/{id}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> deleteQuestion(@PathVariable String id, Principal principal, HttpServletRequest request) {
        Question question = questionBusiness.getQuestionById(id);
        DataResponse response = new DataResponse();
        if (!getUserId(principal, request).toString().equals(question.getUserId())) {
            response.setStatus(0);
        } else {
            questionBusiness.deleteQuestion(new ObjectId(id));
//        response.setResult(results);
            response.setStatus(1);
        }
        return ResponseEntity.ok(response);
    }
}
