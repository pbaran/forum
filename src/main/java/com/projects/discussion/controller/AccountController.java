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
import com.projects.discussion.entity.UserDetails;
import com.projects.discussion.form.AccountForm;
import com.projects.discussion.form.LoginForm;
import com.projects.discussion.form.SettingsForm;
import com.projects.discussion.service.AccountService;

import javax.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@Controller
public class AccountController {
    private static final Logger log = LoggerFactory.getLogger(AccountController.class);
    private static final String REGISTRATION_OK = "redirect:signup-completed";
    private static final String REGISTRATION_FORM = "signup/registration-form";
    private static final String LOGOUT_OK = "login/logout";
    private static final String LOGIN_FORM = "login/login-form";
    private static final String SETTINGS_OK = "user/settings-ok";
    private static final String SETTINGS_FORM = "user/settings-form";
    private static final String PROFILE = "user/profile";
    
    @Autowired
    private AccountService accountService;
            
//    @InitBinder
//    public void initBinder(WebDataBinder binder) {
//        binder.setAllowedFields(new String[] {
//            "login", "password", "email", "acceptTerms"
//        });
//        
//        // converts empty string to null which is nice most validation rules fire only
//        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
//    }
    
    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String getRegistrationForm(Model model) {
        model.addAttribute("account", new AccountForm());
        log.info("Registration form was displayed");
        
        return REGISTRATION_FORM;
    }
    
    @RequestMapping(value = "/signup", method = RequestMethod.POST)
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
    
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getLoginForm(Model model) {
        model.addAttribute("login", new LoginForm());
        log.info("Login form was displayed");
        
        return LOGIN_FORM;
    }
    
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutUser() {
        
        return LOGOUT_OK;
    }
    
    @PreAuthorize("hasAnyRole('USER','ADMIN')")
    @RequestMapping(value = "/user/settings", method = RequestMethod.GET)
    public String getSettingsForm(Model model) {
        SettingsForm settingsForm = new SettingsForm();
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = accountService.getUserDetailsByUsername(auth.getName());
        
        settingsForm.setId(userDetails.getId());
        settingsForm.setAddress(userDetails.getAddress());
        settingsForm.setCity(userDetails.getCity());
        settingsForm.setName(userDetails.getName());
        settingsForm.setSurname(userDetails.getSurname());

        model.addAttribute("settingsForm", settingsForm);
        model.addAttribute("user", userDetails.getUser());
        
        return SETTINGS_FORM;
    }
    
    @PreAuthorize("hasAnyRole('USER','ADMIN')")
    @RequestMapping(value = "/user/settings", method = RequestMethod.POST)
    public String changeSettings(
            @ModelAttribute("settingsForm") 
            @Valid SettingsForm form,
            BindingResult result,
            Model model) {

        if (result.hasErrors()) {
            
            return SETTINGS_FORM;
        } else {
            UserDetails userDetails = toUserDetails(form);
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();

            accountService.updateUserDetails(userDetails, auth.getName());
            model.addAttribute("user", userDetails.getUser());
            
            return SETTINGS_OK;
        }
    }
    
    @RequestMapping(value = "/user/profile/{username}", method = RequestMethod.GET)
    public String showProfileUser(
            @PathVariable String username,
            Model model) {

        UserDetails userDetails = accountService.getUserDetailsByUsername(username);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        model.addAttribute("authUsername", auth.getName());
        model.addAttribute("userDetails", userDetails);
        
        return PROFILE;
    }
    
    @PreAuthorize("hasAnyRole('USER','ADMIN')")
    @RequestMapping(value = "/user/profile", method = RequestMethod.GET)
    public String showMyProfile(Model model) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = accountService.getUserDetailsByUsername(auth.getName());
        model.addAttribute("authUsername", auth.getName());
        model.addAttribute("userDetails", userDetails);
        
        return PROFILE;
    }

    private static User toAccount(AccountForm form) {
        User user = new User();
        user.setLogin(form.getLogin());
        user.setEmail(form.getEmail());
        user.setPassword(form.getPassword());
        
        return user;
    }

    private static UserDetails toUserDetails(SettingsForm form) {
        UserDetails userDetails = new UserDetails();
        userDetails.setId(form.getId());
        userDetails.setAddress(form.getAddress());
        userDetails.setCity(form.getCity());
        userDetails.setName(form.getName());
        userDetails.setSurname(form.getSurname());
        
        return userDetails;
    }


}
