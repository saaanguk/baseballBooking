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
<jsp:setProperty name="member" property="pw" />
<%
	String id = session.getAttribute("id")+"";
	member.setId(id);

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
	
	int result = memberDAO.pwCheck(member.getId(), member.getPw());
	
	if(result == -1) {
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