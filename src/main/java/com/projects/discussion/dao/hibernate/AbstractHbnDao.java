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

package com.projects.discussion.dao.hibernate;

import com.projects.discussion.dao.Dao;
import java.io.Serializable;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.util.Date;
import java.util.List;
import javax.inject.Inject;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.util.ReflectionUtils;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
public abstract class AbstractHbnDao<T extends Object> implements Dao<T>{
    @Inject
    private SessionFactory sessionFactory;
    private Class<T> domainClass;
    
    protected Session getSession() {
        return sessionFactory.getCurrentSession();
    }
    
    @SuppressWarnings("unchecked")
    private Class<T> getDomainClass() {
        if (domainClass == null) {
            ParameterizedType thisType = (ParameterizedType) getClass().getGenericSuperclass();
            this.domainClass = (Class<T>) thisType.getActualTypeArguments()[0];
        }
        return domainClass;
    }
    
    private String getDomainClassName() {
        return getDomainClass().getName();
    }
    
    public void create(T t) {
        Method method = ReflectionUtils.findMethod(
            getDomainClass(), "setDateCreated",
            new Class[] {Date.class});
        if (method != null) {
            try {
                method.invoke(t, new Date());
            } catch (Exception e) {
                /* ignore */
            }
            getSession().save(t);
        }
    }
    
    @SuppressWarnings("unchecked")
    public T get(Serializable id) {
        return (T) getSession().get(getDomainClass(), id);
    }
    
    @SuppressWarnings("unchecked")
    public T load(Serializable id) {
        return (T) getSession().load(getDomainClass(), id);
    }
    
    @SuppressWarnings("unchecked")
    public List<T> getAll(){
        return getSession().createQuery("from " + getDomainClassName()).list();
    }
    
    public void update(T t) {
        getSession().update(t);
    }
    
    public void delete(T t) {
        getSession().delete(t);
    }
}
