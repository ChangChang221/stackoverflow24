package com.stackoverflow.nhom24.controller;

import com.stackoverflow.nhom24.business.QuestionBusiness;
import com.stackoverflow.nhom24.business.TagBusiness;
import com.stackoverflow.nhom24.entity.Tag;
import com.stackoverflow.nhom24.model.response.TagResponse;
import lombok.AllArgsConstructor;
import org.mapstruct.Mapping;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@AllArgsConstructor
public class TagController {
    private final TagBusiness tagBusiness;
    private final QuestionBusiness questionBusiness;

    @GetMapping(value = "/tags")
    public String tags(final ModelMap modelMap, Integer page, String tab, Integer startPagination) {
        boolean statustab = true;
        if(page == null){
            page = 1;
        }
        if(tab == null) {
            statustab = false;
            tab = "newest";
        }
        if(startPagination == null){
            startPagination = 0;
        }
        if(page > startPagination + 10){
            startPagination = startPagination + 10;
        } else if(page < startPagination){
            startPagination = startPagination - 10;
        }
        int total  = tagBusiness.getTotal();
        int totalPagination = (total / 20) + 1;
        if(startPagination + 10 >= totalPagination) {
            startPagination = totalPagination - 10;
        } if(startPagination <= 1){
            startPagination = 0;
        }
//        //System.out.println("total = " + total + ", total/10+1 = " + x);
        List<Tag> listTag = tagBusiness.getAll(page);
        List<TagResponse> responses = questionBusiness.countQuestionTag(listTag, page, tab);
        modelMap.addAttribute("tags", responses);
        modelMap.addAttribute("total", total);
        modelMap.addAttribute("pagination", totalPagination);
        modelMap.addAttribute("page", page);
        modelMap.addAttribute("startPagination", startPagination);
        modelMap.addAttribute("endPagination", startPagination + 10);
        modelMap.addAttribute("sidebar", 2);
//        modelMap.addAttribute("cntQuestionTag", cntQuestionTag);
        return "tags";
    }

}
