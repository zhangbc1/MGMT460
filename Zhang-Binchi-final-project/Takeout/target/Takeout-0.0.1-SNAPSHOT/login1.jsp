<%--
  Created by IntelliJ IDEA.
  User: zhangbinchi
  Date: 11/4/21
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    String method=request.getMethod();
    String ErrMsg="";
    if (method.compareToIgnoreCase("post")==0) {
        String UserName = request.getParameter("txUserName");
        String Password = request.getParameter("txPassword");
        Connection Con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TakeoutDatabase", "root", "123456");
        Statement Cmd = Con.createStatement();
        String SQL = String.format("select * from Users where UserName='%s' and Password='%s'", UserName, Password);
        ResultSet Dat = Cmd.executeQuery(SQL);

        Boolean UserExists=Dat.next();
        if (!UserExists) ErrMsg="Invalid UserName or Password";
        else {
            UserName = Dat.getString("UserName");
            String ID = Dat.getString("ID");
            HttpSession Session= (HttpSession) request.getSession();
            Session.setAttribute("UserName", UserName);
            Session.setAttribute("ID", ID);

            if (Session.getAttribute("RetPage")==null
                    || Session.getAttribute("RetPage").toString().isEmpty()){
                request.getRequestDispatcher("cart.jsp").forward(request, response);}
            else {
                String RetPage=Session.getAttribute("RetPage").toString();
                request.getRequestDispatcher(RetPage).forward(request, response);
            }
        }
        Dat.close();
        Cmd.close();
        Con.close();
    }
%>
</body>
</html>
