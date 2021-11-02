<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>
<%
	List<VolunteerBoard> list = (List<VolunteerBoard>) request.getAttribute("list");
%>
<h3>글이다다다다다다</h3>

<script>
$(document).ready(function(){
	$("#main-title").text('봉사 승인');
})
</script>

<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>