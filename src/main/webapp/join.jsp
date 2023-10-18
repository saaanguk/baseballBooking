<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page session="true" %>
<% String id = session.getAttribute("id")+""; %>
<!doctype html>
<html lang="kor">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">

        <title>고의사구_회원가입</title>

        <!-- CSS FILES -->        
        <link rel="preconnect" href="https://fonts.googleapis.com">
        
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;600;700&family=Open+Sans&display=swap" rel="stylesheet">
                        
        <link href="asset/css/bootstrap.min.css" rel="stylesheet">

        <link href="asset/css/bootstrap-icons.css" rel="stylesheet">

        <link href="asset/css/templatemo-topic-listing.css" rel="stylesheet">
        
        <link href="css/join.css" rel="stylesheet">      
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

                        <div class="container">
                    <form id="join" action="joinMember.jsp" method="post">
					  <h2><span class="entypo-login"><i class="fa fa-sign-in"></i></span> Join </h2>

					  <input type="button" class="button" value="id Check" onclick="idCheck()" style="float:right; height: 40px; width: 80px; border: 0px;  background:rgb(4, 142, 108);  border-radius:7px;  padding: 10px;  color:white;  font-size:15px;  margin-top: 10px;">
					  <input type="text" class="id" placeholder="urserID" name='id' id="id"/>
					  <input type="password" class="pw"placeholder="password" name='pw'id="pw"/>
					  <input type="password" class="pwCheck"placeholder="password Check" name='pwCheck'/>
					  <input type="text" class="name"placeholder="name" name='name' id="name"/>
					  
					  <select class="form-select" aria-label="Default select example" class="position" name="position" id="position" style="height: 54px;width:300px;">
						  <option selected>position</option>
						  <option value="투수">투수</option>
						  <option value="포수">포수</option>
						  <option value="1루수">1루수</option>
						  <option value="2루수">2루수</option>
						  <option value="유격수">유격수</option>
						  <option value="3루수">3루수</option>
						  <option value="좌익수">좌익수</option>
						  <option value="중견수">중견수</option>
						  <option value="우익수">우익수</option>
						</select>
					  <input type="date" class="birth" name="birth" placeholder="birth" id="birth"/>
					  <input type="text" class="ph" name="ph" placeholder="phone number" id="ph"/>
					  <input type="text" class="addr" name="addr" placeholder="address" id='addr'/>
					  <input type="text" class="email" name="email" placeholder="email" id='email'/>
					  <% String idCheck = session.getAttribute("idCheck")+"";
						 if (idCheck.equals("false") || idCheck.equals("null")){					  
					  %>
					  <input type="submit" class="entypo-join" value="Join" disabled>
					  
					  <% } else { %>
					 <input type="submit" class="entypo-join" value="Join">
					  <% } %>
					</form>
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
		<script src="js/login.js"></script>
    </body>
</html>

<script>
	function idCheck() {
        var id = document.getElementById('id').value;
        location.href = "idCheck.jsp?id="+id;
    }
   
</script>
