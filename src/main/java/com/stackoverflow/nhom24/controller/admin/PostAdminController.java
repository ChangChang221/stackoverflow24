package com.stackoverflow.nhom24.controller.admin;

import com.stackoverflow.nhom24.business.QuestionBusiness;
import com.stackoverflow.nhom24.entity.Question;
import com.stackoverflow.nhom24.model.response.QuestionResponse;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@AllArgsConstructor
public class PostAdminController {

    private final QuestionBusiness questionBusiness;

    @GetMapping("/admin/post")
    public String getAllPost( final ModelMap model) {

        List<Question> questions = questionBusiness.getAll();
        model.addAttribute("questions", questions);
        return "adminPosts";
    }


}

