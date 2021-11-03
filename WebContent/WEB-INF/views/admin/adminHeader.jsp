<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 부트스트랩(CSS & JavaScript Bundle with Popper) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 매테리얼 아이콘 -->
<!-- <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<style>
main, #sidebar, #sidebar a {display:flex;}
#sidebar {width:280px; padding:16px; flex-direction:column;}
#sidebar a {align-items:center; text-decoration:none; color:white;}
#sidebar img {width:30px; border-radius:50%; margin-right:10px;}
#sidebar ul {flex-direction:column;}
#sidebar ul li {list-style:none;}
#sidebar i {font-size:13px;}
#sidebar ul li a.btn {justify-content:space-between;}
.btn[aria-expanded="true"] i {transform:rotate(90deg);}
.category ul li a {font-weight:300; font-size:14px;}
a.btn {font-weight:500;}
#main-title {margin:0 0 0 10px; font-weight:bold;}
#index {height:700px; background-color:#eceef2;}
</style>
<script>
<% 
	String msg = (String) session.getAttribute("msg");
	// System.out.println("msg@adminHeader.jsp = " + msg);
	if(msg != null) session.removeAttribute("msg");
	
%>
<% if(msg != null) { %>
	// 사용자 메세지 전달
	alert("<%= msg %>");
<% } %>
</script>

	<main>
	
		<!-- 사이드메뉴 -->
		<div id="sidebar" class="bg-dark text-white">
			<a href="<%= request.getContextPath() %>/">
				<img src="https://i.ibb.co/SJzcjwt/Notes-211021-004517.jpg">
		    	<span class="fs-5">펫다온</span>
		    </a>
			<hr>
			<ul class="nav">
				<!-- 사용자 관리 -->
				<li>
					<a class="btn" data-bs-toggle="collapse" data-bs-target="#member" aria-expanded="false" aria-controls="member">사용자 관리&nbsp<i class="bi bi-chevron-right"></i></a>
					<div class="collapse category" id="member">
						<ul>
							<li><a href="<%= request.getContextPath() %>/admin/adminmemberList">회원</a></li>
							<li><a href="#">블랙리스트</a></li>
						</ul>
					</div>
				</li>
				<!-- 게시물 관리 -->
				<li>
					<a class="btn" data-bs-toggle="collapse" data-bs-target="#board" aria-expanded="false" aria-controls="board">게시물 관리&nbsp<i class="bi bi-chevron-right"></i></a>
					<div class="collapse category" id="board">
						<ul>
							<li><a href="#">게시물 목록</a></li>
							<li><a href="<%= request.getContextPath() %>/admin/volunteerBoardList">봉사 게시글 승인</a></li>
						</ul>
					</div>
				</li>
				<!-- 고객센터 -->
				<li>
					<a class="btn" data-bs-toggle="collapse" data-bs-target="#service" aria-expanded="false" aria-controls="service">고객센터&nbsp<i class="bi bi-chevron-right"></i></a>
					<div class="collapse category" id="service">
						<ul>
							<li><a href="#">공지사항</a></li>
							<li><a href="#">1:1문의</a></li>
							<li><a href="#">신고내역</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
		
		<div class="container">
	    	<div class="row">
	    		
	    		<!-- 상단메뉴 -->
				<nav class="navbar bg-white">
					<p id="main-title">관리자 페이지</p>
					<div class="dropdown">
						<a class="btn" data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-person-fill"></i>&nbspadmin</a>
						<ul class="dropdown-menu dropdown-menu-end">
						   	<li><a class="dropdown-item" href="<%= request.getContextPath() %>/">홈으로</a></li>
						    <li><a class="dropdown-item" href="#">로그아웃</a></li>
						</ul>
					</div>
				</nav>
				
				<!-- 목록 불러올 부분 -->
				<div id="index">