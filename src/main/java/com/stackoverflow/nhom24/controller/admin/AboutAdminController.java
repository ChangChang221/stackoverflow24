package com.stackoverflow.nhom24.controller.admin;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
@AllArgsConstructor
public class AboutAdminController {
    @GetMapping("/admin/about")

    public String home(final ModelMap model){
        return "aboutMe";
    }
}