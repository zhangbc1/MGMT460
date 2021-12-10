<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");
	Statement Cmd = Con.createStatement();
	String SQL = "select * from Users ";
	ResultSet Dat = Cmd.executeQuery(SQL);
	while (Dat.next()) {
		 String UserName = Dat.getString("Username");
		 String Email = Dat.getString("Email");
		 String Phone = Dat.getString("Phone");
		 String Password = Dat.getString("Password");
		 String BillAddress = Dat.getString("BillAddress");
		 String OneRow = String.format("%s, %s, %s, %s, %s",UserName,Email,Phone,Password,BillAddress);
		 out.println(OneRow);
	}
	Dat.close();
	Cmd.close();
	Con.close();
%>
<br><br><a href="index.html">HOME</a>
		<div id="outer-box">
            <div id="header-box"></div>
            <div id="body-box">
                <div id="col1-box"></div>
                <div id="col2-box"></div>
                <div id="col3-box"></div>
      		</div>
      	</div>
</body>
</html>