package com.stackoverflow.nhom24.controller;

import com.stackoverflow.nhom24.business.QuestionBusiness;
import com.stackoverflow.nhom24.model.response.QuestionDetailResponse;
import com.stackoverflow.nhom24.model.response.QuestionResponse;
import lombok.AllArgsConstructor;
import org.hibernate.search.annotations.Parameter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@Controller
@AllArgsConstructor
public class HomeController {

    private final QuestionBusiness questionBusiness;

    @GetMapping(value = "/")
    
    public String home(final ModelMap model, Integer page,String tab, Integer startPagination) throws ExecutionException, InterruptedException {
        long start = System.currentTimeMillis();
        if (tab == null) {
            tab = "newest";
        }

        if (page == null) {
            page = 1;
        }
        Integer finalPage = page;
        CompletableFuture<List<QuestionResponse>> questions = CompletableFuture.supplyAsync(() -> questionBusiness.getAll(finalPage, "newest"));
//        CompletableFuture<Integer> totalAsync = CompletableFuture.supplyAsync(() -> questionBusiness.getTotal("newest"));
        if(startPagination == null){
            startPagination = 0;
        }
        if (page > startPagination + 10) {
            startPagination = startPagination + 10;
        }
        if (page < startPagination) {
            startPagination = startPagination - 10;
        }
        int total = questionBusiness.getTotal(tab);
        int totalPagination = (total / 15) + 1;
        if (startPagination + 10 >= totalPagination) {
            startPagination = totalPagination - 10;
        } else if (startPagination <= 1) {
            startPagination = 0;
        }
        model.addAttribute("questions", questions.get());
        long end = System.currentTimeMillis();
        System.out.println(end - start + "    time");
        model.addAttribute("pagination", totalPagination);
        model.addAttribute("total", total);

        model.addAttribute("page", page);
        model.addAttribute("startPagination", startPagination);
        model.addAttribute("endPagination", startPagination + 10);
        model.addAttribute("sidebar", 1);
        return "home";
    }
}
