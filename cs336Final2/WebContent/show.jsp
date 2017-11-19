<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<h2><%
String header = request.getParameter("command");
if (header.equals("characters"))
{
	header = "Characters";
}
else{
	header = header + "s";
}
out.print(header);
%></h2>
	<%
	    
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String entity = request.getParameter("command");
			String str = "";
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			if (entity.equals("characters")){
			str = "SELECT charID,name,surname,gender,royaltyscale FROM " + entity;
			}
			else
			{
				str = "SELECT charID,name,surname,gender,royaltyscale FROM characters";
			}
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Make an HTML table to show the results in:
			out.print("<table class=\"table table-hover\">");
			
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			//depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected
			if (entity.equals("beers"))
				out.print("manf");
			else
				out.print("surname");
			out.print("</td>");
			out.print("<td>");
			out.print("gender");
			out.print("</td>");
			out.print("<td>");
			out.print("royaltyScale");
			out.print("</td>");
			out.print("</tr>");
			//parse out the results
			while (result.next() && result !=null) {
				//make a row
				out.print("<tr>");
				//make a column
				 //out.print("<td><a href=\"#\">Two</a></td>");
				String charName = result.getString("name");
				String id = result.getString("charID");
				out.print("<td><a href = \"character.jsp?name=" + charName + "&id=" + id+"\" >");
				//Print out current bar or beer name:
				if (result.getString("name")!=null)
				{
				out.print(result.getString("name"));
				}
				out.print("</a></td>");
				out.print("<td>");
				//Print out current bar/beer additional info: Manf or Address
				if (result.getString("surname")!=null)
				{
				out.print(result.getString("surname"));
				}
				out.print("</td>");
				out.print("<td>");
				if (result.getString("gender")!=null)
				{
				out.print(result.getString("gender"));
				}
				out.print("</td>");
				out.print("<td>");
				if (result.getString("royaltyScale")!=null)
				{
				out.print(result.getString("royaltyScale"));
				}
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");

			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
</div>
</body>
</html>