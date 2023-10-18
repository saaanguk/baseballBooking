package baseballbooking;

import java.sql.Time;
import java.sql.Date;

public class stadium {
	private String groundName;
	private String groundLocation;
	private String img;
	private String resDate;
	private String start_time;
	private String finish_time;
	private String team_name1;
	private String team_name2;
	private String training;
	
	public String getTraining() {
		return training;
	}
	public void setTraining(String training) {
		this.training = training;
	}
	public String getResDate() {
		return resDate;
	}
	public void setResDate(String resDate) {
		this.resDate = resDate;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getFinish_time() {
		return finish_time;
	}
	public void setFinish_time(String finish_time) {
		this.finish_time = finish_time;
	}
	public String getTeam_name1() {
		return team_name1;
	}
	public void setTeam_name1(String team_name1) {
		this.team_name1 = team_name1;
	}
	public String getTeam_name2() {
		return team_name2;
	}
	public void setTeam_name2(String team_name2) {
		this.team_name2 = team_name2;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getGroundName() {
		return groundName;
	}
	public void setGroundName(String grounName) {
		this.groundName = grounName;
	}
	public String getGroundLocation() {
		return groundLocation;
	}
	public void setGroundLocation(String groundLocation) {
		this.groundLocation = groundLocation;
	}
}
