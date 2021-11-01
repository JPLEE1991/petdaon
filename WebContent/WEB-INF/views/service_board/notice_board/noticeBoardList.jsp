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
.card {border-radius:.8rem;}
#breadcrumb {border:0; margin:0 auto; background-color:#eceef2;; height:300px;}
#breadcrumb nav {padding:30px 15px; font-size:18px;}
#breadcrumb nav li a.nav-link {color:black;}
#noticelist-container {height:700px;}
#noticelist {height:899px; border:0; margin:0 auto; background-color:white; padding:15px 30px; top:-28.5%;}
.table tbody tr:hover {background-color:none; cursor:pointer;}
.table td {border-top:0px; padding:30px; text-align:left;} /*  */
.table td:last-child {font-size:13px; color:#8e929f; vertical-align:middle; text-align:right;} /*  */
#btn {text-align:center; padding:30px 0;}
#btn span.cPage {color:#212529; display:inline-block; width:35px; height:35px; line-height:35px; vertical-align:middle; background-color:#ffd749; border-radius:15%;}
#btn a {color:#212529; text-decoration:none; display:inline-block; width:35px; height:35px; line-height:35px; vertical-align:middle; background-color:#eceef2; border-radius:15%;}
#btn a:hover {background-color:#ffd749;}
</style>
	
	<div class="container">
		<div class="row">
		
			<h2>고객센터</h2>
			
			<!-- 사용자경로 -->
			<div id="breadcrumb" class="card col-11 col-xxl-10 position-relative">
				<nav class="navbar justify-content-start">
					<li class="nav-item">
				       <a class="nav-link" href="<%= request.getContextPath() %>/serviceCenter">고객센터</a>
				    </li>
				    <span class="material-icons">chevron_right</span>
				    <li class="nav-item">
				       <a class="nav-link" href="#">공지사항</a>
				    </li>
				</nav>
			</div>
			
			<!-- 공지사항 -->
			<div id="noticelist-container" class="container col-11 col-xxl-10">
				<div id="noticelist" class="card col-11 position-absolute start-50 translate-middle-x">
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
			</div>
			
			<!-- 페이징버튼 -->
			<div>
			    <div id="btn"><%= request.getAttribute("pagebar") %></div>
			</div>
			
		</div>
	</div>
	
	<br/><br/><br/><br/><br/><br/>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>