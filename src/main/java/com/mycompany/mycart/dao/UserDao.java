/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.mycart.dao;

import org.hibernate.SessionFactory;
import org.hibernate.Session;
import com.mycompany.mycart.entities.User;
import org.hibernate.query.Query;
/**
 *
 * @author Ahsan
 */
public class UserDao {
    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    
    public User  getUserByEmailAndPaaswor(String email,String password){
        User user =null;
    
        try {
            String query="FROM User WHERE userEmail =: e AND userPassword =: p";
            Session session= this.factory.openSession();
            Query  q=session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p",password);
            
            user=(User) q.uniqueResult();
                        
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
    
}
