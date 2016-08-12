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
<link rel="stylesheet" href="../css/style.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
  <script>
  function getURLParameter(name) {
	  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
	}
  </script>
  
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
    	<title>Welcome to Pick 'Em Chief!</title>
  </head>

  <body>
  <div class='container'>
<div class='login'>
<form id='loginform'>
Username (email): <input type="text" value="" name="username" id="username"/> <br/>
Password: <input type="password" value="" name="password" id="password"/> <br/>
<br/>
<input type="submit" value="Log In"/>
<p>
<button id='createaccount'>Don't have an account?</button>
</p>
</form>
</div>
</div>
<script type='text/javascript'>
$( document ).ready(function() {
	var username = '<%session.getAttribute("username");%>';
	var returnURL = getURLParameter('returnUrl');
	$('#loginform').on("submit", function(e){
		e.preventDefault();
		var username = $('#username').val();
		var pw = $('#password').val();
		$.ajax({
			url: '/login',
			data: 'username=' + encodeURIComponent(username) + '&password=' + encodeURIComponent(pw),
			success:function(data){
				//alert(data);
				if(data === "errorloggingin"){
					alert("Error logging in.");
				} else if(data === "wrongpw"){
					alert("Incorrect password.");
				} else{
					if(returnURL.length === 0){
						window.location = data;
					} else {
						window.location = returnURL + ".jsp";
					}
				}
			}
		});
		
	});
	
	$('#createaccount').on("click", function(){
		window.location = '/createaccount.jsp';
	});
});
</script>
  </body>
</html>
