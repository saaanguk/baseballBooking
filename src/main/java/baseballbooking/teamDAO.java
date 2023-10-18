package baseballbooking;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.stream.Stream;


public class teamDAO {
	private Connection conn; // connection:db에접근하게 해주는 객체

	private PreparedStatement pstmt;

	private ResultSet rs;

	// mysql에 접속해 주는 부분

	public teamDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		
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
	

	public int insert(String id, String team_name, String addr, String img) throws Exception {
		
		String SQL = "SELECT * FROM member WHERE id = ?";

		try {

			// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
	
			pstmt = conn.prepareStatement(SQL);
	
			// sql인젝션 같은 해킹기법을 방어하는것... pstmt을 이용해 하나의 문장을 미리 준비해서(물음표사용)
	
			// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
	
			pstmt.setString(1, id);
	
			// rs:result set 에 결과보관
	
			rs = pstmt.executeQuery();
	
			// 결과가 존재한다면 실행
	
			if (rs.next()) {
				
				String name = rs.getString("name");
				String position = rs.getString("position");
				String position2 = "감독";
				
				String SQL2 = "update member set position2 = ?, team = ? where id =?";
				
				try {
					pstmt = conn.prepareStatement(SQL2);
					
					pstmt.setString(1, position2);
					pstmt.setString(2, team_name);
					pstmt.setString(3, id);
					
					pstmt.executeUpdate();
					
					
				} catch(Exception e) {
					e.printStackTrace();
					
				}
				
				String SQL1 = "insert into team(team_name, coach_name, my_name, position1, position2, img, addr) values(?,?,?,?,?,?,?)";
				
				try {
					
					pstmt = conn.prepareStatement(SQL1);
					
					pstmt.setString(1, team_name);
					pstmt.setString(2, name);
					pstmt.setString(3, name);
					pstmt.setString(4, position);
					pstmt.setString(5, position2);
					pstmt.setString(6, img);
					pstmt.setString(7, addr);
					
					return pstmt.executeUpdate();
					
					
					
				} catch (Exception e) {
					e.printStackTrace();
				
					
				}
				
				return -1;
	
			} 
		}catch (Exception e) {
	
			e.printStackTrace();
			
		
	
		} finally {
			rs.close();
			pstmt.close();
			conn.close();
		}
		return -2;
			
	}
	
	public int teamOut(String id, String team) {
		
		String SQL = "delete from team where my_name=? and team_name=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, id);
			pstmt.setString(2, team);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			return -1;
		}
	}
		
	public int delete(String id) {
		
		String SQL = "delete from team where id = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return -1;
		}
	}
}
