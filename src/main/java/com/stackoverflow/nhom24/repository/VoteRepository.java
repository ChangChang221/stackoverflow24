package com.stackoverflow.nhom24.repository;

import com.stackoverflow.nhom24.entity.Vote;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoteRepository extends MongoRepository<Vote, ObjectId> {

}

