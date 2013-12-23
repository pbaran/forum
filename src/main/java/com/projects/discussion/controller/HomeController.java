package com.projects.discussion.controller;

import com.projects.discussion.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Piotr Baran <admin@piotrus.net.pl
 */
@Controller
public class HomeController {

    @Autowired
    private CategoryService categoryService;
    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String showListCategories(Model model) {
        model.addAttribute("categoryList", categoryService.getCategories());
        
        return "index";
    }

//    public void setCategoryService(CategoryService categoryService) {
//        this.categoryService = categoryService;
//    }
}
