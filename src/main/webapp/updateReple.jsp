<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %> <!-- 세션 시작 -->

<%@ page import="baseballbooking.commentDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<% request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="comment" class="baseballbooking.comment" scope="page" />
<jsp:setProperty name="comment" property="text" />
<%
	String id = session.getAttribute("id")+"";
	String boardIdx = request.getParameter("idx");
	int idx = Integer.parseInt(boardIdx);
	System.out.println("가져온 인덱스 값 : "+ idx);
	
	String commentIdx =request.getParameter("commentIdx");
	System.out.println("댓글 인덱스 값 : " + commentIdx);
	int idx2 = Integer.parseInt(commentIdx);
	
	System.out.println(comment.getText());
	comment.setCommentID(id);
	comment.setIdx(idx);
	comment.setCommentIdx(idx2);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	commentDAO commentDAO = new commentDAO();
	
	int result = commentDAO.update(comment.getIdx(), comment.getText(), comment.getCommentID(), comment.getCommentIdx());
	
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