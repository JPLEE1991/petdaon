<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

	VolunteerBoard board = (VolunteerBoard) request.getAttribute("board");

	/* 로그인 기능 구현되면 주석 해제 수정할것 고치기 */
	/* boolean editable = loginMember != null && (
			  loginMember.getMemberId().equals(board.getWriter())
			  || MemberService.ADMIN_ROLE.equals(loginMember.getMemberRole())
			); */
			
	/* 코멘트 기능 추가할때 넣기 */
	/* List<BoardComment> commentList = (List<BoardComment>) request.getAttribute("commentList"); */

%>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
    
    <div class="container">
    	<h3>봉사 게시글 상세조회</h3>
    	<div class="row">
    	
    		<div class="col-md-5 text-center">
<%
		// 봉사 프로필 이미지
		if(board.getThumbnail() != null) {
%>
    			<img src="<%= request.getContextPath() %>/<%= board.getThumbnail() %>" class="img-thumbnail" id="img-thumbnail" alt="봉사 게시글 썸네일 사진" />
<% 
		}
		else {
%>    		
				<img src="<%= request.getContextPath() %>/images/blank-volunteer-640.jpg" class="img-thumbnail" id="img-thumbnail" alt="봉사 게시글 썸네일 사진" />
<%
		}
%>
    		</div>
    		<div class="col-md-7">
    			<!-- 제목 -->
    			<h4><%= board.getTitle() %></h4>
    			
    			<!-- 센터명 -->
    			<div class="row">
    				<div class="col-sm-2 font-weight-bold">
				      센터명
				    </div>
				    <div class="col-sm-10">
				      <%= board.getCenterName() %>
				    </div>
				</div>
				
				<!-- 활동기간 (봉사 시작일 ~ 봉사 종료일) -->
    			<div class="row">
    				<div class="col-sm-2 font-weight-bold">
				      활동기간
				    </div>
				    <div class="col-sm-10">
				      <%= board.getStartDate() %> ~ <%= board.getEndDate() %>
				    </div>
				</div>
				
				<!-- 신청 마감일 -->
    			<div class="row">
    				<div class="col-sm-2 font-weight-bold">
				      모집마감
				    </div>
				    <div class="col-sm-10">
				      <%= board.getDeadlineDate() %>
				    </div>
				</div>
    			
    		</div>
    	
    	</div>
    	
    	<nav>
		  <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
		    <button class="nav-link active" id="nav-detail-tab" data-bs-toggle="tab" data-bs-target="#nav-detail" type="button" role="tab" aria-controls="nav-detail" aria-selected="true">상세정보</button>
		    <button class="nav-link" id="nav-comment-tab" data-bs-toggle="tab" data-bs-target="#nav-comment" type="button" role="tab" aria-controls="nav-comment" aria-selected="false">문의/답변</button>
		    <button class="nav-link" id="nav-status-tab" data-bs-toggle="tab" data-bs-target="#nav-status" type="button" role="tab" aria-controls="nav-status" aria-selected="false">신청현황</button>
		  </div>
		</nav>
		<div class="tab-content" id="nav-tabContent">
		  <div class="tab-pane fade show active" id="nav-detail" role="tabpanel" aria-labelledby="nav-detail-tab"><%= board.getContent() %></div>
		  <div class="tab-pane fade" id="nav-comment" role="tabpanel" aria-labelledby="nav-comment-tab">문의답변</div>
		  <div class="tab-pane fade" id="nav-status" role="tabpanel" aria-labelledby="nav-status-tab">신청현황</div>
		</div>

    </div>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>