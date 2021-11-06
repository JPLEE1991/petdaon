<%@page import="com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	NoticeBoard noticeBoard = (NoticeBoard) request.getAttribute("noticeBoard");
	/* boolean editable = loginMember != null && (
			  loginMember.getMemberId().equals(noticeBoard.getWriter())
			  || MemberService.ADMIN_ROLE.equals(loginMember.getMemberRole())
			); */
%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/serviceCenter/boardList.css"/> --%>
<!-- 부트스트랩(CSS & JavaScript Bundle with Popper) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 매테리얼 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">

<style>
h2 {padding:30px; margin:0 auto; text-align:center;}
.material-icons-round {font-size:1em;}
#notice {padding:30px 0;}
#notice-title {font-size:20px; font-weight:bold; padding-bottom:5px;}
#notice-date {font-size:15px; color:#8e929f; padding-bottom:15px;}
#btnbar {border:1px solid rgba(0,0,0,.125); border-radius:.5rem; display:flex; justify-content:center; align-items:center; padding:9px; margin:0 auto;}
#btnbar:focus {background-color:#eceef2; box-shadow:none;}
</style>
	
	<div class="container">
		<div class="row">
		
			<h2>고객센터</h2>
			
			<div class="container col-9">
				<!-- 공지 -->
				<div id="notice" class="container">
					<div id="notice-title"><%= noticeBoard.getTitle() %></div>
					<div id="notice-date"><%= noticeBoard.getEnrollDate() %> &nbsp &nbsp &nbsp 조회 <%= noticeBoard.getViewNum() %></div>
					<div id="notice-content"><%= noticeBoard.getContent() %></div>
				</div>
				
				<!-- 목록으로 -->
				<a id="btnbar" class="btn col-12" href="<%= request.getContextPath() %>/serviceCenter/noticeBoard/noticeBoardList"><span class="material-icons-round">chevron_left</span>&nbsp목록으로</a>
			
			</div>
		</div>
	</div>
	
	<br/><br/><br/><br/><br/><br/>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>