<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page session="true" %>
    
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%  String id = session.getAttribute("id")+""; %>
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
                            <h1 class="text-white text-center">구장 예약</h1>
                            <h6 class="text-center">우리 팀의 연습 구장을 찾으세요.</h6>

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
									
								<form method="post" action="groundBooking.jsp?ground=<%= request.getParameter("ground") %>">
                                   <div class="container text-center" style="width:930px">
                                   	  <div class="row">
                                   	  	<div class="col" style="margin-bottom:30px;">
                                   	  		
                                   	  		<h2 name="groundName" id="groundName"><%=request.getParameter("ground") %></h2>
                                   	  	</div>
                                   	  </div>
									  <div class="row">
									    <div class="col" style="margin-left:150px;">
									    	<% 
									    	Connection conn = null;
									    	PreparedStatement pstmt = null;
									    	ResultSet rs = null;
									    	String groundName = request.getParameter("ground");
									    	try {
									    		String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
									    		String dbID = "root";
									    		String dbPassword = "qwer";
									    		Class.forName("com.mysql.cj.jdbc.Driver");
									    		
									    		conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
									    		  // 데이터베이스에서 팀 정보를 가져오는 SQL 쿼리 작성
									    		String SQL = "SELECT * FROM stadium where stadium_name = ?";
									    		pstmt = conn.prepareStatement(SQL);
									    		pstmt.setString(1, groundName);
									    		rs = pstmt.executeQuery();
									    		// 가져온 팀 정보를 반복하여 표시
									    		if (rs.next()) {
									    			String img = rs.getString("img");
									    			out.println("<img src='File/" + img + "' alt='' style='width:300px;'>");
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
									    	%>
									     	
									    </div>
									    <div class="col" style="margin-right:100px;">
									    
									    
									    	 <h6>날짜</h6>
									    	 <label><input type="date" name="resDate"></label></br></br></br>
									    	<h6>시작 시간 ~ 종료 시간</h6>
									    	<label><input type="time" name="start_time"  min="09:00:00" max="18:00:00">~<input type="time" name="finish_time" min="09:00:00" max="18:00:00"></label></br></br></br>
									    	<h6>예약 목적</h6>
									    	<label>
									    		<select class="form-select" aria-label="Default select example" class="training" name="training" id="training">
									    			<option selected value="null">예약 목적</option>
									    			<option value="training">팀 훈련</option>
									    			<option value="vs">연습 경기</option>
									    		</select>
									    	</label>
										
									    
									    </div>
									  </div>
									  <div class="row" style="margin-top: 20px">
									    <div class="col">
									     
									      <button type="submit">예약하기</button> <input type="button" onclick="history.back()" value="뒤로가기">
									    </div>
									  
									  </div>
									</div>
                                  </form>
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
                        <a class="navbar-brand mb-2" href="index.html">
                            <i class="bi bi-trophy"></i>
                            <span>Base on Balls</span>
                        </a>
                    </div>

                    <div class="col-lg-3 col-md-4 col-6">
                        <h6 class="site-footer-title mb-3">Resources</h6>

                        <ul class="site-footer-links">
                            <li class="site-footer-link-item">
                                <a href="#" class="site-footer-link">Home</a>
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


                        <p class="copyright-text mt-lg-5 mt-4">Copyright © 2048 Topic Listing Center. All rights reserved.
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
