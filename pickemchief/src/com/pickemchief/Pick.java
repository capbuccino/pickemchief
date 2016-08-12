package com.pickemchief;
import java.util.Date;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;


@Entity
public class Pick {
    @Id Long id;
    @Index Long gameID;
    @Index Long playerID;
    String pick;
    String winner;
    boolean correct;
    private Pick() {}
    
    public Pick(Long gameID, Long playerID, String pick, String winner, boolean correct){
    	this.gameID = gameID;
    	this.playerID = playerID;
    	this.pick = pick;
    	this.winner = winner;
    	this.correct = correct;
    }
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getGameID() {
		return gameID;
	}
	public void setGameID(Long gameID) {
		this.gameID = gameID;
	}
	public Long getPlayerID() {
		return playerID;
	}
	public void setPlayerID(Long playerID) {
		this.playerID = playerID;
	}
	public String getPick() {
		return pick;
	}
	public void setPick(String pick) {
		this.pick = pick;
	}
	public String getWinner() {
		return winner;
	}
	public void setWinner(String winner) {
		this.winner = winner;
	}
	public boolean isCorrect() {
		return correct;
	}
	public void setCorrect(boolean correct) {
		this.correct = correct;
	}
    
   
   
}
