<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@page import="java.io.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
 //File creation
 File f = new File("");
 out.print(f.getAbsolutePath());
 String strPath = "C:\\Users\\basis_000\\OneDrive\\school\\rutgers\\Senior fall\\Databases\\project\\gameoftables\\cs336Final2\\WebContent\\example.txt";
 File strFile = new File(strPath);
 boolean fileCreated = strFile.createNewFile();
 //File appending
 Writer objWriter = new BufferedWriter(new FileWriter(strFile));
 objWriter.write("This is a test");
 objWriter.flush();
 objWriter.close();
%> 
</body>
</html>