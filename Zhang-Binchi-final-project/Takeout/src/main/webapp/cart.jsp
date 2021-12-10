<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%! int i; %>
<%! Array[] dish; %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="index.css"/>
    <link rel="stylesheet" type="text/css" href="menu.css"/>
    <link rel="stylesheet" type="text/css" href="cart.css"/>
    <script src="cart.js"></script>
    <script src="minicart.js"></script>

</head>
<body id="cart-body">
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
                            <li class="smooth-menu"><a href='login.jsp'><span id="spLogin">LOG IN</span></a></li>
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
<br>
<div class="container">
    <div class="row">
        <div class="col-3 col-sm-3">Product Information</div>
        <div class="col-3 col-sm-3">Price</div>
        <div class="col-3 col-sm-3">Number Of Product</div>
        <div class="col-3 col-sm-3">ACT</div>

        <!-- Force next columns to break to new line -->
        <div class="w-100"></div>
    </div>
</div>

<div>
        <tr class="count">
            <td colspan="7">
                <div class="jiesuan clearfix">
                    <div class="right fr clearfix">
                        <p id="items"></p>
                        <p id="am"> </p>
                        <p id="discount">discount：-$0.00</p>
                        <!-- <div><a href="#" class="btn pay">结算</a></div> -->
                        <a href="pay.jsp" class="btn pay fr" style="background-color: #cccccc;">check out</a>
                    </div>
                </div>
            </td>
        </tr>
</div>
<script>


</script>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    Connection Con = null;
    try {
        Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");
    } catch (SQLException e) {
        e.printStackTrace();
    }
    assert Con != null;
    Statement Cmd = null;
    try {
        Cmd = Con.createStatement();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    String SQL = "select * from Food";
    ResultSet Dat = null;
    try {
        Dat = Cmd.executeQuery(SQL);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    int count=0;
    while (true) {
        try {
            if (!Dat.next()) break;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>