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
</style>
<body>
	
	
	<%//image size 835X555
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
	
	String str = "SELECT charID,name,surname,gender,royaltyscale FROM characters LIMIT 500";
	ResultSet result = stmt.executeQuery(str);
	
	while (result.next() && result !=null) {
		String n = result.getString("royaltyscale");
		int val = Integer.parseInt(n);
		graphics2D.drawOval ( val*50, 320, 7, 7 );
		
	}
	
    graphics2D.drawOval ( 160, 320, 10, 10 );
    graphics2D.drawOval(50, 50, 10, 10);
    graphics2D.drawOval(800, 550, 10, 10);
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
	
	
	
	
</body>

</html>