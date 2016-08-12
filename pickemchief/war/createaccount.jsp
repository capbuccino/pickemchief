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
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
<link rel="stylesheet" href="../css/style.css">
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
    	<title>Welcome to Pick 'Em Chief!</title>
  </head>

  <body>
 <div class='container'>
<div class='login'>
<form id='createaccountform'>
Username (email): <input type="text" value="" name="username" id="username"/> <br/>
Enter your password: <input type="password" value="" name="password" id="password"/> <br/>
Confirm your password: <input type="password" value="" name="confirmpassword" id="confirmpassword"/> <br/>
<br/>
<input type="submit" value="Create Account"/>
</form>
<p>When creating your account, please do not use a secure password, or a password you use on any other sites.
This website has no external security so please don't put any important data in it.</p>
</div>
</div>


<script type='text/javascript'>
$( document ).ready(function() {
	var username = '<%session.getAttribute("username");%>';
	
	$('#loginform').on("submit", function(e){
		e.preventDefault();
		var username = $('#username').val();
		var pw = $('#password').val();
		$.ajax({
			url: '/login',
			data: 'username=' + encodeURIComponent(username) + '&password=' + encodeURIComponent(pw),
			success:function(data){
				//alert(data);
				window.location = data;
			}
		});
		
	});
	
	$('#createaccountform').on("submit", function(e){
		e.preventDefault();
		var username = $('#username').val();
		var password = $('#password').val();
		var confirmpassword = $('#confirmpassword').val();
		
		if(!(username === "" || password === "" || confirmpassword === "")){
			var bMatch = false;
			if(password === confirmpassword){
				bMatch = true;
			}
			
			if(bMatch){
				$.ajax({
					url: '/createplayer',
					data: 'username=' + encodeURIComponent(username) + '&password=' + encodeURIComponent(password),
					success: function(data){
						if(data === 'success'){
							alert("Login Successful. Now being redirected to pick screen...");
							window.location = '/Pick.jsp';
						} else if(data === 'alreadyexists'){
							alert("Error: account name already exists.");
						} else{
							alert(data);
						}
					}
				});
			} else{
				alert("Passwords do not match. Please try again.");
				$('#password').val("");
				$('#confirmpassword').val("");
			}
		} else{
			alert("Please enter values for all of the fields above.");
		}
		
	});
	
});
</script>
  </body>
</html>
