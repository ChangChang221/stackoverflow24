package com.stackoverflow.nhom24.elasticsearch.repository;

import com.stackoverflow.nhom24.elasticsearch.entity.QuestionES;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.annotations.Query;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepositoryES extends ElasticsearchRepository<QuestionES,String> {

    @Query("{\"bool\": {\"must\": [{\"match\": {\"title\": \"?0\"}}]}}")
    Page<QuestionES> findByTitle(String title, Pageable pageable);
}
//"sort": [
//        {
//        "FIELD": {
//        "order": "desc"
//        }
//        }
//        ]