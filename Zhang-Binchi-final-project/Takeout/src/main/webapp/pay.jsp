<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.jms.Session.*" %>
<%@ page import="javax.swing.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="index.css"/>
    <link rel="stylesheet" type="text/css" href="about.css"/>
    <title>Pay for the foods</title>
    <script src="cart.js"></script>
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

<div class="container" style="margin: 0 auto;">
    <div class="location" >
        <div class="address-title">
    <div class="row">
        <div class="col-lg-6 col-md-6">
            <div class="w-100"></div>
            <tr class="count">
                <td colspan="7">
                    <div class="jiesuan clearfix">
                        <p id="items"></p>
                        <p id="am"> </p>
                        <p id="discount">discount：-$0.00</p>
                        <!-- <div><a href="#" class="btn pay">结算</a></div> -->
                    </div>
                </td>
            </tr>

            <form method="post" action="">
                        <h2 class="wow slideInDown">Credit Card Number</h2>
                        <input name="txCredit" placeholder="credit card number">
                        <br>
                        <h2 class="wow slideInDown">security code</h2>
                        <input name="txSecurity" placeholder="security code">
                        <br>
                        <h2 class="wow slideInDown">expires date</h2>
                        <input name="txExpires" placeholder="expires date">
                        <br>
                        <input id="pay" type="submit" onsubmit="return false" value="check out the order">

            </form>
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
         String ID = Session.getAttribute("ID").toString();
         Class.forName("com.mysql.cj.jdbc.Driver");
        Connection Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");
        Statement Cmd = Con.createStatement();
        //out.println(sql);
        String CreditCardNumber =request.getParameter("txCredit");
        String SecurityCode =request.getParameter("txSecurity");
        String ExpiresDate =request.getParameter("txExpires");

        String sql = String.format("UPDATE Users SET CreditCardNumber='%s',SecurityCode='%s',ExpiresDate='%s' WHERE ID='%s'", CreditCardNumber, SecurityCode, ExpiresDate,ID);

        try {
                Cmd.executeUpdate(sql);
                        }
        catch (SQLException e) {
                    e.printStackTrace();
                }
        String SQL = String.format("INSERT INTO Orders(UserID) VALUES('%s')",ID);
        try {
                Cmd.executeUpdate(SQL);
                        }
        catch (SQLException e) {
                    e.printStackTrace();
                }
        Cmd.close();
        Con.close();
                }

%>
    <script>
        document.getElementById("pay").addEventListener("click",function (){
            let foods = [];
            for(let num=0;num<localStorage.length;num++){
                let key = localStorage.key(num);
                let product = JSON.parse(localStorage.getItem(key));
                let food = {};
                food.foodID = product.foodid;
                food.price = product.price;
                food.quantity = product.count;
                foods.push(food);
            }
            let param = {foods:foods};
            let params = {paymoney:JSON.stringify(param)};
            let url = new URL("http://127.0.0.1:3000/pay");
            url.search = new URLSearchParams(params).toString();
            fetch(url.toString()).then(response=>{
                return response;
            }).then((res)=>{
                console.log(res);
            });
        });
    </script>

</body>
</html>