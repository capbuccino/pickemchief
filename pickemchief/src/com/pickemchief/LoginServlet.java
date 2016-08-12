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

public class LoginServlet extends HttpServlet {
	static {
        ObjectifyService.register(Player.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
    	HttpSession session = req.getSession(true);
    	PrintWriter out = resp.getWriter();
    	String username = req.getParameter("username");
    	String password = req.getParameter("password");
    	Player player = ofy().load().type(Player.class).filter("username", username).first().get();
    	try{
    		if(password.equals(player.getPassword()) ){
    			//login successful
    			session.setAttribute("username", username);
    			out.print("/Pick.jsp");
    		} else {
    			//login not successful
    			out.print("wrongpw");
    		}
    	} catch(NullPointerException e){
    		//no such player found
    		out.print("errorloggingin");
    	}
    }
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
 		   throws IOException {
 	doPost(req, resp);
 	
 }
}