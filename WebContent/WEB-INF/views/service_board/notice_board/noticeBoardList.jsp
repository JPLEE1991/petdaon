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
.table td {border-top:0px; padding:30px; text-align:left;} /*  */
.table td:last-child {font-size:13px; vertical-align:middle; text-align:right;} /*  */
.table tbody tr:hover {background-color:#FAFAFA;}
.card {border-radius:.8rem;}
#breadcrumb {border:0; margin:0 auto; background-color:#eeeeee; height:300px;}
#breadcrumb nav {padding:30px 15px; font-size:18px;}
#breadcrumb nav li a.nav-link {color:black;}
#noticelist-container {height:700px;}
#noticelist {border:0; margin:0 auto; background-color:white; padding:15px 30px; top:-29.5%;}
#btn {text-align:center; padding:30px 0;}
#btn span.cPage {color:black; padding:6px 12px; background-color:#FFD749; border-radius:15%;}
#btn a {color:black; text-decoration:none; padding:6px 12px; background-color:#eeeeee; border-radius:15%;}
#btn a:hover {background-color:#FFD749;}
</style>
	
	<div class="container">
		<div class="row">
		
			<h2>고객센터</h2>
			
			<!-- 사용자경로 -->
			<div id="breadcrumb" class="card col-11 col-xxl-10 position-relative">
				<nav class="navbar navbar justify-content-start">
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
					<table class="table table-hover">
						<tbody>
						    <%
						    	for(NoticeBoard noticeBoard : list) {
							%>
							<tr>
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
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>