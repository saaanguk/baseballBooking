package baseballbooking;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class memberDAO {
	private Connection conn; // connection:db에접근하게 해주는 객체

	private PreparedStatement pstmt;

	private ResultSet rs;

	// mysql에 접속해 주는 부분

	public memberDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		
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
	
	public int login(String id, String pw) {
		
		
		
		
		String SQL = "SELECT * FROM member WHERE id = ? and pw = ?";

		try {

			// pstmt : prepared statement 정해진 sql문장을 db에 삽입하는 형식으로 인스턴스가져옴
	
			pstmt = conn.prepareStatement(SQL);
	
			// sql인젝션 같은 해킹기법을 방어하는것... pstmt을 이용해 하나의 문장을 미리 준비해서(물음표사용)
	
			// 물음표해당하는 내용을 유저아이디로, 매개변수로 이용.. 1)존재하는지 2)비밀번호무엇인지
	
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
	
			// rs:result set 에 결과보관
	
			rs = pstmt.executeQuery();
	
			// 결과가 존재한다면 실행
	
			if (rs.next()) {
	
				// 패스워드 일치한다면 실행
	
				if (rs.getString("id").equals(id) && rs.getString("pw").equals(pw)) {
					
					
					
					return 1; // 라긴 성공
		
				} else
		
				return 0; // 비밀번호 불일치
	
			}
	
			return -1; // 아이디가 없음 오류
	
		} catch (Exception e) {
	
			e.printStackTrace();
	
		}
	
			return -2; // 데이터베이스 오류를 의미

	}
	
	public int idCheck(String id) {
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
	
				// 패스워드 일치한다면 실행
	
				
					
					
					return 1; // 라긴 성공
		
			}	 else {
					return 0; // 아이디가 없음 오류
			
			}
			
	
		} catch (Exception e) {
	
			e.printStackTrace();
	
		}
	
			return -2; // 데이터베이스 오류를 의미

	}
	
	public int join(String id, String pw, String name, String birth, String position, String ph, String addr, String email) {
		
		String SQL = "insert into member(id, pw, name, birth, position, ph, addr, email) values(?,?,?,?,?,?,?,?)";
		
		try {
			
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, birth);
			pstmt.setString(5, position);
			pstmt.setString(6, ph);
			pstmt.setString(7, addr);
			pstmt.setString(8, email);
			
			return pstmt.executeUpdate();
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	public int requestTeam(String teamName, String name, String ph, String position, String birth) {
		
		String SQL = "insert into team_agree(team_name, name, hp, position, birth) values(?,?,?,?,?)";
		
		try {
			
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, teamName);
			pstmt.setString(2, name);
			pstmt.setString(3, ph);
			pstmt.setString(4, position);
			pstmt.setString(5, birth);
			
			return pstmt.executeUpdate();
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return -1;
		
	}
	
	public int joinTeam(String name, String ph, String team) {
		String position = "";
		String addr;
		String SQL1 = "select * from member where name = ? and ph =?";
		
		try {
			pstmt = conn.prepareStatement(SQL1);
			
			pstmt.setString(1, name);
			pstmt.setString(2, ph);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				position = rs.getString("position");
			}
		} catch (Exception e) {
	
			e.printStackTrace();
	
		}
		
		String SQL2 = "select * from team where team_name = ?";
		try {
			pstmt = conn.prepareStatement(SQL2);
			
			pstmt.setString(1, team);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				addr = rs.getString("addr");
				String img = rs.getString("img");
				String coach = rs.getString("coach_name");
				
				String SQL = "insert into team(team_name, coach_name, my_name, position1, img, addr) values(?,?,?,?,?,?)";
				
				try {
					
					pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, team);
					pstmt.setString(2, coach);
					pstmt.setString(3, name);
					pstmt.setString(4, position);
					pstmt.setString(5, img);
					pstmt.setString(6, addr);
					
					pstmt.executeUpdate();
					
					
					
				} catch (Exception e) {
					e.printStackTrace();
					return -1;
				} 
				
			}
		} catch (Exception e) {
	
			e.printStackTrace();
	
		}
		
		
		
		String SQL = "update member set team = ? where name =? and ph = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, team);
			pstmt.setString(2, name);
			pstmt.setString(3, ph);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} 
		return -1;
		
		
		
	}
	
	public int deleteTeamAgree(String name, String team) {
		String SQL = "delete from team_agree where name=? and team_name=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, name);
			pstmt.setString(2, team);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			return -1;
		}
	}
	
	public int teamOut(String id, String team) {
		String SQL = "update member set team = null where id = ? and team = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, id);
			pstmt.setString(2, team);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println(e.getMessage());
			return -1;
		}
	}
	
	public int pwCheck(String id, String pw) {
		String SQL = "select * from member where id = ? and pw =?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return 1;
			}
		} catch (Exception e) {
	
			e.printStackTrace();
			
		}
		return -1;
	}
	
	public int update(String id, String pw, String addr, String ph, String email, String img) {
		
		if(pw == null || pw == "") {
			
			if(img == null || img == "") {
				String SQL = "update member set ph = ?, addr = ?, email = ? where id = ?";
				
				try {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, ph);
					pstmt.setString(2, addr);
					pstmt.setString(3, email);
					pstmt.setString(4, id);
					
					return pstmt.executeUpdate();
				} catch(Exception e) {
					System.out.println(e.getMessage());
					return -1;
				}
			} else {
				String SQL = "update member set ph = ?, addr = ?, email = ?, img = ? where id = ?";
				
				try {
					pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, ph);
					pstmt.setString(2, addr);
					pstmt.setString(3, email);
					pstmt.setString(4, img);
					pstmt.setString(5, id);
					
					return pstmt.executeUpdate();
				} catch(Exception e) {
					System.out.println(e.getMessage());
					return -1;
				}
			}
			
		} else {
			String SQL = "update member set pw = ?, ph = ?, addr = ?, email = ?, img = ? where id = ?";
			
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, pw);
				pstmt.setString(2, ph);
				pstmt.setString(3, addr);
				pstmt.setString(4, email);
				pstmt.setString(5, img);
				pstmt.setString(6, id);
				
				return pstmt.executeUpdate();
			} catch(Exception e) {
				System.out.println(e.getMessage());
				return -1;
			}
		}
	}
	
	public int delete(String id) {
		String SQL = "delete from member where id = ?";
		
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
