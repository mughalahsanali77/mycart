<%-- 
    Document   : register
    Created on : Jan 3, 2023, 1:00:21 PM
    Author     : Ahsan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        
        <%@include file="COMPONENTS/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="COMPONENTS/navbar.jsp"%>
        <div class="container">
        <div class="row mt-5">
            <div class="col-md-4 offset-md-4">

                <div class="card">
                    <%@include file="COMPONENTS/message.jsp"%>
                    <div class="card-header text-center">
                        <span class="fa fa-user-plus"></span>
                         
                            <br>
                        <h3 class="text-center my-3">Signup here</h3>
                    </div>
                    <div class="card-body px-5">
                        <form action="RegisterServlet" method="post">
                    
                    <div class="form-group">
                        <span class="fa fa fa-user-circle"></span>
                        <label for="InputUsername">Username</label>
                        <input name="user_name" type="text" class="form-control" id="InputUsername"  placeholder="Enter Username">
                        <label for="InputEmail">Email</label>
                        <input name="user_email" type="email" class="form-control" id="InputEmail"  placeholder="Enter Email">
                        <label for="InputPassword">Password</label>
                        <input  name="user_password" type="Password" class="form-control" id="InputPassword"  placeholder="Enter Password">
                        <label for="InputPhone">Phone</label>
                        <input name="user_phone" type="text" class="form-control" id="InputPhone"  placeholder="Enter Phone">
                        <label for="InputAddress">Address</label>
                        <textarea name="user_address" style="height: 200px;" class="form-control"  placeholder="Enter Address"></textarea>
                    </div>
                        <div class="container text-center ">
                        <button class="btn btn-outline-success">Register</button>
                        <button class="btn btn-outline-warning">Reset</button>
                        </div>

                </form>

                    </div>
                   
                    </div>
                </div>

            </div>
        </div>
        </div>
    </body>
</html>
