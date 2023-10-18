<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page session="true" %>
    
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<% String id = session.getAttribute("id")+""; %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">

        <title>고의사구</title>

        <!-- CSS FILES -->        
        <link rel="preconnect" href="https://fonts.googleapis.com">
        
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;600;700&family=Open+Sans&display=swap" rel="stylesheet">
                        
        <link href="asset/css/bootstrap.min.css" rel="stylesheet">

        <link href="asset/css/bootstrap-icons.css" rel="stylesheet">

        <link href="asset/css/templatemo-topic-listing.css" rel="stylesheet">    
        
        <link href="css/img.css" rel="stylesheet">
        
		  
		
     
		
<!--

TemplateMo 590 topic listing

https://templatemo.com/tm-590-topic-listing

-->
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
                            <h1 class="text-white text-center">구단 가입</h1>
                            <h6 class="text-center"></h6>

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
								
									  
									    
									    <% 
										    Connection conn = null;
										    PreparedStatement pstmt = null;
										    ResultSet rs = null;
											String teamName = request.getParameter("team");
										    try {
										    	String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
										    	
												String dbID = "root";
											
												String dbPassword = "qwer";
											
												Class.forName("com.mysql.cj.jdbc.Driver");
											
												conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
												
										        // 데이터베이스에서 팀 정보를 가져오는 SQL 쿼리 작성
										        String SQL = "SELECT * FROM team where team_name = ?";
										        pstmt = conn.prepareStatement(SQL);
										        pstmt.setString(1, teamName);
										        rs = pstmt.executeQuery();
										
										        // 가져온 팀 정보를 반복하여 표시
										        if (rs.next()) {
										            String imageFileName = rs.getString("img");
										            String location = rs.getString("addr");
										            String coach = rs.getString("coach_name");
										            
										            // <article> 요소 생성 및 데이터 표시
										            out.println("<div class='container text-center' style='float: none; margin=100 auto;'>");
										            out.println("<div class='row'style='float: none; margin=0 auto;'>");
										            out.println("<div class='col' style='float: none; margin=0 auto;'>");
										            out.println("<img src='File/" + imageFileName + "'class='img-thumbnail' alt='...' style='margin-left:42%;'></br></br>");
										            out.println("</div>");
										            out.println("</div>");
										            out.println("<h4>" + teamName + "</h4>");
										            out.println("<h6> 지역 : " + location + "<h6>");
										            out.println("<h6> 감독 : " + coach + "</h6>");
										           
										        }
										    } catch (Exception e) {
										        e.printStackTrace();
										    } finally {
										        // DB 연결 및 리소스 해제
										       try {
										            if (rs != null) rs.close();
										            if (pstmt != null) pstmt.close();
										        } catch (SQLException e) {
										            e.printStackTrace();
										        }
										    }
									    %>
									     <% 
										    
										    try {
										    	
										    	int pit =0;
									            int cat =0;
									            int one =0;
									            int two =0;
									            int sho =0;
									            int thr =0;
									            int lef =0;
									            int cen =0;
									            int rig =0;
									            
										    	String dbURL = "jdbc:mysql://localhost:3306/baseball_db"; 
										    	
												String dbID = "root";
											
												String dbPassword = "qwer";
											
												Class.forName("com.mysql.cj.jdbc.Driver");
											
												conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
												
										        // 데이터베이스에서 팀 정보를 가져오는 SQL 쿼리 작성
										        String SQL = "SELECT * FROM member where team = ?";
										        pstmt = conn.prepareStatement(SQL);
										        pstmt.setString(1, teamName);
										        rs = pstmt.executeQuery();
										
										        // 가져온 팀 정보를 반복하여 표시
										        while (rs.next()) {
										            String position = rs.getString("position");
										            
										            
										            if(position.equals("투수")) {
										            	pit ++;
										            } else if(position.equals("포수")){
										            	cat ++;
										            } else if(position.equals("1루수")){
										            	one ++;
										            } else if(position.equals("2루수")){
										            	two ++;
										            } else if(position.equals("유격수")){
										            	sho ++;
										            } else if(position.equals("3루수")){
										            	thr ++;
										            } else if(position.equals("좌익수")){
										            	lef ++;
										            } else if(position.equals("중견수")){
										            	cen ++;
										            } else if(position.equals("우익수")){
										            	rig ++;
										            }
										        }
										            // <article> 요소 생성 및 데이터 표시
										            out.println("<div class='row'>");
										            out.println("<div class='col'>");
													
										            out.println("<label>투수 :"+ pit +"명</label></br>");
										            out.println("<label>포수 :"+ cat +"명</label></br>");
										            out.println("<label>1루수 :"+ one +"명</label></br>");
										            out.println("<label>2루수 :"+ two +"명</label></br>");
										            out.println("<label>유격수 :"+ sho +"명</label></br>");
										            out.println("<label>3루수 :"+ thr +"명</label></br>");
										            out.println("<label>좌익수 :"+ lef +"명</label></br>");
										            out.println("<label>중견수 :"+ cen +"명</label></br>");
										            out.println("<label>우익수 :"+ rig +"명</label></br></br>");
										            out.println("<a href='teamRequest.jsp?team=" + teamName + "'>");
										            out.println("<button type='submit' class=''>가입신청</button> <input type='button' value='뒤로가기' onclick='history.back()'>");
										            out.println("</a>");
										            
										            out.println("</div>");
										            out.println("</div>");
										           
										        
										    } catch (Exception e) {
										        e.printStackTrace();
										    } finally {
										        // DB 연결 및 리소스 해제
										       try {
										            if (rs != null) rs.close();
										            if (pstmt != null) pstmt.close();
										        } catch (SQLException e) {
										            e.printStackTrace();
										        }
										    }
									    %>
									    
									     
									    
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
