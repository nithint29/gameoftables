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
<%
String id = request.getParameter("command");
if (id.equals("charPatterns"))
{
	out.print("<div class = \"font\">");
	out.print("<h1>");
	out.print("Character Patterns");
	out.print("</h1>");
	out.print("<h3>");
	out.print("Follow these steps to view these character patterns: ");
	out.print("<br>");
	out.print("1) On home page go to the Characters section and click View All Characters.");
	out.print("<br>");
	out.print("2) Click the filter button to explore these various patterns pertaining to the characters.");
	out.print("</h3>");
	out.print("</div>");
	out.print("<br>");	
	out.print("<table class=\"datatable table table-striped table-bordered table-hover\">");
	out.print("<thead>");
	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td>");
	//print out column header
	out.print("Pattern");
	out.print("</td>");
	//make a column
	out.print("<td>");
	//depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected

	out.print("To View in Filter");
	out.print("</td>");
	out.print("</tr>");
	out.print("</thead>");
	out.print("<tbody id = \"myTable\">");
	out.print("<tr>");
	out.print("<td>");
	//print out column header
	out.print("There are no Starks who are traitors, or allied to a different house than Stark.");
	out.print("</td>");
	out.print("<td>");
	//print out column header
	out.print("Check the Stark checkbox in houses and check status as Traitor. Click 'Submit'. ");
	out.print("</td>");
	out.print("</tr>");
	out.print("<tr>");
	out.print("<td>");
	//print out column header
	out.print("Targaryens tend to have higher numbers of kills due to dragons.");
	out.print("</td>");
	out.print("<td>");
	//print out column header
	out.print("Move the kills slider to 15, you will see that most of the characters are Targaryens.");
	out.print("</td>");
	out.print("</tr>");
	
	
	out.print("<tr>");
	out.print("<td>");
	//print out column header
	out.print("Some other 'warrior' houses also have slightly high numbers of kills: Starks, Baratheons.");
	out.print("</td>");
	out.print("<td>");
	//print out column header
	out.print(" Move the kills slider to other numbers to see how other house members fare.");
	out.print("</td>");
	out.print("</tr>");
	
	
	out.print("<tr>");
	out.print("<td>");
	//print out column header
	out.print("People in houses are usually better trained for combat.");
	out.print("</td>");
	out.print("<td>");
	//print out column header
	out.print(" Move the kills slider to higher and higher numbers to see that more and more people belong to one of the 10 royal houses.");
	out.print("</td>");
	out.print("</tr>");
	
	
	out.print("<tr>");
	out.print("<td>");
	//print out column header
	out.print("Incest is possible within Targaryens and Lannisters.");
	out.print("</td>");
	out.print("<td>");
	//print out column header
	out.print("Check status as weirdo.");
	out.print("</td>");
	out.print("</tr>");
	
	out.print("<tr>");
	out.print("<td>");
	//print out column header
	out.print("Some houses tend to have higher numbers of members or allies than others.");
	out.print("</td>");
	out.print("<td>");
	//print out column header
	out.print("Go to the main pages and go to the houses part and click on 'View all Houses'. In the drop down choose a house to view their stats.");
	out.print("</td>");
	out.print("</tr>");
	
	out.print("</tbody>");
	out.print("</table>");
	
}
else if(id.equals("mapPatterns")){
	out.print("<div class = \"font\">");
	out.print("<h1>");
	out.print("Map Patterns");
	out.print("</h1>");
	out.print("<h3>");
	out.print("Follow these steps to view these map patterns: ");
	out.print("<br>");
	out.print("1) On home page go to the Map section and click Explore the Continent.");
	out.print("<br>");
	out.print("2) Click the filter button at the bottom to explore these various patterns pertaining to the map.");
	out.print("</h3>");
	out.print("</div>");
	out.print("<table class=\"datatable table table-striped table-bordered table-hover\">");
	out.print("<thead>");
	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td>");
	//print out column header
	out.print("Pattern");
	out.print("</td>");
	//make a column
	out.print("<td>");
	//depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected

	out.print("To View");
	out.print("</td>");
	out.print("</tr>");
	out.print("</thead>");
	out.print("<tbody id = \"myTable\">");
	out.print("<tr>");
	out.print("<td>");
	out.print("There is a higher concentration of characters near major cities named on the map such as Casterly Rock, Highgarden, etc.");
	out.print("</td>");
	out.print("<td>");
	out.print("Observe that there are more circles near major cities on the map, indicating that there are more characters there.");
	out.print("</td>");
	out.print("</tr>");
	out.print("<tr>");
	out.print("<td>");
	out.print("There are very few characters located in the sea.");
	out.print("</td>");
	out.print("<td>");
	out.print("Observe that there are very few circles in the sea on the map, indicating that there are very few characters there.");
	out.print("</td>");
	out.print("</tr>");
	out.print("<tr>");
	out.print("<td>");
	out.print("Characters of a house are found in a common place for the most part (Starks allies are found in Winterfell and Bear Island, for example).");
	out.print("</td>");
	out.print("<td>");
	out.print("Check the house name in the filter and click submit and observe that the circles are concentrated near a city where the members of that house are located.");
	out.print("</td>");
	out.print("</tr>");
	out.print("</tbody>");
	out.print("</table>");
	
}

else {
	out.print("<div class = \"font\">");
	out.print("<h1>");
	out.print("Updating the Database");
	out.print("</h1>");
	out.print("<h3>");
	out.print("Follow these steps to learn about adding to the database: ");
	out.print("<br>");
	out.print("<br>");
	out.print("1) On home page go to the Characters section and click View all Characters.");
	out.print("<br>");
	out.print("<br>");
	out.print("2) Click on a characters name and scroll to the bottom.");
	out.print("<br>");
	out.print("<br>");
	out.print("3) Choose either 'Add Kill' or 'Add Lover', enter the character and click submit.");
	out.print("</h3>");
	out.print("</div>");
	
	
}
%>
</div>

</body>
</html>