<%@page import="java.util.List"%>
<%@page import="com.petdaon.mvc.bulletin_board.model.vo.BoardExt"%>
<%@page import="com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bulletin_board</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bulletin_board/board.css" />
<style>
.nav-item>a {
  	text-align:center;
  }
 .nav-item {
  	margin: 30px;
  }
 .btn-w {
	display: flex;
	justify-content:flex-end;
	margin-right:30px;
  }
</style>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<BulletinBoard> list = (List<BulletinBoard>) request.getAttribute("list");
%>

<section id="board-container">
	<h2>자유게시판</h2>
	<!-- animal icon nav -->
  <nav class="navbar navbar-expand-lg navbar-light container justify-content-end">
    <div class="collapse navbar-collapse justify-content-center">
      <ul class="navbar-nav">
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/all.png" width="70"; />
          <a class="nav-link" href="<%= request.getContextPath() %>/findMe_board/boardList">전체</a>
        </li>
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/pet.png" width="70";/>
          <a class="nav-link" href="#">강아지</a>
        </li>
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/cat.png" width="70"; />
          <a class="nav-link" href="#">고양이</a>
        </li>
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/pawprint.png" width="70"; />
          <a class="nav-link" href="#">자유</a>
        </li>
      </ul>
    </div>
  </nav>
	<table id="tbl-board">
		<tr>
			<th>번호</th>		
			<th>말머리</th>		
			<th>제목</th>	
			<th>작성자</th>	
			<th>작성일</th>
			<th>첨부파일</th>	
			<th>조회수</th>				
		</tr>
<%
	for(BulletinBoard board : list){		
%>
	<tr>
		<td><%= board.getNo() %></td>
		<td>
			<a href="<%= request.getContextPath() %>/bulletin_board/boardView?no=<%= board.getNo() %>"><%= board.getTitle() %></a>
		</td>
		<td><%= board.getTitle() %></td>
		<td><%= board.getWriter() %></td>
		<td><%= board.getRegDate() %></td>
		<td>
<% 
		if(board.getAttach() != null){
%>
				<img src="<%= request.getContextPath() %>/images/bulletin_board/file.png" width="16px" alt="" />	
<% 		
		} 
%>		
				
		</td>
		<td><%= board.getReadCount() %></td>
	</tr>
<%
	}
%>			
	</table>
	
	<div id='pageBar'><%= request.getAttribute("pageBar") %></div>
</section>
<br />


<div class="btn-w">
<input type="button" class="btn btn-outline-secondary" value="글쓰기" id="btn-add" onclick="location.href='<%= request.getContextPath() %>/views/bulletin_board/boardForm';" />
</div>

<br />
<br />
<br />
<br />
<br />

<%@ include file="/WEB-INF/views/common/footer.jsp" %>