<%@page import="com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<NoticeBoard> list = (List<NoticeBoard>) request.getAttribute("list");
%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/serviceCenter/boardList.css"/> --%>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 매테리얼 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<style>
h2 {padding:30px; margin:0 auto; text-align:center;}
.card {border-radius:.5rem;}
.material-icons {font-size:16px;}
#inquiry-container {padding:25px; margin-top:20px; border:0; background-color:#eceef2;}
#inquiry-container p:first-child {padding-bottom:25px; margin:0; font-size:18px;}
#inquiry-container .card {border:0;}
#inquiry-card .card-body {padding:20px;}
#inquiry-card a {padding-top:10px; display:flex; align-items:center; text-decoration:none; color:#212529;}
#inquiry-card a:hover {}
#inquiry-card p {padding:10px 0; font-size:15px; color:#8e929f;}
#notice-text {margin-top:50px; margin-bottom:10px; font-size:15px;}
#noticelist {margin:0 auto; background-color:white; padding:10px 20px;}
#noticelist table {margin:0;}
.table tbody tr:hover {background-color:none; cursor:pointer;}
.table tbody tr:last-child td {border-bottom:0px;}
.table td {border-top:0px; padding:20px; text-align:left;}
.table td:last-child {font-size:13px; color:#8e929f; vertical-align:middle; text-align:right;}
#btnbar {border:1px solid rgba(0,0,0,.125); border-radius:.5rem; display:flex; justify-content:center; align-items:center; padding:15px; margin:0 auto; margin-top:10px;}
#btnbar:focus {background-color:#eceef2; box-shadow:none;}
</style>

	<!-- 문의 -->
    <div class="container">
    	<div class="row">
    
    		<h2>고객센터</h2>
    
	    	<div id="inquiry-container" class="container card col-10 col-xxl-9">
		    	<p class="card-text">안녕하세요, 도움이 필요하신가요?</p>
		    
		    	<div id="inquiry-card" class="row row-cols-2">
			    	<!-- 1:1문의 -->
				    <div class="col-6">
					    <div class="card">
						  <div class="card-body">
						    <a href="<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardForm">1:1문의<span class="material-icons">chevron_right</span></a>
						    <p class="card-text">질문을 남겨주시면<br/>꼼꼼히 확인하고 답변 드리겠습니다.</p>
						  </div>
						</div>
				    </div>
					<!-- 문의내역 -->
					<div class="col-6">
						<div class="card">
						  <div class="card-body">
						    <a href="<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardList">나의 문의내역<span class="material-icons">chevron_right</span></a>
						    <p class="card-text">나의 문의내역에서는<br/>1:1문의 내역을 확인할 수 있습니다.</p>
						  </div>
						</div>
					</div>
		    	</div>
			
		    </div>
		    
		    <!-- 공지사항 -->
		    <p id="notice-text" class="container col-10 col-xxl-9">공지사항</p>
			<div id="noticelist" class="container card col-10 col-xxl-9">
				<table class="table">
					<tbody>
					    <%
					    	for(NoticeBoard noticeBoard : list) {
						%>
						<tr onClick="location.href='<%= request.getContextPath() %>/serviceCenter/noticeBoard/noticeBoardView?no=<%= noticeBoard.getNo() %>'">
							<td><%= noticeBoard.getNo() %> &nbsp &nbsp &nbsp <%= noticeBoard.getTitle() %></td>
							<td><%= noticeBoard.getEnrollDate() %></td>
						</tr>
						<%
					    	}
						%>
					</tbody>
				</table>
			</div>
		    
		    <!-- 공지사항 더보기 -->
			<a id="btnbar" class="btn col-10 col-xxl-9" href="<%= request.getContextPath() %>/serviceCenter/noticeBoard/noticeBoardList">공지사항 더보기&nbsp<span class="material-icons">chevron_right</span></a>
		    
    	</div>
    </div>
    
	<br/><br/><br/><br/><br/><br/>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>