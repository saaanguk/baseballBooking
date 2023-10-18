<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- 세션 시작 -->

<%@ page import="baseballbooking.memberDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="member" class="baseballbooking.member" scope="page" />
<%
	String teamName = request.getParameter("team");
	String id = session.getAttribute("id")+"";
	member.setTeam(teamName);
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
		String dbID = "root";
		String dbPassword = "qwer";
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		  // 데이터베이스에서 팀 정보를 가져오는 SQL 쿼리 작성
		String SQL = "SELECT * FROM member where id = ?";
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, id);
		
		
		rs = pstmt.executeQuery();
		// 가져온 팀 정보를 반복하여 표시
		if (rs.next()) {
			String team = rs.getString("team");
			
			if(team != null) {
				
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
				
				script.println("alert('이미 가입한 구단이 있습니다.')");
				
				script.println("history.back()");
				
				script.println("</script>");
				
			} else {
				
				System.out.println("가입되어 있는 팀 : " + rs.getString("team"));
				
				String name = rs.getString("name");
				String hp = rs.getString("ph");
				String position = rs.getString("position");
				String birth = rs.getString("birth");
				
				member.setName(name);
				member.setPh(hp);
				member.setPosition(position);
				member.setBirth(birth);
				
				memberDAO memberDAO = new memberDAO();
	
				int result = memberDAO.requestTeam(member.getTeam(), member.getName(), member.getPh(), member.getPosition(), member.getBirth());
				
				if(result == -1){ //중복
						
					
					PrintWriter script = response.getWriter();
					
					script.println("<script>");
					
					script.println("alert('구단 가입 신청이 실패하였습니다.')");
					
					script.println("history.back()");
					
					script.println("</script>");
					
				} else {
						
						PrintWriter script = response.getWriter();
						
						script.println("<script>");
						
						script.println("alert('가입 신청이 되었습니다.')");
						
						script.println("location.href = 'index.jsp'");
						
						script.println("</script>");
				}
				
			}
				
			
			
		} else {
			
		}
	}catch (Exception e) {
	        e.printStackTrace();
	} finally {
	        // DB 연결 및 리소스 해제
	    try {
	       if (rs != null) rs.close();
	       if (pstmt != null) pstmt.close();
	       if (conn != null) conn.close();
	    } catch (SQLException e) {
	       e.printStackTrace();
	    }
}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


</body>
</html>