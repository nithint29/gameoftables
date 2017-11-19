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
<div class="container">
<h2 class = "font"><%
String name =request.getParameter("name");
out.print(name + " Romances");
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
			Statement stmt2 = con.createStatement();
			String id = request.getParameter("id");
			String romances = "SELECT name1,surname1,name2,surname2 from romances where charID1 =" + id;
			String totalRom = "SELECT count(*) as total from romances where charID1 =" + id;
			String kills = "SELECT * from kills where killerID = " + id;
			String totalKills = "SELECT count(*) as total from kills where killerID = " + id;
			ResultSet count = stmt.executeQuery(totalRom);
			count.next();
			int total = count.getInt("total");
			count.close();
			ResultSet myCount = stmt2.executeQuery(totalKills);
			myCount.next();
			int totalVictims = myCount.getInt("total");
			myCount.close();
			ResultSet result = stmt.executeQuery(romances);
			ResultSet victims = stmt2.executeQuery(kills);
			out.print("<table class=\"table table-hover\">");
			
			//make a row
			out.print("<tr>");
			//make a column
			//print out column header
			out.print("<td>");
			out.print("Lover Name");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Lover Surname");
			out.print("</td>");
			out.print("</tr>");
			while (result.next() && result !=null) {
				//make a row
				out.print("<tr>");
				out.print("<td>");
				out.print(result.getString("name2"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("surname2"));
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
			out.print("<h4 class = \"font\">");
			out.print("Total romances: " + total);
			out.print("</h4>");
			out.print("<br>");
			out.print("<br>");
			out.print("<br>");
			out.print("<br>");
			out.print("<br>");
			out.print("<br>");
			out.print("<h2 class = \"font\">");
			String charName =request.getParameter("name");
			out.print(charName + " Kills");
			out.print("</h2>");
			out.print("<table class=\"table table-hover\">");
			
			//make a row
			out.print("<tr>");
			//make a column
			//print out column header
			out.print("<td>");
			out.print("Victim Name");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Victim Surname");
			out.print("</td>");
			out.print("</tr>");
			while (victims.next() && victims !=null) {
				//make a row
				out.print("<tr>");
				out.print("<td>");
				out.print(victims.getString("victimName"));
				out.print("</td>");
				out.print("<td>");
				out.print(victims.getString("victimSurname"));
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
			out.print("<h4 class = \"font\">");
			out.print("Total kills: " + totalVictims);
			out.print("</h4>");
			db.closeConnection(con); 
	}
	catch(Exception e){
		out.print(e);
	}
		%>
</div>
</body>
</html>
