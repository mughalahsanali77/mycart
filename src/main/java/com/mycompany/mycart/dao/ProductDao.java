/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.mycart.dao;

import com.mycompany.mycart.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

/**
 *
 * @author Ahsan
 */
public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public boolean saveProduct(Product product){
    boolean f=false;
        try {
            Session session=this.factory.openSession();
            Transaction tx=session.beginTransaction();
            session.save(product);
            tx.commit();
            session.close();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
            f=false;
        }
    
    return f;
    }
    
    public List<Product> getAllProducts(){
        Session session=this.factory.openSession();
        Query query= session.createQuery("from Product");
        List<Product> list=query.list();
        return list;
    }
    
    public List<Product> getProductsbyCategory(int catId){
        Session session=this.factory.openSession();
        Query query= session.createQuery("from Product p WHERE p.category.categoryId =:id");
        query.setParameter("id", catId);
        List<Product> list=query.list();
        return list;
    }
}
