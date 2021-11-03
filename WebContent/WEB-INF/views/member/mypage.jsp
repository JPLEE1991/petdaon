<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
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
#sidebar {width:280px; padding:16px; flex-direction:column; background-color:pink;}
#sidebar a {align-items:center; text-decoration:none; color:white;}
#sidebar img {width:30px; border-radius:50%; margin-right:10px; }
#sidebar ul {flex-direction:column; }
#sidebar ul li {list-style:none;}
#sidebar i {font-size:13px;}
#sidebar ul li a.btn {justify-content:space-between;}
.btn[aria-expanded="true"] i {transform:rotate(90deg);}
.category ul li a {font-weight:300; font-size:14px;}
a.btn {font-weight:500;}
#main-title {margin:0 0 0 10px; font-weight:bold;}
#index {height:700px; background-color:#eceef2;}
</style>

	<main>
	
		<!-- 사이드메뉴 -->
		<div id="sidebar" class="bg-blue text-white">
			<a href="<%= request.getContextPath() %>/">
		    	<span class="fs-5">마이페이지</span>
		    </a>
			<hr>
			<ul class="nav">
				<!-- 사용자 관리 -->
				<li>
					<a class="btn" data-bs-toggle="collapse" data-bs-target="#member" aria-expanded="false" aria-controls="member">개인정보 변경&nbsp<i class="bi bi-chevron-right"></i></a>
					<div class="collapse category" id="member">
						<ul>
							<li><a href="<%= request.getContextPath() %>/admin/adminmemberList">개인정보 변경</a></li>
							<li><a href="<%= request.getContextPath() %>/member/updatePassword">비밀번호 변경</a></li>
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
		
				
				<!-- 목록 불러올 부분 -->
				<div id="index">