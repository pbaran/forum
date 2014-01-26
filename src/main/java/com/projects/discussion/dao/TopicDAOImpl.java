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

package com.projects.discussion.dao;

import com.projects.discussion.dao.hibernate.AbstractHbnDao;
import com.projects.discussion.entity.Topic;
import com.projects.discussion.entity.User;
import java.util.Date;
import java.util.List;
import org.springframework.stereotype.Repository;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@Repository
public class TopicDAOImpl extends AbstractHbnDao<Topic> implements TopicDAO {

    public List<Topic> getTopicsByCategoryId(Long categoryId) {
        return getSession()
            .createQuery("from Topic t where t.category.id = :categoryId order by t.lastPost desc")
            .setParameter("categoryId", categoryId)
            .list();
    }
    public Long getTopicIdByTitleSeo(String titleSeo) {
        return ((Long) getSession()
            .createQuery("select t.id from Topic t where titleSeo = :titleSeo")
            .setParameter("titleSeo", titleSeo).iterate().next() ).longValue();
    }

    public Topic getTopic(Long topicId) {
        return (Topic) getSession()
            .createQuery("from Topic where id = :id")
            .setParameter("id", topicId)
            .uniqueResult();
    }

    public void updateLastPostAndLastPoster(Long topicId, Date lastPost, User lastPoster) {
        Topic topicToUpdate = get(topicId);
        topicToUpdate.setLastPost(lastPost);
        topicToUpdate.setLastPoster(lastPoster);
        topicToUpdate.setPosts(topicToUpdate.getPosts()+1);
        update(topicToUpdate);
    }

}
