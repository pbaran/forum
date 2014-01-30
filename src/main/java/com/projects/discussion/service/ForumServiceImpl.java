/*
 * The MIT License
 *
 * Copyright 2014 Piotr Baran <admin@piotrus.net.pl>.
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

package com.projects.discussion.service;

import com.projects.discussion.dao.CategoryDAO;
import com.projects.discussion.dao.PostDAO;
import com.projects.discussion.dao.TopicDAO;
import com.projects.discussion.dao.UserDAO;
import com.projects.discussion.entity.Category;
import com.projects.discussion.entity.Post;
import com.projects.discussion.entity.Topic;
import com.projects.discussion.entity.User;
import com.projects.discussion.form.ThreadForm;
import com.projects.discussion.helper.Slug;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@Service("forumService")
@Transactional(readOnly = true)
public class ForumServiceImpl implements ForumService {
    
    @Autowired
    private TopicDAO topicDao;
    @Autowired
    private PostDAO postDao;
    @Autowired
    private UserDAO userDao;
    @Autowired
    private CategoryDAO categoryDao;

    public List<Topic> getTopicsByCategory(Long categoryId) {
        return topicDao.getTopicsByCategoryId(categoryId);
    }

    public List<Post> getPostsByTopicId(Long topicId) {
        return postDao.getPostsByTopicId(topicId);
    }

    public Long getTopicIdByTitleSeo(String titleSeo) {
        return topicDao.getTopicIdByTitleSeo(titleSeo);
    }

    public Topic getTopic(Long topicId) {
        return topicDao.getTopic(topicId);
    }

    public Category getCategoryById(Long categoryId) {
        return categoryDao.get(categoryId);
    }

    @Transactional(readOnly = false)
    public Post createPost(String titleSeoThread, String username, String content) {
        Post post = new Post();

        post.setAuthor(userDao.getUserByUsername(username));
        post.setAuthorName(username);
        post.setContent(content);
        post.setTopicId(topicDao.getTopicIdByTitleSeo(titleSeoThread));

        postDao.create(post);
        return post;
    }

    @Transactional(readOnly = false)
    public void updateTopic(Long topicId, Date lastPost, User lastPoster) {
        topicDao.updateLastPostAndLastPoster(topicId, lastPost, lastPoster);
    }

    @Transactional(readOnly = false)
    public void updateLastActiveTopicInCategory(Topic lastActiveTopic) {
        categoryDao.updateLastActiveTopic(lastActiveTopic);
    }

    @Transactional(readOnly = false)
    public void createThread(Long categoryId, String username, ThreadForm form) {
        Topic topic = new Topic();
        User poster = userDao.getUserByUsername(username);
        Category category = categoryDao.get(categoryId);
        
        topic.setAuthor(poster);
        topic.setCategory(category);
        topic.setDescription(form.getDescription());
        topic.setLastPoster(poster);
        topic.setPosts(0L);
        topic.setLastPost(new Date());
        topic.setTitle(form.getTitle());
        topic.setTitleSeo(Slug.parse(form.getTitle()));

        // create new thread
        topicDao.create(topic);
        
        // update number of topics and last active topic in category
        category.setTopics(category.getTopics() + 1);
        category.setLastActiveTopic(topic);
        
        //update number of topics and last poster in category
        categoryDao.update(category);
    }

    @Transactional(readOnly = false)
    public void addCategory(Category category) {
        categoryDao.create(category);
    }    

    @Transactional(readOnly = false)
    public void removeCategory(Long id) {
        categoryDao.deleteById(id);
    }

    @Transactional(readOnly = false)
    public void updateCategory(Category category) {
        categoryDao.update(category);
    }
}
