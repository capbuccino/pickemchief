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
import javax.servlet.http.HttpSession;

import com.googlecode.objectify.ObjectifyService;
import org.jsoup.Jsoup;
import org.jsoup.helper.Validate;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class ViewAllTheirPicksServlet extends HttpServlet {
	static {
        ObjectifyService.register(Player.class);
        ObjectifyService.register(Game.class);
        ObjectifyService.register(Pick.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
    	HttpSession session = req.getSession(true);
    	PrintWriter out = resp.getWriter();
    	String startdate = req.getParameter("startdate");
    	String enddate = req.getParameter("enddate");

    	Integer intStartdate = Integer.parseInt(startdate);
    	Integer intEnddate = Integer.parseInt(enddate);
        ofy().clear();
        
        //get all players
        List<Player> allplayers = ofy().load().type(Player.class).list();
        String html = "";
        try{
        for(Player player : allplayers){
        	Long playerId = player.getId();
        	String playerName = player.getUsername();
        	List<Pick> picks = ofy().load().type(Pick.class).filter("playerID", playerId).list();
        	html += "<table class='picktable'>" +
        			"		<thead>" +
        			"			<tr>" +
        			"				<th colspan='2'>Player: <b>" + playerName + "</b></th>" +
        			"			</tr>" +
        			"			<tr>" +
        			"				<th>Game</th>" +
        			"				<th>Pick</th>" +
        			"			</tr>" +
        			"		</thead>" +
        			"		<tbody>";
        	for(Pick pick : picks){
        		Long gameID = pick.getGameID();
        	//	for(int i = intStartdate; i <= intEnddate; i ++){
        			//String date = String.valueOf(i);
        			Game game = ofy().load().type(Game.class).filter("id", gameID).first().get();
            		boolean fallsWithinDateRange = false;
            		for(int i = intStartdate; i <= intEnddate; i++){
            			String date = String.valueOf(i);
            			if(date.equals(game.getDate())){
            				fallsWithinDateRange = true;
            			}
            		}
            		if(fallsWithinDateRange){
            			String matchup = game.getAwayteam() + " @ " + game.getHometeam();
            			String selection = "";
            			String userPick = pick.getPick();
            			if(userPick.equals("away")){
            				selection = game.getAwayteam();
            			} else if(userPick.equals("home")){
            				selection = game.getHometeam();
            			}
            			html += "<tr>" +
            				"	<td>" + matchup + "</td>" +
            				"   <td>" + selection + "</td>" +
            				"</tr>";
            		}
        		//}
        	}
        	html += "</tbody></table><p>";
        }
        } catch(Exception e){
        	out.print(e.getMessage());
        	out.print(html);
        }
        out.print(html);
        
    	
    	

    }
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
 		   throws IOException {
 	doPost(req, resp);
 	
 }
}