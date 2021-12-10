<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create</title>
<link rel="stylesheet" type="text/css" href="all.css" />
</head>
<body>
    <%
    String Username = request.getParameter("txUsername");
    String Email = request.getParameter("txEmail");
    String Phone = request.getParameter("txPhone");
    String Password = request.getParameter("txPassword");
    String BillAddress = request.getParameter("txBillAddress");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");
    Statement cmd = con.createStatement();
    String sql = String.format("insert into Users(UserName,Email,Phone,Password,BillAddress) values('%s', '%s', '%s','%s','%s')",Username,Email,Phone,Password,BillAddress);
    cmd.executeUpdate(sql);
    cmd.close();
    con.close();
    request.getRequestDispatcher("retrieve.jsp").forward(request, response);
    %>
</body>
</html>