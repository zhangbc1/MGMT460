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
    <title>Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="index.css"/>
    <link rel="stylesheet" type="text/css" href="menu.css"/>
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
<br>
<br>
<br>
<div id="menu" class="menu-area section-padding">
    <div class="container">
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
                } %>
        <% if(count%3 == 0){ %>
        <div class="row">
            <%}%>
        <div class="col-lg-4 col-md-4">
            <div class="single-menu-item">
                <img class="pic" src="<%=Dat.getString("Image") %>" style="overflow: hidden;width:250px;height:200px"/>
                <h6 class = "foodname"><%=Dat.getString("FoodName") %></h6>
                <p class ="description"><%=Dat.getString("Description") %> </p>
                <p class="price-tag"><%=Dat.getString("Price") %> Plus Tax</p>
                <p class="foodid" style="display: none"><%=Dat.getString("ID")%></p>
                <a href="javascript:void(0)" class="order-btn">Add to Cart</a>
            </div>
        </div>
            <% if(count%3 == 2){ %>
            </div>
                <%}%>

        <%String FoodName = Dat.getString("FoodName");
            //String OneRow = String.format("%s",FoodName);
            //out.println(OneRow);
            count++;
        }
            Dat.close();
            Cmd.close();
            Con.close();
        %>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded",load);
    function load(){
        //event listener for the user add food to cart
        var btn = document.getElementsByClassName('order-btn');
        var i = 0;
        var foodname = document.getElementsByClassName('foodname');
        var price = document.getElementsByClassName("price-tag");
        var foodid = document.getElementsByClassName("foodid");
        for(i=0;i<btn.length;i++) {
            btn[i].addEventListener("click", storage);
            btn[i].foodname = foodname[i];
            btn[i].price = price[i];
            btn[i].foodid = foodid[i];
        }

    }
    function storage(evt) {
        if (localStorage.getItem(evt.currentTarget.foodname.innerHTML) == null) {
            var value = new Object();
            value.price = parseFloat(evt.currentTarget.price.innerHTML);
            value.count = 1;
            value.foodid = parseInt(evt.currentTarget.foodid.innerHTML);
            localStorage.setItem(evt.currentTarget.foodname.innerHTML,JSON.stringify(value));
        }else{
            var had = localStorage.getItem(evt.currentTarget.foodname.innerHTML);
            had = JSON.parse(had);
            had.count++;
            localStorage.setItem(evt.currentTarget.foodname.innerHTML,JSON.stringify(had));
        }
        location.reload();
    }

</script>

</body>
</html>