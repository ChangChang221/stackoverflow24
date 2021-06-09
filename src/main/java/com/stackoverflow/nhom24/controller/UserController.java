package com.stackoverflow.nhom24.controller;

import com.stackoverflow.nhom24.business.AnswerBusiness;
import com.stackoverflow.nhom24.business.QuestionBusiness;
import com.stackoverflow.nhom24.business.TagBusiness;
import com.stackoverflow.nhom24.business.UserBusiness;
import com.stackoverflow.nhom24.controller.base.BaseController;
import com.stackoverflow.nhom24.entity.Tag;
import com.stackoverflow.nhom24.entity.User;
import com.stackoverflow.nhom24.model.request.LoginRequest;
import com.stackoverflow.nhom24.model.request.SignUpRequest;
import com.stackoverflow.nhom24.model.response.QuestionResponse;
import com.stackoverflow.nhom24.model.response.UserResponse;
import com.stackoverflow.nhom24.utils.EncrytedPasswordUtils;
import lombok.AllArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Controller
@AllArgsConstructor
public class UserController extends BaseController {

    private final UserBusiness userBusiness;
    private final AnswerBusiness answerBusiness;
    private final QuestionBusiness questionBusiness;
    private final TagBusiness tagBusiness;

//    D:\Project CN Web\stackoverflow\src\main\resources\asset
    private final String imagePath = "E:/Project handle/stackoverflow/src/main/resources/asset";

    @GetMapping( "/users/auth")
    public String auth(final ModelMap model) {
        model.addAttribute("user", new SignUpRequest());
        model.addAttribute("login", new LoginRequest());
        return "login";
    }

    @PostMapping("/signup")
    public String signUp(@ModelAttribute("user") SignUpRequest model){
        User user = new User();
        user.setUsername(model.getEmailSignUp());
        user.setName(model.getNameSignUp());
        user.setPassword(EncrytedPasswordUtils.encrytedPassword(model.getPasswordSignUp()));
        user.setRole("ROLE_USER");
        user.setPhoto("avatar1.png");
        User newUser = userBusiness.createUser(user);

        return "redirect:/users/auth";
    }

    @GetMapping("/users/{id}")
    public String getUserById(final ModelMap model, @PathVariable String id, String tab,Principal principal, HttpServletRequest request) {
        if (tab == null) {
            tab = "all";
        }
        List<QuestionResponse> questions = new ArrayList<>();
        List<QuestionResponse> answers = new ArrayList<>();
        Integer total = 0;
        //System.out.println("tab: " + tab);
        boolean statusEdit = false;
        if(principal == null || !getUserId(principal, request).toString().equals(id)){
            statusEdit = false;
        } else {
            statusEdit = true;
        }

        switch (tab) {
            case "all": {
                questions = questionBusiness.getByUserId(id);
                answers = questionBusiness.getQuestionOfAnswerByUserId(id);
                total = questions.size() + answers.size();
                break;
            }
            case "questions": {
                questions = questionBusiness.getByUserId(id);
                total = questions.size();
                break;
            }
            case "answers": {
                answers = questionBusiness.getQuestionOfAnswerByUserId(id);
                total = answers.size();
                break;
            }
        }
        User userDetail = userBusiness.getById(id);
        userBusiness.updateView(userDetail);
        model.addAttribute("userDetail", userDetail);
        model.addAttribute("questions", (List<QuestionResponse>) questions);
        model.addAttribute("answers", (List<QuestionResponse>) answers);
        model.addAttribute("total", total);
        model.addAttribute("sidebar", 3);
        model.addAttribute("statusEdit", statusEdit);
        return "userDetail";
    }

    @GetMapping("/users")
    public String getAllUser(final ModelMap modelMap, Integer page, String tab, Integer startPagination) {
        if (page == null) {
            page = 1;
        }

        if (tab == null) {
            tab = "reputationScore";
        }

        if (startPagination == null) {
            startPagination = 0;
        }
        if (page > startPagination + 10) {
            startPagination = startPagination + 10;
        } else if (page < startPagination) {
            startPagination = startPagination - 10;
        }

        int total = userBusiness.getTotal();
        int totalPagination = (total / 40) + 1;
        if (startPagination + 10 >= totalPagination) {
            startPagination = totalPagination - 10;
        }
        if (startPagination <= 1) {
            startPagination = 0;
        }
//        List<Tag> listTag = tagBusiness.getAll(Integer.parseInt(page));
        List<UserResponse> users = userBusiness.getListUser(page, tab);
//        List<UserResponse> response = userBusiness.getTagOfUser(users);
//        //System.out.println("users: "+users.get(0).getTags().get(0));
        //System.out.println("users: " + users.get(0).getName());
        modelMap.addAttribute("users", users);
        modelMap.addAttribute("pagination", totalPagination);
        modelMap.addAttribute("total", total);
        modelMap.addAttribute("page", page);
        modelMap.addAttribute("startPagination", startPagination);
        modelMap.addAttribute("endPagination", startPagination + 10);
        modelMap.addAttribute("sidebar", 3);
        return "users";
    }

    @GetMapping("/users/edit/{id}")
    public String getProfile(final ModelMap model, Principal principal, HttpServletRequest request, @PathVariable String id) {
   //    String userId = getUserId(principal, request);
        if(!getUserId(principal, request).toString().equals(id)){
            return "redirect:/users/" + id;
        }
        User users = userBusiness.getById(id);
        model.addAttribute("user", users);
        model.addAttribute("sidebar", 3);
        return "userEditProfile";
    }

    @PostMapping("/users/editProfile/{id}")
    public String editUser(final ModelMap model, Principal principal, HttpServletRequest request ,
                           @ModelAttribute("user") User user, @RequestParam("postImg") String postImg, @PathVariable String id) throws IOException {
        try {
            if( postImg != null && !postImg.equals("")) {
//                Date dateNow = new Date();
//                Random rd = new Random();
//                String name =  dateNow.getTime() + postImg.getOriginalFilename();
//                postImg.transferTo(new File( imagePath + "/" + name.replace('-', '1')));
                user.setPhoto(postImg);
            }
            userBusiness.updateUser(id, user);
            return "redirect:/users/" + id;
        } catch (Exception e){
            model.addAttribute("status", false);
            return "redirect:/users/edit/" + id;
        }
    }
    @RequestMapping(value = {"/deleteUser/{id}"}, method = RequestMethod.GET)
    public String deleteUser( @PathVariable("id") String id, ModelMap model) {
        //System.out.println("test");
        userBusiness.deleteUser(id);
        return "test/user";
    }
    @PostMapping("/editUser/{id}")
    public String editUser(@PathVariable String id){

        return "redirect:/test/user/edit/"+id;
    }
}

