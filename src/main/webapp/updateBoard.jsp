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
<jsp:useBean id="board" class="baseballbooking.board" scope="page" />
<jsp:setProperty name="board" property="content" />
<%
	String id = session.getAttribute("id")+"";
	String title = request.getParameter("title");
	
	board.setId(id);
	board.setText(title);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	boardDAO boardDAO = new boardDAO();
	
	int result = boardDAO.update(board.getId(), board.getText(), board.getContent());
	
	if(result == -1) {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('DB오류가 발생하였습니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
	} else {
	PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('수정 되었습니다.')");
		
		script.println("location.href='board.jsp'");
		
		script.println("</script>");
	}
	
%>

</body>
</html>