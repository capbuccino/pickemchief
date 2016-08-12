package com.pickemchief;
import java.util.Date;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;


@Entity
public class Game {
    @Id Long id;
    @Index String date;
    String hometeam;
    String awayteam;
    String winner;
    String time;
    private Game() {}
    
    public Game(String date, String hometeam, String awayteam, String winner, String time){
    	this.date = date;
    	this.hometeam = hometeam;
    	this.awayteam = awayteam;
    	this.winner = winner;
    	this.time = time;
    }
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHometeam() {
		return hometeam;
	}
	public void setHometeam(String hometeam) {
		this.hometeam = hometeam;
	}
	public String getAwayteam() {
		return awayteam;
	}
	public void setAwayteam(String awayteam) {
		this.awayteam = awayteam;
	}
	public String getWinner() {
		return winner;
	}
	public void setWinner(String winner) {
		this.winner = winner;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
   
   
}
