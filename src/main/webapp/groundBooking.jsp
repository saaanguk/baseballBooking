<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %> <!-- 세션 시작 -->

<%@page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@ page import="baseballbooking.stadiumDAO" %>

<jsp:useBean id="stadium" class="baseballbooking.stadium" scope="page" />

<jsp:setProperty name="stadium" property="resDate" />

<jsp:setProperty name="stadium" property="start_time" />

<jsp:setProperty name="stadium" property="finish_time" />

<jsp:setProperty name="stadium" property="training" />

<%  
	String groundName = request.getParameter("ground");
	String id = session.getAttribute("id")+"";
	stadium.setGroundName(groundName);
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
			String teamName = rs.getString("team");
			stadium.setTeam_name1(teamName);
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
<%
	
	if(stadium.getResDate() == null) {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('날짜를 선택해주십시오.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		return;
	} else if(stadium.getStart_time()==null) {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('시작시간을 선택해주십시오.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		return;
	} else if(stadium.getFinish_time()==null) {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('종료시간을 선택해주십시오.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		return;
	} else if(stadium.getTraining().equals("null")) {
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('예약 목적을 선택해주십시오.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		return;
	} else {
		stadiumDAO dao = new stadiumDAO();
		
		int result = dao.booking(stadium.getGroundName(), stadium.getResDate(), stadium.getStart_time(), stadium.getFinish_time(), stadium.getTeam_name1(), stadium.getTraining());
		
		if(result == 1) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('연습매칭 예약이 되었습니다.')");
			
			script.println("location.href = 'index.jsp'");
			
			script.println("</script>");
		} else if (result == 2) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('훈련 예약이 되었습니다.')");
			
			script.println("location.href='index.jsp'");
			
			script.println("</script>");
		} else if(result == 3) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('연습 매칭 예약이 되었습니다.')");
			
			script.println("location.href = 'index.jsp'");
			
			script.println("</script>");
		} else if(result == -2) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('이미 예약 되어 있어 불가합니다.')");
			
			script.println("history.back()");
			
			script.println("</script>");
		} else if(result == -1){
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('DB오류가 발생하였습니다.')");
			
			script.println("history.back()");
			
			script.println("</script>");
		} else if(result == -3) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('결과를 찾지 못했습니다.')");
			
			script.println("history.back()");
			
			script.println("</script>");
		}
	}
%>

</body>
</html>