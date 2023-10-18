<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- 세션 시작 -->

<%@ page import="baseballbooking.boardDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="board" class="baseballbooking.board" scope="page" />

<jsp:setProperty name="board" property="text" />

<jsp:setProperty name="board" property="content" />

<% String id = session.getAttribute("id")+"";
	board.setId(id);
	
	String team_name = session.getAttribute("team")+"";
	board.setTeam_name(team_name);
	
	
	
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		System.out.println("작성자 : " + board.getId());
		System.out.println("제목 : " + board.getText());
		System.out.println("내용 : " + board.getContent());
		System.out.println("작성일 : " + board.getNowDate());
		
		boardDAO dao = new boardDAO();
	
		int result = dao.teamBoardSave(board.getTeam_name(), board.getId(), board.getText(), board.getContent());
		
		if(result == -1) {
			
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('게시글을 등록하지 못하였습니다.')");
			
			script.println("history.back()");
			
			script.println("</script>");
		} else {
			
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('게시글을 등록하였습니다.')");
			
			script.println("location.href='teamBoard.jsp'");
			
			script.println("</script>");
		}
	
	%>

</body>
</html>