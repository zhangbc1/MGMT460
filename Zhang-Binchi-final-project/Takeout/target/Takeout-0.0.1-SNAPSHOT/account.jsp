<%--
  Created by IntelliJ IDEA.
  User: zhangbinchi
  Date: 12/7/21
  Time: 00:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.jms.Session.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Users Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="index.css"/>
    <link rel="stylesheet" type="text/css" href="users.css"/>
    <script src="minicart.js"></script>
</head>
<body>
<div class="header-area absolate-header">
    <div class="sticky-area">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-2">
                    <div class="logo">
                        <a href="index.html">Chinese Food Restaurant</a>
                    </div>
                    <div class="responsive-menu-wrap" style="display: none;"></div>
                </div>
                <div class="col-lg-8">
                    <div class="main-menu text-center">
                        <ul id="navigation">
                            <li class="smooth-menu"><a href='index.html'><span>Home</span></a></li>
                            <li class="smooth-menu"><a href='menu.jsp'><span>MENU</span></a></li>
                            <li class="smooth-menu"><a href='cart.jsp'><span>CART</span></a></li>
                            <li class="smooth-menu"><a href='users.jsp'><span>USER CENTER</span></a></li>
                            <li class="smooth-menu"><a href='about.html'><span>ABOUT</span></a></li>
                            <li class="smooth-menu"><a href='login.jsp'><span>LOG IN</span></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-2 text-center" style="display: block;background-color: #FF6900">
                    <div class="cart-contact">
                        <div class="mini-cart">
                            <button class="cart-toggle-btn"> <span class="cart-count"><a id="minicart" href="cart.jsp">0</a></span>
                                <i class="las la-shopping-bag"></i> </button>
                        </div>
                        <a href="menu.jsp" class="boxed-btn top">Order Online</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    HttpSession Session=(HttpSession) request.getSession();
    if (Session.getAttribute("UserName")==null
            || Session.getAttribute("UserName").toString().isEmpty()){
        request.getRequestDispatcher("login.jsp").forward(request, response);}
    else {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");
        Statement Cmd = Con.createStatement();
        //out.println(sql);
        String id = Session.getAttribute("ID").toString();
        String UserName =request.getParameter("txUserName");
        String Email =request.getParameter("txEmail");
        String Password =request.getParameter("txPassword");
        String BillAddress =request.getParameter("txBillAddress");
        String sql = String.format("UPDATE Users SET UserName='%s',Email='%s',Password='%s',BillAddress='%s' WHERE ID='%s'", UserName, Email, Password,BillAddress,id);
        ResultSet Dat = null;
        try {
            Cmd.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Cmd.close();
        Con.close();
    }
%>
<form method="post" action="">
    UserName: <input type="text" name="txUserName"><br>
    Email: <input type="text" name="txEmail"><br>
    Password:<input type="text" name="txPassword"><br>
    Bill Address:<input type="text" name="txBillAddress"><br>
    <input type="submit" value="Update">
</form>
</body>
</html>
