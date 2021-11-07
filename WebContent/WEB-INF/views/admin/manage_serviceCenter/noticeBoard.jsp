<%@page import="com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>
<%
	List<NoticeBoard> list = (List<NoticeBoard>) request.getAttribute("list");
%>

<style>
.card {border-radius:.8rem;}
#noticelist-container {margin:30px; padding:20px;}
#noticelist {border:0; margin:0 auto; background-color:white; padding:15px 30px; top:-28.5%;}
.table tbody tr:hover {background-color:none; cursor:pointer;}
.table td {border-top:0px; padding:10px; text-align:left;}
.table td:last-child {font-size:13px; color:#8e929f; vertical-align:middle; text-align:right;}
#btn {padding:30px 0; display:flex; justify-content:center; align-items:center;}
#btn a {display:flex; justify-content:center; align-items:center; text-decoration:none; border-radius:15%; margin:0 2px; color:#212529; width:35px; height:35px; background-color:#eceef2;}
#btn a.cPage {background-color:#ffd749;}
#btn a:hover {background-color:#ffd749;}
#btn-enroll {border:1px solid rgba(0,0,0,.125); border-radius:.5rem; display:flex; justify-content:center; align-items:center; padding:9px; margin:0 auto;}
#btn-enroll:focus {background-color:#eceef2; box-shadow:none;}
</style>

	<!--공지사항 관리페이지 -->
			
	<!-- 공지내역 -->
	<div id="noticelist-container" class="container col-11 col-xxl-10">
		<div id="noticelist" class="card col-11">
			<table class="table">
				<tbody>
				    <%
				    	for(NoticeBoard noticeBoard : list) {
					%>
					<tr id="notice" onClick="openView(<%= noticeBoard.getNo() %>)">
						<td><%= noticeBoard.getNo() %> &nbsp &nbsp &nbsp <%= noticeBoard.getTitle() %></td>
						<td><%= noticeBoard.getEnrollDate() %></td>
					</tr>
					<%
				    	}
					%>	
				</tbody>
			</table>
			<a id="btn-enroll" class="btn col-12" href="<%= request.getContextPath() %>/admin/noticeBoard/noticeBoardForm">등록</a>
		</div>
		
		<!-- 페이징버튼 -->
		<div>
		    <div id="btn"><%= request.getAttribute("pagebar") %></div>
		</div>
	</div>
			
<script>
$(document).ready(function(){
	$("#main-title").text('공지사항');
});

function openView(no){
	const width = 450;
	const height = 450;
	const x = (screen.availWidth - width) / 2 + screen.availLeft;
	const y = (screen.availHeight - height) / 2 + screen.availTop;
	const url = '<%= request.getContextPath() %>/admin/noticeBoard/noticeBoardView?no=' + no;
	open(url, 'popup', `width=\${width}, height=\${height}, left=\${x}, top=\${y}`);
};
</script>
			
<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>