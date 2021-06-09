package com.stackoverflow.nhom24.business;

import com.stackoverflow.nhom24.entity.Question;
import com.stackoverflow.nhom24.entity.Tag;
import com.stackoverflow.nhom24.model.response.TagResponse;
import com.stackoverflow.nhom24.repository.QuestionRepository;
import com.stackoverflow.nhom24.repository.TagRepository;
import com.stackoverflow.nhom24.service.TagService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
@AllArgsConstructor
public class TagBusiness {
    private final TagRepository tagRepository;
    private final TagService tagService;
    private final QuestionRepository questionRepository;
    public List<Tag> getAll(int page){
        List<Tag> tags = tagRepository.findAll().stream().skip((page-1)*20).limit(20).collect(Collectors.toList());
        return tags;
    }

    public List<String> getNameTag(int page) {
        List<Tag> tags = getAll(page);
        List<String> listNameTag = new ArrayList<>();
        int sizeTag = tags.size();
        for (int i = 0; i < sizeTag; i++) {
            listNameTag.add(tags.get(i).getName());
        }

        return listNameTag;
    }

    public int getTotal() {
        return tagRepository.findAll().size();
    }

    public List<TagResponse> filterTag(String query){
        return tagService.getByName(query);
    }

//    public List<TagResponse> countQuestionTag(List<Tag> tags, int page, String tab) {
//
//        List<TagResponse> tagsResponse = mapper.mapAsList(tags, TagResponse.class);
//
//        //get name tag
//        List<String> nameTag = tagBusiness.getNameTag(page);
//        int sizeNameTag = nameTag.size();
////        //System.out.println("sizenametag = " + sizeNameTag);
//
////        System.out.print("nameTag = " );
//        for(int j = 0; j < sizeNameTag; j++) {
////            System.out.print(nameTag.get(j) + ", ");
//        }
////        //System.out.println();
//
////        //System.out.println("gettotal = " + tagBusiness.getTotal()/10 + 1);
//        for (int i = 0; i < 15; i++) {
//            tagsResponse.get(i).setNumberQuestion(0);
//            /*TagResponse tagResponse = new TagResponse();
//            tagResponse.setNumberQuestion(0);
//            tagsResponse.add(tagResponse);*/
//        }
//
//        //get questions response
//
//        List<Question> response = questionRepository.findAll();
//        int sizeResponse = response.size();
////        //System.out.println("sizeResponse = " + sizeResponse);
//
////        //System.out.println();
//        for (int i = 0; i < sizeResponse; i++) {
//
//            //get tag of a question
//            List<String> tagList = response.get(i).getTags();
//            int sizeTagList = tagList.size();
//
////            System.out.print("tagList = ");
//            for (int k = 0; k < sizeTagList; k++) {
//                System.out.print(tagList.get(k) + ", ");
//            }
////            //System.out.println();
//            for (int j = 0; j < sizeNameTag; j++) {
//                for (int k = 0; k < sizeTagList; k++) {
//                    if (tagList.get(k).equals(nameTag.get(j))) {
//                        tagsResponse.get(j).setNumberQuestion(tagsResponse.get(j).getNumberQuestion() + 1);
//                    }
//                }
//            }
//        }


//        return tagsResponse;
//    }
}
