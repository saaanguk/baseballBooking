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
	session.setAttribute("idCheck", false);
	memberDAO memberDAO = new memberDAO(); //인스턴스생성
	
	int result = memberDAO.idCheck(member.getId());


//로그인 성공
	
	if(result == 1){ //중복
		
		session.setAttribute("idCheck", false);
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('중복된 아이디가 존재합니다.')");
		
		script.println("location.href='join.jsp'");
		
		script.println("</script>");
	
	} else if(result == 0){ //중복없음
		
		session.setAttribute("idCheck", true);
	
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('중복된 아이디가 없어 회원가입이 가능합니다.')");
		
		script.println("location.href='join.jsp'");
		
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