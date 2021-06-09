package com.stackoverflow.nhom24.elasticsearch;

import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class QuestionServiceES {
    ElasticsearchTemplate elasticsearchTemplate;
}
