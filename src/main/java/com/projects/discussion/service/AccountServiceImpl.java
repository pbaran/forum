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

package com.projects.discussion.service;

import com.projects.discussion.dao.UserDAO;
import com.projects.discussion.entity.User;
import java.util.Date;
import java.util.List;
import javax.inject.Inject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.Errors;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@Service("accountService")
@Transactional(readOnly = true)
public class AccountServiceImpl implements AccountService {
    private static final int INACTIVE_USER = 0;
    private static final int ACTIVE_USER = 1;
    
    @Autowired
    private UserDAO userDao;
    
    @Transactional(readOnly = false)
    public boolean registerAccount(User user, String password, Errors errors) {
        String salt = "tyD";
        
        user.setPassword(salt + password);//generate sha2 hash
        user.setJoined(new Date());
        user.setActive(INACTIVE_USER);
        
        //@TODO validate data

        userDao.create(user);
        
        return true;
    }

    public List<User> getUsers() {
        return userDao.getAll();
    }
    
}
