<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page session="true" %> <!-- 세션 시작 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->



<% request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page import="baseballbooking.stadiumDAO" %>

<jsp:useBean id="stadium" class="baseballbooking.stadium" scope="page" />
<%
	String path = request.getRealPath("/File");
	
	int size = 1024 * 1024 * 10; // 파일 사이즈 설정 : 10M
	String fileName = "";    // 업로드한 파일 이름
	String originalFileName = "";    //  서버에 중복된 파일 이름이 존재할 경우 처리하기 위해
	
	// cos.jar라이브러리 클래스를 가지고 실제 파일을 업로드하는 과정
	try{
	    // DefaultFileRenamePolicy 처리는 중복된 이름이 존재할 경우 처리할 때
	    // request, 파일저장경로, 용량, 인코딩타입, 중복파일명에 대한 정책
	    MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
	    
	    // 전송한 전체 파일이름들을 가져온다.
	    Enumeration files = multi.getFileNames();
	    String str = (String)files.nextElement();
	    
	    //파일명 중복이 발생했을 때 정책에 의해 뒤에 1,2,3 처럼 숫자가 붙어 고유 파일명을 생성한다.
	    // 이때 생성된 이름을 FilesystemName이라고 하여 그 이름 정보를 가져온다. (중복 처리)
	    fileName = multi.getFilesystemName(str);
	    //실제 파일 이름을 가져온다.
	    originalFileName = multi.getOriginalFileName(str);
	    
	    String groundName =  multi.getParameter("groundName");
	    String groundLocation = multi.getParameter("groundLocation");
	    
	    stadium.setGroundName(groundName);
	    stadium.setGroundLocation(groundLocation);
	    
	}catch(Exception e){
	    e.printStackTrace();
	}
	
	stadium.setImg(fileName);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(stadium.getGroundName() == null || stadium.getGroundLocation() == null) {
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('입력이 안 된 부분이 존재합니다.')");
			
			script.println("history.back()");
			
			script.println("</script>");
		} else {
			stadiumDAO dao = new stadiumDAO();
			
			int result = dao.insert(stadium.getGroundName(), stadium.getGroundLocation(), stadium.getImg());
			
			if(result == -1) {
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
				
				script.println("alert('구장 추가에 실패하였습니다.')");
				
				script.println("history.back()");
				
				script.println("</script>");
			} else {
				
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
				
				script.println("alert('구장이 추가 되었습니다.')");
				
				script.println("location.href = 'index.jsp'");
				
				script.println("</script>");
			}
		}
	%>
</body>
</html>