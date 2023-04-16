<%
    User user=(User)session.getAttribute("current-user");
    if(user==null){
        session.setAttribute("message", "Please Login First before Preceseding Checkout");
        response.sendRedirect("login.jsp");
       return;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CheckOut : MyCart</title>
        <%@include file="COMPONENTS/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="COMPONENTS/navbar.jsp" %>
        <div class="container-fluid">
            <div class="row mt-5">
                <div class="col-md-6 car">
                    <!--cart-->
                    <div class="card">
                        <div class="card-header custom-bg text-center text-white">
                            <span class="fa fa-location-arrow"></span>
                            <br>
                            <br>
                            <h3> Your Selected Items</h3>
                        </div>
                        <div class="card-body">
                            <div class="cart-body">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <!--user details-->



                    <div class="card">

                        <div class="card-header text-center custom-bg text-center text-white">
                            <span class="fa fa-map-marker"></span>

                            <br>
                            <h3 class="text-center my-3 ">Delivery Address</h3>
                        </div>
                        <div class="card-body px-5">
                            <form action="RegisterServlet" method="post">

                                <div class="form-group">
                                    <span class="fa fa fa-user-circle"></span>
                                    <label for="InputUsername">Username</label>
                                    <input name="user_name" type="text" value="<%= user1.getUserName() %>" class="form-control" id="InputUsername"  placeholder="Enter Username">
                                    <label for="InputEmail">Email</label>
                                    <input name="user_email" type="email" value="<%= user1.getUserEmail() %>"class="form-control" id="InputEmail"  placeholder="Enter Email">
                                    <label for="InputPhone">Phone</label>
                                    <input name="user_phone" type="text" value="<%= user1.getUserPhone() %>" class="form-control" id="InputPhone"  placeholder="Enter Phone">
                                    <label for="InputAddress">Delivery Address</label>
                                    <textarea name="user_address"  style="height: 200px;" class="form-control"  placeholder="Enter Address"><%= user1.getUserAddress().trim() %></textarea>
                                </div>
                                <div class="container text-center ">
                                    <button class="btn btn-outline-success">Order Now</button>
                                    <button class="btn btn-outline-primary"><a href="index.jsp" >Continue Shopping</a></button>

                            </form>

                        </div>

                    </div>
                </div>


            </div>

        </div>
    </div>
</body>
</html>
