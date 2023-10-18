<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- 세션 시작 -->

<%@ page import="baseballbooking.stadiumDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="stadium" class="baseballbooking.stadium" scope="page" />

<% String team = session.getAttribute("team")+"";
	String groundName = request.getParameter("stadium");
	String date = request.getParameter("date");
	String start = request.getParameter("start");
	String finish = request.getParameter("finish");
	
	stadium.setGroundName(groundName);
	stadium.setTeam_name1(team);
	stadium.setResDate(date);
	stadium.setStart_time(start);
	stadium.setFinish_time(finish);

	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		System.out.println("저장된 구장명 : " + stadium.getGroundName());
		System.out.println("저장된 팀명 : " + stadium.getTeam_name1());
		System.out.println("저장된 시작시간 : " + stadium.getStart_time());
		System.out.println("저장된 종료시간 : " + stadium.getFinish_time());
		
		stadiumDAO stadiumDAO = new stadiumDAO();
		
		int result = stadiumDAO.bookingCancel(stadium.getGroundName(), stadium.getTeam_name1(), stadium.getResDate(), stadium.getStart_time(), stadium.getFinish_time());
		
		if (result == 1 ) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('예약이 취소 되었습니다.')");
			
			script.println("location.href = 'request.jsp'");
			
			script.println("</script>");
		} else if (result == -1 ) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('예약 취소가 실패하였습니다.')");
			
			script.println("history.back()");
			
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('DB오류')");
			
			script.println("history.back()");
			
			script.println("</script>");
		}
	
	%>

</body>
</html>