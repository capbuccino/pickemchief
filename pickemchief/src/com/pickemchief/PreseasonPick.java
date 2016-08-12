package com.pickemchief;
import java.util.Date;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;


@Entity
public class PreseasonPick {
    @Id Long id;
    @Index Long playerID;
    String sec;
    String acc;
    String big12;
    String big10;
    String pac12;
    String accCoastal;
    String accAtlantic;
    String big10East;
    String big10West;
    String pac12North;
    String pac12South;
    String secWest;
    String secEast;
    String playoff1;
    String playoff2;
    String playoff3;
    String playoff4;
    String nationalChamp;
    private PreseasonPick() {}
    
    
	public PreseasonPick(Long playerID, String sec,
			String acc, String big12, String big10,
			String pac12, String accCoastal, String accAtlantic,
			String big10East, String big10West, String pac12North,
			String pac12South, String secWest, String secEast, String playoff1,
			String playoff2, String playoff3, String playoff4,
			String nationalChamp) {
		this.playerID = playerID;
		this.sec = sec;
		this.acc = acc;
		this.big12 = big12;
		this.big10 = big10;
		this.pac12 = pac12;
		this.accCoastal = accCoastal;
		this.accAtlantic = accAtlantic;
		this.big10East = big10East;
		this.big10West = big10West;
		this.pac12North = pac12North;
		this.pac12South = pac12South;
		this.secWest = secWest;
		this.secEast = secEast;
		this.playoff1 = playoff1;
		this.playoff2 = playoff2;
		this.playoff3 = playoff3;
		this.playoff4 = playoff4;
		this.nationalChamp = nationalChamp;
	}


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getPlayerID() {
		return playerID;
	}
	public void setPlayerID(Long playerID) {
		this.playerID = playerID;
	}
	public String getSecWinner() {
		return sec;
	}
	public void setSecWinner(String secWinner) {
		this.sec = secWinner;
	}
	public String getAccWinner() {
		return acc;
	}
	public void setAccWinner(String accWinner) {
		this.acc = accWinner;
	}
	public String getBig12Winner() {
		return big12;
	}
	public void setBig12Winner(String big12Winner) {
		this.big12 = big12Winner;
	}
	public String getBig10Winner() {
		return big10;
	}
	public void setBig10Winner(String big10Winner) {
		this.big10 = big10Winner;
	}
	public String getPac12Winner() {
		return pac12;
	}
	public void setPac12Winner(String pac12Winner) {
		this.pac12 = pac12Winner;
	}
	public String getAccCoastal() {
		return accCoastal;
	}
	public void setAccCoastal(String accCoastal) {
		this.accCoastal = accCoastal;
	}
	public String getAccAtlantic() {
		return accAtlantic;
	}
	public void setAccAtlantic(String accAtlantic) {
		this.accAtlantic = accAtlantic;
	}
	public String getBig10East() {
		return big10East;
	}
	public void setBig10East(String big10East) {
		this.big10East = big10East;
	}
	public String getBig10West() {
		return big10West;
	}
	public void setBig10West(String big10West) {
		this.big10West = big10West;
	}
	public String getPac12North() {
		return pac12North;
	}
	public void setPac12North(String pac12North) {
		this.pac12North = pac12North;
	}
	public String getPac12Soth() {
		return pac12South;
	}
	public void setPac12Soth(String pac12Soth) {
		this.pac12South = pac12Soth;
	}
	public String getSecWest() {
		return secWest;
	}
	public void setSecWest(String secWest) {
		this.secWest = secWest;
	}
	public String getSecEast() {
		return secEast;
	}
	public void setSecEast(String secEast) {
		this.secEast = secEast;
	}
	public String getPlayoff1() {
		return playoff1;
	}
	public void setPlayoff1(String playoff1) {
		this.playoff1 = playoff1;
	}
	public String getPlayoff2() {
		return playoff2;
	}
	public void setPlayoff2(String playoff2) {
		this.playoff2 = playoff2;
	}
	public String getPlayoff3() {
		return playoff3;
	}
	public void setPlayoff3(String playoff3) {
		this.playoff3 = playoff3;
	}
	public String getPlayoff4() {
		return playoff4;
	}
	public void setPlayoff4(String playoff4) {
		this.playoff4 = playoff4;
	}
	public String getNationalChamp() {
		return nationalChamp;
	}
	public void setNationalChamp(String nationalChamp) {
		this.nationalChamp = nationalChamp;
	}
    
	
    
    
   
   
}
