<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter"  %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
    	<title>Welcome to Pick 'Em Chief!</title>
  </head>

  <body>
  <%!
public List<String> getNumDays(Integer days){
	List<String> output = new ArrayList<String>();
	
	
	Calendar now = Calendar.getInstance();
	output.add(getDate(now));
	days -= 1;
	
	for(int i = 0; i < days; i++){
		now.add(Calendar.DAY_OF_MONTH, 1);
		output.add(getDate(now));
	}
	//ut.println(output);
	return output;		
}
  %>
  <%!
public String getDate(Calendar now){
	int dayOfMonth = now.get(Calendar.DAY_OF_MONTH);
	String dayOfMonthStr = ((dayOfMonth < 10) ? "0" : "") + dayOfMonth;
	int month = now.get(Calendar.MONTH) + 1;
	String monthStr = ((month < 10) ? "0" : "") + month;
	int year = now.get(Calendar.YEAR);
	String yearStr = String.valueOf(year);
	return (yearStr + monthStr + dayOfMonthStr);	

}
%>
<%
try{
if (session.getAttribute("username") == null) {
		//session.setAttribute("username", username);
	response.sendRedirect("login.jsp");
}
}catch(Exception e){
	out.println(e.getMessage());
}
	ObjectifyService.register(Game.class);	
	ObjectifyService.register(Pick.class);	
	PrintWriter writer = response.getWriter();
	Integer numDays = 17;
	List<String> todaysdate = getNumDays(numDays);
	writer.println(todaysdate);
	for(String date : todaysdate){
	pageContext.setAttribute("todaysdate", date);
	%>
	${fn:escapeXml(date)}
	
		<table class="pick">
    <%
	List<Game> games = ofy().load().type(Game.class).filter("date", date).list();
   // List<Game> games = null;
	for(Game game : games){
		pageContext.setAttribute("hometeam", game.getHometeam());
		pageContext.setAttribute("awayteam", game.getAwayteam());
		pageContext.setAttribute("date", game.getDate());
		pageContext.setAttribute("time", game.getTime());
		pageContext.setAttribute("winner", game.getWinner());
		pageContext.setAttribute("gameID", String.valueOf(game.getId()));
		
		%>
		
		<form id="savepick" action="/savepick">
		<input type="hidden" value="${fn:escapeXml(hometeam)}" name="hometeam" id="hometeam"/>
		<input type="hidden" value="${fn:escapeXml(awayteam)}" name="awayteam" id="awayteam"/>
		<input type="hidden" value="${fn:escapeXml(date)}" name="date" id="date"/>
		<input type="hidden" value="${fn:escapeXml(time)}" name="time" id="time"/>
		<input type="hidden" value="${fn:escapeXml(gameID)}" name="gameID" id="gameID"/>
					
		<tr>
			<td><b><a href="#" onclick="savePick('home', '${fn:escapeXml(gameID)}');">${fn:escapeXml(hometeam)}</a></b></td>
			<td>&nbsp@&nbsp </td>
			<td><b><a href="#" onclick="savePick('away', '${fn:escapeXml(gameID)}')">${fn:escapeXml(awayteam)}</a></b></td>
			
			<td>${fn:escapeXml(time)}</td>
		</tr>
		</form>
		
		<%
		}
	}
%>

		</table>
   <form action="/creategame" method="post">
    
  <table style="color:black"><tr><td>
   Home Team:</td><td>
   <input type="text" id="hometeam" name="hometeam" value=""><br></td></tr><tr><td>
   Away Team: </td><td>
   <input type="text" id="awayteam" name="awayteam" value=""><br></td></tr><tr><td>
   Date: </td><td>
   <input type="text" id="date" name="date" value=""></td></tr><tr><td>
   Time: </td><td>
   <input type="text" id="time" name="time" value=""></td></tr>
   <tr><td> 
    <button onclick="CreateJSON()">Create Game</button></td></tr>
   </table>
    </form>
  </body>
</html>



<script>

function savePick(homeaway, gameID){
	//ofy().
}
</script>
