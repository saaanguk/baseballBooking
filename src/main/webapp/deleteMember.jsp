<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- 세션 시작 -->

<%@ page import="baseballbooking.memberDAO" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="baseballbooking.teamDAO" %>
<%@ page import="baseballbooking.boardDAO" %>

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="member" class="baseballbooking.member" scope="page" />

<jsp:useBean id="team" class="baseballbooking.team" scope="page" />


<%
	String id = session.getAttribute("id")+"";
	member.setId(id);
	team.setId(id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	memberDAO memberDAO = new memberDAO();
	teamDAO teamDAO = new teamDAO();
	
	int result = memberDAO.delete(member.getId());
	int result1 = teamDAO.delete(team.getId());
	
	if(result == -1 || result1 == -1) {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('DB오류가 발생하였습니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("location.href='viewMyInfo.jsp'");
		
		script.println("</script>");
	}
	
%>

</body>
</html>