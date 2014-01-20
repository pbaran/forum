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

package com.projects.discussion.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@Entity
@Table(name="topic")
public class Topic {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="id", nullable = false, unique = true)
    private Long id;

    @JoinColumn(name = "category_id", nullable = false)
    @ManyToOne(fetch = FetchType.EAGER)
    private Category category;
    
    @Column(name="title", nullable = false)
    private String title;
    
    @Column(name="description", nullable = false)
    private String description;
    
    @JoinColumn(name="author_id", nullable = false)
    @ManyToOne(fetch = FetchType.EAGER)
    private User author;
    
    @Column(name="posts")
    private Long posts;
    
    @Column(name="last_poster_id", nullable = false)
    private Long lastPosterId;
    
    @Column(name="start_date", insertable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date startDate;
    
    @Column(name="last_post", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastPost;
    
    @Column(name="title_seo", nullable = false)
    private String titleSeo;
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Long getPosts() {
        return posts;
    }

    public void setPosts(Long posts) {
        this.posts = posts;
    }

    public Long getLastPosterId() {
        return lastPosterId;
    }

    public void setLastPosterId(Long lastPosterId) {
        this.lastPosterId = lastPosterId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getLastPost() {
        return lastPost;
    }

    public void setLastPost(Date lastPost) {
        this.lastPost = lastPost;
    }

    public String getTitleSeo() {
        return titleSeo;
    }

    public void setTitleSeo(String titleSeo) {
        this.titleSeo = titleSeo;
    }
}
