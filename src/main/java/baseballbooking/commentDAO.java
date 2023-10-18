package baseballbooking;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class commentDAO {
	private Connection conn; // connection:db에접근하게 해주는 객체

	private PreparedStatement pstmt;

	private ResultSet rs;

	// mysql에 접속해 주는 부분
	public commentDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		
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
	public int boardComment(int board_idx, String id, String commentID, String text) {
		
		String SQL = "insert into board_comment(board_idx, id, commentID, text, reg_date) values(?,?,?,?,now())";
		
		try {
			
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, board_idx);
			pstmt.setString(2, id);
			pstmt.setString(3, commentID);
			pstmt.setString(4, text);
			
			pstmt.executeUpdate();
			
			return 1;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;	
		} 
	}
	
	public int update(int board_idx, String text, String commentID, int commentIdx) {
		
		String SQL = "update board_comment set text = ? where board_idx = ? and (commentID = ? and idx =?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, text);
			pstmt.setInt(2, board_idx);
			pstmt.setString(3, commentID);
			pstmt.setInt(4, commentIdx);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}
	
	public int delete(int idx, String commentID, int commentIdx) {
		
		String SQL = "delete from board_comment where board_idx = ? and (commentID = ? and idx = ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, idx);
			pstmt.setString(2, commentID);
			pstmt.setInt(3, commentIdx);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}
	
	public int teamBoardComment(int board_idx, String id, String commentID, String text, String teamName) {
		
		String SQL = "insert into team_board_comment(team_name, team_board_idx, id, commentID, text, reg_date) values(?,?,?,?,?,now())";
		
		try {
			
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, teamName);
			pstmt.setInt(2, board_idx);
			pstmt.setString(3, id);
			pstmt.setString(4, commentID);
			pstmt.setString(5, text);
			
			pstmt.executeUpdate();
			
			return 1;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;	
		} 
	}
	
	public int teamUpdate(int board_idx, String text, String commentID, int commentIdx) {
		
		String SQL = "update team_board_comment set text = ? where team_board_idx = ? and (commentID = ? and idx =?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, text);
			pstmt.setInt(2, board_idx);
			pstmt.setString(3, commentID);
			pstmt.setInt(4, commentIdx);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}
	
	public int teamDelete(int idx, String commentID, int commentIdx) {
		
		String SQL = "delete from team_board_comment where team_board_idx = ? and (commentID = ? and idx = ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, idx);
			pstmt.setString(2, commentID);
			pstmt.setInt(3, commentIdx);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}
}
