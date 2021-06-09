package com.stackoverflow.nhom24.controller.admin;

import com.stackoverflow.nhom24.business.UserBusiness;
import com.stackoverflow.nhom24.controller.base.BaseController;
import com.stackoverflow.nhom24.entity.User;
import lombok.AllArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;


@Controller
@AllArgsConstructor
public class adminHome extends BaseController {
    private final UserBusiness userBusiness;
    @GetMapping("/admin/home")
    public String home(final ModelMap model, Principal principal, HttpServletRequest request){
        ObjectId userId = getUserId(principal, request);
        User user = userBusiness.getById(userId.toString());
        model.addAttribute("user", user);
        return "adminHome";
    }
}
