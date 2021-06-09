package com.stackoverflow.nhom24.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/*
 * đây là file cấu hình Spring-MVC cho project
 * @author admin
 * */

@Configuration // báo cho spring boot đây là một file cấu hình cho spring mvc
@EnableWebMvc // file cấu hình này dùng cho Webmvc
@ComponentScan(basePackages = { "com.stackoverflow.nhom24" }) // chỉ ra đường dẫn có controller
public class WebMVC implements WebMvcConfigurer {
    // giá trị return của hàm là kiểu dữ liệu của bean
    /**
     * chỉ cho spring-mvc biết nơi chứa các view đã tạo ở phần 1: front-end.
     *
     * @return
     */
    @Bean
    public ViewResolver viewResolver() {
        //System.out.println("--------------MVC-----------");

        InternalResourceViewResolver bean = new InternalResourceViewResolver();


        bean.setViewClass(JstlView.class);

        bean.setPrefix("/WEB-INF/views/");
        bean.setSuffix(".jsp"); //các file trong view được cấu hình với đuôi jsp
        return bean;
    }

    // classpath là src/main/resources
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/styles/**").addResourceLocations("classpath:/styles/");
        registry.addResourceHandler("/js/**").addResourceLocations("classpath:/js/");
        registry.addResourceHandler("/asset/**").addResourceLocations("classpath:/asset/");
//        registry.addResourceHandler("/summernote/**").addResourceLocations("classpath:/summernote/");
//        registry.addResourceHandler("/video/**").addResourceLocations("classpath:/video/");
//        registry.addResourceHandler("/glyphicons/**").addResourceLocations("classpath:/glyphycons/"); //glyphicons

        registry.addResourceHandler("/files/**").addResourceLocations("file:E:/Project handle/stackoverflow/upload/img/");
//        registry.addResourceHandler("/files/video/**").addResourceLocations("file:F:/Project/ProjectBack-End/java-web-001/upload/video/");
		registry.addResourceHandler("/summernote/**").addResourceLocations("classpath:/META-INF/resources/summernote/");
//		registry.addResourceHandler("/files/**").addResourceLocations("file:E:/eclipse-workspace/Javaweb1903BE/upload/");
    }
}

