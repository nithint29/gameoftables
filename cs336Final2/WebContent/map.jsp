<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.awt.image.BufferedImage,java.awt.Graphics2D,javax.imageio.ImageIO,java.awt.Color,java.net.URL"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,javax.xml.bind.DatatypeConverter.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
 <link href='http://fonts.googleapis.com/css?family=Dosis' rel='stylesheet'  type='text/css'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
.btn-primary{
    background-color: #30191e !important;
}
.btn-primary:hover{
 background-color: #000000 !important;
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
.title{
padding-top:30px;
paddig-bottom:20px;
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
	
	
	
	
	
	<%
	String b64 = "";
	BufferedImage image = null;
	ByteArrayOutputStream baos = new ByteArrayOutputStream();
	try {
		//https://i.imgur.com/D5XUwfK.png
		URL url = new URL("https://i.imgur.com/POZNpOp.jpg");
		image = ImageIO.read(url);
	} catch (IOException e) {
		e.printStackTrace();
	}
	if(image == null)
	{
		out.print("nullllllllllllll");
	}
	else{

	//HIGH garden - 165,325
	//casterly rock 107,143
	//riverrun 230,72
	//dragonstone 460,120
	//kingslanding 390,178
	//Storms end 428,284
	//sunspar 480,460
	//pike 105,27
	//pentos 630,185
	//harrenhal 315,95
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	Graphics2D graphics2D = image.createGraphics();

    graphics2D.setPaint ( Color.red);	
	
    String str = "SELECT charID,xcoord,ycoord,name,surname FROM charlocations WHERE TRUE ";
	
	try {
		ArrayList<String> al = new ArrayList<String>();
		//Get the database connection
		
		//Get tparameters
		
		String entity = request.getParameter("command");
		String[] houses = request.getParameterValues("house");
		String sKills = request.getParameter("kills");
		int kills=0;
		if(sKills !=null){
			kills += Integer.parseInt(sKills);
		}
		String sRoms = request.getParameter("romances");
		int roms=0;
		if(sRoms !=null){
			roms += Integer.parseInt(sRoms);
		}
		String sLimit = request.getParameter("limit");
		int limit=0;
		if(sLimit !=null){
			limit += Integer.parseInt(sLimit);
		}
		
		String alive = request.getParameter("alive");
		String dead = request.getParameter("dead");
		String traitor = request.getParameter("traitor");
		String weirdo = request.getParameter("weirdo");
		String royalOrder = request.getParameter("royalOrder");
		String killOrder = request.getParameter("killOrder");
		String romOrder = request.getParameter("romanceOrder");
		
		String houseString = "('Stark','Targaryen','Lannister','Tyrell','Martell','Bolton','Baratheon','Arryn','Greyjoy','Frey')";
		
		//Start adding stuff to querry to filter things
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
		if(weirdo != null)
		{
			str += " AND (charID in (select charID1 from romances where surname1=surname2) or charID in (select charID2 from romances where surname1=surname2)) ";
		}
		if( kills > 0)
		{
			str +=" AND (charID in (select killerID from kills group by killerID having count(*) >= "+kills+ ")) ";
		}
		if( roms > 0)
		{
			str +=" AND (charID in (select charID1 from romances group by charID1 having count(*) >= "+roms+ ")) ";
		}
		if( limit > 0)
		{
			str +=" LIMIT "+limit;
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	
	
	
	ResultSet result = stmt.executeQuery(str);
	
	while (result.next() && result !=null) {
		String xs = result.getString("xcoord");
		int x = Integer.parseInt(xs);
		String ys = result.getString("ycoord");
		int y = Integer.parseInt(ys);
		
		graphics2D.drawOval ( x, y, 7, 7 );
		
	}
	
//    graphics2D.drawOval ( 160, 320, 10, 10 );
    graphics2D.dispose ();

  
    
    ImageIO.write ( image, "jpg", baos);
    baos.flush();
    byte[] imageInByteArray = baos.toByteArray();
    baos.close();
    b64 = javax.xml.bind.DatatypeConverter.printBase64Binary(imageInByteArray);
    
	}
    
	
	
	
	%>
	
	<div class = "title text-center"><h3 class = "font text-center" style="text-align:center;">Map</h3></div>
	
	<div id="map" class="map" style="padding-top:20px">
	<p style="text-align:center;"><img src="data:image/jpg;base64, <%=b64%>" alt="map.jpg not found" class="img-thumbnail" ></p>
	</div>
	
	
	
	
	<div class="filterBar container">
	<button class = "btn btn-primary btn-block bc" data-toggle="collapse" data-target="#filter">Filters</button>
	<div id="filter" class="collapse">
	   <form name="form1" method="get" action="map.jsp">
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
  			<output id="rangevalue">0</output>
		 </div>
		 <div id="slider" style="padding-top:0px">
         	<h3>Minimum Romances</h3>
  			 <input type="range" min="0" max="20" name="romances" value="0" class="slider" id="myRange" onchange="rangevalue1.value=value">
  			<span class="highlight"></span>
  			<output id="rangevalue1">0</output>
		 </div>
		 <div id="slider" style="padding-top:0px">
         	<h3>Limit Data</h3>
  			 <input type="range" min="1" max="6000" name="limit" value="1000" class="slider" id="myRange" onchange="rangevalue2.value=value">
  			<span class="highlight"></span>
  			<output id="rangevalue2">1000</output>
		 </div>
		 
		 <div>
            <h3>Character Status</h3>
            <label class="checkbox-inline"><input type="checkbox" name="alive" value="true"/>Alive</label>
            <label class="checkbox-inline"><input type="checkbox" name="dead" value="true"/>Dead</label>
            <label class="checkbox-inline"><input type="checkbox" name="traitor" value="true"/>Traitor</label>
            <label class="checkbox-inline"><input type="checkbox" name="weirdo" value="true"/>Weirdo</label>
         </div>
         
		 
         <div class = "text-center space">
            <button type="submit" class="btn btn-success">Submit</button>
         </div>
        </form>
	</div>
</div>
	
	
	
	
</body>

</html>