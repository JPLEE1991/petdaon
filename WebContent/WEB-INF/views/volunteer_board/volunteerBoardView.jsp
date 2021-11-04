<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.petdaon.mvc.member.model.service.MemberService"%>
<%@page import="com.petdaon.mvc.common.vo.BoardComment"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerApplicationExt"%>
<%@page import="java.util.List"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!--SNS 카카오톡 공유  -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

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

	/* 관리자 or 게시글 작성자일 경우 */
	boolean editable = _member != null && (
			  _member.getMemberId().equals(board.getWriter())
			  || MemberService.ADMIN_ROLE.equals(_member.getMemberRole())
			);
	
	/* 관리자일 경우 */
	boolean adminEditable = _member != null && MemberService.ADMIN_ROLE.equals(_member.getMemberRole());
	
	// 날짜 비교하기 위한 준비
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar cal = Calendar.getInstance();
	String today = sdf.format(cal.getTime());
	String deadline = sdf.format(board.getDeadlineDate());
%>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />

<style>

/* SNS공유 */
.link-icon { position: relative; display: inline-block; width: auto; font-size: 14px; font-weight: 500; color: #333; margin-right: 10px; padding-top: 50px; width:40px }
.link-icon.twitter { background-image: url(<%=request.getContextPath()%>/images/icon-twitter.png); background-repeat: no-repeat; }
.link-icon.facebook { background-image: url(<%=request.getContextPath()%>/images/icon-facebook.png); background-repeat: no-repeat; } 
.link-icon.kakao { background-image: url(<%=request.getContextPath()%>/images/icon-kakao.png); background-repeat: no-repeat; }
/* /SNS공유 */

</style> 
  
    <div class="container">
    	<div class="row">
    		<div class="col-md-9">
		    	<h3>봉사 게시글 상세조회</h3>
    		</div>
    		<div class="col-md-3">
		    	<%-- 게시글 수정은 관리자 or 게시글 작성자 가능 / 게시글 삭제는 관리자만 가능 --%>
		    	<% if(adminEditable) {%><button type="button" class="btn btn-danger btn-sm float-right ml-2" onclick="deleteBoard()">삭제</button><%} %>    		
		    	<% if(editable) {%><button type="button" class="btn btn-primary btn-sm float-right" onclick="updateBoard()">수정</button><%} %>
    		</div>
    	</div>
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
<%-- 마감기간 지날 시 신청기간이 지났습니다 띄움 --%>
<% if(today.compareTo(deadline) <= 0) {%>
						<button type="button" id="triggerModal" class="btn btn-primary my-2" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="applicationModal()">
						  신청하기
						</button>
<% } else { %>
						<div class="my-2">
							<span class="bg-primary text-white small p-1 rounded">신청기간이 지났습니다.</span>
						</div>
<% } %>
						<!-- Modal -->
						<%-- Modal을 이용한 봉사신청폼 작성 --%>
						<form
							id="applicationForm"
							name="volunteerApplicationEnrollFrm"
							action="<%=request.getContextPath() %>/volunteerApplication/applicationEnroll"
							method="post">
							<%-- hidden으로 봉사신청 테이블 insert를 위한 신청자아이디, 게시글 번호 받아오기 --%>
<% 
	if(_member != null) {
%>
							<input type="hidden" name="memberId" value="<%= _member.getMemberId() %>" />
<% 
	} 
%>
							<input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
							
							<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">봉사 신청</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							        <!-- 이름 -->
							        <div class="mb-2 row">
										<label for="memberName" class="col-sm-2 col-form-label">이름</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" name="memberName" id="memberName" value="<%= _member != null ? _member.getMemberName() : "" %>" readonly>
										</div>
									</div>
									
									<!-- 휴대폰 -->
							        <div class="mb-2 row">
										<label for="phone" class="col-sm-2 col-form-label">휴대폰</label>
										<div class="col-sm-10">
											<input type="tel" class="form-control" name="phone" id="phone" value="<%= _member != null ? _member.getPhone() : "" %>" readonly>
										</div>
									</div>
									
									<!-- 이메일 -->
							        <div class="mb-2 row">
										<label for="email" class="col-sm-2 col-form-label">이메일</label>
										<div class="col-sm-10">
											<input type="email" class="form-control" name="email" id="email" value="<%= _member != null ? _member.getEmail() : "" %>" readonly>
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
						
						
						<!-- SNS 공유버튼 모음  -->
						
						<a id="btnKakao" class="link-icon kakao float-right" href="javascript:shareKakao();"></a>   			
						<a id="btnFacebook" class="link-icon facebook float-right" href="javascript:shareFacebook();"></a>    
						<a id="btnTwitter" class="link-icon twitter float-right" href="javascript:shareTwitter();"></a>

						<!-- /SNS공유 버튼 모음 -->
						
						
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
				<input type="hidden" name="writer" value="<%= _member != null ? _member.getMemberId() : "" %>" />
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
		boolean removable = 
				_member != null && 
				(
				  _member.getMemberId().equals(bc.getWriter())
				  || MemberService.ADMIN_ROLE.equals(_member.getMemberRole())
				);
		
		if(bc.getCommentLevel() == 1){
%>
			<%-- 댓글 --%>
			<div class="row level1 h-100">
				<div class="col-md-12">
					<span class="comment-writer"><%= VolunteerBoardService.DELETE_NO.equals(bc.getDeleteYn()) ? bc.getWriter() : "삭제" %></span>
					<span class="comment-date small"><%= bc.getRegDate() %></span>
				</div>
				<div class="col-md-12 comment-content bg-light text-dark">
					<%-- 댓글 내용 --%>
<%-- 삭제된 댓글인 경우 처리 --%>
<% if(VolunteerBoardService.DELETE_NO.equals(bc.getDeleteYn())) { %>
					<span><%= bc.getContent() %></span>
<% if(removable){ %><button type="button" class="btn btn-delete btn-danger float-right btn-sm ml-2" value="<%= bc.getNo() %>">삭제</button><% } %>
<%-- 작성자와 관리자만 답글 버튼 보일 수 있게 함 --%>
<% if(editable) { %><button type="button" class="btn btn-reply btn-primary float-right btn-sm" value="<%= bc.getNo() %>">답글</button><% } %>
					
<% 
	} 
	else {
%>
					<span>삭제된 문의입니다.</span>
<%
	}
%>
					
				</div>
			</div>
<%
		}
		else {
%>
			<%-- 대댓글(답글) --%>
			<div class="row level2">
				<div class="col-md-12">
					<span class="comment-writer"><%= VolunteerBoardService.DELETE_NO.equals(bc.getDeleteYn()) ? bc.getWriter() : "삭제" %></span>
					<span class="comment-date small"><%= bc.getRegDate() %></span>
				</div>
				<div class="col-md-12 comment-content bg-secondary text-white">
					<%-- 댓글 내용 --%>
<%-- 삭제된 댓글인 경우 처리 --%>
<% if(VolunteerBoardService.DELETE_NO.equals(bc.getDeleteYn())) { %>
					<span class="pl-5"><%= bc.getContent() %></span>
<% if(removable){ %><button type="button" class="btn btn-delete btn-danger float-right btn-sm ml-2" value="<%= bc.getNo() %>">삭제</button><% } %>
<% 
	} 
	else {
%>
					<span class="pl-5">삭제된 답변입니다.</span>
<%
	}
%>
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
<%-- 관리자나 게시글 작성자만 신청자의 개인정보 확인 가능 --%>				      
<% if(editable) {%>
				      <td><%= va.getMemberName() %></td>
				      <td><%= va.getPhone() %></td>
				      <td><%= va.getEmail() %></td>
<% } else { %>
					  <td><%= va.getMemberName().charAt(0) %>*<%= va.getMemberName().charAt(va.getMemberName().length() -1) %></td>
				      <td><%= va.getPhone().substring(0, 3) %>-****-<%= va.getPhone().substring(va.getPhone().length() - 4, va.getPhone().length()) %></td>
				      <td><%= va.getEmail().substring(0, 2) %>****@<%= va.getEmail().substring(va.getEmail().indexOf("@") + 1, va.getEmail().indexOf("@") + 3) %>******</td>
<% } %>
				      <td><%= va.getRegDate() %></td>
				      <td>
<%-- 봉사 게시글 작성자만 승인여부 권한 부여 --%>
<% if(_member != null && _member.getMemberId().equals(board.getWriter())) {%>
<%-- 승인 클릭 시 승인하시겠습니까? 물어보고 확인 누르면 승인 상태 변함 --%>
<%-- 반대로 승인 상태에서 미승인 누르면 미승인 하시겠습니까? 물어보고 확인 누르면 미승인 상태로 변함 --%>
<%-- 이미 상태인것을 선택할 시에는 이미 승인 상태입니다. 이미 미승인 상태입니다 alert창 --%>
<%-- 승인상태(N/Y) 와 댓글번호 파라미터로 보내서 ?값 두개에다 넣기 --%>
	<% if(VolunteerBoardService.APPROVAL_YES.equals(va.getApprovalYn())) {%>
						<%-- 승인 여부를 위한 폼 태그 --%>
						<form
							name="volunteerApplicationApprovalFrm"
							action="<%=request.getContextPath() %>/volunteerApplication/applicationApproval"
							method="post">
   							<input type="hidden" name="no" value="<%= va.getNo() %>"/>
   							<input type="hidden" name="boardNo" value="<%= board.getNo() %>"/>
							<button type="button" class="application-yes btn btn-primary btn-sm already" value="승인">승인</button>
							<button type="submit" class="application-no btn btn-outline-primary btn-sm" name="approvalStatus" value="<%= VolunteerBoardService.APPROVAL_NO %>">미승인</button>
						</form>
	<% } else { %>
						<form
							name="volunteerApplicationApprovalFrm"
							action="<%=request.getContextPath() %>/volunteerApplication/applicationApproval"
							method="post">
   							<input type="hidden" name="no" value="<%= va.getNo() %>"/>
   							<input type="hidden" name="boardNo" value="<%= board.getNo() %>"/>
							<button type="submit" class="application-yes btn btn-outline-primary btn-sm" name="approvalStatus" value="<%= VolunteerBoardService.APPROVAL_YES %>">승인</button>
							<button type="button" class="application-no btn btn-primary btn-sm already" value="미승인">미승인</button>
						</form>
	<% } %>
<% } else { %>
				      
				      	<span class="bg-primary text-white small p-1 rounded">
				      	<%= VolunteerBoardService.APPROVAL_YES.equals(va.getApprovalYn()) ? "승인" : "미승인" %>
				      	</span>
<% } %>
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
<br /><br /><br />
<%-- 댓글삭제를 위한 폼 --%>
<form 
   action="<%= request.getContextPath() %>/volunteerBoard/boardCommentDelete" 
   name="volunteerBoardCommentDelFrm"
   method="POST">
   <input type="hidden" name="no" />
   <input type="hidden" name="boardNo" value="<%= board.getNo() %>"/>
</form>

<% if(adminEditable) {%>
<%-- 게시글 삭제를 위한 폼 --%>
<form action="<%= request.getContextPath() %>/volunteerBoard/boardDelete" name="deleteVolunteerBoardFrm">
	<input type="hidden" name="no" value="<%= board.getNo() %>" />
</form>
    
<script>

/**
 * 삭제할 때 저장된 첨부파일이 있다면, 파일삭제!
 * - java.io.File API
 */
//봉사 게시글 삭제 (삭제여부 변경 - 기존 이미지 파일은 삭제하기)
const deleteBoard = () => {
	// 수정은 괜찮은데 삭제는 되돌릴 수 없으므로 삭제기능에 confirm은 필수이다.
	if(confirm("정말 이 게시물을 삭제하시겠습니까?")){
		$(document.deleteVolunteerBoardFrm).submit();
	}
}
</script>
<% } %>

<script>
<% if(editable){ %>
// 봉사게시글 수정
// 실행코드가 한줄인경우 화살표함수 안에서 중괄호를 생략할 수 있다!
const updateBoard = 
() => location.href = "<%= request.getContextPath() %>/volunteerBoard/boardUpdate?no=<%= board.getNo() %>";
<% } %>

/**
 * 이미 승인 or 미승인 상태일 시 동일한 요구 클릭 시
 */
$(".already").click(function(e){
	alert(`이미 \${$(this).val()} 상태입니다.`);
});


/**
 * 댓글 삭제
 */
$(".btn-delete").click(function(e){
   //console.log(this);
   //console.log($(this).val());
   
   if(confirm("해당 댓글을 삭제하시겠습니까?")){
      var $frm = $(document.volunteerBoardCommentDelFrm);
      var no = $(this).val();
      $frm.find("[name=no]").val(no);
      $frm.submit();
   }
});


/**
 * 댓글 답글
 */
$(".btn-reply").click((e) => {
	const commentRef = $(e.target).val();
	const div = `<form 
		action="<%= request.getContextPath() %>/volunteerBoard/boardCommentEnroll" 
		name="volunteerBoardCommentFrm2"
		method="POST">
		<input type="hidden" name="commentLevel" value="2" />
		<input type="hidden" name="writer" value="<%= _member != null ? _member.getMemberId() : "" %>" />
		<input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
		<input type="hidden" name="commentRef" value="\${commentRef}" />
		
		<div class="row my-2">
			<div class="col-md-11">
				<textarea class="form-control" id="floatingTextarea" name="content"></textarea>
			</div>
			<div class="col-md-1">
				<button class="btn btn-primary h-100">등록</button>
			</div>
		</div>
	</form>`;
	
	const $parent = $(e.target).parent().parent();
	$(div).insertAfter($parent);
	$parent.parent().find("form[name=volunteerBoardCommentFrm2]").submit((e) => {
<% if(_member == null) {%>
			//로그인 하지 않았을 경우 발생
			loginAlert();
			return false; // return false없으면 loginAlert()띄우고 그냥 제출되버림 꼭 쓰기!
<% } %>

			// 내용검사
			const $textarea = $("[name=content]", e.target);	
			
			if(!/^(.|\n)+$/.test($textarea.val())){
				alert("댓글 내용을 작성해주세요.");
				$textarea.focus();
				return false;
			}
		})
		.find("[name=content]")
		.focus();
	
	// 현재버튼의 handler 제거
	$(e.target).off('click'); // 답글버튼 계속 누를때마다 폼 추가되는 것 막기 위해 핸들러 제거함
});


/**
 * 신청하기 모달 트리거 누를 때 _member null (로그인 하지 않은 경우) alert창 띄움 "로그인후 이용할 수 있습니다."
 * 이외에 모집인원 마감 시 alert창 띄움
 * 모달 남아있는 css 등 제거함(제거하지 않으면 화면 동작 못함)
 */
const applicationModal = () => {
	<% if(_member == null) {%>
	//로그인 하지 않았을 경우 발생
	loginAlert();
	// 모달창 숨기기(로그인 기능 구현되면 테스트 해보기 문제 있을 수도 있음)
	$('#applicationForm').hide();
	// 백그라운드 남아있는것 제거
	$('.modal-backdrop').remove();
	var el = document.body
	el.style = null;
	$('.modal-open').css({
		'overflow' : 'visible'
	});
<% } else if(board.getCapacity() <= applicationCnt){ %>
	alert("모집인원이 마감되었습니다.");
	// 모달창 숨기기(로그인 기능 구현되면 테스트 해보기 문제 있을 수도 있음)
	$('#applicationForm').hide();
	// 백그라운드 남아있는것 제거
	$('.modal-backdrop').remove();
	var el = document.body
	el.style = null;
	$('.modal-open').css({
		'overflow' : 'visible'
	});
<%
	} else {
%>
	$('#applicationForm').show();
<%
	}
%>
}


/**
* volunteerApplicationEnrollFrm 검사
*/
function volunteerApplicationValidate(e){
	// 이미 신청한 경우 신청버튼 누를 시 '이미 신청하신 상태입니다.' alert창 띄우기
<%
if(applicationList != null && !applicationList.isEmpty()) { // isEmpty()는 객체가 null로 되어있어 비는 것이 아닌 값이 존재하지 않는 상태이다.
	for(VolunteerApplicationExt va : applicationList) {
		if(_member != null && _member.getMemberId().equals(va.getApplicant())){
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


$(document.volunteerBoardCommentFrm).submit((e) => {
<% if(_member == null) {%>
	//로그인 하지 않았을 경우 발생
	loginAlert();
	return false; // return false없으면 loginAlert()띄우고 그냥 제출되버림 꼭 쓰기!
<% } %>

	// 내용검사
	// const textarea = $("[name=content]", document.volunteerBoardCommentFrm);	
	const $textarea = $("[name=content]", e.target);	
	
	if(!/^(.|\n)+$/.test($textarea.val())){
		alert("문의/답변 내용을 작성해주세요.");
		$textarea.focus();
		return false;
	}
});

const loginAlert = () => {
	alert("로그인후 이용할 수 있습니다.");
}

/* SNS공유  */
var thisUrl = document.URL;	// 현재 URL
var snsTitle = "<%=board.getTitle()%>";	// 전달할 타이틀
//트위터 공유
function shareTwitter() {
	// encodeURIComponent는 스크립트 내장함수로 인코딩하여 넘기는 방법입니다.
	var url = "http://twitter.com/share?url="+encodeURIComponent(thisUrl)+"&text="+encodeURIComponent(snsTitle); // 전달할 URL
	window.open(url);
}
//페북 공유 기능
function shareFacebook() {
	var url = "http://www.facebook.com/sharer/sharer.php?u="+encodeURIComponent(thisUrl); // 전달할 URL
    window.open(url);
}
//카카오 공유 기능
function shareKakao() {
	// 사용할 앱의 JavaScript 키 설정
	Kakao.init('81fc3c40931e5c23dfea9c79c1a7abc4');
	
	// 카카오링크 버튼 생성
	Kakao.Link.createDefaultButton({
		container: '#btnKakao', // 카카오공유버튼ID
	    objectType: 'feed',
	    content: {
	    	title: "<%=board.getTitle()%>", // 보여질 제목
	      	<%-- description: "<%=board.getContent()%>", // 보여질 설명 --%>
	      	//local 서버 내에 있는 이미지라 링크가 걸리지 않음. 임의 이미지 링크 걸어놓음.
	      	imageUrl: thisUrl, // 콘텐츠 URL
		      link: {
		         mobileWebUrl: thisUrl,
		         webUrl: thisUrl
		      }
	    	}
	  	});
	}


</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>