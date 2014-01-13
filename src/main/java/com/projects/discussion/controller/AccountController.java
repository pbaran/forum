    /*
 * The MIT License
 *
 * Copyright 2013 Piotr Baran <admin@piotrus.net.pl>.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.projects.discussion.controller;

import com.projects.discussion.entity.User;
import com.projects.discussion.form.AccountForm;
import com.projects.discussion.service.AccountService;

import javax.inject.Inject;
import javax.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@Controller
@RequestMapping("/users")
public class AccountController {
    private static final Logger log = LoggerFactory.getLogger(AccountController.class);
    private static final String REGISTRATION_FORM = "users/registration-form";
    private static final String REGISTRATION_OK = "redirect:registration-ok";
    
    @Autowired
    private AccountService accountService;
            
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setAllowedFields(new String[] {
            "login", "password", "email", "acceptTerms"
        });
        
        // converts empty string to null which is nice most validation rules fire only
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
    
    @RequestMapping(value = "new", method = RequestMethod.GET)
    public String getRegistrationForm(Model model) {
        model.addAttribute("account", new AccountForm());
        log.info("Registration form was displayed");
        
        return REGISTRATION_FORM;
    }
    
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String showListUsers(Model model) {
        model.addAttribute("userList", accountService.getUsers());
        
        return "users/list";
    }
    
    @RequestMapping(value = "", method = RequestMethod.POST)
    public String postRegistrionForm(
            @ModelAttribute("account") 
            @Valid AccountForm form,
            BindingResult result) {
        
        log.info("Transferred data for account form: {}", form);
        
        if (result.hasErrors()) {
            log.info("Errors occurred during data entry");
            
            return REGISTRATION_FORM;
        } else {
            log.info("creating new user");
            User user = toAccount(form);
            accountService.registerAccount(user, user.getPassword(), result);
            
            return REGISTRATION_OK;
        }
    }
    private static User toAccount(AccountForm form) {
        User user = new User();
        user.setLogin(form.getLogin());
        user.setEmail(form.getEmail());
        user.setPassword(form.getPassword());
        user.setActive(0);
        
        return user;
    }

//    public void setAccountService(AccountService accountService) {
//        this.accountService = accountService;
//    }
    
//    private static void convertPasswordError(BindingResult result) {
//        
//    }
}
