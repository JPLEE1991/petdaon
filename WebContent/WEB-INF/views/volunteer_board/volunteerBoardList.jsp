<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />

	<div class="container">
		<h2>봉사게시판</h2>
		<button type="button" class="btn btn-primary" onclick="location.href='<%= request.getContextPath() %>/volunteerBoard/boardForm';">등록하기</button>
	</div>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>