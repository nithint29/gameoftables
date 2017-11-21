<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Game Of Tables</title>
 <link href='http://fonts.googleapis.com/css?family=Dosis' rel='stylesheet'  type='text/css'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
.jumbotron { 
    background-color: #000000; /* Orange f4511e */
    color: #C0C0C0;
}
.btn-primary{
    background-color: #30191e !important;
}
.btn-primary:hover{
 background-color: #000000 !important;
}
.btn-primary:active{
background-color: #000000 !important;
}
.mynavbar {
background-color: #A9A9A9;
font-family: 'Dosis', sans-serif;
}
.hr {
    border-bottom:2px black solid;
    padding-top:50px;
}
.space{
 padding-bottom:120px;
    padding-top:90px;
}
.font{
font-family: 'Dosis', sans-serif;
}
.centerText{
textAlign: center;
}
.about{
padding-top:50px;
}
.imageRow{
padding-bottom:50px;
}
.cboxes{
paddig-top:50px;
padding-left:550px;
}

</style>

<body>
<div class = "mynavbar">
<nav class = "navbar navbar-fixed-top navbar-inverse">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#about">ABOUT</a></li>
        <li><a href="#characters">CHARACTERS</a></li>
        <li><a href="#houses">HOUSES</a></li>
        <li><a href="#map">MAP</a></li>
      </ul>
    </div>
    </div>
  </div>
</nav>
<div class="jumbotron text-center">
  <p style="text-align:center;"><img src="GOT.jpg"></p>
  <h3 class = "font">Game of Tables</h3>
  <h4 class = "font">A Song of Entities and Relations</h4>
  <br>
  <br>
  <br>
  <br>
  <br>
</div>
<div class = "hr container-fluid text-center" id="about">
<div class = "text-center">
<h2 class = "font about">ABOUT</h2>
</div>
<div class = "space">
<div class = "text-center">
  <h4 class = "font">Our website provides a Game of Thrones fantasy league, where characters are ranked based on several attributes.</h4>
  <h4 class = "font">Here are the various attributes we use to rank the characters.</h4>
  <br>
  </div>
  <br>
  <div class="row">
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-king"></span>
      <h4>POWER</h4>
      <p>How much power they possess</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-heart"></span>
      <h4>ROMANCES</h4>
      <p>How many romantic partners they have had</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-user"></span>
      <h4>ALLEGIANCES</h4>
      <p>Who their allies are and how powerful they are</p>
    </div>
    </div>
    <br><br>
  <div class="row">
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-screenshot"></span>
      <h4>KILLS</h4>
      <p>How many characters they have killed</p>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-globe"></span>
      <h4>LOCATION</h4>
      <p>Where they are from</p>
    </div>
  </div>
</div>
</div>
<!-- the usual HTML way -->
<br>

 <!-- Show html form to i) display something, ii) choose an action via a 
  | radio button -->
<!-- forms are used to collect user input 
	The default method when submitting form data is GET.
	However, when GET is used, the submitted form data will be visible in the page address field-->
	<hr />
<div class = "hr container-fluid text-center bg-chars" id = "characters">
<div class = "text-center">
<h2 class = "font">CHARACTERS</h2>
</div>
<div class = "space">
<div class="row imageRow">
 	<div class="col-sm-4">
		<img src="images/tyrion2.jpg" class="img-responsive img-circle" style="display:inline; width:220px; height:344px">
	</div>
	 <div class="col-sm-4">
		<img src="images/jonsnow.jpg" class="img-responsive img-circle" style="display:inline; width:220px; height:344px">
	</div>
	<div class="col-sm-4">
		<img src="images/dany3.PNG" class="img-responsive img-circle" style="display:inline; width:220px; height:344px">
	</div>
</div>

<p>Explore the characters of Westeros </p>
<br>
<br>

<form style="text-align:center;" method="get" action="show.jsp">
	<button type="submit" name="command" value="characters" class="btn btn-success">
        View All Characters
    </button>
</form>
 
    </div>
</div>
<br>

<div class = "hr" id = "houses">	
<div class = "text-center">
<h2 class = "font">HOUSES</h2>
</div>
<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo">House Stark</button>

<div id="demo" class="collapse text-center">
<p style="text-align:center;"><img src="starksigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Stark\"";
	String leaderQuery = "SELECT * from houses where name = \"Stark\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Stark\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo2">House Lannister</button>

<div id="demo2" class="collapse">
<p style="text-align:left;"><img src="lannistersigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Lannister\"";
	String leaderQuery = "SELECT * from houses where name = \"Lannister\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Lannister\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo3">House Arryn</button>

<div id="demo3" class="collapse">
<p style="text-align:left;"><img src="arrynsigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Arryn\"";
	String leaderQuery = "SELECT * from houses where name = \"Arryn\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Arryn\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo4">House Baratheon</button>

<div id="demo4" class="collapse">
<p style="text-align:left;"><img src="baratheonsigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Baratheon\"";
	String leaderQuery = "SELECT * from houses where name = \"Baratheon\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Baratheon\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo5">House Bolton</button>

<div id="demo5" class="collapse">
<p style="text-align:left;"><img src="boltonsigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Bolton\"";
	String leaderQuery = "SELECT * from houses where name = \"Bolton\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Bolton\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo6">House Frey</button>

<div id="demo6" class="collapse">
<p style="text-align:left;"><img src="freysigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Frey\"";
	String leaderQuery = "SELECT * from houses where name = \"Frey\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Frey\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo7">House Greyjoy</button>

<div id="demo7" class="collapse">
<p style="text-align:left;"><img src="greyjoysigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Greyjoy\"";
	String leaderQuery = "SELECT * from houses where name = \"Greyjoy\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Greyjoy\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" >House Martell</button>

<div id="demo8" class="collapse">
<p style="text-align:left;"><img src="martellsigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Martell\"";
	String leaderQuery = "SELECT * from houses where name = \"Martell\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Martell\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo9">House Targaryen</button>

<div id="demo9" class="collapse">
<p style="text-align:left;"><img src="targaryensigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Targaryen\"";
	String leaderQuery = "SELECT * from houses where name = \"Targaryen\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Targaryen\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>

<button class = "btn btn-primary btn-block" data-toggle="collapse" data-target="#demo10">House Tyrell</button>

<div id="demo10" class="collapse">
<p style="text-align:left;"><img src="tyrellsigil.png" style="width:150px;height:150px;"></p>
<%
try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	String allegQuery = "SELECT count(*) as total from allegiances where allegiance = \"Tyrell\"";
	String leaderQuery = "SELECT * from houses where name = \"Tyrell\"";
	String membQuery = "SELECT count(*) as total from characters where surname = \"Tyrell\"";
	ResultSet countAlleg = stmt.executeQuery(allegQuery);
	countAlleg.next();
	int totalAlleg = countAlleg.getInt("total");
	countAlleg.close();
	ResultSet countMemb = stmt2.executeQuery(membQuery);
	countMemb.next();
	int totalMemb = countMemb.getInt("total");
	countMemb.close();
	ResultSet leader = stmt3.executeQuery(leaderQuery);
	leader.next();
	String houseLead = leader.getString("leader");
	leader.close();
	out.print("<div class = \"font\">");
	out.print("<h2>");
	out.print("Leader of house: " + houseLead);
	out.print("<br>");
	out.print("Total characters alleged to this house: " + totalAlleg);
	out.print("<br>");
	out.print("Total members from this house: " + totalMemb);
	out.print("</h2>");
	out.print("</div>");
	db.closeConnection(con); 
}catch(Exception e)
{
	out.print(e);
}
	
%>
</div>
<div class = "space">
<form method="post" action="show.jsp">
    <!-- note the show.jsp will be invoked when the choice is made -->
	<!-- The next lines give HTML for radio buttons being displayed -->
<div class="form-group">
  <input type="radio" name="command" value="Stark"/>Starks
    <!-- when the radio for bars is chosen, then 'command' will have value 
     | 'bars', in the show.jsp file, when you access request.parameters -->
  <br>
   <input type="radio" name="command" value="Lannister"/>Lannisters
   <br>
   <input type="radio" name="command" value="Baratheon"/>Baratheons
   <br>
   </div>
  <button type="submit" class="btn btn-success">
        Submit
    </button>
</form>
</div>
</div>
    <br>
    <br>
<div class = "hr" id = "map">
<div class = "text-center">
<h2 class = "font">MAP</h2>
</div>
<br>
<div class = "space">
	<form method="post" action="newBeer.jsp">
	<table>
	<tr>    
	<td>Bar</td><td><input type="text" name="bar"></td>
	</tr>
	<tr>
	<td>Beer</td><td><input type="text" name="beer"></td>
	</tr>
	<tr>
	<td>Price</td><td><input type="text" name="price"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="submit">
	</form>
<br>

Or we can query the beers with price:
<br>
	<form method="post" action="query.jsp">
		<select name="price" size=1>
			<option value="3.0">$3.0 and under</option>
			<option value="5.0">$5.0 and under</option>
			<option value="8.0">$8.0 and under</option>
		</select>&nbsp;<br> <input type="submit" value="submit">
	</form>
	</div>
	</div>
<br>
<script>
$(document).ready(function(){
  // Add smooth scrolling to all links in navbar + footer link
  $(".navbar a, footer a[href='#myPage']").on('click', function(event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 900, function(){
   
        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
  
  $(window).scroll(function() {
    $(".slideanim").each(function(){
      var pos = $(this).offset().top;

      var winTop = $(window).scrollTop();
        if (pos < winTop + 600) {
          $(this).addClass("slide");
        }
    });
  });
})
</script>

</body>
</html>