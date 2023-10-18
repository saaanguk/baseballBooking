<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    <%@ page session="true" %>
    <% session.invalidate();
    PrintWriter script = response.getWriter();
    script.println("<script>");
	
	script.println("alert('로그아웃이 되었습니다.')");
	
	script.println("location.href='index.jsp'");
	
	script.println("</script>");
  //  	response.sendRedirect("index.jsp");
    %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고의사구_로그아웃</title>
</head>
<body>

</body>
</html>