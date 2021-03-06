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

import com.projects.discussion.entity.Category;
import com.projects.discussion.entity.Post;
import com.projects.discussion.entity.Topic;
import com.projects.discussion.entity.User;
import com.projects.discussion.form.ThreadForm;
import java.util.Date;
import java.util.List;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
public interface ForumService {
    public List<Topic> getTopicsByCategory(Long categoryId);
    public Topic getTopic(Long topicId);
    public Long getTopicIdByTitleSeo(String titleSeo);
    public List<Post> getPostsByTopicId(Long topicId);
    public Category getCategoryById(Long categoryId);
    public Post createPost(String titleSeoThread, String username, String content);
    public void updateTopic(Long topicId, Date lastPost, User lastPoster);
    public void updateLastActiveTopicInCategory(Topic lastActiveTopic);
    public void createThread(Long categoryId, String username, ThreadForm form);
    public void addCategory(Category category);
    public void removeCategory(Long id);
    public void updateCategory(Category category);
}
