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

public class GetPicksFromDateServlet extends HttpServlet {
	static {
        ObjectifyService.register(Player.class);
        ObjectifyService.register(Game.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
    	HttpSession session = req.getSession(true);
    	PrintWriter out = resp.getWriter();
    	String date = req.getParameter("date");
    	String html = "";
    	
    	/*
    	html += "<table class='datatable'>" +
    			"<thead>" +
    				"<th class='picksheader' colspan='2'>Home Team</th>" +
    				"<th class='picksheader' colspan='2'>Away Team</th>" +
    			"</thead>" +
    			
    			"<tbody>";*/
    	List<Game> games = ofy().load().type(Game.class).filter("date", date).list();
    	for(Game game : games){
    		/*html += "<tr>" +
    					"<td><input class='homeinput' type='radio' name='game" + game.getId() + "'/></td>" +
    					"<td class='hometeam'>" + game.getHometeam() + "</td>" +
    					"<td><input class='awayinput' type='radio' name='game" + game.getId() + "'/></td>" +
    					"<td class='awayteam'>" + game.getAwayteam() + "</td>" +
    				"</tr>";*/
    		html += game.getHometeam() + "splithere" + game.getAwayteam() + "splithere" + game.getId() + "|";
    	}
    	//html += "</tbody></table>";
    	out.print(html);

    }
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
 		   throws IOException {
 	doPost(req, resp);
 	
 }
}