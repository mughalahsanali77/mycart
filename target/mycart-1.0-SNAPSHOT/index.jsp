<%-- 
    Document   : index
    Created on : Jan 1, 2023, 9:17:29 PM
    Author     : Ahsan
--%>

<%@page import="com.mycompany.mycart.helper.Helper"%>
<%@page import="com.mycompany.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.mycart.dao.CategoryDao"%>
<%@page import="com.mycompany.mycart.entities.Product"%>
<%@page import="com.mycompany.mycart.dao.ProductDao"%>
<%@page import="com.mycompany.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MyCart : HOME  </title>
    <%@include file="COMPONENTS/common_css_js.jsp"%>
</head>

<%@include file="COMPONENTS/navbar.jsp"%>

<div class="row mt-3 mx-2">
    <%        String cat = request.getParameter("category");
         ProductDao pDao = new ProductDao(FactoryProvider.getFactorty());
        List<Product> productList =null;
        CategoryDao cDao = new CategoryDao(FactoryProvider.getFactorty());
        List<Category> categoryList=cDao.getCategoris();
        
        if(cat==null ||cat.trim().equals("all")) {
             productList = pDao.getAllProducts();
        }else{
            int catId=Integer.parseInt(cat.trim());
             productList=pDao.getProductsbyCategory(catId);
        
        }

       


    %>



    <!--//categories-->
    <div class="col-md-2">


        <div class="list-group mt-4">

            <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                All Products
            </a>

            <%                    for (Category category : categoryList) {
            %>

            <a href="index.jsp?category=<%= category.getCategoryId()%>" class="list-group-item list-group-item-action"> <%= category.getCategoryTitle()%></a>
            <%
                }
            %>
        </div>

    </div>




    <!--//products-->
    <div class="col-md-10">

        <div class="row mt-4">
            <div class="col-md-12">

                <div class="card-columns">
                    <%
                        for (Product product : productList) {

                    %>
                    <div class="card product-card">
                        <div class="container text-center">
                            <img class="card-img-top m-2 "  src="img/product/<%=product.getpPhoto()%>" alt="Card image cap" style="max-height:250px; max-width:100%; width:auto;">

                        </div>

                        <div class="card-body">
                            <h5 class="card-title"><%= product.getpName()%></h5>
                            <p class="car-text"><%= Helper.get10Words(product.getpDesc())%></p>
                        </div>

                        <div class="card-footer text-center">
                            <button class="btn custom-bg text-white" onclick="add_to_cart(<%= product.getpId() %>,'<%= product.getpName() %>',<%= product.getPriceAfterDiscount() %> )">Add To Cart</button>
                            <button class="btn btn-outline-success ">&#8360; <%= product.getPriceAfterDiscount() %>/- <span class="text-secondary discount-label"> <i style="text-decoration: line-through!important;">&#8360; <%=product.getpPrice()%> </i><%=product.getpDiscount()%>% off  </span> </button>
                        </div>

                    </div>
                    <%

                        }

                        if(productList.size()==0){
                            Category cate=cDao.getCategoryById(Integer.parseInt(cat));
                        out.println("<h3>No Item is is added in "+cate.getCategoryTitle()+" </h3>");
                        
                        
                        }
                    %>
                    
                </div>

            </div>

        </div>
    </div>
</div>

