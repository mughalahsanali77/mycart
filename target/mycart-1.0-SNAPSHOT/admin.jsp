<%@page import="com.mycompany.mycart.helper.Helper"%>
<%@page import="java.util.Map"%>
<%@page import="com.mycompany.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.mycart.helper.FactoryProvider"%>
<%@page import="com.mycompany.mycart.dao.CategoryDao"%>
<%@page import="com.mycompany.mycart.entities.User"%>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "You are not logged in,Login first");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "only Admin can access this page");
            response.sendRedirect("normal.jsp");
            return;
        }
    }
      CategoryDao cDao = new CategoryDao(FactoryProvider.getFactorty());
                                List<Category> list = cDao.getCategoris();
    
Map<String,Long> m=Helper.getCount(FactoryProvider.getFactorty());


%>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel : MyCart</title>
        <%@include file="COMPONENTS/common_css_js.jsp"%>
    </head>
    <body>
        <%@include file="COMPONENTS/navbar.jsp" %>
        <%@include file="COMPONENTS/message.jsp" %>
        <div class="container admin">
            <div class="row mt-3">
                <!--column 1-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img src="img/users.png" alt="users_icon" class="img-fluid rounded-circle" style="max-width: 125px">
                            </div>

                            <h1><%= m.get("userCount") %></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>
                <!--column 2-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img src="img/categories_1.png" alt="categories_icon" class="img-fluid " style="max-width: 125px">
                            </div>
                            <h1><%=list.size()%></h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>
                </div>
                <!--column 3-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img src="img/products.png" alt="products_icon" class="img-fluid " style="max-width: 125px">
                            </div>
                            <h1><%=m.get("productCount")%></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row mt-3">
                <!--column 1-->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body text-center" data-toggle="modal" data-target="#add-category-Modal">
                            <div class="container">
                                <img src="img/apps.png" alt="add_category-icon" class="image-fluid " style="max-width: 125px;">
                            </div>
                            <p class="mt-2 text-muted ">Click here to add category</p>
                            <h1 class="text-muted text-uppercase" >add category</h1>
                        </div>
                    </div>
                </div>

                <!--column 2-->
                <div class="col-md-6">
                    <div class="card"  data-toggle="modal" data-target="#add-productModal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img src="img/add-to-basket.png" alt="add_product-icon" clas="image-fluid rounded-circle" style="max-width: 125px;">
                            </div>

                            <p class="mt-2 text-muted ">Click here to add product</p>
                            <h1 class="text-muted text-uppercase" >Add product</h1>
                        </div>
                    </div>
                </div>

            </div>


        </div>



        <!--add category modal-->



        <!-- Modal -->
        <div class="modal fade" id="add-category-Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">

                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="enter category title" name="category-title" required/>
                            </div>
                            <div class="form-group">
                                <textarea style="height:  250px" class="form-control" placeholder="eneter category detail" name="category-detail" required></textarea>

                            </div>
                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>



        <!--end add category modal-->





        <!--start add product modal-->


        <!-- Modal -->
        <div class="modal fade" id="add-productModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                            <input type="hidden" name="operation" value="addproduct">

                            <div class="form-group">
                                <input type="text" name="productName" class="form-control" placeholder="enter product title"  required/>
                            </div>

                            <div class="form-group">
                                <textarea style="height:  150px" class="form-control" placeholder="enter product detail" name="productDetail" required></textarea>   
                            </div>

                            <div class="form-group">
                                <input type="number" name="productPrice" class="form-control" placeholder="enter product price"  required/>
                            </div>

                            <div class="form-group">
                                <input type="number" name="productDiscount" class="form-control" placeholder="enter product discount"  required/>
                            </div>

                            <div class="form-group">
                                <input type="number" name="productQuantity" class="form-control" placeholder="enter product quantity"  required/>
                            </div>


                            


                            <div class="form-group">
                                <select name="categoryId" class="form-control"  >

                                    <%
                                        for (Category c : list) {
                                    %>
                                    <option value="<%=c.getCategoryId()%>"  ><%=c.getCategoryTitle()%></option>
                                    <%
                                        }
                                    %>

                                </select>

                            </div>


                            <div class="form-group">
                                <label for="pPic">select product`s picture</label><br>
                                <input type="file" class="from-control" id="pPic" name="productPicture"/>


                            </div>

                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>

                        </form>

                    </div>

                </div>
            </div>
        </div>


        <!--add product modal end-->

    </body>
</html>
