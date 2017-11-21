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

<h1 class = "font">Characters</h1>

<p class = "font">Type something in the input field to search the table for first names, surnames, gender, or royaltyScale:</p>  
<input class="form-control" id="myInput" type="text" placeholder="Search..">

<div class="filterBar">
	<button class = "btn btn-primary btn-block bc" data-toggle="collapse" data-target="#filter">Filters</button>
	<div id="filter" class="collapse">
	   <form name="form1" method="get" action="show.jsp">
	   	<div>
            <h3>Select Houses</h3>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Stark"/>Stark</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Targaryen"/>Targaryen</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Lannister"/>Lannister</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Tyrell"/>Tyrell</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Martell"/>Martell</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Bolton"/>Bolton</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Baratheon"/>Baratheon</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Arryn"/>Arryn</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Greyjoy"/>Greyjoy</label>
            <label class="checkbox-inline"><input type="checkbox" name="house" value="Frey"/>Frey</label>
         </div>
         
         <div id="slider" style="padding-top:0px">
         	<h3>Minimum Kills</h3>
  			<input class="slider" type="range" id="rangeinput" name="kills" value="0" onchange="rangevalue.value=value" />
  			<span class="highlight"></span>
  			<output id="rangevalue">50</output>
		 </div>
		 
		 <div>
            <h3>Character Status</h3>
            <label class="checkbox-inline"><input type="checkbox" name="alive" value="true"/>Alive</label>
            <label class="checkbox-inline"><input type="checkbox" name="dead" value="true"/>Dead</label>
            <label class="checkbox-inline"><input type="checkbox" name="traitor" value="true"/>Traitor</label>
         </div>
		 
         <div class = "text-center space">
            <button type="submit" class="btn btn-success">Submit</button>
         </div>
        </form>
	</div>
</div>

  <br>
	<%
	    
		try {
			ArrayList<String> al = new ArrayList<String>();
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Get the selected radio button from the index.jsp
			String str = "SELECT charID,name,surname,gender,royaltyscale FROM characters where TRUE ";
			String entity = request.getParameter("command");
			String[] houses = request.getParameterValues("house");
			String sKills = request.getParameter("kills");
			int kills=0;
			if(sKills !=null){
				kills += Integer.parseInt(sKills);
			}
			String alive = request.getParameter("alive");
			String dead = request.getParameter("dead");
			String traitor = request.getParameter("traitor");
			
			
			String houseString = "('Stark','Targaryen','Lannister','Tyrell','Martell','Bolton','Baratheon','Arryn','Greyjoy','Frey')";
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			if (entity != null && entity.equals("characters")){
				str = "SELECT charID,name,surname,gender,royaltyscale FROM characters LIMIT 500";
			}
			if(houses != null && houses.length >=0)
			{
				String houseFilter = "AND (surname in (";
				for(String s:houses)
				{
					houseFilter += "'"+s+"',";
				}
				houseFilter = houseFilter.substring(0, houseFilter.length()-1);
				houseFilter+= ")) ";
				
				str += houseFilter;
			}
			if(alive != null)
			{
				str += " AND (not exists(select * from kills where victimID = charID)) ";
			}
			if(dead != null)
			{
				str += " AND (exists(select * from kills where victimID = charID)) ";
			}
			if(traitor != null)
			{
				str += " AND (charID in (select charID from allegiances where allegiances.surname <> allegiance and surname in "+ houseString+")) ";
			}
			if( kills > 0)
			{
				str +=" AND (charID in (select killerID from kills group by killerID having count(*) > "+kills+ ")) ";
			}
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Make an HTML table to show the results in:
				//before: table table-hover
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
		} catch (Exception e) {
			out.print(e);
		}
	%>
</div>

<script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
    $('#myTable').DataTable( {
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
    } );
  });
});
</script>
</body>
</html>