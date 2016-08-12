
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
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
  <script src="../js/jquery.dataTables.js"></script>
  <script>
  $(function() {
   /* $( "#datepicker" ).datepicker({
    	onSelect: function(dateText) {
    		var dateparts = dateText.split("/");
    		var year = dateparts[2];
    		var month = dateparts[0];
    		var day = dateparts[1];
    		var date = year + month + day;
    	    $('#datedisplay').text(date);
    	    $.ajax({
    	    	url: '/getpicksfromdate',
    	    	data: 'date=' + date,
    	    	success:function(data){
    	    		$("#picktable").html(data);	
    	    	}
    	    });
    	  }
    });*/
  });
  </script>
  <script>
  $(function() {
    var startDate;
    var endDate;

    var selectCurrentWeek = function() {
        window.setTimeout(function () {
            $('.week-picker').find('.ui-datepicker-current-day a').addClass('ui-state-active')
        }, 1);
    }
    
    var getGamesForWeek = function(startDate, endDate) {
    	var startdateparts = startDate.split("\/");
    	var startdatemonth = startdateparts[0];
    	var startdateday   = startdateparts[1];
    	var startdateyear  = startdateparts[2];
    	
    	var enddateparts = endDate.split("\/");
    	var enddatemonth = enddateparts[0];
    	var enddateday   = enddateparts[1];
    	var enddateyear  = enddateparts[2];
    	
    	var startdate = startdateyear + startdatemonth + startdateday;
    	var enddate = enddateyear + enddatemonth + enddateday;
    	
    	$("#picks").html("");
    	var mainTable = $('#maintable').dataTable();

		mainTable.fnClearTable();
		
    	if(!(isNaN(startdate) || isNaN(enddate))){
        	for(var i = startdate; i <= enddate; i++){
        		$.ajax({
        			url: '/getpicksfromdate',
        			data: 'date=' + i,
        			async: true,
        			success: function(data){
        				//$("#picks").append(data);
        				var games = data.split("|");
        				for(var i = 0; i < games.length-1; i++){
        					var hometeam = games[i].split("splithere")[0];
        					var awayteam = games[i].split("splithere")[1];
        					var gameId = games[i].split("splithere")[2];
        					mainTable.fnAddData(["<input class='homeinput' type='radio' name='game" + gameId + "'>", hometeam, "<input class='awayinput' type='radio' name='game" + gameId + "'>", awayteam]);
        				};
        			}
        		});
        		
        	}	
    	}
    	
    }

    $('.week-picker').datepicker( {
        showOtherMonths: true,
        selectOtherMonths: true,
        onSelect: function(dateText, inst) { 
            var date = $(this).datepicker('getDate');
            startDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 4);
            endDate = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 7);
            var dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
            $('#startDate').text($.datepicker.formatDate( dateFormat, startDate, inst.settings ));
            $('#endDate').text($.datepicker.formatDate( dateFormat, endDate, inst.settings ));
			
            selectCurrentWeek();
            getGamesForWeek($.datepicker.formatDate( dateFormat, startDate, inst.settings ), 
            		$.datepicker.formatDate( dateFormat, endDate, inst.settings ));
        },
        beforeShowDay: function(date) {
            var cssClass = '';
            if(date >= startDate && date <= endDate)
                cssClass = 'ui-datepicker-current-day';
            return [true, cssClass];
        },
        onChangeMonthYear: function(year, month, inst) {
            selectCurrentWeek();
        }
    });

    $('.week-picker .ui-datepicker-calendar tr').on('mousemove', function() { $(this).find('td a').addClass('ui-state-hover'); });
    $('.week-picker .ui-datepicker-calendar tr').on('mouseleave', function() { $(this).find('td a').removeClass('ui-state-hover'); });
});
</script>
</head>
<body>
<div id='wholebodyoutside'>
<div id='wholebodyinside'>
<!-- p>Date: <input type="text" id="datepicker"></p>
<div id='datedisplay'></div>
Your username: <div id='username'></div>
<div id='picktable'></div>
<div id='savepickdiv'><button id='savepick'>Save Picks</button></div>
<div id='picksuccess'></div-->

<!-- div id='usernamediv'>Your username: 

</div-->
<div id='header'>

</div>
<div id='body'>
<span id='username' style='visibility: hidden'></span>
<div id='bodydiv'>
<div id='bodytop'>
<br/><br/>
<p id='calendardescription'>
    To select games, choose a weekend by clicking a date on the calendar below.
    </p>
    <br/>

<div class="week-picker"></div>
    <br />
    <!-- label>Week :</label> <span id="startDate"></span> - <span id="endDate"></span-->
    Once you've chosen a date above, the matchups for that weekend will appear in the table below. Simply select who you think will win
    in each matchup, then click "Save Picks".
    <br/><br/>
    </div>
    <div id='bodybottom'>
    <div class='picksuccess'></div>
    <br/><br/>
    <div id='picksdiv'>
    	<table id='maintable' class='display dataTable'>
    		<thead>
    			<tr>
    				<th>Home Select</th>
    				<th class='picksheader'>Home Team</th>
    				<th>Away Select</th>
    				<th class='picksheader'>Away Team</th>
    			</tr>
    		</thead>
    		<!-- tbody id='picks'>
    			<!tr>
    				<td></td>
    				<td></td>
    				<td></td>
    				<td></td>
    			</tr>
    		</tbody-->
    	</table>
    </div>
<div id='savepickdiv'><button id='savepick'>Save Picks</button></div>
<div class='picksuccess'></div></div>
</div>
</div></div>
</div>
<script type='text/javascript'>
$( document ).ready(function() {

	$('#maintable').dataTable({
		"autoWidth": true,
		"iDisplayLength": 50
	});
	
	var username = '';
	
	//get username
	$.ajax({
		url: "/getusername",
		success:function(data){
			username = data;
			if (username === '') {
				window.location = "login.jsp";
			} else {
				$('#username').append(username);
			}
		}
	});
	
	
	$("#savepick").on("click", function(){
		//get all selected values
		var tds = $('#maintable input[type=radio]:checked');
		
		$(tds).each(function(){
			var homeaway = '';
			var tdclass= $(this).attr('class');
			if(tdclass === 'homeinput'){
				homeaway = 'home';
			} else if(tdclass === 'awayinput'){
				homeaway = 'away';
			}
			
			var game = $(this).attr('name');
			var gameId = game.split('game')[1];
			var username = $('#username').text();
			$.ajax({
				url: '/savepick',
				data: 'homeaway=' + homeaway + '&gameId=' + gameId + '&username=' + username,
				async: true,
				success: function(data){
					if(data === 'success'){
						$('.picksuccess').text("Picks saved successfully!");
						//alert("Picks saved successfully!");
					} else if(data === 'no playerId found'){
						alert(data);
					}
				}
			});

			
		});
		//alert(tds);
	});
	
	
	
	
});
</script>
</body>
</html>