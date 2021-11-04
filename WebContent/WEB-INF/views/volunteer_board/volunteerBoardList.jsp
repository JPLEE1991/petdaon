<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<VolunteerBoard> list = (List<VolunteerBoard>) request.getAttribute("list");
	//System.out.println("list@volunteerBoardList.jsp = " + list);
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<!-- fullcalender -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/fullcalendar-5.10.0/main.css" />
<script src="<%=request.getContextPath()%>/js/fullcalendar-5.10.0/main.js"></script>
<%-- 슬라이드 구현을 위해 넣어줌. header부분에 있을 텐데 위의 jquery선언을 다시해줘서 문제가 일어난건가? --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
	
	<%-- 봉사 최근 게시글 4개 카드형식으로 놓기 --%>
	<div class="container mt-5">
		<div class="row">
		
<%
		if(list != null && !list.isEmpty()) { // isEmpty()는 객체가 null로 되어있어 비는 것이 아닌 값이 존재하지 않는 상태이다.
			for(VolunteerBoard board : list) {%>
				<div class="col-md-3">

					<div class="card w-100 h-100" style="width: 18rem;">
					
						<a href="<%= request.getContextPath() %>/volunteerBoard/boardView?no=<%= board.getNo() %>">
							<img src="<%= request.getContextPath() %>/<%= board.getThumbnail() %>" class="card-img-top" alt="<%= board.getTitle() %> 썸네일 사진">
						</a>
					
					
						<div class="card-body">
							<a href="<%= request.getContextPath() %>/volunteerBoard/boardView?no=<%= board.getNo() %>" class="link-dark">
								<p class="card-text fw-bold"><%= board.getTitle() %></p>
							</a>
							<p class="card-text">활동기간 : <%= board.getStartDate() %> ~ <%= board.getEndDate() %></p>
							<p class="card-text">모집마감 : <%= board.getDeadlineDate() %></p>
							<p class="card-text"><%= board.getDay() %> / <%= board.getTime() %></p>
							<p class="card-text">장소 : <%= board.getPlace() %></p>
							<%-- <a href="<%= request.getContextPath() %>/volunteerBoard/boardView?no=<%= board.getNo() %>" class="btn btn-primary float-end">상세보기</a> --%>
						</div>
					</div>
				
				</div>
<%
			}
		}
		%>		
		
			
			<!-- <div class="col-md-3">
			
				<div class="card w-100" style="width: 18rem;">
					<img src="..." class="card-img-top" alt="...">
					<div class="card-body">
						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					</div>
				</div>
			
			</div>
			
			<div class="col-md-3">
			
				<div class="card w-100" style="width: 18rem;">
					<img src="..." class="card-img-top" alt="...">
					<div class="card-body">
						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					</div>
				</div>
			
			</div>
			
			<div class="col-md-3">
			
				<div class="card w-100" style="width: 18rem;">
					<img src="..." class="card-img-top" alt="...">
					<div class="card-body">
						<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					</div>
				</div>
			
			</div> -->
		
		</div>
	
	
	</div>
	
	
	
	<%-- --%>
	
	
	
	
	
	
	
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

<script>
// 등록하기 버튼 클릭 시 alert창 ''
$(".enroll-btn").click(function(e){
	alert(`봉사 등록폼을 작성하시면 관리자 게시물 검토 후 연락을 드리며 승인 후 게시물이 등록됩니다.
등록 후 담당자 정보 수정과 게시글 삭제는 관리자의 권한이 필요합니다. 관리자에게 문의해주세요.`);
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
      

</script>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>