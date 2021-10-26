<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- 서머노트를 위해 추가해야할 부분 -->

<%-- <script type="text/javascript" src="<%= request.getContextPath() %>/js/summernote-ko-KR.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/js/summernote-lite.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/summernote-lite.css" --%>
<!--  -->



<script>
// 봉사시간/봉사요일 직접입력
	$(function(){
    //직접입력 인풋박스 기존에는 숨어있다가
	$("#selboxDirectTime").hide();
	$("#selboxDirectDay").hide();
    
	$("#time").change(function() {
		//직접입력을 누를 때 나타남
		if($("#time").val() == "directTime") {
			$("#selboxDirectTime").show();
		}
		else {	
			$("#selboxDirectTime").hide();
		}	
	})
	
	$("#day").change(function() {
		//직접입력을 누를 때 나타남
		if($("#day").val() == "directDay") {
			$("#selboxDirectDay").show();
		}
		else {	
			$("#selboxDirectDay").hide();
		}	
	}) 
});

/**
* volunteerBoardEnrollFrm 유효성 검사
*/
function boardValidate(e){
	const $title = $("[name=title]");
	const $contents = $("[name=contents]");
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test($title.val())){
		alert("제목을 입력하세요.");
		return false;
	}
					   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	// .(임의의 문자)에는 \n(개행문자)가 포함되지 않는다.
	if(!/^(.|\n)+$/.test($contents.val())){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
}

$(() => {
	$(document.volunteerBoardEnrollFrm).submit(boardValidate);
});
	
</script>

	<div class="container">
		<h2>봉사 등록</h2>
		<form
			name="volunteerBoardEnrollFrm"
			action="<%=request.getContextPath() %>/volunteerBoard/boardEnroll"
			method="post"
			enctype="multipart/form-data">

			<div class="row">
				<div class="col-md-4">
					<!-- 봉사 게시글 썸네일 이미지 -->
					<img src="<%= request.getContextPath() %>/images/blank-profile-640.png" class="img-thumbnail" alt="봉사게시판 썸네일 사진">
					<input class="form-control" type="file" name="thumbnail" id="thumbnail">	
				</div>
				
				<div class="col-md-8">
					<!-- 제목 -->
					<div class="mb-2 row">
						<label for="title" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" placeholder="제목 입력" class="form-control" name="title" id="title">
						</div>
					</div>
					
					<!-- 작성자 임시 지정. 로그인 기능 구현되면 value값 loginMember.getMemberId() 로 변경하기. -->
					<div class="mb-2 row">
						<label for="writer" class="col-sm-2 col-form-label">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="writer" id="writer" value="honggd" readonly>
						</div>
					</div>
					
					<!-- 센터명 -->
					<div class="mb-2 row">
						<label for="centerName" class="col-sm-2 col-form-label">센터명</label>
						<div class="col-sm-10">
							<input type="text" placeholder="센터명 입력" class="form-control" name="centerName" id="centerName">
						</div>
					</div>
					
					<!-- 봉사시작일 / 종료일. 유효성 검사에 봉사 시작일보다 종료일이 앞서지 않게 만들것 -->
					<div class="mb-2 row">
						<label for="startDate" class="col-sm-2 col-form-label">봉사 시작일</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" name="startDate" id="startDate">
						</div>
						<label for="endDate" class="col-sm-2 col-form-label">봉사 종료일</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" name="endDate" id="endDate">
						</div>
					</div>
					
					<!-- 신청 마감일 -->
					<div class="mb-2 row">
						<label for="deadlineDate" class="col-sm-2 col-form-label">신청 마감일</label>
						<div class="col-sm-10">
							<input type="date" class="form-control" name="deadlineDate" id="deadlineDate">
						</div>
					</div>
					
					<!-- 모집인원 min max로 조절해도 console창으로 임의로 변경가능하니 유효성 검사로 인원제한 걸기 -->
					<div class="mb-2 row">
						<label for="capacity" class="col-sm-2 col-form-label">모집인원</label>
						<div class="col-sm-10">
							<input type="number" placeholder="모집인원 입력" min="0" max="100" class="form-control" name="capacity" id="capacity">
						</div>
					</div>
					
					<!-- 장소 -->
					<div class="mb-2 row">
						<label for="place" class="col-sm-2 col-form-label">장소</label>
						<div class="col-sm-10">
							<input type="text" placeholder="장소 입력" class="form-control" name="place" id="place">
						</div>
					</div>
					
					<!-- 봉사시간 -->
					<div class="mb-2 row">
						<label for="time" class="col-sm-2 col-form-label">봉사시간</label>
						<div class="col-sm-5">
							<select class="form-select" name="time" id="time" aria-label="Default select example" required>
							  <option value="" selected>봉사시간</option>
							  <option value="시간협의">시간협의</option>
							  <option value="directTime">직접입력</option>
							</select>
						</div>
						<div class="col-sm-5">
							<input type="text" placeholder="예시) 13시 00분 ~ 17시 00분" class="form-control" name="selboxDirectTime" id="selboxDirectTime">
						</div>
					</div>
					
					<!-- 봉사요일 -->
					<div class="mb-2 row">
						<label for="day" class="col-sm-2 col-form-label">봉사요일</label>
						<div class="col-sm-5">
							<select class="form-select" name="day" id="day" aria-label="Default select example" required>
							  <option value="" selected>봉사요일</option>
							  <option value="요일협의">요일협의</option>
							  <option value="평일">평일</option>
							  <option value="주말">주말</option>
							  <option value="directDay">직접입력</option>
							</select>
						</div>
						<div class="col-sm-5">
							<input type="text" placeholder="직접 입력" class="form-control" name="selboxDirectDay" id="selboxDirectDay">
						</div>
					</div>
					
					<!-- 내용(써머노트 일단 후퇴!) -->
					<!-- <div id="summernote"></div> -->
	
							
				</div>
				
				
				<!-- 내용 -->
				<div class="col-md-12">
					<label for="contents" class="col-form-label">내용</label>
					<textarea class="form-control" placeholder="내용 입력" aria-label="With textarea" name="contents" id="contents" cols="20" rows="10"></textarea>
				</div>
					
				
				
				
				
			</div>
			
			
			<!-- 담당자 정보 (이름 / 휴대폰 / 이메일) 이름부분 로그인 기능 구현되면 값 가져오기 -->
			<label for="" class="col-form-label">담당자 정보</label>
			<div class="row">
				<!-- 이름. 이름부분 로그인 기능 구현되면 값 가져오기 -->
				<div class="col-sm-4">
					<input type="text" class="form-control" name="name" id="name" value="홍길동" readonly>
				</div>
				
				<!-- 휴대폰 -->
				<div class="col-sm-4">
					<input type="tel" placeholder="(-없이)01012345678" class="form-control" name="phone" id="phone" maxlength="11">
				</div>
				
				<!-- 이메일 -->
				<div class="col-sm-4">
					<input type="email" placeholder="이메일 입력" class="form-control" name="email" id="email">
				</div>
				
			</div>
			
			<div class="row">
			
				<div class="d-flex justify-content-center my-3">
					<button type="button" class="col-sm-2 btn btn-secondary btn-lg mx-3">취소</button>
					<button type="submit" class="col-sm-2 btn btn-primary btn-lg mx-3">등록하기</button>
				
				</div>
			</div>
		</form>
	</div>


	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

<script>
// 써머노트 일단후퇴!
/*
 $('#summernote').summernote({
	  width: 800,
      height: 500,                 // 에디터 높이
      minHeight: 500,             // 최소 높이
      maxHeight: 500,             // 최대 높이
      focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
      lang: "ko-KR",					// 한글 설정
      placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
	});
	*/
</script>




<%-- <script>
/**
* boardEnrollFrm 유효성 검사
*/
function boardValidate(e){
	const $title = $("[name=title]");
	const $content = $("[name=content]");
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test($title.val())){
		alert("제목을 입력하세요.");
		return false;
	}
					   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	// .(임의의 문자)에는 \n(개행문자)가 포함되지 않는다.
	if(!/^(.|\n)+$/.test($content.val())){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
}

$(() => {
	$(document.boardEnrollFrm).submit(boardValidate);
});
</script>
<section id="board-container">
<h2>게시판 작성</h2>
<form
	name="boardEnrollFrm"
	action="<%=request.getContextPath() %>/board/boardEnroll" 
	method="post"
	enctype="multipart/form-data">
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="title" required></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="writer" value="<%= loginMember.getMemberId() %>" readonly/>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>			
			<input type="file" name="upFile">
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="40" name="content"></textarea></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="등록하기">
		</th>
	</tr>
</table>
</form>
</section> --%>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
