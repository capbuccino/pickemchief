<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="org.w3c.dom.Document" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import ="java.util.Calendar" %>
<%@ page import = "com.googlecode.objectify.ObjectifyService" %>
<%@ page import = "com.pickemchief.*" %>
<%@ page import = "static com.googlecode.objectify.ObjectifyService.ofy" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
    	<title>Welcome to Pick 'Em Chief!</title>
  </head>
  <body>
  <%
  
  
	if (session.getAttribute("username") == null) {
  		//session.setAttribute("username", username);
		response.sendRedirect("login.jsp");
	}
	
%>
	 	
   <!--  form action="creategame" method="post">
    
  <table style="color:black"><tr><td>
   Home Team:</td><td>
   <input type="text" id="hometeam" name="hometeam" value="hometeam"><br></td></tr><tr><td>
   Away Team: </td><td>
   <input type="text" id="awayteam" name="awayteam" value="awayteam"><br></td></tr><tr><td>
   Date: </td><td>
   <input type="text" id="date" name="date" value=""></td></tr>
   <tr><td> 
    <input type="submit" value="Create Game!" /></td></tr>
   </table>
    </form-->
    <p>
    <a href="/Start.jsp">View picks</a>
  </body>
</html>
