package com.projects.discussion.controller;

import com.projects.discussion.entity.Category;
import com.projects.discussion.form.CategoryForm;
import com.projects.discussion.helper.Slug;
import com.projects.discussion.service.CategoryService;
import com.projects.discussion.service.ForumService;
import javax.inject.Inject;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Piotr Baran <admin@piotrus.net.pl
 */
@Controller
@RequestMapping(value = "/admin")
public class AdministratorController {
    
    private static final String MANAGE_CATEGORY = "admin/manage-category";
    private static final String EDIT_CATEGORY = "admin/edit-category";

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ForumService forumService;
    
    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String showAdministrationPanel(Model model) {
        
        return "admin/panel";
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/manage/category", method = RequestMethod.GET)
    public String showListCategories(Model model) {
        CategoryForm categoryForm = new CategoryForm();
        
        model.addAttribute("categoryForm", categoryForm);
        model.addAttribute("categoryList", categoryService.getCategories());
        
        return MANAGE_CATEGORY;
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/manage/category", method = RequestMethod.POST)
    public String addCategory(
            @ModelAttribute("categoryForm") 
            @Valid CategoryForm form,
            BindingResult result,
            Model model) {

        if (result.hasErrors()) {
            
            return MANAGE_CATEGORY;
        } else {
            
            Category category = toCategory(form);
            forumService.addCategory(category);
            
            return "redirect:/admin/manage/category";
        }
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/manage/category/edit/{id}", method = RequestMethod.GET)
    public String getFormToEditCategory(
            @PathVariable Long id,
            Model model) {

        Category category = forumService.getCategoryById(id);
        CategoryForm categoryForm = new CategoryForm();
        categoryForm.setId(category.getId());
        categoryForm.setName(category.getName());
        categoryForm.setNameSeo(category.getNameSeo());
        categoryForm.setDescription(category.getDescription());
        
        model.addAttribute("categoryForm", categoryForm);
        
        return EDIT_CATEGORY;
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/manage/category/edit/{id}", method = RequestMethod.POST)
    public String editCategory(
            @PathVariable Long id,
            @ModelAttribute("categoryForm") 
            @Valid CategoryForm form,
            BindingResult result) {

        if (result.hasErrors()) {
            
            return EDIT_CATEGORY;
        } else {
            Category category = toCategory(form);
            category.setId(id);

            forumService.updateCategory(category);
            
            return "redirect:/admin/manage/category";
        }
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/manage/category/delete/{id}", method = RequestMethod.GET)
    public String removeCategory(
            @PathVariable Long id,
            Model model) {
        
        forumService.removeCategory(id);
        
        return "redirect:/admin/manage/category";
    }

    private static Category toCategory(CategoryForm form) {
        Category category = new Category();
        category.setName(form.getName());
        category.setNameSeo(Slug.parse(form.getNameSeo()));
        category.setDescription(form.getDescription());
        category.setPosts(0);
        category.setTopics(0);
        
        return category;
    }
}
