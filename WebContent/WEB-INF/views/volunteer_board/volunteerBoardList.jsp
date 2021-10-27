<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<VolunteerBoard> list = (List<VolunteerBoard>) request.getAttribute("list");
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
<!-- fullcalender -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/fullcalendar-5.10.0/main.css" />
<script src="<%=request.getContextPath()%>/js/fullcalendar-5.10.0/main.js"></script>
<!--  -->

	<div class="container">
		<h3>봉사게시판</h3>
		<button type="button" class="btn btn-primary" onclick="location.href='<%= request.getContextPath() %>/volunteerBoard/boardForm';">등록하기</button>
		<div id="calendar"></div>
	</div>
	
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	
	
<script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth'
        });
        calendar.render();
      });
      
    //페이지 로딩시, 봉사 게시글 전체 달력에 넣기
  	<%-- $.ajax({
  		url: "<%= request.getContextPath() %>/volunteerBoard/boardList",
  		success(data){
  			$(celebName).append(`<option value=''>Celeb 선택</option>`)
  			$(data).each((i, celeb) => {
  				const {name} = celeb; // 구조분해 할당... 복습하기
  				$(celebName).append(`<option value='\${name}'>\${name}</option>`)
  			});
  		},
  		error: console.log
  	}); --%>

</script>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>