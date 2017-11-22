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
<link rel="stylesheet" href="css/datatables/datatables.css">
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
.bc:after {
    font-family: "Glyphicons Halflings";
    content: "\e114";
    float: right;
    margin-left: 15px;
  }
  /* Icon when the collapsible content is hidden */
.bc.collapsed:after {
    content: "\e080";
  }
.space{
padding-bottom:50px;
    padding-top:50px;  
}

.slider {
    -webkit-appearance: none;
    width: 100%;
    height: 15px;
    border-radius: 5px;
    background: #d3d3d3;
    outline: none;
    opacity: 0.7;
    -webkit-transition: .2s;
    transition: opacity .2s;
}

.slider:hover {
    opacity: 1;
}

.slider::-webkit-slider-thumb {
    -webkit-appearance: none;
    appearance: none;
    width: 25px;
    height: 25px;
    border-radius: 50%;
    background: #4CAF50;
    cursor: pointer;
}

.slider::-moz-range-thumb {
    width: 25px;
    height: 25px;
    border-radius: 50%;
    background: #4CAF50;
    cursor: pointer;
}

</style>

<body>
<div class="container">
<h1 class = "font">Fantasy rankings</h1>
<div class="container">
<% 
try
{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "select (count(*)*2) + (c.royaltyScale*10) + ((select count(*) from romances r, characters cx where cx.charID = r.charID1 and cx.charID = c.charID group by r.charID1) *5) as score, c.name, c.surname from kills k, characters c where c.charID = k.killerID group by k.killerID order by score desc";
			ResultSet res = stmt.executeQuery(str);
			
			out.print("<table class=\"datatable table table-striped table-bordered table-hover\">");
			out.print("<thead>");
			//make a row
			out.print("<tr>");
			//make a column
			//make a column
			out.print("<td>");
			//depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected

			out.print("name");
			out.print("</td>");
			out.print("<td>");
			out.print("surname");
			out.print("</td>");
			out.print("</tr>");
			out.print("</thead>");
			out.print("<tbody id = \"myTable\">");
			//parse out the results
			while (res.next() && res!=null) {
				out.print("<tr>");
				
				String name = res.getString("name");
				String surname = res.getString("surname");
				
				out.print("<td>");
				out.print(name);
				out.print("</td>");
				out.print("<td>");
				out.print(surname);
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</tbody>");
			out.print("</table>");
			db.closeConnection(con);
}
catch(Exception e)
{
	out.print(e);
}
%>
</div>


</body>
</html>