<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();		
//Create a SQL statement
Statement stmt = con.createStatement();
Statement stmt1 = con.createStatement();
Statement stmt2 = con.createStatement();


String victimid = request.getParameter("kill");
String newVic = request.getParameter("new");

String str1 = "select * from characters where charID=" +newVic;
String str2 =  "select * from characters where charID=" +newVic;
ResultSet res1 = stmt1.executeQuery(str1);
ResultSet res2 = stmt2.executeQuery(str2);
res1.next();
String newN = res1.getString("name");
res2.next();
String newS = res1.getString("surname");



String str = "UPDATE kills SET victimName= \""+newN +"\" , victimSurname=\""+newS +"\" ,victimID= "+newVic +" WHERE victimID= "+victimid;
stmt.execute(str);
out.print("kill changed to "+newVic);


%>
</body>
</html>