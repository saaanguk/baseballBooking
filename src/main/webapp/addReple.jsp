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
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="comment" class="baseballbooking.comment" scope="page" />

<jsp:setProperty name="comment" property="text" />


<% String commentId = session.getAttribute("id")+"";
	String id = session.getAttribute("writer")+"";
	String text = session.getAttribute("title")+"";
	
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
		String SQL = "SELECT * FROM board where id = ? and text = ?";
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, id);
		pstmt.setString(2, text);
		rs = pstmt.executeQuery();
		// 가져온 팀 정보를 반복하여 표시
		if (rs.next()) {
			int idx = rs.getInt("idx");
			comment.setIdx(idx);
			
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
	
	comment.setId(id);
	comment.setCommentID(commentId);

	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		System.out.println("저장된 글 번호 : " + comment.getIdx());
		System.out.println("저장된 작성자 : " + comment.getId());
		System.out.println("저장된 댓글자 : " + comment.getCommentID());
		System.out.println("저장된 댓글 : " + comment.getText());
		
		commentDAO dao = new commentDAO();
	
		int result = dao.boardComment(comment.getIdx(), comment.getId(), comment.getCommentID(), comment.getText());
		
		if(result == -1) {
			
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('댓글을 등록하지 못하였습니다.')");
			
			script.println("history.back()");
			
			script.println("</script>");
		} else {
			
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('댓글을 등록하였습니다.')");
			
			script.println("location.href='board.jsp'");
			
			script.println("</script>");
		}
	
	%>

</body>
</html>