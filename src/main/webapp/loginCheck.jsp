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


<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="member" class="baseballbooking.member" scope="page" />

<jsp:setProperty name="member" property="id" />

<jsp:setProperty name="member" property="pw" />


<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>고의사구_로그인</title>

</head>

<body>

	<%
	session.setAttribute("loginCheck", false);
	memberDAO memberDAO = new memberDAO(); //인스턴스생성
	
	int result = memberDAO.login(member.getId(), member.getPw());


//로그인 성공
	
	if(result == 1){ //로그인 성공
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
			String dbID = "root";							
			String dbPassword = "qwer";
					
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			pstmt = conn.prepareStatement("select * from baseball_db.member where id = ?");
			pstmt.setString(1, member.getId());
			rs = pstmt.executeQuery();
			if(rs.next()){
				
				session.setAttribute("team",rs.getString("team"));
				session.setAttribute("position2", rs.getString("position2"));
			}
		}catch(SQLException se){
			se.printStackTrace();
		}finally{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		session.setAttribute("id", member.getId());
		session.setAttribute("loginCheck", true);
		
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('로그인이 되었습니다.')");
		
		script.println("location.href='index.jsp'");
		
		script.println("</script>");
	
	} else if(result == 0){ //로그인 실패
	
		PrintWriter script = response.getWriter();
	
		session.setAttribute("loginCheck", false);
		
		script.println("<script>");
		
		script.println("alert('비밀번호가 틀렸습니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		
	} else if(result == -1){ //아이디 없음
	
		PrintWriter script = response.getWriter();
	
		session.setAttribute("loginCheck", false);
		
		script.println("<script>");
		
		script.println("alert('존재하지 않는 아이디 입니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
	
	
	
	}
	
	
	
	//DB오류
	
	
	
	else if(result == -2){
	
	PrintWriter script = response.getWriter();
	
	script.println("<script>");
	
	script.println("alert('DB오류가 발생했습니다.')");
	
	script.println("history.back()");
	
	script.println("</script>");
	
	} 
	
%>

​

</body>



</html>