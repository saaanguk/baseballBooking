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

<%@ page import="baseballbooking.teamDAO" %>

<jsp:useBean id="team" class="baseballbooking.team" scope="page" />


<% String id = session.getAttribute("id")+"";
	

// 실제로 서버에 저장되는 path
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
			    
			    String team_name =  multi.getParameter("teamName");
			    String addr = multi.getParameter("addr");
			    
			    team.setTeam_name(team_name);
			    team.setAddr(addr);
			    
			}catch(Exception e){
			    e.printStackTrace();
			}
	
	team.setId(id);
	team.setImg(fileName);

%>



<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->


<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>고의사구_구단창설</title>

</head>

<body>

	<%	
    

	if (team.getTeam_name()==null || team.getAddr()==null) {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('입력이 안 된 부분이 존재합니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
	} else {
	
		
		teamDAO teamDAO = new teamDAO(); //인스턴스생성
		
		int result = teamDAO.insert(team.getId(), team.getTeam_name(), team.getAddr(), team.getImg());
		
	
	
	//로그인 성공
		
		if(result == -1){ //중복
			
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('구단 창설이 실패하였습니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		
		} else if(result == -2){
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('DB오류')");
			
			script.println("location.href = 'index.jsp'");
			
			script.println("</script>");
		} else {
			session.setAttribute("team", team.getTeam_name());
		
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('구단 창설이 되었습니다.')");
			
			script.println("location.href = 'index.jsp'");
			
			script.println("</script>");
		}
	}
	
%>

​

</body>



</html>