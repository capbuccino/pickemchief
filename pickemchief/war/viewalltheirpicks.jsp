
<%@ page import = "com.googlecode.objectify.ObjectifyService" %>
<%@ page import = "com.pickemchief.*" %>
<%@ page import = "static com.googlecode.objectify.ObjectifyService.ofy" %>
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <style>
  .picksheader{
  background-color: red;
  }
  #usernamediv{
  position: fixed;
  top: 0;
  left: 0;
  z-index: 999;
  width: 100%;
  height: 50px;
  font-family: 'Lucida Grande',Tahoma,Verdana,sans-serif;
  font-size: 14px;
  color: white;
  }
  #bodydiv{
  	overflow: auto;
  font-family: 'Lucida Grande',Tahoma,Verdana,sans-serif;
  font-size: 14px;
  color: white;
  width: 100%;
  }
  #maintable tbody td{
  	color: black;
  }
  .picktable{
  	padding: 20px;
  }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pick 'Em</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/jquery.dataTables.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
  <script src="../js/jquery.dataTables.js"></script>
</head>
<body>

<!-- p>Date: <input type="text" id="datepicker"></p>
<div id='datedisplay'></div>
Your username: <div id='username'></div>
<div id='picktable'></div>
<div id='savepickdiv'><button id='savepick'>Save Picks</button></div>
<div id='picksuccess'></div-->

<!-- div id='usernamediv'>Your username: 

</div-->
<div id='bodydiv'>
<form id='viewForm'>

Enter start date: <input type="text" value="" id="startdate"/>
<br/>
<br/>
Enter end date: <input type="text" value="" id="enddate"/>
<br/>
<br/>
<input type="submit" value="Update"/>
</form>
<br/><br/>
</div>
<div id='results'>
</div>

<script type='text/javascript'>
$( document ).ready(function() {

	
	
	$('#viewForm').on("submit", function(e){
		e.preventDefault();
		var startdate = $('#startdate').val();
		var enddate = $('#enddate').val();
		
		$.ajax({
			url: '/viewalltheirpicks',
			data: 'startdate=' + encodeURIComponent(startdate) + '&enddate=' + encodeURIComponent(enddate),
			success:(function(data){
				$('#results').html(data);
			}),
			async: false
		});
		
	});
	
	
});
</script>
</body>
</html>