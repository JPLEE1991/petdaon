<%@page import="com.petdaon.mvc.member.model.service.MemberService"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/member/mypageHeader.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
<%
	List<VolunteerBoard> list = (List<VolunteerBoard>) request.getAttribute("list");
%>
<style>
/* 테이블 overflow 설정 */
.table.table-ellipsis th, .table.table-ellipsis tbody td {
    max-width: 100px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.set {
	max-height: 640px;
	overflow: auto;
}

/* input부분 효과 지우기 */
.form-control[readonly]{
	background-color: white;
}

.form-control:focus {
	box-shadow: none;
	border-color: #ced4da;
}


</style>
	
	<h3>봉사 등록 확인</h3>
	<hr />
	
	<div class="col-md-12">
			<!-- 테이블 -->
		  	<div class="table-responsive-xl set">
			  	<table class="table table-ellipsis">
				  <thead>
				    <tr class="table-secondary">
				      <th scope="col">번호</th>
				      <th scope="col">상태</th>
				      <th scope="col">등록번호</th>
				      <th scope="col">등록일</th>
				      <th scope="col">봉사 시작일</th>
				      <th scope="col">봉사 종료일</th>
				      <th scope="col">제목(상세보기)</th>
				    </tr>
				  </thead>
				  <tbody>
		<%
			int cnt = 0;
		if(list != null && !list.isEmpty()) { // isEmpty()는 객체가 null로 되어있어 비는 것이 아닌 값이 존재하지 않는 상태이다.
			for(VolunteerBoard board : list) {
		%>				    
				    <tr>
				      <th scope="row"><%= ++cnt %></th>
				      <td><%= VolunteerBoardService.APPROVAL_NO.equals(board.getApprovalYn()) ? "미승인" : VolunteerBoardService.APPROVAL_YES.equals(board.getApprovalYn()) ? "승인" : "승인보류"%></td>
				      <td><%= board.getNo() %></td>  
		<% if(VolunteerBoardService.DELETE_YES.equals(board.getDeleteYn())) { %>
					  <td colspan="4" class="text-center">관리자에 의해 삭제된 게시물입니다.</td>
		<% } else {%>     
					  <td><%= board.getRegDate() %></td>
					  <td><%= board.getStartDate() %></td>
					  <td><%= board.getEndDate() %></td>
					  <%-- a태그 클릭 시 show함수 호출됨. show함수 호출할 때 게시글 번호를 넣어 보낸다.--%>
					  <td><a href="" class="link-dark" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="show('<%= board.getNo() %>')"><%= board.getTitle() %></a></td>
				      <%-- <td><a href="<%= request.getContextPath() %>/volunteerBoard/boardView?no=<%= board.getNo() %>" class="link-dark" target="_blank"><%= board.getTitle() %></a></td> --%>
		<% } %>
				    </tr>
		<%
			}
		}
		else {
		%>
					<tr>
				      <td colspan="7" class="text-center">게시글이 존재하지 않습니다.</td>
				    </tr>
		<%
		}
		%>
				  </tbody>
				</table>
			</div>
		
		</div>
		
		 <!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-scrollable">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">봉사 등록 번호 : <span class="no"></span><span class="status-cancle text-danger ml-2">[접수취소]</span></h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <div class="row">
		        	<div class="col-md-12">
		        		<div class="input-group">
						  <span class="input-group-text">제목</span>
						  <input type="text" aria-label="First name" class="form-control title" readonly>
						</div>
		        	</div>
		        	<div class="col-md-12">
		        		<div class="input-group">
						  <span class="input-group-text">센터명</span>
						  <input type="text" aria-label="First name" class="form-control center-name" readonly>
						</div>
		        	</div>
		        	<div class="col-md-12">
		        		<div class="input-group">
						  <span class="input-group-text">등록일</span>
						  <input type="text" aria-label="First name" class="form-control reg-date" readonly>
						</div>
		        	</div>
		        	<div class="col-md-6">
		        		<div class="input-group">
						  <span class="input-group-text">시작일</span>
						  <input type="text" aria-label="First name" class="form-control start-date" readonly>
						</div>
		        	</div>
		        	<div class="col-md-6">
		        		<div class="input-group">
						  <span class="input-group-text">종료일</span>
						  <input type="text" aria-label="First name" class="form-control end-date" readonly>
						</div>
		        	</div>
		        	<div class="col-md-6">
		        		<div class="input-group">
						  <span class="input-group-text">모집인원</span>
						  <input type="text" aria-label="First name" class="form-control capacity" readonly>
						</div>
		        	</div>
		        	<div class="col-md-6">
		        		<div class="input-group">
						  <span class="input-group-text">마감일</span>
						  <input type="text" aria-label="First name" class="form-control deadline-date" readonly>
						</div>
		        	</div>
		        	<div class="col-md-12">
		        		<div class="input-group">
						  <span class="input-group-text">봉사시간</span>
						  <input type="text" aria-label="First name" class="form-control time" readonly>
						</div>
		        	</div>
		        	<div class="col-md-12">
		        		<div class="input-group">
						  <span class="input-group-text">봉사요일</span>
						  <input type="text" aria-label="First name" class="form-control day" readonly>
						</div>
		        	</div>
		        	<div class="col-md-12">
		        		<div class="input-group">
						  <span class="input-group-text">장소</span>
						  <input type="text" aria-label="First name" class="form-control place" readonly>
						</div>
		        	</div>
		        	<div class="col-md-12">
		        		<div class="input-group">
						  <span class="input-group-text">이메일</span>
						  <input type="text" aria-label="First name" class="form-control email" readonly>
						</div>
		        	</div>
		        	<div class="col-md-12">
		        		<div class="input-group">
						  <span class="input-group-text">휴대폰</span>
						  <input type="text" aria-label="First name" class="form-control phone" readonly>
						</div>
		        	</div>
		        	<div class="col-md-12">
						  <span class="input-group-text">내용</span>
						  <span class="form-control contents"></span>
						</div>
		        	</div>
		        </div>
			    <div class="modal-footer">
			    	
			    	<%-- 접수취소를 위한 폼 --%>
					<form 
					   action="<%= request.getContextPath() %>/volunteerBoard/boardCancle" 
					   name="volunteerBoardCancleFrm"
					   method="POST">
					   <input type="hidden" name="board-no"/>
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="submit" class="btn btn-danger cancle">접수취소</button>
				        <button type="button" class="btn btn-primary move" onclick="newPage();">게시판으로 이동</button>
					</form>
			    	
			    </div>
		      </div>
		    </div>
		  </div>

		<br /><br /><br />
<script>
// 제목을 클릭하면 show실행됨.
function show(boardNo){
	// 호출 시 넘겨준 값을 이용하여 ajax를 통해 modal을 띄울 때 동적으로 바뀌어야 하는 값을 얻어온다.
	// ajax를 이용하여 게시글번호를 보내고 board를 받아온다음 정보를 넣어준다.
	$.ajax({
		// 게시글 번호 보냄
		url: "<%= request.getContextPath() %>/volunteerBoard/selectOne?boardNo=" + boardNo,
		success(data){
			console.log(data);
			const {no, title, centerName, content, startDate, endDate, email, phone, approvalYn, deleteYn, capacity, place, deadlineDate, regDate, time, day, boardCode, writer, enrollYn} = data;
			// 얻어온 값을 이용하여, modal에서 동적으로 바뀌어야 하는 값을 바꾸어 준다.
			$(".no").html(`\${no}`);
			$(".title").val(`\${title}`);
			$(".center-name").val(`\${centerName}`);
			$(".reg-date").val(`\${regDate}`);
			$(".start-date").val(`\${startDate}`);
			$(".end-date").val(`\${endDate}`);
			$(".capacity").val(`\${capacity}`);
			$(".deadline-date").val(`\${deadlineDate}`);
			$(".time").val(`\${time}`);
			$(".day").val(`\${day}`);
			$(".place").val(`\${place}`);
			$(".email").val(`\${email}`);
			$(".phone").val(`\${phone}`);
			$(".contents").html(`\${content}`);
			
			<%--모달폼에서 등록취소(승인된 게시글은 나오지 않음 - 이건 값받아와서 이값이면(enroll상태가 N일경우 버튼 만들어놓고 제거하는 기능 추가하거나 하자)와 게시판으로 이동(이건 승인된 게시글만 보이게끔 만들기 - 마찬가지로 approval상태에 따라 하기 왼쪽글참고)
			승인된 게시판은 '게시판으로 이동' 버튼이 보이며 클릭 시 게시판으로 이동한다.(게시글 번호 이용함) --%>
			if("<%= VolunteerBoardService.APPLICATION_YES %>" == approvalYn) {
				<%-- 승인일 경우 '게시판으로 이동' 버튼 show() --%>
				// 아래 newPage() 함수에서 이용하기 위해 값을 집어넣음.
				$(".move").val(`\${no}`);
				$(".move").show();
			}
			else {
				<%-- 승인이 아닐 경우 '게시판으로 이동' 버튼 hide() --%>
				$(".move").hide();
			}
			
			<%-- 접수취소를 위한 준비. 미승인인 경우 접수취소가 가능하며 접수취소 버튼 클릭 시 volunteerBoardCancleFrm 폼 제출 한다.--%>
			// hidden으로 된 input태그 게시글 번호 넣음
			$("input[name=board-no]").val(`\${no}`);
			<%-- if("<%= VolunteerBoardService.APPLICATION_NO %>" == approvalYn && "<% VolunteerBoardService.ENROLL_YES %>" == enrollYn) { --%>
			if("<%= VolunteerBoardService.APPLICATION_NO %>" == approvalYn && "<%= VolunteerBoardService.ENROLL_YES %>" == enrollYn) {
				<%-- 미승인이면서 접수상태인 경우 '접수 취소' 버튼 show() --%>
				$('.cancle').show();
			} else {
				<%-- 미승인이 아닐 경우 '접수 취소' 버튼 hide() --%>
				$('.cancle').hide();
			}
			
			<%-- 이미 접수취소인 경우 접수취소 문구가 상단에 보인다. --%>
			if("<%= VolunteerBoardService.ENROLL_NO %>" == enrollYn) {
				$('.status-cancle').show();
			} else {
				$('.status-cancle').hide();
			}
			
		},
		error: console.log
	});
	
	// modal을 띄워준다.
	$(".modal").modal('show');
}

<%-- '게시판으로 이동'클릭 시 넘어감--%>
function newPage()  {
	  window.location.href = '<%= request.getContextPath() %>/volunteerBoard/boardView?no=' + $(".move").val();
	};

</script>

<%@ include file="/WEB-INF/views/member/mypageFooter.jsp" %>