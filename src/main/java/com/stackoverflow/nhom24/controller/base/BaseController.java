package com.stackoverflow.nhom24.controller.base;

import com.stackoverflow.nhom24.service.AccountSession;
import lombok.val;
import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.impl.ConfigurableMapper;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.User;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

public class BaseController {

    @Autowired(required = false)
    protected MapperFacade mapper = new ConfigurableMapper();

    protected ObjectId getUserId(Principal principal, HttpServletRequest request) {
        if (principal instanceof UsernamePasswordAuthenticationToken) {
            val authentication = (UsernamePasswordAuthenticationToken) principal;
            if (authentication.getPrincipal() instanceof AccountSession) {
                val user = (AccountSession) authentication.getPrincipal();
                return user.getId();
            }
        }
        return null;
    }
}
