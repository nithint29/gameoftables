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
<h1 class = "font">Houses</h1>
<form method="get" action="house.jsp">
<div class="form-group">
  <label for="sel1">Select house:</label>
  <select name = "house" class="form-control" id="sel1">
  	<option>Choose House</option>
    <option>Stark</option>
    <option>Lannister</option>
    <option>Arryn</option>
    <option>Baratheon</option>
    <option>Bolton</option>
    <option>Frey</option>
    <option>Greyjoy</option>
    <option>Martell</option>
    <option>Targaryen</option>
    <option>Tyrell</option>
  </select>
</div>
<button type="submit" class="btn btn-success">Submit</button>
</form>
<br>
<div class="filterBar">
	<button class = "btn btn-primary btn-block bc" data-toggle="collapse" data-target="#filter">Filters</button>
	<div id="filter" class="collapse">
	   <form name="form1" method="get" action="house.jsp">
         
         <div id="slider" style="padding-top:0px">
         	<h3>Minimum Kills</h3>
  			<input class="slider" type="range" id="rangeinput" name="kills" value="0" onchange="rangevalue.value=value" />
  			<span class="highlight"></span>
  			<output id="rangevalue">0</output>
		 </div>
		 <div id="slider" style="padding-top:0px">
         	<h3>Minimum Romances</h3>
  			 <input type="range" min="0" max="20" name="romances" value="0" class="slider" id="myRange" onchange="rangevalue1.value=value">
  			<span class="highlight"></span>
  			<output id="rangevalue1">0</output>
		 </div>
		 
		 <div>
            <h3>Character Status</h3>
            <label class="checkbox-inline"><input type="checkbox" name="alive" value="true"/>Alive</label>
            <label class="checkbox-inline"><input type="checkbox" name="dead" value="true"/>Dead</label>
            <label class="checkbox-inline"><input type="checkbox" name="traitor" value="true"/>Traitor</label>
            <label class="checkbox-inline"><input type="checkbox" name="weirdo" value="true"/>Weirdo</label>
         </div>
         
         <div>
            <h3>Sort By</h3>
            <div class="form-group">
			  <label for="sel1">Royalty:</label>
			  <select class="form-control-inline" id="sel1" name="royalOrder">
			    <option>None</option>
			    <option>ASC</option>
			    <option>DESC</option>
			  </select>
			  <label for="sel1" style="padding-left:10px">Kills:</label>
			  <select class="form-control-inline" id="sel1" name="killOrder">
			    <option>None</option>
			    <option>ASC</option>
			    <option>DESC</option>
			  </select>
			  <label for="sel1" style="padding-left:10px">Romances:</label>
			  <select class="form-control-inline" id="sel1" name="romanceOrder">
			  	<option>None</option>
			    <option>ASC</option>
			    <option>DESC</option>
			  </select>
			</div>
         </div>
		 
         <div class = "text-center space">
            <button type="submit" class="btn btn-success">Submit</button>
         </div>
        </form>
	</div>
</div>

<br>
<br>
<%
	    
		try {
			ArrayList<String> al = new ArrayList<String>();
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			Statement stmt3 = con.createStatement();
			Statement stmt4 = con.createStatement();
			String houseName = request.getParameter("house");
			String houseLead = "";
			int totalAlleg = 0;
			int totalMemb = 0;
			ResultSet result = null;
			if (houseName!=null && !(houseName.equals("Choose House")))
			{
			String str = "SELECT charID,name,surname,gender,royaltyscale FROM characters where surname = \"" + houseName + "\"";
			String leaderQuery = "SELECT * from houses where name = \"" + houseName + "\"";
			String membQuery = "SELECT count(*) as total from characters where surname = \"" + houseName + "\"";
			String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"" + houseName + "\"";
			result = stmt4.executeQuery(str);
			ResultSet countAlleg = stmt.executeQuery(allegQuery);
			countAlleg.next();
			totalAlleg = countAlleg.getInt("total");
			countAlleg.close();
			ResultSet countMemb = stmt2.executeQuery(membQuery);
			countMemb.next();
			totalMemb = countMemb.getInt("total");
			countMemb.close();
			ResultSet leader = stmt3.executeQuery(leaderQuery);
			leader.next();
			houseLead = leader.getString("leader");
			leader.close();
			}
			if(houseName!=null && !(houseName.equals("Choose House")))
			{
			String picPath = houseName.toLowerCase()+"sigil.png";
			out.print("<h1 style = \"text-align:center;\" class = \"font\">");
			out.print("House " + houseName);
			out.print("</h1>");
			out.print("<br>");
			out.print("<div style = \"width:100%; display:table\">");
			out.print("<div style = \"display: table-row\">");
			out.print("<div style = \"display: table-cell;\">");
			out.print("<p style = \"text-align:left;\">");
			out.print("<img src = \""+picPath+"\" style = \"width:150px;height:150px;\">");
			out.print("</p>");
			out.print("</div>");
			out.print("<div class = \"font\" style = \"display: table-cell;\">");
			out.print("<h2>");
			out.print("Leader of house: " + houseLead);
			out.print("<br>");
			out.print("Total characters alleged to this house: " + totalAlleg);
			out.print("<br>");
			out.print("Total members from this house: " + totalMemb);
			out.print("</h2>");
			out.print("</div>");
			out.print("</div>");
			out.print("</div>");
			out.print("<br>");
			out.print("<br>");
			out.print("<table class=\"datatable table table-striped table-bordered table-hover\">");
			out.print("<thead>");
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

			out.print("surname");
			out.print("</td>");
			out.print("<td>");
			out.print("gender");
			out.print("</td>");
			out.print("<td>");
			out.print("royaltyScale");
			out.print("</td>");
			out.print("</tr>");
			out.print("</thead>");
			out.print("<tbody id = \"myTable\">");
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
			out.print("</tbody>");
			out.print("</table>");

			//close the connection.
			db.closeConnection(con);
			}
		}catch(Exception e)
		{
			out.print(e);
		}
			%>
</div>

</body>
</html>