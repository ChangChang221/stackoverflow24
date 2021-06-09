package com.stackoverflow.nhom24.controller.admin;

import com.stackoverflow.nhom24.business.UserBusiness;
import com.stackoverflow.nhom24.entity.User;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@AllArgsConstructor
public class UserAdminController {

    private final UserBusiness userBusiness;

    @GetMapping("/admin/user")
    public String getAllUser(final ModelMap model) {
        List<User> users = userBusiness.getAll();
        model.addAttribute("users", users);
        return "adminUsers";
    }

}
