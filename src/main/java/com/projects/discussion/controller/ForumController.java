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

import com.projects.discussion.entity.Topic;
import com.projects.discussion.service.ForumService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@Controller
public class ForumController {
    private static final Logger log = LoggerFactory.getLogger(ForumController.class);
    private static final String TOPICS_VIEW = "forum/list-topics";
    private static final String TOPIC_VIEW = "forum/topic";
    
    @Autowired
    private ForumService forumService;
    
    @RequestMapping(value = "category/{categoryId}", method = RequestMethod.GET)
    public String showListTopics(@PathVariable Long categoryId, Model model) {
        model.addAttribute("topicList", forumService.getTopicsByCategory(categoryId));
        
        return TOPICS_VIEW;
    }
    
    @RequestMapping(value = "/topic/{name}", method = RequestMethod.GET)
    public String getTopic(@PathVariable String name, Model model) {
        Long topicId = forumService.getTopicIdByTitleSeo(name);

        model.addAttribute("topic", forumService.getTopic(topicId));
        model.addAttribute("postsList", forumService.getPostsByTopicId(topicId));
        
        return TOPIC_VIEW;
    }
}
