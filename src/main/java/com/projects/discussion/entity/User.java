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

package com.projects.discussion.entity;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * @author Piotr Baran <admin@piotrus.net.pl>
 */
@NamedQuery(
        name = "findUserByLogin",
        query = "from User where login = :login")
@Entity
@Table(name="user")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="id", nullable = false)
    private Long id;

    @NotNull
    @Size(min = 3, max = 100)
    @Column(name="login", nullable = false)
    private String login;
    
    @NotNull
    @Size(min = 3, max = 100)
    @Column(name="password", nullable = false)
    private String password;
    
    @NotNull
    @Size(min = 6, max = 512)
    @Column(name="email", nullable = false)
    private String email;
    
    @Column(name="active", nullable = false)
    private int active;
   
    @Column(name="joined", insertable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date joined;
    
    @JoinColumn(name="type")
    @ManyToOne(fetch = FetchType.EAGER)
    private UserRoles type;
    
//    @OneToMany(fetch = FetchType.LAZY, mappedBy = "topic")
//    private List<Topic> userList;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        String hash = null;
        try {
            MessageDigest sha2 = MessageDigest.getInstance("SHA-256");
            sha2.update(password.getBytes());
            BigInteger code = new BigInteger(1, sha2.digest());
            hash = code.toString(16);
        } catch (NoSuchAlgorithmException nsax) {
            // ignore
        }
        this.password = hash;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public Date getJoined() {
        return joined;
    }

    public void setJoined(Date joined) {
        this.joined = joined;
    }

    public UserRoles getType() {
        return type;
    }

    public void setType(UserRoles type) {
        this.type = type;
    }
}
