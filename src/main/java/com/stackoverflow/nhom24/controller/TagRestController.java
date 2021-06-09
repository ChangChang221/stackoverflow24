package com.stackoverflow.nhom24.controller;

import com.stackoverflow.nhom24.business.TagBusiness;
import com.stackoverflow.nhom24.model.response.DataResponse;
import com.stackoverflow.nhom24.model.response.TagResponse;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@AllArgsConstructor
@CrossOrigin(origins = "*")
public class TagRestController {
    private final TagBusiness tagBusiness;

    @GetMapping("/tags/search")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> filterTag(String query){
        List<TagResponse> tags = tagBusiness.filterTag(query);
        DataResponse response = new DataResponse();
        response.setResult(tags);
        response.setStatus(1);
        return ResponseEntity.ok(response);
    }
}
