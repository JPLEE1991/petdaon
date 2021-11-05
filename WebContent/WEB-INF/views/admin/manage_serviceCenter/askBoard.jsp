<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.service.AskBoardService"%>
<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>
<%
	List<AskBoard> list = (List<AskBoard>) request.getAttribute("list");
%>

<style>
.card {border-radius:.8rem;}
#asklist-container {margin:30px; padding:20px;}
#asklist {border:0; margin:0 auto; background-color:white; padding:15px 30px; top:-28.5%;}
.table tbody tr:hover {background-color:none; cursor:pointer;}
.table td {border-top:0px; padding:10px; text-align:center;}
.table td:last-child {font-size:13px; vertical-align:middle; color:#efbc1f;}
#inquirycontent {width:300px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; margin:0 auto; color:#8e929f;}
#btn {padding:30px 0; display:flex; justify-content:center; align-items:center;}
#btn a {display:flex; justify-content:center; align-items:center; text-decoration:none; border-radius:15%; margin:0 2px; color:#212529; width:35px; height:35px; background-color:#eceef2;}
#btn a.cPage {background-color:#ffd749;}
#btn a:hover {background-color:#ffd749;}
</style>

	<!--1:1문의 관리페이지 -->
			
	<!-- 회원 문의내역 -->
	<div id="asklist-container" class="container col-11 col-xxl-10">
		<div id="asklist" class="card col-12">
			<table class="table">
				<tbody>
				    <%
						for(AskBoard askBoard : list) {
					%>
					<tr id="ask" onClick="openView(<%= askBoard.getInquiryNo() %>)">
						<td>문의번호 : <%= askBoard.getInquiryNo() %></td>
						<td><%= askBoard.getInquiryTitle() %></td>
						<td><p class="d-none d-sm-block d-sm-none d-md-block d-md-none d-lg-block" id="inquirycontent"><%= askBoard.getInquiryContent() %></p></td>
						<td>
							<%=
								askBoard.getStatus().equals("D") ? "접수" :
								askBoard.getStatus().equals("C") ? "접수취소" :
								askBoard.getStatus().equals("I") ? "처리중" : "처리완료"
							%>
							<%-- <select class="status">
			            		<option
			            			value="<%= AskBoardService.D_STATUS %>"
			            			<%= AskBoardService.D_STATUS.equals(askBoard.getStatus()) ? "selected" : "" %>>접수</option>
			            		<option
			            			value="<%= AskBoardService.C_STATUS %>"
			            			<%= AskBoardService.C_STATUS.equals(askBoard.getStatus()) ? "selected" : "" %>>접수취소</option>
			            		<option
			            			value="<%= AskBoardService.I_STATUS %>"
			            			<%= AskBoardService.I_STATUS.equals(askBoard.getStatus()) ? "selected" : "" %>>처리중</option>
			            		<option
			            			value="<%= AskBoardService.F_STATUS %>"
			            			<%= AskBoardService.F_STATUS.equals(askBoard.getStatus()) ? "selected" : "" %>>처리완료</option>
			            	</select> --%>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		
		<!-- 페이징버튼 -->
		<div>
		    <div id="btn"><%= request.getAttribute("pagebar") %></div>
		</div>
	</div>
			
<script>
$(document).ready(function(){
	$("#main-title").text('1:1문의');
});

/* 각 문의 클릭하면 해당하는 상세페이지를 팝업창으로 제공한다. */
function openView(inquiryNo){
	const width = 400;
	const height = 450;
	const x = (screen.availWidth - width) / 2 + screen.availLeft;
	const y = (screen.availHeight - height) / 2 + screen.availTop;
	const url = '<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardView?inquiryNo=' + inquiryNo;
	open(url, 'popup', `width=\${width}, height=\${height}, left=\${x}, top=\${y}`);
};
</script>
			
<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>