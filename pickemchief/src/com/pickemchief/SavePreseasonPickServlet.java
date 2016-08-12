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

public class SavePreseasonPickServlet extends HttpServlet {
	static {
        ObjectifyService.register(Player.class);
        ObjectifyService.register(PreseasonPick.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
    	HttpSession session = req.getSession(true);
    	PrintWriter out = resp.getWriter();
    	String acc = req.getParameter("acc");
    	String sec = req.getParameter("sec");
    	String big10 = req.getParameter("big10");
    	String big12 = req.getParameter("big12");
    	String pac12 = req.getParameter("pac12");
    	String playoff1 = req.getParameter("playoff1");
    	String playoff2 = req.getParameter("playoff2");
    	String playoff3 = req.getParameter("playoff3");
    	String playoff4 = req.getParameter("playoff4");
    	String nationalChamp = req.getParameter("nationalChamp");
    	String accAtlantic = req.getParameter("accAtlantic");
    	String accCoastal = req.getParameter("accCoastal");
    	String big10West = req.getParameter("big10West");
    	String big10East = req.getParameter("big10East");
    	String pac12North = req.getParameter("pac12North");
    	String pac12South = req.getParameter("pac12South");
    	String secWest = req.getParameter("secWest");
    	String secEast = req.getParameter("secEast");
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
    		PreseasonPick preseasonpick = ofy().load().type(PreseasonPick.class).filter("playerID", playerId).first().get();
    		
    		try{
    			//try to delete an existing record
    			ofy().delete().entity(preseasonpick);
    		} catch(Exception e){
    			//no preseason pick exists, that's okay     			
    		} finally {
    			//either way, let's save the new pick
    			PreseasonPick newPick = new PreseasonPick(playerId, sec, acc, big12, big10, pac12, accCoastal, accAtlantic, big10East, big10West, pac12North, pac12South, secWest, secEast, playoff1, playoff2, playoff3, playoff4, nationalChamp);
  			
    			ofy().save().entity(newPick).now();
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