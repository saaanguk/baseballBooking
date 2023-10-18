<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page session="true"%>
<%@ page import="baseballbooking.boardDAO"%>
<%@ page import="baseballbooking.board"%>
<%@ page import="java.util.ArrayList"%>
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
							<h1 class="text-white text-center">Base on Balls</h1>
							<h6 class="text-center">고품격의 사회인 야구 매칭 시스템</h6>
						</div>
					</div>
				</div>
			</section>
			<section class="featured-section">
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-6 col-12">
							<div class="custom-block custom-block-overlay">
								<div class="d-flex flex-column h-100">
									<img src="images/3623322_5dM.jpg" class="custom-block-image img-fluid" alt="">
									<div class="custom-block-overlay-text d-flex">
										<div>
											<h5 class="text-white mb-2">구단 찾기</h5>
											<p class="text-white">나에게 맞는 구단을 찾으세요.</p><br></br><br></br><br></br>
											<a href="searchTeam.jsp" class="btn custom-btn mt-2 mt-lg-3">구단 찾기</a>
										</div>
									</div>
									<div class="section-overlay"></div>
								</div>
							</div>
						</div>
						<div class="col-lg-6 col-12">
							<div class="custom-block custom-block-overlay">
								<div class="d-flex flex-column h-100">
									<img src="images/baseball.jpg" class="custom-block-image img-fluid" alt="">
									<div class="custom-block-overlay-text d-flex">
										<div>
											<h5 class="text-white mb-2">간편한 구장 예약</h5>
											<p class="text-white">팀 훈련, 다른 팀과의 연습경기 예약하기</p><br></br><br></br><br></br>
											<a href="search.jsp" class="btn custom-btn mt-2 mt-lg-3">예약 하기</a>
										</div>
									</div>
									<div class="section-overlay"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
			<section class="explore-section section-padding" id="section_2">
				<div class="container">
					<div class="col-12 text-center">
						<h2 class="mb-4">Board</h2>
					</div>
				</div>
				<div class="container-fluid">
					<div class="row">
						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="design-tab" data-bs-toggle="tab" data-bs-target="#design-tab-pane" type="button" role="tab" aria-controls="design-tab-pane" aria-selected="true">자유게시판</button>
							</li>
							<%if(session.getAttribute("team") != null){%>
								<li class="nav-item" role="presentation">
								<button class="nav-link" id="marketing-tab" data-bs-toggle="tab" data-bs-target="#marketing-tab-pane" type="button" role="tab" aria-controls="marketing-tab-pane" aria-selected="false"><%= team %>게시판</button>
							</li>
							<%}else {%>
								<li class="nav-item" role="presentation">
								<button class="nav-link" id="marketing-tab" data-bs-toggle="tab" data-bs-target="#marketing-tab-pane" type="button" role="tab" aria-controls="marketing-tab-pane" aria-selected="false">팀별게시판</button>
							</li>
							<%} %>
							
						</ul>
					</div>
				</div>
				<div class="container">
					<div class="row">
						<div class="col-12">
							<div class="tab-content" id="myTabContent">
								<div class="tab-pane fade show active" id="design-tab-pane" role="tabpanel" aria-labelledby="design-tab" tabindex="0">
									<a href="board.jsp"><button type="button" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem; background-color: rgb(129, 221, 241); border: none; float: left;">
									  더보기
									</button></a>
									<div class="row">
										<table class="table table-hover">
											<thead>
												<tr>
													<th scope="col">순번</th>
													<th scope="col">제목</th>
												    <th scope="col">내용</th>
												    <th scope="col">작성자</th>
												    <th scope="col">작성일</th>
												    <th scope="col">조회수</th>
												</tr>
											</thead>
											<tbody>
												<% Class.forName("com.mysql.cj.jdbc.Driver");
													Connection conn = null;
													PreparedStatement pstmt = null;
													ResultSet rs = null;
													
													try{
														String dbURL="jdbc:mysql://localhost:3306/baseball_db";
														String dbID = "root";
														String dbPW = "qwer";
														Class.forName("com.mysql.cj.jdbc.Driver");
														conn = DriverManager.getConnection(dbURL, dbID, dbPW);
														String countQuery = "SELECT COUNT(*) AS total FROM board WHERE available = 1";
													    PreparedStatement countStmt = conn.prepareStatement(countQuery);
													    
													    ResultSet countResult = countStmt.executeQuery();
													    countResult.next();
													   	int totalRecords = countResult.getInt("total");
													   	int count = totalRecords;
														
														pstmt = conn.prepareStatement("select * from board order by reg_date desc limit 5");
														rs = pstmt.executeQuery();
														
														while(rs.next()){%>
															<tr>
																<th scope="row"><%= count %></th>
										      					<td><a href="showBoard.jsp?title=<%= rs.getString("text") %>&writer=<%=rs.getString("id")%>"><%= rs.getString("text") %></a></td>
																<td><%= rs.getString("content") %></td>
															    <td><%= rs.getString("id") %></td>
															    <td><%= rs.getDate("reg_date") %></td>
															    <td><%= rs.getInt("hit") %></td>
															</tr>
														<% count--;}
													}catch(SQLException se){
														se.printStackTrace();
													}finally{
														if(rs != null){rs.close();}
														if(pstmt != null){pstmt.close();}
														if(conn != null){conn.close();}
													}
												%>
											</tbody>
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="marketing-tab-pane" role="tabpanel" aria-labelledby="marketing-tab" tabindex="0">
									<%if(session.getAttribute("team") != null){ %>
									<a href="teamBoard.jsp"><button type="button" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem; background-color: rgb(129, 221, 241); border: none; float: right;">
									  더보기
									</button></a>
									<%}else{ %>
									<button type="button" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem; background-color: rgb(129, 221, 241); border: none; float: right;" onclick="if(confirm('팀에 가입 되어있지 않습니다.'))location.href='searchTeam.jsp';">
									  더보기
									</button>
									<%} %>
									<div class="row">
										<table class="table table-hover">
											<thead>
												<tr>
													<th scope="col">순번</th>
													<th scope="col">제목</th>
												    <th scope="col">내용</th>
												    <th scope="col">작성자</th>
												    <th scope="col">작성일</th>
												    <th scope="col">조회수</th>
												</tr>
											</thead>
											<tbody>
												<% Class.forName("com.mysql.cj.jdbc.Driver");
													Connection conn1 = null;
													PreparedStatement pstmt1 = null;
													ResultSet rs1 = null;
													
													try{
														String dbURL = "jdbc:mysql://localhost:3306/baseball_db";
														String dbID = "root";
														String dbPW = "qwer";
														
														Class.forName("com.mysql.cj.jdbc.Driver");
														conn1 = DriverManager.getConnection(dbURL, dbID, dbPW);
														
														String countQuery = "SELECT COUNT(*) AS total FROM team_board WHERE team_name=? and available = 1";
													    PreparedStatement countStmt = conn.prepareStatement(countQuery);
													    countStmt.setString(1, team);
													    ResultSet countResult = countStmt.executeQuery();
													    countResult.next();
													    int totalRecords = countResult.getInt("total");
													    int count = totalRecords;
														
														pstmt1 = conn1.prepareStatement("select * from team_board where team_name=?");
														pstmt.setString(1, team);
														rs1 = pstmt.executeQuery();
														
														while(rs.next()){%>
															<tr>
																<th scope="row"><%= count%></th>
														  		<td><a href="showTeamBoard.jsp?title=<%= rs.getString("text") %>&writer=<%=rs.getString("id")%>"><%= rs.getString("text") %></a></td>
														  		<td><%=rs.getString("content")%></td>
														  		<td><%=rs.getString("id")%></td>
														  		<td><%=rs.getString("reg_date")%></td>
														  		<td><%=rs.getString("hit")%></td>
															</tr>
														<% count--;}
													}catch(SQLException se){
														se.printStackTrace();
													}finally{
														if(rs1 != null){rs.close();}
														if(pstmt1 != null){pstmt.close();}
														if(conn1 != null){conn1.close();}
													}
												%>
											</tbody>
										</table>
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