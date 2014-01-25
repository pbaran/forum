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

import com.projects.discussion.entity.Post;
import com.projects.discussion.entity.Topic;
import com.projects.discussion.form.AccountForm;
import com.projects.discussion.form.PostForm;
import com.projects.discussion.service.ForumService;
import java.util.Date;
import java.util.List;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@Controller
public class ForumController {
    private static final Logger log = LoggerFactory.getLogger(ForumController.class);
    private static final String CATEGORY_WITHOUT_TOPICS_VIEW = "forum/category-without-topics";
    private static final String TOPICS_VIEW = "forum/list-topics";
    private static final String TOPIC_VIEW = "forum/topic";
    
    @Autowired
    private ForumService forumService;
    
    @RequestMapping(value = "category/{categoryId}", method = RequestMethod.GET)
    public String showListTopics(@PathVariable Long categoryId, Model model) {
        List<Topic> topicList = forumService.getTopicsByCategory(categoryId);
        
        if (topicList.isEmpty()) {
            model.addAttribute("category", forumService.getCategoryById(categoryId));
            
            return CATEGORY_WITHOUT_TOPICS_VIEW;
        } else {
            Date currentDate = new Date();
            long msec = currentDate.getTime(),
                day = 24 * 60 * 60 * 1000;

            model.addAttribute("topicList", topicList);
            model.addAttribute("sevenDaysBack", msec - 7*day);

            return TOPICS_VIEW;
        }
    }
    
    @RequestMapping(value = "/topic/{name}", method = RequestMethod.GET)
    public String getTopic(@PathVariable String name, Model model) {
        Long topicId = forumService.getTopicIdByTitleSeo(name);

        model.addAttribute("topic", forumService.getTopic(topicId));
        model.addAttribute("postsList", forumService.getPostsByTopicId(topicId));
        model.addAttribute("post", new PostForm());
   
        return TOPIC_VIEW;
    }
    
    @RequestMapping(value = "/topic/{name}", method = RequestMethod.POST)
    public String sendPost(
            @ModelAttribute("post") @Valid PostForm form,
            @PathVariable("name") String titleSeoThread,
            BindingResult result,
            Model model) {

        Long topicId = forumService.getTopicIdByTitleSeo(titleSeoThread);
        Topic topic = forumService.getTopic(topicId);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Post post;

        model.addAttribute("topic", topic);
        model.addAttribute("postsList", forumService.getPostsByTopicId(topicId));
        model.addAttribute("post", new PostForm());

        if (result.hasErrors()) {
            return TOPIC_VIEW;
        }

        //@TODO create post and update data to a transcation!
        
        // create new post for thread
        post = forumService.createPost(titleSeoThread, auth.getName(), form.getContent());

        //update lastPost and lastPoster field in topic entity
        forumService.updateTopic(topicId, new Date(), post.getAuthor());
        
        //update lastActiveTopic field in category entity
        forumService.updateLastActiveTopicInCategory(topic);
        
        return "redirect:/topic/" + titleSeoThread + "#post-" + post.getId();
    }
}
