<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>
<%
	List<VolunteerBoard> list = (List<VolunteerBoard>) request.getAttribute("list");
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
%>
<style>
form {
	margin-bottom : 0;
}
select {
	height:30px;
}
select option{
	font-size: 12px;
}
.form-select{
	font-size: 12px;
}

/* 테이블 overflow 설정 */
.table.table-ellipsis tbody td {
    max-width: 100px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

div#search-memberId {display: <%= searchType == null || "memberId".equals(searchType) ? "inline-block" : "none" %>;}
div#search-centerName{display: <%= "centerName".equals(searchType) ? "inline-block" : "none" %>;}
div#search-approvalStatus{display: <%= "approvalStatus".equals(searchType) ? "inline-block" : "none" %>;}

.form-control {
	padding: 0;
}
</style>

	<div class="container row" style="margin:0 auto;">
		<div class="col-md-12">
			<div id="search-container" class="d-flex justify-content-start">
		        <!-- 검색타입 :  -->
		        <select id="searchType" class="form-select form-select-sm" style="width:100px;">
		            <option value="memberId" <%= "memberId".equals(searchType) ? "selected" : "" %>>아이디</option>		
		            <option value="centerName" <%= "centerName".equals(searchType) ? "selected" : "" %>>센터명</option>
		            <option value="approvalStatus" <%= "approvalStatus".equals(searchType) ? "selected" : "" %>>승인여부</option>
		        </select>
		        <div id="search-memberId" class="search-type">
		            <form action="<%=request.getContextPath()%>/admin/volunteerBoardFinder">
		                <input type="hidden" name="searchType" value="memberId"/>
		                <%-- 사용자 입력값을 받을 부분 --%>
		                <input type="text" class="form-control w-auto d-inline-block" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." value="<%= "memberId".equals(searchType) ? searchKeyword : "" %>"/>
		                <button type="submit" class="btn btn-primary btn-sm">검색</button>			
		            </form>	
		        </div>
		        <div id="search-centerName" class="search-type">
		            <form action="<%=request.getContextPath()%>/admin/volunteerBoardFinder">
		                <input type="hidden" name="searchType" value="centerName"/>
		                <input type="text" class="form-control w-auto d-inline-block" name="searchKeyword" size="25" placeholder="검색할 센터명을 입력하세요." value="<%= "centerName".equals(searchType) ? searchKeyword : "" %>"/>
		                <button type="submit" class="btn btn-primary btn-sm">검색</button>			
		            </form>	
		        </div>
		        <div id="search-approvalStatus" class="search-type">
		            <form action="<%=request.getContextPath()%>/admin/volunteerBoardFinder">
		                <input type="hidden" name="searchType" value="approvalStatus"/>
		                <input type="radio" name="searchKeyword" value="N" <%= "approvalStatus".equals(searchType) && "N".equals(searchKeyword) ? "checked" : "" %>> 미승인
		                <input type="radio" name="searchKeyword" value="Y" <%= "approvalStatus".equals(searchType) && "Y".equals(searchKeyword) ? "checked" : "" %>> 승인
		                <input type="radio" name="searchKeyword" value="W" <%= "approvalStatus".equals(searchType) && "W".equals(searchKeyword) ? "checked" : "" %>> 승인보류
		                <button type="submit" class="btn btn-primary btn-sm">검색</button>
		            </form>
		        </div>
		    </div>
		</div>
	
		<div class="col-md-12">
			<!-- 테이블 -->
		  	<div class="table-responsive-xl">
			  	<table class="table table-ellipsis">
				  <thead>
				    <tr class="table-secondary">
				      <th scope="col">번호</th>
				      <th scope="col">센터명</th>
				      <th scope="col">작성자 ID</th>
				      <th scope="col">제목</th>
				      <th scope="col">등록일</th>
				      <th scope="col">상태</th>
				      <th scope="col">승인여부</th>
				    </tr>
				  </thead>
				  <tbody>
		<%
			int cnt = 0;
		if(list != null && !list.isEmpty()) { // isEmpty()는 객체가 null로 되어있어 비는 것이 아닌 값이 존재하지 않는 상태이다.
			for(VolunteerBoard board : list) {
		%>				    
				    <tr>
				      <th scope="row"><%= board.getNo() %></th>   
				      <td><%= board.getCenterName() %></td>
				      <td><%= board.getWriter() %></td>
				      <td><a href="<%= request.getContextPath() %>/volunteerBoard/boardView?no=<%= board.getNo() %>" class="link-dark" target="_blank"><%= board.getTitle() %></a></td> 
					  <td><%= board.getRegDate() %></td>
				      <td><%= VolunteerBoardService.ENROLL_YES.equals(board.getEnrollYn()) ? "접수" : "취소" %></td>
				      <td>
		<%-- 접수상태만 승인여부 선택 변경 가능 --%>
		<% if(VolunteerBoardService.ENROLL_YES.equals(board.getEnrollYn())) {%>
		<%-- 승인여부 select option --%>
						<select class="form-select approval-status" aria-label="Default select example" style="width:100px;" data-board-no="<%= board.getNo() %>">
						  <option value="<%= VolunteerBoardService.APPROVAL_NO %>" <%= VolunteerBoardService.APPROVAL_NO.equals(board.getApprovalYn()) ? "selected" : "" %>>미승인</option>
						  <option value="<%= VolunteerBoardService.APPROVAL_YES %>" <%= VolunteerBoardService.APPROVAL_YES.equals(board.getApprovalYn()) ? "selected" : "" %>>승인</option>
						  <option value="<%= VolunteerBoardService.APPROVAL_WAIT %>" <%= VolunteerBoardService.APPROVAL_WAIT.equals(board.getApprovalYn()) ? "selected" : "" %>>승인보류</option>
						</select>
		<% } else { %>
				      
				      	<span class="bg-primary text-white small p-1 rounded">접수취소</span>
		<% } %>
				      </td>
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
			<div style="text-align: center;">
				<div id="pageBar" class="d-inline-block">
					<%= request.getAttribute("pagebar") %>
				</div>
			</div>
		
		</div>
	
	</div>

	<%-- 승인 여부 변경을 위한 폼 태그 --%>
	<%-- 승인상태 미승인,승인,보류(N/Y/W)와 게시글번호 폼을이용하여 파라미터로 보내서 ?값 두개에다 넣는다. --%>
	<form
		name="volunteerBoardApprovalFrm"
		action="<%=request.getContextPath() %>/admin/volunteerBoardApproval"
		method="post">
			<input type="hidden" name="boardNo" />
			<input type="hidden" name="approvalStatus" />
	</form>

<script>
// main-title 변경
$(document).ready(function(){
	$("#main-title").text('봉사 승인');
})

// 수직 정렬을 위한 설정
$(document).ready(function(){
	$('#index').addClass('d-flex align-items-center');
})


// 검색타입 select 바뀔때마다 이벤트 발생
$("#searchType").change((e) => {
	// e.target 이벤트발생객체 -> #searchType
	const type = $(e.target).val(); // 선택된 검색타입
	console.log(type);
	
	// 1. .search-type 감추기
	$(".search-type").hide();
	
	// 2. #search-${type} 보여주기(display:inline-block)
	$(`#search-\${type}`).css("display", "inline-block"); // show()로 그냥 하면 문제는 그 해당태그의 원래 display속성으로 보여주게 되서 줄바꿈이 일어나므로 show() 이용하지 않음.
	
});

//승인여부 select 바뀔때마다 이벤트발생
$(".approval-status").change((e) => {
	const $this = $(e.target);
	const boardNo = $this.data("boardNo"); // 게시글번호 // data-속성의 키값을 camelcasing으로 처리
	const approvalStatus = $this.val(); // 지금 선택된 값 가져옴
	//console.log(approvalStatus);
	
	// msg부분을 위한 str 생성
	let str = "";
	if(approvalStatus == "<%= VolunteerBoardService.APPROVAL_NO %>") {
		str = "미승인";
	} else if(approvalStatus == "<%= VolunteerBoardService.APPROVAL_YES %>") {
		str = "승인";
	} else {
		str = "승인보류";
	}
	
	// jsp의 EL문법과 js의 String Template 충돌. escaping처리 할것.
	const msg = `[\${str}]으로 변경하시겠습니까?`;
	if(confirm(msg)){
		// 사용자가 OK하면 해당 폼을 제출한다. 아이디값 권한값 채움.
		const $frm = $(document.volunteerBoardApprovalFrm);
		$frm.find("[name=boardNo]").val(boardNo);
		$frm.find("[name=approvalStatus]").val(approvalStatus);
		$frm.submit();
	}
	else {
		// 취소하는 경우
		// 초기값으로 복귀
		// $this.find("[selected]") -> 현재 셀렉트 태그에 원래 selected된 얘를 찾는다. selected 속성이 있는.
		// 그러고 걔의 .prop("selected", true) 을 이용하여 selected속성을 true로 해주세요. 초기값으로 복귀한다.
		// prop()는 속성의 값을 true 혹은 false 로 반환합니다.
		// prop속성은 html의 태그를 js로 제어하는 것이라서 true false로 처리합니다.
		// 원래 selected속성을 찾은다음에 다시 selected 처리하고 있다. find 부분 이건원래 html에 inline으로 작성된 속성을 찾는것이고 .prop으로 자바스크립트 제어함.
		// 구글링 찾은 내용 참고 -> .prop()는 지정한 선택자를 가진 첫번째 요소의 속성값을 가져오거나 속성값을 추가합니다. 주의할 점은 HTML 입장에서의 속성(attribute)이 아닌 JavaScript 입장에서의 속성(property)이라는 것입니다.
		$this.find("[selected]").prop("selected", true); // 이 코드가 없으면 바뀐 값으로 남아있을 텐데 기존 선택된 요소 selected가 있는 태그를 찾아서 실제 처리를 해주었다. 다시한번 selected true처리를 해줌. 
	}
});

</script>

<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>