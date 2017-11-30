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

try{
if (request.getParameter("optradio").equals("kill"))
{
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();		
//Create a SQL statement
Statement stmt = con.createStatement();
Statement stmt1 = con.createStatement();
Statement stmt2 = con.createStatement();


String id = request.getParameter("curr");
String newVic = request.getParameter("new");

String str1 = "select * from characters where charID=" +id;
String str2 =  "select * from characters where charID=" +newVic;

ResultSet res1 = stmt1.executeQuery(str1);
ResultSet res2 = stmt2.executeQuery(str2);

res1.next();
//String newN = res1.getString("killerName");
res2.next();
//String newS = res1.getString("surname");
String currFirstName = res1.getString("name");
String currLastName = res1.getString("surname");
String newFirstName = res2.getString("name");
String newLastName = res2.getString("surname");

String insertQuery = "insert into kills (killerID, killerName, killerSurname, victimID, victimName, victimSurname) values ('"+id+"','"+currFirstName+"','" +currLastName+"','"+newVic+"','"+newFirstName+"','"+newLastName+"')";
stmt.execute(insertQuery);
out.print("kill added to "+id);
}
else{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		
	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt1 = con.createStatement();
	Statement stmt2 = con.createStatement();


	String id = request.getParameter("curr");
	String newVic = request.getParameter("new");

	String str1 = "select * from characters where charID=" +id;
	String str2 =  "select * from characters where charID=" +newVic;

	ResultSet res1 = stmt1.executeQuery(str1);
	ResultSet res2 = stmt2.executeQuery(str2);

	res1.next();
	//String newN = res1.getString("killerName");
	res2.next();
	//String newS = res1.getString("surname");
	String currFirstName = res1.getString("name");
	String currLastName = res1.getString("surname");
	String newFirstName = res2.getString("name");
	String newLastName = res2.getString("surname");

	String insertQuery = "insert into romances (charID1, name1, surname1, charID2, name2, surname2) values ('"+id+"','"+currFirstName+"','" +currLastName+"','"+newVic+"','"+newFirstName+"','"+newLastName+"')";
	stmt.execute(insertQuery);
	out.print("kill added to "+id);
}
}catch(Exception e)
{
	out.print("Constraint violated: the character you added doesn't exist.");
}

%>
</body>
</html>