<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.petdaon.mvc.member.model.vo.Member,
				java.util.List"%>
<%
List<Member> list = (List<Member>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html lang="en">
	<head> 
<title>회원관리</title>
 	<style>
    </style>
    <script type="text/javascript">
    </script>
	</head>
 	<body>
<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>

	
	<div class="container-fluid" >
	
	<div class="join-title"><h2>회원목록(<%=list.size() %>)</h2></div>
	<div class="row">
		<div class="col-sm-10 col-sm-offset-1">
			<div class="panel panel-default">
				<div class="panel-body">
					<table>
						<tbody>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>회원권한</th>
								<th>휴대폰번호</th>
								<th>가입일</th>
								<th>상태</th>
								<th>경고횟수</th>
							</tr>
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
			</div>
		</div>
	</div>
	
	
	<!-- 페이징버튼 -->
	<div>
	    <div id="btn"><%= request.getAttribute("pagebar") %></div>
	</div>
			
	</div>



<script src="<%=request.getContextPath()%>/resource/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>


</body>
</html>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>




<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>

