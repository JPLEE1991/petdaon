<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerApplicationExt"%>
<%@page import="com.petdaon.mvc.member.model.service.MemberService"%>
<%@page import="com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/member/mypageHeader.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
<%
	List<VolunteerApplicationExt> list = (List<VolunteerApplicationExt>) request.getAttribute("list");
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

</style>
	
	<h3>봉사 신청 확인</h3>
	<hr />
	
	<div class="col-md-12">
			<!-- 테이블 -->
		  	<div class="table-responsive-xl set">
			  	<table class="table table-ellipsis">
				  <thead>
				    <tr class="table-secondary">
				      <th scope="col">번호</th>
				      <th scope="col">승인여부</th>
				      <th scope="col">신청번호</th>
				      <th scope="col">신청일</th>
				      <th scope="col">봉사명(상세보기)</th>
				    </tr>
				  </thead>
				  <tbody>
		<%
			int cnt = 0;
		if(list != null && !list.isEmpty()) { // isEmpty()는 객체가 null로 되어있어 비는 것이 아닌 값이 존재하지 않는 상태이다.
			for(VolunteerApplicationExt va : list) {
		%>				    
				    <tr>
				      <th scope="row"><%= ++cnt %></th>
				      <td><%= VolunteerBoardService.APPROVAL_NO.equals(va.getApprovalYn()) ? "미승인" : "승인"%></td>
				      <td><%= va.getNo() %></td>  
				      <td><%= va.getRegDate() %></td>
				      <td><a href="<%= request.getContextPath() %>/volunteerBoard/boardView?no=<%= va.getBoardNo() %>" class="link-dark" target="_blank"><%= va.getTitle() %></a></td> 
				    </tr>
		<%
			}
		}
		else {
		%>
					<tr>
				      <td colspan="5" class="text-center">게시글이 존재하지 않습니다.</td>
				    </tr>
		<%
		}
		%>
				  </tbody>
				</table>
			</div>
		
		</div>
		

		<br /><br /><br />
<script>

</script>

<%@ include file="/WEB-INF/views/member/mypageFooter.jsp" %>