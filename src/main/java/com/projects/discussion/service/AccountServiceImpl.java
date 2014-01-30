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
import com.projects.discussion.dao.UserDetailsDAO;
import com.projects.discussion.dao.UserRolesDAO;
import com.projects.discussion.entity.User;
import com.projects.discussion.entity.UserDetails;
import com.projects.discussion.entity.UserRoles;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
    @Autowired
    private UserRolesDAO userRolesDao;
    @Autowired
    private UserDetailsDAO userDetailsDao;
    
    @Transactional(readOnly = false)
    public boolean registerAccount(User user, String password, Errors errors) {
        String hash = generateMD5Hash(password);
        
        user.setPassword(hash);
        user.setJoined(new Date());
        user.setActive(INACTIVE_USER);
        user.setType(getUserRole());
        
        //@TODO validate data

        userDao.create(user);
        
        UserDetails userDetails = new UserDetails();
        userDetails.setUser(user);
        userDetailsDao.create(userDetails);
        
        return true;
    }

    public List<User> getUsers() {
        return userDao.getAll();
    }

    public UserRoles getUserRole() {
        return userRolesDao.getUserRole();
    }
    
    private String generateMD5Hash(String password) {
        String hash = null;
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(password.getBytes(), 0, password.length());
            hash = new BigInteger(1, md5.digest()).toString(16);
            if (hash.length() < 32) {
                hash = "0" + hash;
            }
        } catch (NoSuchAlgorithmException nsax) {
            // ignore
        }
        return hash;
    }
}
