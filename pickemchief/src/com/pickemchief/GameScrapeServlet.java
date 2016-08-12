package com.pickemchief;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import org.jsoup.Jsoup;
import org.jsoup.helper.Validate;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class GameScrapeServlet extends HttpServlet {
	static {
        ObjectifyService.register(Game.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
    	PrintWriter out = resp.getWriter();
    	String todaydate = req.getParameter("todaydate");
    	try{
    	Document doc = Jsoup.connect("http://espn.go.com/nba/schedule?date=" + todaydate).get();
    	Elements days = doc.select("tbody");
    	List<Game> oddgames = new ArrayList<Game>();
    	List<Game> evengames = new ArrayList<Game>();
    	
    	int countDays = 3; //0, 1, 2
    	
    	for(int i = 0; i < countDays; i++){
    		Element day = days.get(i);

    			int numGames = 0;
    			Element header = day.select("tr.stathead").first();
    			String inputdate = header.html();
    			String outputdate = parseDate(inputdate, out);
    			//out.println("<h1><b>" + outputdate + "</b></h1>");
    			Elements oddmatchupdays = day.select("tr.oddrow");
    			Elements evenmatchupdays = day.select("tr.evenrow");
    	
    			for(Element matchupday : oddmatchupdays){
    				Element teams = matchupday.select("td").first();
    				if(!"No Games Scheduled".equals(teams.text())){
    					Element time = matchupday.select("td").get(1);
    					String[] teamnames = parseGame(teams.text(), out);
    					Game game = new Game(outputdate, teamnames[0], teamnames[1], "",  time.text());
    					//out.println(game.getHometeam() + " @ " + game.getAwayteam() + " on " + game.getDate() + " at " + game.getTime() + "<p>");
    					///ofy().save().entity(game).now();
    					oddgames.add(game);
    				}
    			}
    			for(Element matchupday : evenmatchupdays){
    				Element teams = matchupday.select("td").first();
    				if(!"No Games Scheduled".equals(teams.text())){
    					Element time = matchupday.select("td").get(1);
    					String[] teamnames = parseGame(teams.text(), out);
    					Game game = new Game(outputdate, teamnames[0], teamnames[1], "",  time.text());
    					//out.println(game.getHometeam() + " @ " + game.getAwayteam() + " on " + game.getDate() + " at " + game.getTime() + "<p>");
    					//ofy().save().entity(game).now();
    					evengames.add(game);
    				}
    			}
    			numGames = evengames.size() + oddgames.size();
    			//out.println(numGames + "<p>");
    			if((numGames % 2 == 0) && (numGames != 0)){
    				//even games
    				for(int j = 0; j < numGames / 2; j++){
    					ofy().save().entity(oddgames.get(j));
    					ofy().save().entity(evengames.get(j));
    				}
    			} else if((numGames %2 == 1) && (numGames != 0)){
    				for(int j = 0; j < (numGames-1)/2; j++){
    					ofy().save().entity(oddgames.get(j));
    					ofy().save().entity(evengames.get(j));
    				}
    				ofy().save().entity(oddgames.get((numGames-1)/2));
    			}
    			evengames.clear();
    			oddgames.clear();
    			
    		}
    		out.println("Schedule load success");
    	
    	}catch(Exception e){
    		out.println(e.getMessage());
    		//out.println("http://espn.go.com/nba/schedule?date=" + todaydate);
    	}
    	//out.println(parseDate("Wednesday, December 25") + "<p>");
    }
    private String[] parseGame(String html, PrintWriter out) {
		// TODO Auto-generated method stub
		String[] input = html.split(" at ");
		String awayteam = "";
		String hometeam = ""; 
	
		try{
		 awayteam = input[0];
		 hometeam = input[1];
		} catch(Exception e){
			out.println(e.getMessage());
			out.println(hometeam + " " + awayteam);
		}
		String [] output = {"",""};
		switch(awayteam){
		case "Chicago": output[0] = "Chicago Bulls"; break;
		case "Brooklyn": output[0] = "Brooklyn Nets"; break;
		case "Oklahoma City": output[0] = "Oklahoma City Thunder"; break;
		case "New York": output[0] = "New York Knicks"; break;
		case "Miami": output[0] = "Miami Heat"; break;
		case "LA Lakers": output[0] = "Los Angeles Lakers"; break;
		case "Houston": output[0] = "Houston Rockets"; break;
		case "San Antonio": output[0] = "San Antonio Spurs"; break;
		case "LA Clippers": output[0] = "Los Angeles Clippers"; break;
		case "Golden State": output[0] = "Golden State Warriors"; break;
		case "Atlanta": output[0] = "Atlanta Hawks"; break;
		case "Cleveland": output[0] = "Cleveland Cavaliers"; break;
		case "Memphis": output[0] = "Memphis Grizzlies"; break;
		case "Dallas": output[0] = "Dallas Mavericks"; break;
		case "Portland": output[0] = "Portland Trailblazers"; break;
		case "Charlotte": output[0] = "Charlotte Hornets"; break;
		case "Detroit": output[0] = "Detroit Pistons"; break;
		case "Orlando": output[0] = "Orlando Magic"; break;
		case "Milwaukee": output[0] = "Milwaukee Bucks"; break;
		case "Toronto": output[0] = "Toronto Raptors"; break;
		case "Washington": output[0] = "Washington Wizards"; break;
		case "Minnesota": output[0] = "Minnesota Timberwolves"; break;
		case "Denver": output[0] = "Denver Nuggets"; break;
		case "New Orleans": output[0] = "New Orleans Pelicans"; break;
		case "Utah": output[0] = "Utah Jazz"; break;
		case "Sacramento": output[0] = "Sacramento Kings"; break;
		case "Phoenix": output[0] = "Phoenix Suns"; break;
		case "Boston": output[0] = "Boston Celtics"; break;
		case "Indiana": output[0] = "Indiana Pacers"; break;
		case "Philadelphia": output[0] = "Philadelphia 76ers"; break;
		default: output[0] = "";
		}
		switch(hometeam){
		case "Chicago": output[1] = "Chicago Bulls"; break;
		case "Brooklyn": output[1] = "Brooklyn Nets"; break;
		case "Oklahoma City": output[1] = "Oklahoma City Thunder"; break;
		case "New York": output[1] = "New York Knicks"; break;
		case "Miami": output[1] = "Miami Heat"; break;
		case "LA Lakers": output[1] = "Los Angeles Lakers"; break;
		case "Houston": output[1] = "Houston Rockets"; break;
		case "San Antonio": output[1] = "San Antonio Spurs"; break;
		case "LA Clippers": output[1] = "Los Angeles Clippers"; break;
		case "Golden State": output[1] = "Golden State Warriors"; break;
		case "Atlanta": output[1] = "Atlanta Hawks"; break;
		case "Cleveland": output[1] = "Cleveland Cavaliers"; break;
		case "Memphis": output[1] = "Memphis Grizzlies"; break;
		case "Dallas": output[1] = "Dallas Mavericks"; break;
		case "Portland": output[1] = "Portland Trailblazers"; break;
		case "Charlotte": output[1] = "Charlotte Hornets"; break;
		case "Detroit": output[1] = "Detroit Pistons"; break;
		case "Orlando": output[1] = "Orlando Magic"; break;
		case "Milwaukee": output[1] = "Milwaukee Bucks"; break;
		case "Toronto": output[1] = "Toronto Raptors"; break;
		case "Washington": output[1] = "Washington Wizards"; break;
		case "Minnesota": output[1] = "Minnesota Timberwolves"; break;
		case "Denver": output[1] = "Denver Nuggets"; break;
		case "New Orleans": output[1] = "New Orleans Pelicans"; break;
		case "Utah": output[1] = "Utah Jazz"; break;
		case "Sacramento": output[1] = "Sacramento Kings"; break;
		case "Phoenix": output[1] = "Phoenix Suns"; break;
		case "Boston": output[1] = "Boston Celtics"; break;
		case "Indiana": output[1] = "Indiana Pacers"; break;
		case "Philadelphia": output[1] = "Philadelphia 76ers"; break;
		default: output[1] = "";
		}
		return output;
	}
	private String parseDate(String inputdate, PrintWriter out) {
		// TODO Auto-generated method stub
		
		String[] input = inputdate.split(" ");
		String month = input[2];
		String day = input[3];
		String year;
		
		switch(month){
		case "January": month = "01"; year = "2014"; break;
		case "February": month = "02"; year = "2014";  break;
		case "March": month = "03";  year = "2014"; break;
		case "April": month = "04";  year = "2014"; break;
		case "May": month = "05";  year = "2014"; break;
		case "June": month = "06";  year = "2014"; break;
		case "July": month = "07";  year = "2014"; break;
		case "August": month = "08";  year = "2014"; break;
		case "September": month = "09";  year = "2014"; break;
		case "October": month = "10";  year = "2014"; break;
		case "November": month = "11";  year = "2014"; break;
		case "December": month = "12"; year = "2013"; break;
		default: year = ""; month = ""; break;
		}
		//out.println(day.substring(0,2));
		if(day.substring(0, 2).contains("<")){
			day = "0" + day;
		}
		return (year + "" + month  + "" + day).substring(0, 8);

	}
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
 		   throws IOException {
 	doPost(req, resp);
 	
 }
}