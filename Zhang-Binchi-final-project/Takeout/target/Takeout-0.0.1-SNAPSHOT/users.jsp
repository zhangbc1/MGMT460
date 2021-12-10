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
<div class="view-body" >
    <div class="view-sidebar" >
        <div class="sidebar-content" style="background-color: #657e65;">
            <div class="sidebar-nav">
                    <ul class="sidebar-trans">
                        <li>
                            <a href="account.jsp">
                                <span class="text-normal">Account Setting</span>
                            </a>
                        </li>
                        <br>
                        <li>
                            <a href="bigwheel.html">
                                <span class="text-normal">Big wheel</span>
                            </a>
                        </li>
                        <br>
                        <li>
                            <a href="logout.jsp">
                                <span class="text-normal">Log Out</span>
                            </a>
                        </li>
                        <li>
                            <a href="lock.jsp">
                                <span class="text-normal">Lock</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
   <div class="center-content">
       <div class="center-nav">
           <ul class="center-trans">
               <li>
                <span class="text-normal"></span>
               </li>
           </ul>
   </div>
   </div>
<script>
    //get create time(orders), food name + food price(food),Quantity(orderdetails)
    document.addEventListener("DOMContentLoaded",function (){
        let info = {};
        let param = {userid:"8"};
        let url = new URL("http://127.0.0.1:3000/test");
        url.search = new URLSearchParams(param).toString();
        console.log(url.toString());
        fetch(url.toString()).then(response=>{
            return response.json();
        }).then((res)=>{
            console.log(res);
            let historyContainer = document.createElement("div");
            historyContainer.classList.add("container");
            historyContainer.setAttribute("style","position: absolute;left:400px;top:300px;");
            for(let i = 0; i<res.length;i++){
                let newRow = document.createElement("div");
                newRow.classList.add("row");
                let date = document.createElement("div");
                date.classList.add("col");
                let fd = document.createElement("div");
                fd.classList.add("col");
                let price = document.createElement("div");
                price.classList.add("col")
                let qity = document.createElement("div");
                qity.classList.add("col");

                date.innerHTML = res[i].CreateTime;
                fd.innerHTML = res[i].FoodName;
                price.innerHTML = res[i].Price;
                qity.innerHTML = res[i].Quantity;

                newRow.appendChild(date);
                newRow.appendChild(fd);
                newRow.appendChild(price);
                newRow.appendChild(qity);

                historyContainer.appendChild(newRow);
            }
            document.body.appendChild(historyContainer)
        });

    })
</script>
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
        String SQL = String.format("select * from Orders where UserID='%s'",id);
        ResultSet Dat = null;
        try {
            Cmd.executeUpdate(SQL);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Cmd.close();
        Con.close();

    }
%>
<%--<%--%>
<%--    HttpSession Session=(HttpSession) request.getSession();--%>
<%--    if (Session.getAttribute("UserName")==null--%>
<%--            || Session.getAttribute("UserName").toString().isEmpty()){--%>
<%--        request.getRequestDispatcher("login.jsp").forward(request, response);}--%>
<%--    else {--%>
<%--        Class.forName("com.mysql.cj.jdbc.Driver");--%>
<%--        Connection Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");--%>
<%--        Statement Cmd = Con.createStatement();--%>
<%--        Connection sb = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");--%>
<%--        Statement nc = sb.createStatement();--%>
<%--        //out.println(sql);--%>
<%--        String id = Session.getAttribute("ID").toString();--%>
<%--        String SQL = String.format("select * from Orders where UserID='%s'",id);--%>
<%--        ResultSet Dat = null;--%>
<%--        String sql = String.format("select * from OrderDetails where OrderID='%s'",1);--%>
<%--        ResultSet inf = null;--%>
<%--        try {--%>
<%--            Dat = Cmd.executeQuery(SQL);--%>
<%--        } catch (SQLException e) {--%>
<%--            e.printStackTrace();--%>
<%--        }--%>
<%--        try {--%>
<%--            inf = nc.executeQuery(sql);--%>
<%--        } catch (SQLException e) {--%>
<%--            e.printStackTrace();--%>
<%--        }--%>
<%--        int count=0;--%>
<%--        %>--%>
<%--<div class="container" style="position: absolute;left:400px;top:300px;">--%>
<%--<%--%>
<%--    while (true) {--%>
<%--        try {--%>
<%--            if (!inf.next()) break;--%>
<%--        } catch (SQLException e) {--%>
<%--            e.printStackTrace();--%>
<%--        }%>--%>
<%--        <div class="row">--%>
<%--        <%=inf.getString("FoodID")%>--%>
<%--        </div>--%>
<%--    <%} %>--%>
<%--       <% while (true) {--%>
<%--            try {--%>
<%--                if (!Dat.next()) break;--%>
<%--            } catch (SQLException e) {--%>
<%--                e.printStackTrace();--%>
<%--            }--%>
<%--%>--%>
<%--    <div class="row">--%>
<%--    <%=Dat.getString("CreateTime")%>--%>
<%--    </div>--%>
<%--    <%}%>--%>
<%--</div>--%>

<%--&lt;%&ndash;<div class="account-product margin-big-top">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <div class="text-box-main padding-big fl mine-product" style="position: absolute;left:400px;top:300px;">&ndash;%&gt;--%>
<%--&lt;%&ndash;        <h2 class="h6 margin-big-bottom">History Orders</h2>&ndash;%&gt;--%>
<%--&lt;%&ndash;        <div class="mine-product-content clearfix">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <ul class="w50 fl lists">&ndash;%&gt;--%>
<%--&lt;%&ndash;                <li class="w70 lists-border-list">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <p class="border-list-text"> <em class="orange"></em></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </li>&ndash;%&gt;--%>

<%--&lt;%&ndash;                <li class="w70 lists-border-list">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <p class="border-list-text">Order 2： <em class="orange">xx</em>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <li class="w70 lists-border-list">&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <p class="border-list-text">Order 3： <em class="orange">xx</em>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    </p>&ndash;%&gt;--%>
<%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
<%--&lt;%&ndash;            </ul>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
<%--<%--%>
<%--    Dat.close();--%>
<%--    Cmd.close();--%>
<%--    Con.close();--%>
<%--    inf.close();--%>
<%--    sb.close();--%>
<%--    nc.close();--%>
<%--    }--%>
<%--%>--%>
</body>
</html>