<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.petdaon.mvc.member.model.vo.Member,
				java.util.List"%>
<%
List<Member> list = (List<Member>)request.getAttribute("list");
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

.form-control {
	padding: 0;
}
    </style>
    <script type="text/javascript">
    </script>

<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>

	<div class="col-md-12">
	<!-- 테이블 -->
	<div class="table-responsive-xl">
		<table class="table table-ellipsis">
			<thead>
				<tr class="table-secondary">
					<th scope="col">아이디</th>
					<th scope="col">이름</th>
					<th scope="col">회원권한</th>
					<th scope="col">휴대폰</th>
					<th scope="col">가입일</th>
					<th scope="col">상태</th>
					<th scope="col">경고횟수</th>
				</tr>
			</thead>
			<tbody>
							<%
							for (int i = 0; i < list.size(); i++) {
								Member member = list.get(i);
							%>
							<tr>
								<td>
									<a href="<%=request.getContextPath()%>/admin/adminmemberDetail?memberId=<%=member.getMemberId() %>"><%=member.getMemberId() %></a>
								</td>
								<td>
									<a href="<%=request.getContextPath()%>/admin/adminmemberDetail?memberId=<%=member.getMemberId() %>"><%=member.getMemberName() %></a>
								</td>
								<td><%=member.getMemberRole() %></td>
								<td><%=member.getPhone() %></td>
								<td><%=member.getEnroll_date() %></td>
								<td><%=member.getStatus() %></td>
								<td><%=member.getWarning_count() %></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				
	
	<!-- 페이징버튼 -->
	<div style="text-align: center;">
		<div id="pageBar" class="d-inline-block">
			<%= request.getAttribute("pagebar") %>
		</div>
	</div>
</div>


<script src="<%=request.getContextPath()%>/resource/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>


<br><br><br><br><br><br><br><br><br><br><br>




<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>

