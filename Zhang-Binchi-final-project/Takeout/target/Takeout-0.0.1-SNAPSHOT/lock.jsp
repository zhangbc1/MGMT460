<%--
  Created by IntelliJ IDEA.
  User: zhangbinchi
  Date: 11/18/21
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.jms.Session.*" %>
<html>
<head>
  <head>
    <meta charset="ISO-8859-1">
    <title>Lockout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="index.css"/>
  </head>
</head>
<body>
<h1><%
  HttpSession Session = (HttpSession) request.getSession();
  String username="";
  String id="";
  if (Session.getAttribute("Username")!=null
          && !Session.getAttribute("Username").toString().isEmpty())
    username=Session.getAttribute("Username").toString();
  if (Session.getAttribute("ID")!=null
          && !Session.getAttribute("ID").toString().isEmpty())
    id=Session.getAttribute("ID").toString();
  if (username.isEmpty() || id.isEmpty()) {
    String URL=request.getRequestURI();
    String RetPage=URL.substring(URL.lastIndexOf("/")+1);
    Session.setAttribute("RetPage", RetPage);
    request.getRequestDispatcher("login.jsp").forward(request, response);
  }

%>
</h1>

</body>
</html>
