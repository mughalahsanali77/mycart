<%@page import="com.mycompany.mycart.entities.User"%>
<%
   User user=(User) session.getAttribute("current-user");
   if(user==null){
       session.setAttribute("message", "You are not logged in,Login first");
       response.sendRedirect("login.jsp");
       return;
   }else{
       if(user.getUserType().equals("admin")){
       session.setAttribute("message", "only normal users can access this page");
       response.sendRedirect("admin.jsp");
           return;
       }
   }



%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Panel : MyCart</title>
        <%@include file="COMPONENTS/common_css_js.jsp"%>
    </head>
    <body>
        <%@include file="COMPONENTS/navbar.jsp" %>
        <%@include file="COMPONENTS/message.jsp" %>
        <h1>Hello normal user</h1>
       
    </body>
</html>
