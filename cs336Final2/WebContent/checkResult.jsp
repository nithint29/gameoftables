<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href='http://fonts.googleapis.com/css?family=Dosis' rel='stylesheet'  type='text/css'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
.font{
font-family: 'Dosis', sans-serif;
}
.centerText{
textAlign: center;
}
</style>
<body>
<%
	String gender = request.getParameter("gender");
	String allegiance = request.getParameter("allegiance");
	String royalty = request.getParameter("royalty");
	String[] v = request.getParameterValues("vehicle");
	String kill = request.getParameter("kill");
	out.print(gender);
	out.print(allegiance);
	out.print(royalty);
	out.print(kill);
	String query = "SELECT c.name,c.surname,c.gender,c.royaltyscale from characters c,allegiances a,romances r,kills k where ";
	if (gender!=null)
	{
		query = query + "c.gender = " + gender;
	}
	if (gender!=null && allegiance!=null)
	{
		query = query + " AND c.charID = a.charID AND a.allegiance = " + allegiance;
	}
%>
</body>
</html>