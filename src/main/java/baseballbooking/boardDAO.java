package baseballbooking;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class boardDAO {
	private Connection conn; // connection:db에접근하게 해주는 객체

	private PreparedStatement pstmt;

	private ResultSet rs;

	// mysql에 접속해 주는 부분
	public boardDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		
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
	
	public int boardSave(String id, String text, String content) {
		
		String SQL = "insert into board(id, text, content, reg_date, hit, available) values(?,?,?,now(),0,1)";
		
		try {
			
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, id);
			pstmt.setString(2, text);
			pstmt.setString(3, content);
			
			pstmt.executeUpdate();
			
			return 1;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;	
		} 
	}
	
	public int teamBoardSave(String team_name, String id, String text, String content) {
		String SQL = "insert into team_board(team_name, id, text, content, reg_date, hit, available) values(?,?,?,?,now(),0,1)";
		
		try {
			
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, team_name);
			pstmt.setString(2, id);
			pstmt.setString(3, text);
			pstmt.setString(4, content);
			
			pstmt.executeUpdate();
			
			return 1;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;	
		} 
	}
	
	public int update(String id, String text, String content) {
		String SQL = "UPDATE baseball_db.board SET content = ? WHERE id = ? AND text = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, content);
			pstmt.setString(2, id);
			pstmt.setString(3, text);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}
	
	public int deleteBoard(String id, String text) {
		String SQL = "UPDATE baseball_db.board SET available = 0 WHERE id = ? AND text = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			
			pstmt.setString(1, id);
			pstmt.setString(2, text);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}
	
	public int updateTeam(String id, String text, String content) {
		String SQL = "UPDATE baseball_db.team_board SET content = ? WHERE id = ? AND text = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, content);
			pstmt.setString(2, id);
			pstmt.setString(3, text);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}
	
	public int deleteTeamBoard(String id, String text) {
		String SQL = "UPDATE baseball_db.team_board SET available = 0 WHERE id = ? AND text = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			
			pstmt.setString(1, id);
			pstmt.setString(2, text);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}

}
