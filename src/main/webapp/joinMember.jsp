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

<jsp:setProperty name="member" property="pwCheck" />

<jsp:setProperty name="member" property="name" />

<jsp:setProperty name="member" property="position" />

<jsp:setProperty name="member" property="birth" />

<jsp:setProperty name="member" property="ph" />

<jsp:setProperty name="member" property="addr" />

<jsp:setProperty name="member" property="email" />


<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>고의사구_로그인</title>

</head>

<body>

	<%
	
	if (member.getId()==null || member.getPw()==null || member.getName()==null || member.getPosition().equals("position") || member.getBirth()== null || member.getPh()==null || member.getAddr()==null || member.getEmail()==null) {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('입력이 안 된 부분이 존재합니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
	} else if(!member.getPw().equals(member.getPwCheck())){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		
		script.println("alert('비밀번호가 다릅니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
	}else {
	
		
		memberDAO memberDAO = new memberDAO(); //인스턴스생성
		
		int result = memberDAO.join(member.getId(), member.getPw(), member.getName(), member.getBirth(),member.getPosition(), member.getPh(), member.getAddr(), member.getEmail());
		
	
	
	//로그인 성공
		
		if(result == -1){ //중복
			
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('회원가입이 실패하였습니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		
		} else {
			
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('회원가입이 되었습니다.')");
			
			script.println("location.href = 'index.jsp'");
			
			script.println("</script>");
		}
	}
	
%>

​

</body>



</html>