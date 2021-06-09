package com.stackoverflow.nhom24.service;

import com.stackoverflow.nhom24.entity.User;
import lombok.Getter;
import lombok.Setter;
import org.bson.types.ObjectId;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.ArrayList;
import java.util.List;

public class AccountSession extends org.springframework.security.core.userdetails.User {
    private static final long serialVersionUID = 1L;

    private ObjectId id;

    private String name;
    private String photo;

    public AccountSession(ObjectId id, String username, String password, String name, String photo,
//                           Collection<? extends GrantedAuthority>authorities
                          List<GrantedAuthority> authorities) {
        super(username, password, authorities);
        this.id = id;
        this.name = name;
        this.photo = photo;
    }

//    public static AccountSession build(User user) {
//        GrantedAuthority authority = new SimpleGrantedAuthority(user.getRole());
//        List<GrantedAuthority> authorities = new ArrayList<>();
//                authorities.add(authority);
//
//        return new AccountSession(
//                user.getId(),
//                user.getUsername(),
//                user.getPassword(),
//                user.getName(),
//                user.getPhoto(),
//                authorities
//        );
//    }

    public ObjectId getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public String getPhoto() {
        return this.photo;
    }
}
