package com.pickemchief;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class CreateGameServlet extends HttpServlet {
	static {
        ObjectifyService.register(Game.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {

        resp.setContentType("text/html");

        PrintWriter out = resp.getWriter();
        
    	String hometeam = req.getParameter("hometeam");
        String awayteam = req.getParameter("awayteam");
        String date = req.getParameter("date");
        String time = req.getParameter("time");
        ofy().clear();
        Game game = new Game(date, hometeam, awayteam, "", time);
    	ofy().save().entity(game).now();
        
       //resp.sendRedirect("/Start.jsp");
    	out.println(hometeam + " " + awayteam + " " + date + " " + time + "\n");
    }
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
 		   throws IOException {
 	doPost(req, resp);
 	
 }
}