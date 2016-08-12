
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
  text-align: center;
  }
  #maintable tbody td{
  	color: black;
  }
  #header{
  background-image: url('../images/pickemchief.jpg');
    background-repeat: no-repeat;
    background-position: center top; 
  margin-left: auto;
  margin-right: auto;
  width: 100%;
  background-color: #0ca1d2;
  height: 200px;
  }
  #body{
  }
  .ui-datepicker {
  	margin: auto;
  }
  #bodytop{
    border-style: dashed;
    border-width: 3px;
    border-color: white;
    margin-left: 20%;
    margin-right: 20%;
  }
  #bodybottom{
    margin-left: 20%;
    margin-right: 20%;
  }
  #wholebodyinside{
  margin-left: 15%;
  margin-right: 15%;
  background-color: #0ca1d2;
  }
  #wholebodyoutside{

  }
  body{
  background-color: white;
  }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pick 'Em</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/jquery.dataTables.css">  
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
  
  <script>
  $( function() {
	    $( "#accAtlantic" ).selectmenu();
	    $( "#accCoastal" ).selectmenu();
	    $( "#acc" ).selectmenu();
	    $( "#big10East" ).selectmenu();
	    $( "#big10West" ).selectmenu();
	    $( "#big10" ).selectmenu();
	    $( "#big12" ).selectmenu();
	    $( "#pac12North" ).selectmenu();
	    $( "#pac12South" ).selectmenu();
	    $( "#pac12" ).selectmenu();
	    $( "#secEast" ).selectmenu();
	    $( "#secWest" ).selectmenu();
	    $( "#sec" ).selectmenu();
  });
  </script>
</head>
<body>
<div id='wholebodyoutside'>
<div id='wholebodyinside'>

<div id='header'>

</div>

<div id='body'>
	<span id='username' style='visibility: hidden'></span>
	<div id='bodydiv'>
		<div id='bodytop'><br/>
			Select winners from the following conferences/divisions: <br/><br/>
<label for="accAtlantic">ACC Atlantic:</label>
<select name="accAtlantic" id="accAtlantic">
	<option value="Boston College">Boston College</option>
	<option value="Clemson">Clemson</option>
	<option value="Florida State">Florida State</option>
	<option value="Louisville">Louisville</option>
	<option value="NC State">NC State</option>
	<option value="Syracuse">Syracuse</option>
	<option value="Wake Forest">Wake Forest</option>
</select>
<br/>
<label for="accCoastal">ACC Coastal:</label>
<select name="accCoastal" id="accCoastal">
	<option value="Duke">Duke</option>
	<option value="Georgia Tech">Georgia Tech</option>
	<option value="Miami">Miami</option>
	<option value="North Carolina">North Carolina</option>
	<option value="Pittsburgh">Pittsburgh</option>
	<option value="Virginia">Virginia</option>
	<option value="Virginia Tech">Virginia Tech</option>
</select>
	
<br/>
<label for="acc">Overall ACC Champ:</label>
<select name="acc" id="acc">
	<option value="Boston College">Boston College</option>
	<option value="Clemson">Clemson</option>
	<option value="Duke">Duke</option>
	<option value="Florida State">Florida State</option>
	<option value="Georgia Tech">Georgia Tech</option>
	<option value="Louisville">Louisville</option>
	<option value="Miami">Miami</option>
	<option value="NC State">NC State</option>
	<option value="North Carolina">North Carolina</option>
	<option value="Pittsburgh">Pittsburgh</option>
	<option value="Syracuse">Syracuse</option>
	<option value="Virginia">Virginia</option>
	<option value="Virginia Tech">Virginia Tech</option>
	<option value="Wake Forest">Wake Forest</option>
</select>
			<br/><br/>
			
<label for="big10East">Big 10 East:</label>
<select name="big10East" id="big10East">
	<option value="Indiana">Indiana</option>
	<option value="Maryland">Maryland</option>
	<option value="Michigan">Michigan</option>
	<option value="Michigan State">Michigan State</option>
	<option value="Ohio State">Ohio State</option>
	<option value="Penn State">Penn State</option>
	<option value="Rutgers">Rutgers</option>
</select>
<br/>
<label for="big10West">Big 10 West:</label>
<select name="big10West" id="big10West">
	<option value="Illinois">Illinois</option>
	<option value="Iowa">Iowa</option>
	<option value="Minnesota">Minnesota</option>
	<option value="Nebraska">Nebraska</option>
	<option value="Northwestern">Northwestern</option>
	<option value="Purdue">Purdue</option>
	<option value="Wisconsin">Wisconsin</option>
</select>
<br/>
<label for="big10">Overall Big 10 Champ:</label>
<select name="big10" id="big10">
	<option value="Illinois">Illinois</option>
	<option value="Indiana">Indiana</option>
	<option value="Iowa">Iowa</option>
	<option value="Maryland">Maryland</option>
	<option value="Michigan">Michigan</option>
	<option value="Michigan State">Michigan State</option>
	<option value="Minnesota">Minnesota</option>
	<option value="Nebraska">Nebraska</option>
	<option value="Northwestern">Northwestern</option>
	<option value="Ohio State">Ohio State</option>
	<option value="Penn State">Penn State</option>
	<option value="Purdue">Purdue</option>
	<option value="Rutgers">Rutgers</option>
	<option value="Wisconsin">Wisconsin</option>
</select>
<br/><br/>
<label for="big12">Overall Big 12 Champ:</label>
<select name="big12" id="big12">
	<option value="Baylor">Baylor</option>
	<option value="Iowa State">Iowa State</option>
	<option value="Kansas">Kansas</option>
	<option value="Kansas State">Kansas State</option>
	<option value="Oklahoma">Oklahoma</option>
	<option value="Oklahoma State">Oklahoma State</option>
	<option value="TCU">TCU</option>
	<option value="Texas">Texas</option>
	<option value="Texas Tech">Texas Tech</option>
	<option value="West Virginia">West Virginia</option>
	</select>
	
				<br/><br/>
			
<label for="pac12North">Pac 12 North:</label>
<select name="pac12North" id="pac12North">
	<option value="California">California</option>
	<option value="Oregon">Oregon</option>
	<option value="Oregon State">Oregon State</option>
	<option value="Stanford">Stanford</option>
	<option value="Washington">Washington</option>
	<option value="Washington State">Washington State</option>
</select>
<br/>
<label for="pac12South">Pac 12 South:</label>
<select name="pac12South" id="pac12South">
	<option value="Arizona">Arizona</option>
	<option value="Arizona State">Arizona State</option>
	<option value="Colorado">Colorado</option>
	<option value="Southern California">Southern California</option>
	<option value="UCLA">UCLA</option>
	<option value="Utah">Utah</option>
</select>
<br/>
<label for="pac12">Overall Pac 12 Champ:</label>
<select name="pac12" id="pac12">
	<option value="Arizona">Arizona</option>
	<option value="Arizona State">Arizona State</option>
	<option value="California">California</option>
	<option value="Colorado">Colorado</option>
	<option value="Oregon">Oregon</option>
	<option value="Oregon State">Oregon State</option>
	<option value="Southern California">Southern California</option>
	<option value="Stanford">Stanford</option>
	<option value="UCLA">UCLA</option>
	<option value="Utah">Utah</option>
	<option value="Washington">Washington</option>
	<option value="Washington State">Washington State</option>
</select>

<br/><br/>
		
<label for="secEast">SEC East:</label>
<select name="secEast" id="secEast">
	<option value="Florida">Florida</option>
	<option value="Georgia">Georgia</option>
	<option value="Kentucky">Kentucky</option>
	<option value="Missouri">Missouri</option>
	<option value="South Carolina">South Carolina</option>
	<option value="Tennessee">Tennessee</option>
	<option value="Vanderbilt">Vanderbilt</option>
</select>
<br/>	
<label for="secWest">SEC West:</label>
<select name="secWest" id="secWest">
	<option value="Alabama">Alabama</option>
	<option value="Arkansas">Arkansas</option>
	<option value="Auburn">Auburn</option>
	<option value="LSU">LSU</option>
	<option value="Mississippi State">Mississippi State</option>
	<option value="Ole Miss">Ole Miss</option>
	<option value="Texas A&M">texas a or m</option>
	</select>
<br/>
<label for="sec">Overall SEC Champ:</label>
<select name="sec" id="sec">
	<option value="Alabama">Alabama</option>
	<option value="Arkansas">Arkansas</option>
	<option value="Auburn">Auburn</option>
	<option value="Florida">Florida</option>
	<option value="Georgia">Georgia</option>
	<option value="Kentucky">Kentucky</option>
	<option value="LSU">LSU</option>
	<option value="Mississippi State">Mississippi State</option>
	<option value="Missouri">Missouri</option>
	<option value="Ole Miss">Ole Miss</option>
	<option value="South Carolina">South Carolina</option>
	<option value="Tennessee">Tennessee</option>
	<option value="Texas AM">texas a or m</option>
	<option value="Vanderbilt">Vanderbilt</option>
</select>
<br/>
<br/>
Enter 4 playoff participants:
<br/>
<input type="text" id="playoff1">
<br/>
<input type="text" id="playoff2">
<br/>
<input type="text" id="playoff3">
<br/>
<input type="text" id="playoff4">
<br/><br/>
Enter National Champ:
<br/>
<input type="text" id="nationalChamp">
<br/><br/>
			<div id='savepickdiv'><button id='savepick'>Save Picks</button></div>
			<br/>Note: if you've entered picks already, clicking "Save" will overwrite your selections.
			<div class='picksuccess'></div>
		</div>
	</div>

	
	
		
	
</div>

</div>
</div>
<script type='text/javascript'>
$( document ).ready(function() {

	var username = '';
	
	//get username
	$.ajax({
		url: "/getusername",
		success:function(data){
			username = data;
			if (username === '') {
				window.location = "login.jsp?returnUrl=PreseasonPick";
			} else {
				$('#username').append(username);
			}
		}
	});
	
	
	$("#savepick").on("click", function(){
		//get all selected values
			 
		    var accAtlantic = $( "#accAtlantic" ).val();
		    var accCoastal = $( "#accCoastal" ).val();
		    var acc = $( "#acc" ).val();
		    var big10East = $( "#big10East" ).val();
		    var big10West = $( "#big10West" ).val();
		    var big10 = $( "#big10" ).val();
		    var big12 = $( "#big12" ).val();
		    var pac12North = $( "#pac12North" ).val();
		    var pac12South = $( "#pac12South" ).val();
		    var pac12 = $( "#pac12" ).val();
		    var secEast = $( "#secEast" ).val();
		    var secWest = $( "#secWest" ).val();
		    var sec = $( "#sec" ).val();
		    var playoff1 = $('#playoff1').val();
		    var playoff2 = $('#playoff2').val();
		    var playoff3 = $('#playoff3').val();
		    var playoff4 = $('#playoff4').val();
		    var nationalChamp = $('#nationalChamp').val();
		    if(playoff1.length === 0 || playoff2.length === 0 || playoff3.length === 0 || playoff4.length === 0 || nationalChamp.length === 0){
				alert("Please enter a team in each Playoff field and the National Champ field.");
		    } else {
		    	if(secWest === "Texas AM"){
		    		alert("Are you sure you meant to pick A&M? Really?");
		    	}
		    	if(nationalChamp === "Texas AM"){
		    		alert("You can't be serious. Website self-destructing in 3....2....1....");
		    	}
				var username = $('#username').text();
				$.ajax({
					url: '/savepreseasonpick',
					data: 'accAtlantic=' + accAtlantic
							+ '&accCoastal=' + accCoastal
							+ '&acc=' + acc
							+ '&big10West=' + big10West
							+ '&big10East=' + big10East
							+ '&big10=' + big10
							+ '&big12=' + big12
							+ '&pac12North=' + pac12North
							+ '&pac12South=' + pac12South
							+ '&pac12=' + pac12
							+ '&secWest=' + secWest
							+ '&secEast=' + secEast
							+ '&sec=' + sec
							+ '&playoff1=' + playoff1
							+ '&playoff2=' + playoff2
							+ '&playoff3=' + playoff3
							+ '&playoff4=' + playoff4
							+ '&nationalChamp=' + nationalChamp
							+ '&username=' + username
							,
					async: true,
					success: function(data){
						if(data === 'success'){
							$('.picksuccess').text("Preseason picks saved successfully!");
							alert("Picks saved successfully!");
						} else if(data === 'no playerId found'){
							alert(data);
						}
					}
				});
		    }
	});
	
	
	
	
});
</script>
</body>
</html>