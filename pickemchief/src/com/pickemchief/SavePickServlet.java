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

public class SavePickServlet extends HttpServlet {
	static {
        ObjectifyService.register(Player.class);
        ObjectifyService.register(Game.class);
        ObjectifyService.register(Pick.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
    	HttpSession session = req.getSession(true);
    	PrintWriter out = resp.getWriter();
    	Long gameId = Long.parseLong(req.getParameter("gameId"));
    	String homeaway = req.getParameter("homeaway");
    	String username = req.getParameter("username");

        ofy().clear();
        
    	//first load userid
    	Player player = ofy().load().type(Player.class).filter("username", username).first().get();
    	Long playerId;
    	try{
    		playerId = player.getId();
    	} catch(Exception e){
    		playerId = (long) 0;
    	}
    	//check to see if pick already exists
    	if(playerId != 0){
    		//out.print("gameID: " + gameId + " playerID: " + playerId + "\n");
    		Pick pick = ofy().load().type(Pick.class).filter("gameID", gameId).filter("playerID", playerId).first().get();
    		//.filter("playerId", playerId).first().get();
    		
    	
    		try{
    			if(pick == null){
    				//catch
    				//no pick exists for this player/game in db, let's create one
        			Pick newpick = new Pick(gameId, playerId, homeaway, "", false);
        			ofy().save().entity(newpick).now();
        			//out.print("saved new pick, no existing pick");
    			} else{
        			//pick exists, just update it
        			//only thing that could change about the pick here is who is selected. just need to update homeaway
        			//ofy().delete().entity(pick).now();
    				pick.setPick(homeaway);
        			ofy().save().entity(pick).now();
        		//	out.print("deleted old pick, set value, saved new pick");
    			}
    		} catch(Exception e){
    			//no pick exists for this player/game in db, let's create one
    			Pick newpick = new Pick(gameId, playerId, homeaway, "", false);
    			ofy().save().entity(newpick).now();
    			//out.print("saved new pick, no existing pick catch block");
    		}
    	
    		out.print("success");
    	} else{
    		out.print("no playerId found");
    	}

    }
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
 		   throws IOException {
 	doPost(req, resp);
 	
 }
}