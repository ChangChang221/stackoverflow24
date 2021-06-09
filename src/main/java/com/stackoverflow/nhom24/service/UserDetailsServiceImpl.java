package com.stackoverflow.nhom24.service;

import com.stackoverflow.nhom24.entity.User;
import com.stackoverflow.nhom24.repository.UserRepository;
import com.stackoverflow.nhom24.utils.EncrytedPasswordUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        User appUser = userRepository.findByUsername(userName);

        if (appUser == null) {
            //System.out.println("User not found! " + userName);
            throw new UsernameNotFoundException("User " + userName + " was not found in the database");
        }

        //System.out.println("Found User: " + appUser);

        // [ROLE_USER, ROLE_ADMIN,..]
        String roleNames = appUser.getRole();

        List<GrantedAuthority> grantList = new ArrayList<GrantedAuthority>();
        if (roleNames != null) {
            GrantedAuthority authority = new SimpleGrantedAuthority(roleNames);
            grantList.add(authority);
        }
        //System.out.println(EncrytedPasswordUtils.encrytedPassword("1"));
        UserDetails userDetails = new AccountSession(appUser.getId(), appUser.getUsername(), appUser.getPassword(), appUser.getName(), appUser.getPhoto(), grantList);

        return userDetails;
    }
}
