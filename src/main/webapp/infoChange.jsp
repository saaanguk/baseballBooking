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

<%@ page import="baseballbooking.memberDAO" %>

<jsp:useBean id="member" class="baseballbooking.member" scope="page" />


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
			    
			    String changePw =  multi.getParameter("changePw");
			    String ph = multi.getParameter("ph");
			    String addr = multi.getParameter("addr");
			    String email = multi.getParameter("email");
			    
			    member.setPw(changePw);
			    member.setPh(ph);
			    member.setAddr(addr);
			    member.setEmail(email);
			    
			}catch(Exception e){
			    e.printStackTrace();
			}
	
	member.setId(id);
	member.setImg(fileName);

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
	if(member.getPw() == null || member.getPw() == "" || member.getImg() == null || member.getImg() == "") {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			String dbURL="jdbc:mysql://localhost:3306/baseball_db";
			String dbID = "root";
			String dbPW = "qwer";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPW);
			pstmt = conn.prepareStatement("select * from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				member.setPw(rs.getString("pw"));
				member.setImg(rs.getString("img"));
			}
		}catch(SQLException se){
			se.printStackTrace();
		}finally{
			if(rs != null){rs.close();}
			if(pstmt != null){pstmt.close();}
			if(conn != null){conn.close();}
		}
	}
	
	
	String pw = member.getPw();
	System.out.println("변경된 비밀번호 : " + pw);

	if (member.getPh()==null || member.getAddr()==null || member.getAddr() == null || member.getEmail()==null) {
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('입력이 안 된 부분이 존재합니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
	} else {
	
		
		memberDAO memberDAO = new memberDAO(); //인스턴스생성
		
		int result = memberDAO.update(member.getId(), member.getPw(), member.getAddr(), member.getPh(), member.getEmail(), member.getImg());
		
	
	
	//로그인 성공
		
		if(result == -1){ //중복
			
		
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('정보 변경에 실패하였습니다.')");
		
		script.println("history.back()");
		
		script.println("</script>");
		
		} else {
			
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('정보 변경이 되었습니다.')");
			
			script.println("location.href = 'index.jsp'");
			
			script.println("</script>");
		}
	}
	
%>

​

</body>



</html>