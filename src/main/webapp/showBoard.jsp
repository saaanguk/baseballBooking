<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page session="true"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<% String title = request.getParameter("title"); 
	String writer = request.getParameter("writer");
	String id = session.getAttribute("id")+"";
	int idx = 0;
	int hit = 0;
	
	session.setAttribute("title", title);
	session.setAttribute("writer", writer);

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
		String dbID = "root";							
		String dbPassword = "qwer";
				
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		pstmt = conn.prepareStatement("select * from baseball_db.board where text = ? and id = ?");
		pstmt.setString(1, title);
		pstmt.setString(2, writer);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			hit = rs.getInt("hit");
			hit++;
			System.out.println("조회수 : " + hit);
		}
		
	} catch(Exception e) {
		e.printStackTrace();
		System.out.println(e.getMessage());
		
	}
	try {
		
		pstmt = conn.prepareStatement("UPDATE baseball_db.board SET hit = ? WHERE id = ? AND text = ?");
		pstmt.setInt(1, hit);
		pstmt.setString(2, writer);
		pstmt.setString(3, title);
		pstmt.executeUpdate();
		
	} catch(Exception e) {
		e.printStackTrace();
		System.out.println(e.getMessage());
		
	}
	
	
	
%>

<!doctype html>
<html lang="kor">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>고의사구</title>
		
		<link rel="preconnect" href="https://fonts.googleapis.com">
        
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;600;700&family=Open+Sans&display=swap" rel="stylesheet">
                        
        <link href="asset/css/bootstrap.min.css" rel="stylesheet">

        <link href="asset/css/bootstrap-icons.css" rel="stylesheet">

        <link href="asset/css/templatemo-topic-listing.css" rel="stylesheet">
        
        <link href="css/board.css" rel="stylesheet">
        <style type="text/css">
        	

        
        header {
            background-color: #333;
            color: #fff;
            padding: 10px;
            text-align: center;
        }

        .container1 {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .post-info {
            font-size: 14px;
            color: #888;
            margin-bottom: 20px;
        }

        .post-content {
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
            padding-bottom: 20px; /* 내용과 댓글 창 구분을 위한 추가 패딩 */
            border-bottom: 1px solid #ddd; /* 내용과 댓글 창 구분을 위한 선 추가 */
        }

        .comment-section {
        	
            border-top: 1px solid #ddd;
            padding-top: 50px;
        }

        .comment {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            padding: 10px;
            background-color: #f9f9f9;
        }

        .comment-info {
            font-size: 12px;
            color: #888;
        }

        .comment-content {
            margin-top: 5px;
        }

    </style>
 
	</head>
	<body id="top">
		<main>
			<nav class="navbar navbar-expand-lg">
				<div class="container">
					<a class="navbar-brand" href="index.jsp">
						<i class="bi bi-trophy"></i>
						<span>Base on Balls</span>
					</a>
					<div class="d-lg-none ms-auto me-4">
						<a href="#top" class="navbar-icon bi-person smoothscroll"></a>
					</div>
					<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarNav">
						<ul class="navbar-nav ms-lg-5 me-lg-auto">
							<li class="nav-item">
								<a class="nav-link click-scroll" href="index.jsp">Home</a>
							</li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarLightDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">Booking</a>
								<ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
									<li><a class="dropdown-item" href="searchTeam.jsp">구단 찾기</a></li>
									<li><a class="dropdown-item" href="search.jsp">예약 하기</a></li>
								</ul>
							</li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" id="navbarLightDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">Board</a>
								<ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
									<li><a class="dropdown-item" href="board.jsp">자유게시판</a></li>
									<%if(id.equals("admin")){%>
									<li><a class="dropdown-item" href="allBoard.jsp">팀별게시판</a></li>	
									<%} else {%>
									<li><a class="dropdown-item" href="teamBoard.jsp">팀별게시판</a></li>
									<%} %>
								</ul>
							</li>
							<li class="nav-item">
								<a class="nav-link click-scroll" href="#section_4">FAQs</a>
							</li>
							<li class="nav-item">
								<a class="nav-link click-scroll" href="#section_5">Contact</a>
							</li>
						</ul>
						<div class="nav-item dropdown">
							<div class="d-none d-lg-block">
								<a href="#top" class="navbar-icon bi-person smoothscroll"></a>
								<% String loginCheck = session.getAttribute("loginCheck")+"";
								   String team = session.getAttribute("team")+"";
								  
								   String position2 = session.getAttribute("position2")+"";
								   
								   if(loginCheck.equals("false") || loginCheck.equals("null")){ %>
									 <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
									 	<li><a class="dropdown-item" href="login.jsp">로그인</a></li>
									 	<li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
									 </ul>  
								  <%}else {
									  if(id.equals("admin")){%>
									  	<ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
									  		<li><a class="dropdown-item" href="allMember.jsp">전체 회원 조회</a></li>
									  		<li><a class="dropdown-item" href="insert_ground.jsp">구장 추가</a></li>
									  		<li><a class="dropdown-item" href="logout.jsp">로그아웃</a></li>
									  	</ul>  
									  <%}else{
										  if(team.equals("null")){%>
										  	 <p><%=id%>님 환영합니다.</p>
											 <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
											 	<li><a class="dropdown-item" href="myInfo.jsp">내 정보 확인</a></li>
											 	<li><a class="dropdown-item" href="insert_team.jsp">팀 창단하기</a></li>
											 	<li><a class="dropdown-item" href="logout.jsp">로그아웃</a></li>
											 </ul> 
										  <%}else{
											  if(position2.equals("감독")){%>
												 <p><%=id%>님 환영합니다.</p>
												 <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
												 	<li><a class="dropdown-item" href="myInfo.jsp">내 정보 확인</a></li>
												 	<li><a class="dropdown-item" href="requestCorm.jsp">신청 현황</a></li>
												 	<li><a class="dropdown-item" href="request.jsp">예약 현황</a></li>
												 	<li><a class="dropdown-item" href="myTeam.jsp">나의 팀</a></li>
												 	<li><a class="dropdown-item" href="logout.jsp">로그아웃</a></li>
												 </ul> 
											  <%}else{%>
												 <p><%=id%>님 환영합니다.</p>
												 <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="navbarLightDropdownMenuLink">
												 	<li><a class="dropdown-item" href="myInfo.jsp">내 정보 확인</a></li>
												 	<li><a class="dropdown-item" href="request.jsp">예약 현황</a></li>
												 	<li><a class="dropdown-item" href="myTeam.jsp">나의 팀</a></li>
												 	<li><a class="dropdown-item" href="logout.jsp">로그아웃</a></li>
												 </ul>
											  <%}
										  }
									  }
								  }%>
								
							</div>
						</div>
					</div>
				</div>
			</nav>
			<section class="hero-section d-flex justify-content-center align-items-center" id="section_1">
				<div class="container">
					<div class="row">
						<div class="col-lg-8 col-12 mx-auto">
							<h1 class="text-white text-center">Base on Balls</h1>
							<h6 class="text-center">고품격의 사회인 야구 매칭 시스템</h6>
						</div>
					</div>
				</div>
			</section>
			
			<section class="explore-section section-padding" id="section_2">
				
				
				<div class="container">
					<div class="row">
						<div class="col-12">
							<div class="tab-content" id="myTabContent">
								<div class="tab-pane fade show active" id="design-tab-pane" role="tabpanel" aria-labelledby="design-tab" tabindex="0">
									
									<div class="row">
										<div class="container1">
										<header>
									        <h1><%=title %></h1>
									    </header>
									    <div class="container1">
									        <!-- 게시글 내용 -->
									        <%
									        try{
									    		String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
									    		String dbID = "root";							
									    		String dbPassword = "qwer";
									    				
									    		Class.forName("com.mysql.cj.jdbc.Driver");
									    		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
									    		pstmt = conn.prepareStatement("select * from baseball_db.board where text = ? and id = ?");
									    		pstmt.setString(1, title);
									    		pstmt.setString(2, writer);
									    		rs = pstmt.executeQuery();
									    		
									    		if(rs.next()){
									    			idx = rs.getInt("idx");
									    			
									    			System.out.println("세션값 : " + id);
									    			System.out.println("디비값 : " + rs.getString("id"));
									    			Date nowDate = rs.getDate("reg_date");
									    			
									    			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일"); 
									    	        	//원하는 데이터 포맷 지정
									    			String strNowDate = simpleDateFormat.format(nowDate);
									    			
									    			if(id.equals(rs.getString("id"))) {%>
									    			
									    			<form method="post" action="updateBoard.jsp?title=<%=title%>">
										        			<div class="post-info">
													            작성자: <%=rs.getString("id") %> | 작성일: <%=strNowDate %>
													        </div>
													        <div class="post-content">
													           <textarea class="form-control" rows="5" name="content" id="content" ><%=rs.getString("content") %></textarea>
													           <button type="button" onclick="location.href='board.jsp'">목록</button>
															         <button type="submit">수정</button>
															         <button type="button" onclick="location.href='deleteBoard.jsp?title=<%=title%>&id=<%=id%>'">삭제</button>
													        </div>
										        	</form>
										        	
										        <%}else if (id.equals("admin")){%>
										        	<form method="post" action="updateBoard.jsp?title=<%=title%>">
										        			<div class="post-info">
													            작성자: <%=rs.getString("id") %> | 작성일: <%=strNowDate %>
													        </div>
													        <div class="post-content">
													           <%=rs.getString("content") %>
													           <button type="button" onclick="location.href='board.jsp'">목록</button>
															   <button type="button" onclick="location.href='deleteBoard.jsp?title=<%=title%>&id=<%=id%>'">삭제</button>
													        </div>
										        	</form>
										        <%}else {%>
										        	<div class="post-info">
													            작성자: <%=rs.getString("id") %> | 작성일: <%=strNowDate %>
													</div>
												   		 <div class="post-content">
													    <%=rs.getString("content") %>
													            
													    <div>
													         <button type="button" onclick="location.href='board.jsp'">목록</button>
															 
													    </div>
													</div>
										        <%}
									    		}
									    	}catch(SQLException se){
									    		se.printStackTrace();
									    		System.out.println(se.getMessage());
									    	}finally{
									    		if(rs != null) rs.close();
									    		if(pstmt != null) pstmt.close();
									    		if(conn != null) conn.close();
									    	}%>
									    	
									        <div class="comment-section">
													<h2>댓글</h2>
													
								                    <div>
								                    	<form id="commentForm" method="post" action="addReple.jsp">
								                        <textarea class="form-control" rows="2" name="text" id="text"></textarea>
								                        <button type="submit" style="float:right;">댓글 작성</button>
								                        </form>
								                    </div>
								                	<br></br>
								                	<% try{
											    		String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
											    		String dbID = "root";							
											    		String dbPassword = "qwer";
											    				
											    		Class.forName("com.mysql.cj.jdbc.Driver");
											    		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
											    		pstmt = conn.prepareStatement("select * from baseball_db.board_comment where board_idx = ? and id = ? order by reg_date desc");
											    		pstmt.setInt(1, idx);
											    		pstmt.setString(2, writer);
											    		rs = pstmt.executeQuery();
											    		
											    		while(rs.next()){
											    			int commentIdx = rs.getInt("idx");
											    			
											    			Date nowDate = rs.getDate("reg_date");
											    			
											    			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일"); 
											    	        	//원하는 데이터 포맷 지정
											    			String strNowDate = simpleDateFormat.format(nowDate);
											    			
											    			if(id.equals(rs.getString("commentID"))) {%>
								                	
															
															<div class="comment">
															    <div class="comment-info">
															        작성자: <%= rs.getString("commentID") %> | 작성일: <%= strNowDate %>
															    </div>
															    <form method="post" action="updateReple.jsp?idx=<%=idx %>&commentIdx=<%=commentIdx %>">
															    <div class="comment-content">
															        <textarea class="form-control" rows="2" name="text" id="text" ><%=rs.getString("text") %></textarea>
															        <div style="float:right">
															            <button type="submit">수정</button>
															         	<button type="button" onclick="location.href='deleteReple.jsp?idx=<%=idx%>&commentIdx=<%=commentIdx%>'">삭제</button>
															        </div>
															    </div>
															    </form>
															</div>
															
															
															
															 <%}else {%>
													        	<div class="comment">
															<div class="comment-info">
															    작성자: <%= rs.getString("commentID") %> | 작성일: <%= strNowDate %>
															</div>
															<div class="comment-content">
															    <%=rs.getString("text") %>
															    
															</div>
															</div>
													        <%}
												    		}
												    	}catch(SQLException se){
												    		se.printStackTrace();
												    		System.out.println(se.getMessage());
												    	}finally{
												    		if(rs != null) rs.close();
												    		if(pstmt != null) pstmt.close();
												    		if(conn != null) conn.close();
												    	}%>
										           
											 </div>
									      </div>
									    
										
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
				</div>
			</section>
		</main>
		<footer class="site-footer section-padding">
			<div class="container">
				<div class="row">
					<div class="col-lg-3 col-12 mb-4 pb-2">
						<a class="navbar-brand mb-2" href="index.jsp">
							<i class="bi bi-trophy"></i>
							<span>Base on Balls</span>
						</a>
					</div>
					<div class="col-lg-3 col-md-4 col-6">
						<h6 class="site-footer-title mb-3">Resources</h6>
						<ul>
							<li class="site-footer-link-item">
								<a href="index.jsp" class="site-footer-link">Home</a>
							</li>
							<li class="site-footer-link-item">
                                <a href="#" class="site-footer-link">How it works</a>
                            </li>

                            <li class="site-footer-link-item">
                                <a href="#" class="site-footer-link">FAQs</a>
                            </li>

                            <li class="site-footer-link-item">
                                <a href="#" class="site-footer-link">Contact</a>
                            </li>
						</ul>
					</div>
					<div class="col-lg-3 col-md-4 col-6 mb-4 mb-lg-0">
                        <h6 class="site-footer-title mb-3">Information</h6>

                        <p class="text-white d-flex mb-1">
                            <a href="tel: 305-240-9671" class="site-footer-link">
                                305-240-9671
                            </a>
                        </p>

                        <p class="text-white d-flex">
                            <a href="mailto:info@company.com" class="site-footer-link">
                                info@company.com
                            </a>
                        </p>
                    </div>
                    <p class="copyright-text mt-lg-5 mt-4">Copyright Â© 2048 Topic Listing Center. All rights reserved.
                        <br><br>Design: <a rel="nofollow" href="https://templatemo.com" target="_blank">TemplateMo</a> Distribution <a href="https://themewagon.com">ThemeWagon</a></p>
				</div>
			</div>
		</footer>
		<!-- JAVASCRIPT FILES -->
        <script src="asset/js/jquery.min.js"></script>
        <script src="asset/js/bootstrap.bundle.min.js"></script>
        <script src="asset/js/jquery.sticky.js"></script>
        <script src="asset/js/click-scroll.js"></script>
        <script src="asset/js/custom.js"></script>
        
        
	</body>
	
</html>