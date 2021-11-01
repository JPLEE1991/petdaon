<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<%
	AskBoard askBoard = (AskBoard) request.getAttribute("askBoard");
	/* boolean editable = loginMember != null && (
			  loginMember.getMemberId().equals(askBoard.getWriter())
			  || MemberService.ADMIN_ROLE.equals(loginMember.getMemberRole())
			); */
%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/serviceCenter/boardList.css"/> --%>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 매테리얼 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<style>

</style>

	<div class="container">
		<div class="row">
	
		</div>
	</div>
	
	<script>
	
	</script>
	
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>