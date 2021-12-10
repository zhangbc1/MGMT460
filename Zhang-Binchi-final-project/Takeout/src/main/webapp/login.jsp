<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>

<%! int i; %>
<%! Array[] dish; %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log In </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="index.css"/>
    <link rel="stylesheet" type="text/css" href="login.css"/>
    <script type="text/javascript" src="login.js"></script>
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
    <div id="login_frame">
        <form method="post" action="login1.jsp">
            <p><label class="label_input">User name</label><input name="txUserName" class="text_field"/></p>
            <br>
            <p><label class="label_input">Password</label><input name="txPassword" class="text_field"/></p>
            <br>
                <div id="login_control">
                    <input type="submit" id="btn_login" value="Login"/>
                    <a id="signup" href="signup.jsp">Sign Up </a>
                </div>
        </form>
    </div>
</body>
</html>