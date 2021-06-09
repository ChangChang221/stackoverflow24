package com.stackoverflow.nhom24.business;

import com.stackoverflow.nhom24.business.base.BaseBusiness;
import com.stackoverflow.nhom24.elasticsearch.entity.QuestionES;
import com.stackoverflow.nhom24.elasticsearch.entity.UserES;
import com.stackoverflow.nhom24.elasticsearch.repository.QuestionRepositoryES;
import com.stackoverflow.nhom24.entity.Question;
import com.stackoverflow.nhom24.entity.Tag;
import com.stackoverflow.nhom24.entity.User;
import com.stackoverflow.nhom24.model.response.*;
import com.stackoverflow.nhom24.repository.QuestionRepository;
import com.stackoverflow.nhom24.repository.TagRepository;
import com.stackoverflow.nhom24.repository.UserRepository;
import com.stackoverflow.nhom24.service.AnswerService;
import com.stackoverflow.nhom24.service.CommentService;
import com.stackoverflow.nhom24.service.QuestionService;
import com.stackoverflow.nhom24.utils.EncrytedPasswordUtils;
import lombok.AllArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@Component
@AllArgsConstructor
public class QuestionBusiness extends BaseBusiness {

    private final QuestionRepository questionRepository;
    private final TagRepository tagRepository;
    private final UserRepository userRepository;

    private final QuestionService questionService;
    private final TagBusiness tagBusiness;
    private final AnswerService answerService;
    private final CommentService commentService;

    public List<Question> getAll(){
        List<Question> response= questionRepository.findAll();
        return response;
    }

    public Question getQuestionById(String id){
        Question response= questionRepository.findById(new ObjectId(id)).get();
        return response;
    }

    private final QuestionRepositoryES questionRepositoryES;

    public Page<QuestionES> getAllByElasticsearch(Integer page, String tab, String title) {
        if(tab == null || tab.equals("Relevance")){
            Page<QuestionES> result = questionRepositoryES.findByTitle(title, PageRequest.of(page - 1, 15));
            return result;
        }
        Page<QuestionES> result = questionRepositoryES.findByTitle(title, PageRequest.of(page - 1, 15, Sort.by("createdOn").descending()));
        return result;
    }

    public List<QuestionResponse> getAll(Integer page, String tab) {
        List<QuestionResponse> response = questionService.findAllQuestionAndItem(page, tab);
        return response;
    }

    public List<QuestionResponse> getALlByCondition(Integer page, String query, String tag){
        return questionService.findAllByCondition(page, query, tag, false);
    }

    public int getCountByCondition(Integer page, String query, String tag){
        return questionService.findAllByCondition(page, query, tag, true).size();
    }

    public List<LiveSearchQuestionResponse> getQuestions(String query) {
        List<LiveSearchQuestionResponse> response = questionService.getQuestions(query);
        return response;
    }

    public List<QuestionResponse> getByUserId(String userId) {
        return questionService.getByUserId(new ObjectId(userId));
    }

    public List<QuestionResponse> getQuestionOfAnswerByUserId(String userId) {
        return questionService.getQuestionOfAnswerByUserId(new ObjectId(userId));
    }

//    public void setRole() {
//        List<User> users = userRepository.findAll();
//        for (User el : users) {
//            userRepository.save(el);
    public void setElasticsearch(){
        List<QuestionResponse> questions = questionService.getAllQuestionAndItem();
        List<QuestionES> questionESes = new ArrayList<>();
        UserES userE = new UserES();
        userE.setId(questions.get(0).getUser().getId().toString());
        userE.setTags(questions.get(0).getUser().getTags());
        userE.setViews(questions.get(0).getUser().getViews());
        userE.setCreatedOn(questions.get(0).getUser().getCreatedOn().getTime());
        userE.setName(questions.get(0).getUser().getName());
        userE.setPhoto(questions.get(0).getUser().getPhoto());
        for (QuestionResponse el : questions){
            QuestionES q = new QuestionES();
            q.setId(el.getId().toString());
            q.setCreatedOn(el.getCreatedOn().getTime());
            if(el.getUser() != null){
                UserES userES = new UserES();
                userES.setId(el.getUser().getId().toString());
                userES.setTags(el.getUser().getTags());
                userES.setViews(el.getUser().getViews());
                userES.setCreatedOn(el.getUser().getCreatedOn().getTime());
                userES.setName(el.getUser().getName());
                userES.setPhoto(el.getUser().getPhoto());
                q.setUser(userES);
            } else {
                q.setUser(userE);
            }
            q.setViews(el.getViews());
            q.setTitle(el.getTitle());
            q.setTags(el.getTags());
            q.setAnswers(el.getAnswers());
            questionESes.add(q);
        }
        questionRepositoryES.saveAll(questionESes);
    }

    public void updatePhoto(){
        List<String> photo = new ArrayList<>();
        photo.add("avatarBase.png");
        photo.add("avatar4.jpg");
        photo.add("avatar3.jpeg");
        photo.add("avatarBase.png");
        photo.add("avatar2.jpg");
        photo.add("avatar1.png");
        photo.add("60a489a4a67d0d48bf2f2e001621440330174-1290789959-1998056832876314185img.jpeg");
        List<User> users = userRepository.findAll();
        for (User el : users){
            Random rand = new Random();
            int ranNum = rand.nextInt(6);
            el.setPhoto(photo.get(ranNum));
            userRepository.save(el);
        }
    }

    public int getTotal(String tab) {
        return questionService.findCountOfQuestionAndItem(tab);
    }

    public DataResponse postQuestion(Question question) {
        try {
//            List<Tag> tagsDto = tagRepository.findAll();
//            for (Tag tag : tagsDto) {
//                for (Tag tagPost : tagsPost) {
//                    if (tag.getName().equals(tagPost.getName())) {
//                        tagPost.setId(tag.getId());
//                    }
//                }
//                ;
//            }
//            ;
//            List<Tag> tags = tagsPost.stream().map(tag -> {
//                if (tag.getId() == null) {
//                    tag = tagRepository.save(tag);
//                }
//                return tag;
//            }).collect(Collectors.toList());
//            question.setTags(tags.stream().map(el -> el.getName()).collect(Collectors.toList()));
//            question.setId(new ObjectId());
            questionRepository.save(question);
            DataResponse data = new DataResponse();
            Object result = question.getId().toString();
            data.setStatus(1);
            data.setResult(result);
            return data;
        } catch (Exception e) {
            //System.out.println("QuestionBusiness postQuestion error: "+ e.getMessage());
            DataResponse data = new DataResponse();
            data.setStatus(0);
            return data;
        }

    }

    public QuestionDetailResponse getById(String id) {
        try {
            QuestionDetailResponse question = questionService.findQuestionAndItemById(id);
            Question updateQuestion = new Question();
            if(question.getViews() != null){
                updateQuestion.setViews(question.getViews() + 1);
            } else {
                updateQuestion.setViews(1);
            }
            updateQuestion.setId(new ObjectId(id));
            updateQuestion.setBody(question.getBody());
            updateQuestion.setTitle(question.getTitle());
            updateQuestion.setCreatedOn(question.getCreatedOn());
            updateQuestion.setTags(question.getTags());
            updateQuestion.setAnswers(question.getAnswers());
            updateQuestion.setUserId(new ObjectId(question.getUserId()));

            questionRepository.save(updateQuestion);
            return question;
        } catch (Exception e) {
            //System.out.println("QuestionDetailResponse: " + e.getMessage());
            return new QuestionDetailResponse();
        }

    }

    public void updateNumberAnswer(ObjectId questionId) {
        Question question = questionRepository.findById(questionId).get();
        question.setAnswers(question.getAnswers() + 1);
        questionRepository.save(question);
    }


    public List<QuestionResponse> getQuestionByTag(String tag, long page){
        return questionService.getByTag(tag, page);
    }

    public List<TagResponse> countQuestionTag(List<Tag> tags, int page, String tab) {

        List<TagResponse> tagsResponse = mapper.mapAsList(tags, TagResponse.class);

        //get name tag
        List<String> nameTag = tagBusiness.getNameTag(page);
        int sizeNameTag = nameTag.size();
//        //System.out.println("sizenametag = " + sizeNameTag);

//        System.out.print("nameTag = " );
//        System.out.println();

//        System.out.println("gettotal = " + tagBusiness.getTotal()/10 + 1);
        for (int i = 0; i < tagsResponse.size(); i++) {
            tagsResponse.get(i).setNumberQuestion(0);
            if(tagsResponse.get(i).getDescription().length() > 100){
                tagsResponse.get(i).setDescription(tagsResponse.get(i).getDescription().substring(0, 100));
            }
            /*TagResponse tagResponse = new TagResponse();
            tagResponse.setNumberQuestion(0);
            tagsResponse.add(tagResponse);*/
        }

        //get questions response

        List<Question> response = questionRepository.findAll();
        int sizeResponse = response.size();
//        System.out.println("sizeResponse = " + sizeResponse);

//        System.out.println();
        for (int i = 0; i < sizeResponse; i++) {

            //get tag of a question
            List<String> tagList = response.get(i).getTags();
            int sizeTagList = tagList.size();

//            System.out.print("tagList = ");
            for (int k = 0; k < sizeTagList; k++) {
                System.out.print(tagList.get(k) + ", ");
            }
//            System.out.println();
            for (int j = 0; j < sizeNameTag; j++) {
                for (int k = 0; k < sizeTagList; k++) {
                    if (tagList.get(k).equals(nameTag.get(j))) {
                        tagsResponse.get(j).setNumberQuestion(tagsResponse.get(j).getNumberQuestion() + 1);
                    }
                }
            }
        }


        return tagsResponse;
    }

    public void deleteQuestion(ObjectId id){
        commentService.deleteAllByAnswerId(id);
        answerService.deleteAllByQuestionId(id);
        questionRepository.deleteById(id);
    }

}
