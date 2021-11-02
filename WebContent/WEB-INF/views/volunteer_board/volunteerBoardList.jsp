<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%-- <%
	List<VolunteerBoard> list = (List<VolunteerBoard>) request.getAttribute("list");
%>
 --%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<!-- fullcalender -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/fullcalendar-5.10.0/main.css" />
<script src="<%=request.getContextPath()%>/js/fullcalendar-5.10.0/main.js"></script>
<style>
	/* 봉사 제목 앞에 뜨는 시간 숨기기 */
	.fc-event-time{
		display:none;
	}
</style>
<!--  -->

	<div class="container">
		<div class="row">
			<div class="col-md-12 mb-2">
				<h3 class="float-left">봉사게시판</h3>
				<%-- 로그인 한 사람만 등록하기 버튼 가능하게 이후에 수정하기 로그인안했으면 로그인 후 이용가능하는 alert창 띄우기(로그인 페이지 이동은 생략하자. 호기심에 눌렀을 수도 있으니) --%>
				<button type="button" class="btn btn-primary float-right enroll-btn" onclick="location.href='<%= request.getContextPath() %>/volunteerBoard/boardForm';">등록하기</button>
			</div>
			<div class="col-md-12">
				<span>따뜻한 마음을 나눌 봉사자분들의 참여를 기다립니다.</span>
			</div>
			<div class="col-md-12">
				<div id="calendar"></div>
			</div>
		</div>
	</div>
	
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

<script>
// 등록하기 버튼 클릭 시 alert창 ''
$(".enroll-btn").click(function(e){
	alert("봉사 등록폼을 작성하시면 관리자 게시물 검토 후 연락을 드리며 승인 후 게시글이 등록됩니다.");
});


	//페이지 로딩시, 봉사 게시글 전체 달력에 넣기 - 풀캘린더 이용
    $.ajax({
    	url: "<%= request.getContextPath() %>/volunteerBoard/boardList",
    	// header에서 GET으로 volunteerBoardList.jsp를 보내기 때문에 POST 이용함.
    	type: 'POST',
		success(data){
			//console.log(data);
			
  			var calendarEl = document.getElementById('calendar');
  			
  			// data(봉사 게시글 목록들)를 map()을 활용하여 이벤트 옵션 설정하고 return한다.
  			var events = data.map(function(board) {
  				return {
  					//id : board.no, // 이부분 아직 파악 못함 자기전에 그냥 넣어놓음 url로 해결되면 지우자.
  					// title : 캘린더에 표시되는 일정의 이름 // start : 캘린더에 표시되는 일정 시작 일 // end : 캘린더에 표시되는 일정 마지막 일
  					title : board.title,
					start : new Date(board.startDate), // json형식이 "Nov 4, 2021"와 같이 읽어들여 new Date() 함수를 사용하여 날짜 형식으로 변환함
					// 시작일에만 표시되는게 깔끔해서 주석처리함. 사용자들 보기에 시작일만 있으면 날짜가 가늠이 안될 수 있어 고민해보기.
					//end : new Date(board.endDate)
					
					// 달력 각 게시글 클릭 시 이동하게 만듬.
					// GET URL 경로 뒤에 파라미터(봉사 게시글 번호)를 붙여 전달함
					url : "<%= request.getContextPath() %>/volunteerBoard/boardView?no=" + board.no
  				}
			});
  			
  			var calendar = new FullCalendar.Calendar(calendarEl, {
  				/* 이벤트 옵션 위에서 불러옴 */
				events : events,
				/* eventTimeFormat 이벤트 시간 형식 */
 				/* eventTimeFormat: { // like '14:30:00'
 					hour: '2-digit',
				    minute: '2-digit',
				    hour12: false
				  } */
				height: 650
			});
  			// 캘린더 랜더링
			calendar.render();
  			
		},
		error: console.log
	});
      
	// 이전 수업내용 참고
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