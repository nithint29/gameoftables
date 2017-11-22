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
	
	
	String c = request.getParameter("kill");
	
//	String str = "DELETE from kills where victimID = "+live;
//	stmt.executeQuery(str);
	
	out.print("Kill Deleted"+c);



%>

</body>
</html>