package com.stackoverflow.nhom24.controller;

import com.stackoverflow.nhom24.business.TagBusiness;
import com.stackoverflow.nhom24.business.UserBusiness;
import com.stackoverflow.nhom24.model.response.DataResponse;
import com.stackoverflow.nhom24.model.response.TagResponse;
import com.stackoverflow.nhom24.model.response.UserResponse;
import lombok.AllArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@AllArgsConstructor
@CrossOrigin(origins = "*")
public class UserRestController {
    private final UserBusiness userBusiness;

    @GetMapping("/users/search")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> filterTag(String query){
        System.out.println("search");
        List<UserResponse> users = userBusiness.filterUser(query);
        List<UserResponse> userResponse = userBusiness.getTagOfUser(users);
        DataResponse response = new DataResponse();
        response.setResult(userResponse);
        response.setStatus(1);
        return ResponseEntity.ok(response);
    }

    @PutMapping("/users/updateRole/{id}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> deleteUser(@PathVariable String id, @RequestBody Map<String, Object> data){
        String role = (String) data.get("role");
        userBusiness.updateRole(new ObjectId(id), role);
        DataResponse response = new DataResponse();
//        response.setResult();
        response.setStatus(1);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/users/{id}")
    @CrossOrigin(origins = "*")
    public ResponseEntity<DataResponse> deleteUser(@PathVariable String id){
//        userBusiness.deleteUserById(new ObjectId(id));
        DataResponse response = new DataResponse();
        response.setStatus(1);
        return ResponseEntity.ok(response);
    }
}
