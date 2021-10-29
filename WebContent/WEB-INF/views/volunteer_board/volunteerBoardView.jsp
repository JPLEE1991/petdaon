<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

	VolunteerBoard board = (VolunteerBoard) request.getAttribute("board");
	String name = (String) request.getAttribute("name");
	int applicationCnt = (int) request.getAttribute("applicationCnt");

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
				
				<!-- 모집 인원 -->
    			<div class="row">
    				<div class="col-sm-2 font-weight-bold">
				      모집인원
				    </div>
				    <div class="col-sm-10">
				      <%= applicationCnt %>명 / <%= board.getCapacity() %>명
				    </div>
				</div>
				
				<!-- 봉사 장소 -->
    			<div class="row">
    				<div class="col-sm-2 font-weight-bold">
				      봉사장소
				    </div>
				    <div class="col-sm-10">
				      <%= board.getPlace() %>
				    </div>
				</div>
				
				<!-- 봉사 요일 -->
    			<div class="row">
    				<div class="col-sm-2 font-weight-bold">
				      봉사요일
				    </div>
				    <div class="col-sm-10">
				      <%= board.getDay() %>
				    </div>
				</div>
				
				<!-- 봉사 시간 -->
    			<div class="row">
    				<div class="col-sm-2 font-weight-bold">
				      봉사시간
				    </div>
				    <div class="col-sm-10">
				      <%= board.getTime() %>
				    </div>
				</div>
				
				<!-- 봉사 신청 -->
    			<div class="row">
				    <div class="col-sm-12">
						<!-- Button trigger modal -->
						<button type="button" class="btn btn-primary my-2" data-bs-toggle="modal" data-bs-target="#exampleModal">
						  신청하기
						</button>
						<!-- Modal -->
						<%-- Modal을 이용한 봉사신청폼 작성 --%>
						<form
							name="volunteerApplicationEnrollFrm"
							action="<%=request.getContextPath() %>/volunteerApplication/applicationEnroll"
							method="post">
							<%-- hidden으로 봉사신청 테이블 insert를 위한 신청자아이디, 게시글 번호 받아오기 --%>
							<%-- 로그인 구현 되면 변경하기(value부분 임의값 집어넣음) --%>
							<%-- <input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>" /> --%>
							<input type="hidden" name="memberId" value="honggd" />
							<input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
							
							<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">봉사 신청</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
									<%-- 로그인 구현 되면 변경하기(value부분 임의값 집어넣음) --%>
							        <!-- 이름 -->
							        <div class="mb-2 row">
										<label for="memberName" class="col-sm-2 col-form-label">이름</label>
										<div class="col-sm-10">
											<%-- <input type="text" class="form-control" name="memberName" id="memberName" value="<%= loginMember.getMemberName() %>" readonly> --%>
											<input type="text" class="form-control" name="memberName" id="memberName" value="홍길동" readonly>
										</div>
									</div>
									
									<!-- 휴대폰 -->
							        <div class="mb-2 row">
										<label for="phone" class="col-sm-2 col-form-label">휴대폰</label>
										<div class="col-sm-10">
											<%-- <input type="tel" class="form-control" name="phone" id="phone" value="<%= loginMember.getPhone() %>" readonly> --%>
											<input type="tel" class="form-control" name="phone" id="phone" value="01012341234" readonly>
										</div>
									</div>
									
									<!-- 이메일 -->
							        <div class="mb-2 row">
										<label for="email" class="col-sm-2 col-form-label">이메일</label>
										<div class="col-sm-10">
											<%-- <input type="email" class="form-control" name="email" id="email" value="<%= loginMember.getEmail() %>" readonly> --%>
											<input type="email" class="form-control" name="email" id="email" value="honggd@naver.com" readonly>
										</div>
									</div>
									
									<span class="small">휴대폰·이메일을 변경하시려면 회원 정보 변경 후 신청해주세요.</span>
									
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							        <button type="submit" class="btn btn-primary">신청하기</button>
							      </div>
							    </div>
							  </div>
							</div>
							
						</form>
						
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
		<!-- 탭컨텐츠 -->
		<div class="tab-content" id="nav-tabContent">
		  
		  <!-- 상세정보 -->
		  <div class="tab-pane fade show active" id="nav-detail" role="tabpanel" aria-labelledby="nav-detail-tab">
		  	<!-- 담당자 정보 -->
			<div class="container">
				<div class="personInfo row d-flex justify-content-center bg-secondary text-white">
					<dl class="col-md-4 d-flex justify-content-center">
						<dt class="mr-2">담당자 :</dt>
						<dd><%= name %></dd>
					</dl>
					<dl class="col-md-4 d-flex justify-content-center">
						<dt class="mr-2">이메일 : </dt>
						<dd><%= board.getEmail() %></dd>
					</dl>
					<dl class="col-md-4 d-flex justify-content-center">
						<dt class="mr-2">연락처 : </dt>
						<dd><%= board.getPhone() %></dd>
					</dl>
				</div>
		  	</div>
		  	<!-- 내용 -->
		  	<%= board.getContent() %>
		  </div>
		  
		  <div class="tab-pane fade" id="nav-comment" role="tabpanel" aria-labelledby="nav-comment-tab">문의답변</div>
		  
		  <div class="tab-pane fade" id="nav-status" role="tabpanel" aria-labelledby="nav-status-tab">
		  	<p class="text-start small">* 신청자의 전화번호와 이메일은 본 게시물을 작성한 담당자만 조회가 가능합니다.</p>
		  </div>
		
		</div>

	
    </div>
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<%@ include file="/WEB-INF/views/common/footer.jsp" %>