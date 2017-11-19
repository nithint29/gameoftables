<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<div class="container">
<h2><%
String name =request.getParameter("name");
out.print(name);
%>
</h2>
<% 
try
{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String id = request.getParameter("id");
			String str = "SELECT name1,surname1,name2,surname2 from romances where charID1 =" + id;
			ResultSet result = stmt.executeQuery(str);
			
			out.print("<table class=\"table table-hover\">");
			
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Name");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Surname");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Lover Name");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Lover Surname");
			out.print("</td>");
			while (result.next() && result !=null) {
				//make a row
				out.print("<tr>");
				out.print("<td>");
				out.print(result.getString("name1"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("surname1"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("name2"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("surname2"));
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
			db.closeConnection(con); 
}
catch(Exception e){}
		%>
</div>
</body>
</html>
