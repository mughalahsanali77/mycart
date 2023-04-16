/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.mycart.servlets;

import com.mycompany.mycart.dao.CategoryDao;
import com.mycompany.mycart.dao.ProductDao;
import com.mycompany.mycart.entities.Category;
import com.mycompany.mycart.entities.Product;
import com.mycompany.mycart.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Ahsan
 */
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String operation = request.getParameter("operation");

            if (operation.trim().equals("addcategory")) {
                String categoryTitle = request.getParameter("category-title");
                String categoryDetail = request.getParameter("category-detail");
                Category category = new Category(categoryTitle, categoryDetail);
                CategoryDao dao = new CategoryDao(FactoryProvider.getFactorty());
                int catId = dao.saveCategory(category);
                HttpSession session = request.getSession();
                if (catId != -1) {
                    session.setAttribute("message", "Category Added Successfully");
                    response.sendRedirect("admin.jsp");
                    return;
                } else {
                    session.setAttribute("message", "Category not Added");
                    response.sendRedirect("admin.jsp");
                    return;
                }

            } else if (operation.trim().equals("addproduct")) {

                String productName = request.getParameter("productName");
                String productDescription = request.getParameter("productDetail");
                int productPrice = Integer.parseInt(request.getParameter("productPrice"));
                int productDiscount = Integer.parseInt(request.getParameter("productDiscount"));
                int productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                Part part = request.getPart("productPicture");

                Product p = new Product();
                p.setpName(productName);
                p.setpDesc(productDescription);
                p.setpPrice(productPrice);
                p.setpDiscount(productDiscount);
                p.setpQuantity(productQuantity);
                p.setpPhoto(part.getSubmittedFileName());

                //get Category by id
                CategoryDao cDao = new CategoryDao(FactoryProvider.getFactorty());
                Category category = cDao.getCategoryById(categoryId);

                p.setCategory(category);

                ProductDao pDao = new ProductDao(FactoryProvider.getFactorty());
        
                 boolean f= pDao.saveProduct(p);
                ////file uploading

                //getting file`s path
                String path = request.getRealPath("/img") + File.separator + "product" + File.separator + part.getSubmittedFileName();
                System.out.println(path);
                try {
                    ///reading data

                    InputStream is = part.getInputStream();
                    byte data[] = new byte[is.available()];
                    is.read(data);

                    //writing data
                    FileOutputStream fos = new FileOutputStream(path);
                    fos.write(data);
                    fos.flush();
                    fos.close();
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }

                HttpSession session = request.getSession();
                if (f = true) {
                    session.setAttribute("message", "Product Have Been Added Successfully");
                    response.sendRedirect("admin.jsp");
                    return;
                } else {
                    session.setAttribute("message", "Something went wrong ,please try again");
                    response.sendRedirect("admin.jsp");
                    return;
                }

            }//end elseif
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
