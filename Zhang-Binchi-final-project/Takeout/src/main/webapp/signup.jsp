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
<title>Sign up</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="index.css"/>
	<link rel="stylesheet" type="text/css" href="login.css"/>
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
	Class.forName("com.mysql.cj.jdbc.Driver");
	String method=request.getMethod();
	String ErrMsg="";
	if (method.compareToIgnoreCase("post")==0) {
		String UserName = request.getParameter("txUserName");
		String Email = request.getParameter("txEmail");
		String Phone = request.getParameter("txPhone");
		String BillAddress = request.getParameter("txBillAddress");
		String Password = request.getParameter("txPassword");
		if (Password.compareTo(Password)!=0) ErrMsg="Please enter Passwords!";
		else {
			Connection Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");
			Statement Cmd = Con.createStatement();
			String SQL = String.format("select * from Users where Username='%s'", UserName);
			ResultSet Dat = Cmd.executeQuery(SQL);
			Boolean UserExists= Dat.next();
			Dat.close();
			Cmd.close();
			Con.close();
			if (UserExists) ErrMsg="Username: "+UserName+" taken";
			else {
				Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");
				Cmd = Con.createStatement();
				SQL = String.format("insert into Users(UserName, Email, Phone, Password, BillAddress) values('%s', '%s', '%s', '%s', '%s')", UserName, Email, Phone,
						Password, BillAddress);
				Cmd.executeUpdate(SQL);
				Cmd.close(); Con.close();
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
		}
	}
%>
<div id="signup_frame">
	<form method="post">
		<p><label class="label_input">User Name</label><input name="txUserName" placeholder="UserName"></p>
		<br>
        <p><label class="label_input">Email</label><input name="txEmail" placeholder="Email"></p>
        <br>
        <p><label class="label_input">Phone</label><input name="txPhone" placeholder="Phone"></p>
        <br>
		<p><label class="label_input">Bill Address</label><input name="txBillAddress" placeholder="BillAddress"></p>
		<br>
		<p><label class="label_input">Password</label><input name="txPassword" placeholder="Password"></p>
		<br>
		<input type="submit" value="Submit">
	</form>
	</div>
</body>
</html>