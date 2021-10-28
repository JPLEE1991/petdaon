<%@page import="com.petdaon.mvc.findMe_board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "java.io.File"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%
	Board board = (Board) request.getAttribute("board");
%>
<div class="container">
	<h2>나를 찾아줘</h2>
		<div class="row">
			<div class="col">
				<p><%= board.getNo() %></p>
				<p><%= board.getTitle() %></p>
			</div>
			
			<div class="col">
				<p><%= board.getWriter() %></p>
				<% 	if(board.getAttach() != null){ %>
				<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
				<img alt="첨부파일" src="<%= request.getContextPath() %>/upload/findMe_board/<%= board.getAttach().getRenamedFilename() %>" >
				<a href="<%= request.getContextPath() %>/board/fileDownload?no=<%= board.getAttach().getNo() %>"><%= board.getAttach().getOriginalFilename() %></a>
				<% 	} %>		
			</div>
			<div class="col">
				<p><%= board.getContent() %></p>
			</div>
		</div>

</div>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
