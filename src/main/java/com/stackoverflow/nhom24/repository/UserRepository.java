package com.stackoverflow.nhom24.repository;


import com.stackoverflow.nhom24.entity.User;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

public interface UserRepository extends MongoRepository<User, ObjectId> {

    @Query("{username:'?0'}")
    User findByUsername(String username);
}
