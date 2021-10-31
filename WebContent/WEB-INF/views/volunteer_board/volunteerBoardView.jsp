<%@page import="com.petdaon.mvc.common.vo.BoardComment"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerApplicationExt"%>
<%@page import="java.util.List"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	// 봉사 게시글
	VolunteerBoard board = (VolunteerBoard) request.getAttribute("board");
	// 봉사 게시글 담당자 이름 가져오기
	String name = (String) request.getAttribute("name");
	// 승인상태인 봉사 게시글 신청인원 수 - 모집인원 초과여부 확인을 위해 가져옴
	int applicationCnt = (int) request.getAttribute("applicationCnt");
	// 접수상태인 신청자 리스트
	List<VolunteerApplicationExt> applicationList = (List<VolunteerApplicationExt>) request.getAttribute("applicationList");
	// 댓글(문의/답변)목록 가져오기
	List<BoardComment> commentList = (List<BoardComment>) request.getAttribute("commentList");

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
						<button type="button" id="triggerModal" class="btn btn-primary my-2" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="applicationModal()">
						  신청하기
						</button>
						<!-- Modal -->
						<%-- Modal을 이용한 봉사신청폼 작성 --%>
						<form
							id="applicationForm"
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
		  
		  <!-- 문의답변 -->
		  <div class="tab-pane fade" id="nav-comment" role="tabpanel" aria-labelledby="nav-comment-tab">
		  	<h5 class="my-3">문의/답변</h5>
		  	<!-- 댓글작성 폼 -->
		  	<form 
				action="<%= request.getContextPath() %>/volunteerBoard/boardCommentEnroll" 
				name="volunteerBoardCommentFrm" 
				method="POST">
				<input type="hidden" name="commentLevel" value="1" />
				<%-- 로그인 기능 구현되면 수정하기 value부분에 테스트로 honggd 넣음--%>
				<%-- <input type="hidden" name="writer" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>" /> --%>
				<input type="hidden" name="writer" value="honggd" />
				<input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
				<input type="hidden" name="commentRef" value="0" />
				
				<div class="row my-2">
					<div class="col-md-11">
						<textarea class="form-control" placeholder="문의를 남겨주세요." id="floatingTextarea" name="content"></textarea>
					</div>
					<div class="col-md-1">
						<button class="btn btn-primary h-100">등록</button>
					</div>
				</div>
			</form>
			<hr />
			
<%
if(commentList != null && !commentList.isEmpty()){ // isEmpty()는 객체가 null로 되어있어 비는 것이 아닌 값이 존재하지 않는 상태이다.
	for(BoardComment bc : commentList){
		/* 로그인 기능 구현되면 수정할 부분 수정하고 넣기 */
		/* boolean removable = 
				loginMember != null && 
				(
				  loginMember.getMemberId().equals(bc.getWriter())
				  || MemberService.ADMIN_ROLE.equals(loginMember.getMemberRole())
				); */
		
		if(bc.getCommentLevel() == 1){
%>
			<%-- 댓글 --%>
			<div class="row level1 h-100">
				<div class="col-md-12">
					<span class="comment-writer"><%= bc.getWriter() %></span>
					<span class="comment-date small"><%= bc.getRegDate() %></span>
				</div>
				<div class="col-md-12 comment-content bg-light text-dark">
					<%-- 댓글 내용 --%>
					<span><%= bc.getContent() %></span>
					<button type="button" class="btn btn-reply btn-info float-right btn-sm" value="<%= bc.getNo() %>">답글</button>
				</div>
			</div>
<%
		}
		else {
%>
			<%-- 대댓글(답글) --%>
			<div class="row level2">
				<div class="col-md-12">
					<span class="comment-writer"><%= bc.getWriter() %></span>
					<span class="comment-date small"><%= bc.getRegDate() %></span>
				</div>
				<div class="col-md-12 comment-content bg-secondary text-white">
					<%-- 댓글 내용 --%>
					<div class="pl-5"><%= bc.getContent() %></div>
				</div>
			</div>
<%
		}
	}
}
%>
			
		  </div>
		  
		  <!-- 신청현황 -->
		  <div class="tab-pane fade" id="nav-status" role="tabpanel" aria-labelledby="nav-status-tab">
		  	<p class="text-start small">* 신청자의 전화번호와 이메일은 본 게시물을 작성한 담당자만 조회가 가능합니다.</p>
		  	
		  	<!-- 테이블 -->
		  	
		  	<div class="table-responsive-xl">
			  	<table class="table">
				  <thead>
				    <tr class="table-secondary">
				      <th scope="col">번호</th>
				      <th scope="col">이름</th>
				      <th scope="col">휴대폰</th>
				      <th scope="col">이메일</th>
				      <th scope="col">등록일</th>
				      <th scope="col">승인여부</th>
				    </tr>
				  </thead>
				  <tbody>
<%
if(applicationList != null && !applicationList.isEmpty()) { // isEmpty()는 객체가 null로 되어있어 비는 것이 아닌 값이 존재하지 않는 상태이다.
	int cnt = 0;
	for(VolunteerApplicationExt va : applicationList) {
%>				    
				    <tr>
				      <th scope="row"><%= ++cnt %></th>
				      <td><%= va.getMemberName() %></td>
				      <td><%= va.getPhone() %></td>
				      <td><%= va.getEmail() %></td>
				      <td><%= va.getRegDate() %></td>
				      <td>
				      	<span class="bg-primary text-white small p-1 rounded">
				      	<%= VolunteerBoardService.APPROVAL_YES.equals(va.getApprovalYn()) ? "승인" : "미승인" %>
				      	</span>
				      </td>
				    </tr>
<%
	}
}
else {
%>
					<tr>
				      <td colspan="6" class="text-center">신청한 자원봉사자가 없습니다.</td>
				    </tr>
<%
}
%>
				  </tbody>
				</table>
			</div>
		  	
		  </div>
		
		</div>

	
    </div>
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<script>
/**
 * 신청하기 모달 트리거 누를 때 loginMember null (로그인 하지 않은 경우) alert창 띄움 "로그인후 이용할 수 있습니다."
 */
<%-- const applicationModal = () => {
	// 로그인 기능 구현되면 변경하기 주석된 코드로 바꿀 것 임의값 "신사임당" 집어넣은 상태
	<% if(loginMember == null) {%>
	//로그인 하지 않았을 경우 발생
	alert("로그인후 이용할 수 있습니다.");
	// 모달창 숨기기(로그인 기능 구현되면 테스트 해보기 문제 있을 수도 있음)
	$('#applicationForm').hide();
	// 백그라운드 남아있는것 제거
	$('.modal-backdrop').remove();
<% } else { %>
	$('#applicationForm').show();
<%
	}
%>
} --%>


/**
* volunteerApplicationEnrollFrm 검사
*/
function volunteerApplicationValidate(e){
	// 이미 신청한 경우 신청버튼 누를 시 '이미 신청하신 상태입니다.' alert창 띄우기
<%
if(applicationList != null && !applicationList.isEmpty()) { // isEmpty()는 객체가 null로 되어있어 비는 것이 아닌 값이 존재하지 않는 상태이다.
	for(VolunteerApplicationExt va : applicationList) {
		// 로그인 기능 구현되면 변경하기 주석된 코드로 바꿀 것 임의값 honggd 집어넣은 상태
		// 로그인 유무는 이 제출폼 나오기 전에 검사하였으므로 로그인 loginMember null여부 검사하지 않음
		//if(loginMember.getMemberId().equals(va.getApplicant())){
		if("honggd".equals(va.getApplicant())){
%>
			alert("이미 신청하신 상태입니다.");
			return false;
<%
		}
	}
}
%>
	return true;
}

$(() => {
	$(document.volunteerApplicationEnrollFrm).submit(volunteerApplicationValidate);
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>