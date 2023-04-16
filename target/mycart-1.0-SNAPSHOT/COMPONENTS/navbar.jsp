<%@page import="com.mycompany.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.mycart.helper.FactoryProvider"%>
<%@page import="com.mycompany.mycart.dao.CategoryDao"%>
<%@page import="com.mycompany.mycart.entities.User"%>
<%
    User user1 = (User) session.getAttribute("current-user");
%>

<nav class="navbar navbar-expand-lg navbar-dark" style="background:#673ab7!important; ">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">MyCart</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Categories
                    </a>
                    
                    <%
                        CategoryDao cDao1=new CategoryDao(FactoryProvider.getFactorty());
                        List<Category> categoryList1=cDao1.getCategoris();
                      
                    %>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <%
                            for(Category c:categoryList1){
                        %>
                        <a class="dropdown-item" href="index.jsp?category=<%= c.getCategoryId()%>"><%= c.getCategoryTitle() %></a>
                        <div class="dropdown-divider"></div>
                        <%
                            }
                        %>
                        
                    </div>
                </li>

            </ul>

            <ul class="navbar-nav ml-auto"> 
                
                 <li class="nav-item active">
                     <a class="nav-link" data-toggle="modal" data-target="#cartModal" href="#"><i class="fa fa-cart-plus" style="font-size: 20px;" ></i><span class="mt-0 cart-items">(0)</span></a>
                </li>
                
                <%
                    if (user1 == null) {
                %>

                <li class="nav-item active">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
                <%
                } else {
                %>

                <li class="nav-item active">
                   <%
                       if(user1.getUserType().equals("admin")){
                           %>
                            <a class="nav-link" href="admin.jsp"><%= user1.getUserName() %></a>
                       <%}else if(user1.getUserType().equals("normal")){
                           %>
                            <a class="nav-link" href="normal.jsp"><%= user1.getUserName() %></a>
                       <%}
                   %>
                   
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="LogoutServlet">Logout</a>
                </li>


                <%
                    }
                %>
            </ul>
        </div>


    </div>
</nav>