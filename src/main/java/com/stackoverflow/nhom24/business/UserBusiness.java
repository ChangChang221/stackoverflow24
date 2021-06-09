package com.stackoverflow.nhom24.business;

import com.stackoverflow.nhom24.business.base.BaseBusiness;
import com.stackoverflow.nhom24.entity.User;
import com.stackoverflow.nhom24.model.request.LoginRequest;
import com.stackoverflow.nhom24.model.response.QuestionDetailResponse;
import com.stackoverflow.nhom24.model.response.QuestionResponse;
import com.stackoverflow.nhom24.model.response.TagResponse;
import com.stackoverflow.nhom24.model.response.UserResponse;
import com.stackoverflow.nhom24.repository.QuestionRepository;
import com.stackoverflow.nhom24.repository.UserRepository;
import com.stackoverflow.nhom24.service.AnswerService;
import com.stackoverflow.nhom24.service.CommentService;
import com.stackoverflow.nhom24.service.QuestionService;
import com.stackoverflow.nhom24.service.UserService;
import javassist.NotFoundException;
import lombok.AllArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.*;


@Component
@AllArgsConstructor
public class UserBusiness extends BaseBusiness {
    private final UserRepository userRepository;
    private final UserService userService;
    private final QuestionService questionService;
//    private final CommentService commentService;
    private final AnswerService answerService;

    public List<User> getAll(){

            List<User> user = userRepository.findAll();
            return user;

    }
/*
    public int getAllDay(){
        List<User> user = userRepository.findAll();
        return user.size();
    }
*/
    public User login(LoginRequest model) throws NotFoundException {
        User user = userRepository.findByUsername(model.getUsername());
        if(user == null){
            throw new NotFoundException("sign failed");
        }
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        if(!bCryptPasswordEncoder.encode(model.getPassword()).equals(user.getPassword())){
            throw new NotFoundException("sign failed");
        }
        return user;
    }

    public User createUser(User user){
        User userExisted = userRepository.findByUsername(user.getUsername());
        if(userExisted != null){
            //todo throw exception;
//            throw new Exception();
        }
        User newUser = userRepository.save(user);
        return newUser;
    }

    public UserResponse getUserById(String id){
        UserResponse user = userService.getById(id);
        return user;
    }

    public User getById(String id){
        User user = userRepository.findById(new ObjectId(id)).get();
        return user;
    }

    public void updateView(User user){
        if(user.getViews() != null){
            user.setViews(user.getViews() + 1);
        } else {
            user.setViews(1);
        }
        userRepository.save(user);
    }

    public void updateUser(String id, User newUser){
        User currentUser = userRepository.findById(new ObjectId(id)).get();
        if(newUser.getPhoto() != null){
            currentUser.setPhoto(newUser.getPhoto());
        }
        currentUser.setName(newUser.getName());
        currentUser.setSocial(newUser.getSocial());
        currentUser.setLink(newUser.getLink());
        currentUser.setLocation(newUser.getLocation());
        currentUser.setWebsite(newUser.getWebsite());
        currentUser.setTitle(newUser.getTitle());
        userRepository.save(currentUser);
    }




    public void deleteUser(String id){
        userRepository.deleteById(new ObjectId(id).get());
    }

    public List<UserResponse> getListUser(Integer page, String tab) {

        return userService.getAllUser(page, tab);
    }

    public int getTotal() {
        return userRepository.findAll().size();
    }

    public void  tagIsExist(String tag, HashMap<String, Integer> hashMapTag) {

        Set<String> getSetKey = hashMapTag.keySet();

        boolean exist = false;
        for (String s : getSetKey) {
            if(s.equals(tag)) {
                exist = true;
                hashMapTag.replace(s, hashMapTag.get(s) + 1);
            }
        }
        if (exist == false) {
            hashMapTag.put(tag, 0);
        }
    }
    public List<UserResponse> getTagOfUser(List<UserResponse> users) {
        int sizeUsersList = users.size();
        for (int k = 0; k < sizeUsersList; k++) {
            List<QuestionResponse> questionResponseList = questionService.getByUserId(new ObjectId(users.get(k).getId()));
            int sizeQuestionResponse = questionResponseList.size();

            List<String> listTag = new ArrayList<String>(); //list chứa các tag của user (các tag không trùng lăp)
            HashMap<String, Integer> hashMapTag = new HashMap<>();

            for (int i = 0; i < sizeQuestionResponse; i++) {
                //get list tag cho mỗi câu hỏi
                List<String> listTagUser = questionResponseList.get(i).getTags();
                int sizelistTagUser = listTagUser.size();

                //get các tag này vào set
                /*for (int  j = 0;  j < sizelistTagUser; j++) {
                    getTagsUserSet.add(listTagUser.get(j));
                }*/

                for (int j = 0; j < sizelistTagUser; j++) {
                    tagIsExist(listTagUser.get(j), hashMapTag);
                }

                //chuyển các set thành list
                List<String> getTagUserList = new ArrayList<>();

                //sort map theo thứ tự giảm dần của value
                LinkedHashMap<String, Integer> reverseSortedMap = new LinkedHashMap<>();
                hashMapTag.entrySet().stream().sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
                        .forEachOrdered(x -> reverseSortedMap.put(x.getKey(), x.getValue()));
                Set<String> getKeyHashMap = reverseSortedMap.keySet();

//                //System.out.println(hashMapTag);
                int cnt = 0;
                //lấy 3 tag có value lớn nhất
                for(String s: getKeyHashMap) {
                    if (cnt == 3) break;
                    else {
                        getTagUserList.add(s);
                        cnt++;
                    }
                }
//                //System.out.println(getTagUserList);
                users.get(k).setTags(getTagUserList);

            }


        }


        return users;
    }

    public List<UserResponse> filterUser(String query){
        return userService.getByName(query);
    }

    public void deleteUserById(ObjectId id){
//        commentService.deleteAllByUserId(id);
        answerService.deleteAllByUserId(id);
        questionService.deleteAllByUserId(id);
        userRepository.deleteById(id);
    }

    public void updateRole(ObjectId id, String role){
        User user = userRepository.findById(id).get();
        user.setRole(role);
        userRepository.save(user);
    }
}
