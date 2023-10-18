package baseballbooking;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalTime;



public class stadiumDAO {
	private Connection conn; // connection:db에접근하게 해주는 객체

	private PreparedStatement pstmt;

	private ResultSet rs;

	// mysql에 접속해 주는 부분

	public stadiumDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		
	try {

		String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
	
		String dbID = "root";
	
		String dbPassword = "qwer";
	
		Class.forName("com.mysql.cj.jdbc.Driver");
	
		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	
		} catch (Exception e) {
	
			e.printStackTrace(); // 오류가 무엇인지 출력
	
		}

	}
	

	public int insert(String groundName, String groundLocation, String img) throws Exception {
		
				String SQL = "insert into stadium(stadium_name, addr, img) values(?,?,?)";
				
				try {
					
					pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, groundName);
					pstmt.setString(2, groundLocation);
					pstmt.setString(3, img);
					
					pstmt.executeUpdate();
					
					return 1;
					
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println(e.getMessage());
					return -1;	
				} finally {
					
					pstmt.close();
					conn.close();
				}
	}
	
	public int booking(String groundName, String resDate, String start_time, String finish_time, String team_name1, String training) throws Exception {
	    
		 System.out.println("구장이름 : " + groundName);
		 System.out.println("예약 날짜 : " + resDate);
		 System.out.println("시작 시간 : " + start_time);
		 System.out.println("종료 시간 : " + finish_time);
		 System.out.println("예약 목적 :" + training);
		
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		java.util.Date parsedStartTime = sdf.parse(start_time);
	    java.util.Date parsedFinishTime = sdf.parse(finish_time);
	    
	    java.sql.Time str = new java.sql.Time(parsedStartTime.getTime());
	    java.sql.Time fin = new java.sql.Time(parsedFinishTime.getTime());
	    
	    System.out.println("변형 시작 시간 : " + str);
	    
		String SQL = "SELECT * FROM baseball_db.stadium_booking WHERE (stadium_name = ? AND event_date = ?) AND ((start_time <= ? AND finish_time >= ?) OR (start_time <= ? AND finish_time >= ?))";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, groundName);
			pstmt.setString(2, resDate);
			pstmt.setTime(3, str);
			pstmt.setTime(4, fin);
			pstmt.setTime(5, str);
			pstmt.setTime(6, fin);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
					
					if(rs.getString("training").equals("vs") && training.equals("vs") && rs.getString("team_name2") == null) {
						String SQL1 = "UPDATE baseball_db.stadium_booking SET team_name2 = ? WHERE stadium_name = ? AND event_date = ?";
						
						try {
							pstmt = conn.prepareStatement(SQL1);
							pstmt.setString(1, team_name1);
							pstmt.setString(2, groundName);
							pstmt.setString(3, resDate);
							
							pstmt.executeUpdate();
							
							return 1;
						} catch(Exception e) {
							System.out.println(e.getMessage());
							e.printStackTrace();
							return -1;
						} finally {
							pstmt.close();
						}
					} else {
						return -2;
					}
			} else {
			
					if (training.equals("training")) {
						
						String SQL2 = "INSERT INTO baseball_db.stadium_booking(stadium_name, event_date, start_time, finish_time, team_name1, team_name2, training) VALUES(?,?,?,?,?,?,?)";
						
						try {
							pstmt = conn.prepareStatement(SQL2);
							pstmt.setString(1, groundName);
							pstmt.setString(2, resDate);
							pstmt.setTime(3, str);
							pstmt.setTime(4, fin);
							pstmt.setString(5, team_name1);
							pstmt.setString(6, team_name1);
							pstmt.setString(7, training);
							
							pstmt.executeUpdate();
							
							return 2;
							
						} catch(Exception e) {
							System.out.println(e.getMessage());
							e.printStackTrace();
							return -1;
						} finally {
							pstmt.close();
						}
						
					} else if (training.equals("vs")) {
						String SQL3 = "insert into baseball_db.stadium_booking(stadium_name, event_date, start_time, finish_time, team_name1, training) VALUES(?,?,?,?,?,?)";
						
						try {
							pstmt = conn.prepareStatement(SQL3);
							pstmt.setString(1, groundName);
							pstmt.setString(2, resDate);
							pstmt.setTime(3, str);
							pstmt.setTime(4, fin);
							pstmt.setString(5, team_name1);
							pstmt.setString(6, training);
							
							pstmt.executeUpdate();
							
							return 3;
							
						} catch(Exception e) {
							System.out.println(e.getMessage());
							e.printStackTrace();
							return -1;
						} finally {
							pstmt.close();
						}
					}
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
			return -1;
		} finally {
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		return -3;
	}
	
	public int bookingCancel(String stadium_name, String team_name, String event_date, String startTime, String finishTime) {
		
		String SQL = "select * from stadium_booking where stadium_name = ? and event_date = ? and start_time = ? and finish_time = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, stadium_name);
			pstmt.setString(2, event_date);
			pstmt.setString(3, startTime);
			pstmt.setString(4, finishTime);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("training").equals("training")) {
					String SQL1 = "delete from stadium_booking where stadium_name = ? and event_date = ? and start_time = ? and finish_time = ?";
					try {
						pstmt = conn.prepareStatement(SQL1);
						
						pstmt.setString(1, stadium_name);
						pstmt.setString(2, event_date);
						pstmt.setString(3, startTime);
						pstmt.setString(4, finishTime);
						
						pstmt.executeUpdate();
						
						return 1;
					} catch (Exception e) {
						e.printStackTrace();
						System.out.println(e.getMessage());
						return -1;
					}
				} else if(rs.getString("training").equals("vs")){
					if (rs.getString("team_name1").equals(team_name)) {
						String SQL2 = "update stadium_booking set team_name1 = null where stadium_name = ? and event_date = ? and start_time = ? and finish_time = ?";
						
						try {
							pstmt = conn.prepareStatement(SQL2);
							
							pstmt.setString(1, stadium_name);
							pstmt.setString(2, event_date);
							pstmt.setString(3, startTime);
							pstmt.setString(4, finishTime);
							
							pstmt.executeUpdate();
							
							return 1;
						} catch(Exception e) {
							e.printStackTrace();
							System.out.println(e.getMessage());
							return -1;
						}
					} else {
						String SQL3 = "update stadium_booking set team_name2 = null where stadium_name = ? and event_date = ? and start_time = ? and finish_time = ?";
						
						try {
							pstmt = conn.prepareStatement(SQL3);
							
							pstmt.setString(1, stadium_name);
							pstmt.setString(2, event_date);
							pstmt.setString(3, startTime);
							pstmt.setString(4, finishTime);
							
							pstmt.executeUpdate();
							
							return 1;
						} catch(Exception e) {
							e.printStackTrace();
							System.out.println(e.getMessage());
							return -1;
						}
					}
				}
			}
		} catch (Exception e) {
	
			e.printStackTrace();
			
		}
		return 0;
	}
		
}
