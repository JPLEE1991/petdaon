<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<%-- <script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script> --%>

<%-- 썸머노트를 위해 추가해야할 부분 --%>
<%-- <link href="<%=request.getContextPath()%>/css/summernote/summernote-bs4.css" rel="stylesheet"> 
<script src="<%=request.getContextPath()%>/js/summernote/summernote-bs4.js"></script> --%>
<%-- 위 두줄 대신 사용함. 아래 cdn방식으로 하니 css 문제 안생김 --%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
<script src="<%=request.getContextPath()%>/js/summernote/lang/summernote-ko-KR.js"></script>
<%-- --%>

<script>
// 봉사요일/봉사시간 직접입력
	$(function(){
    //직접입력 인풋박스 기존에는 숨어있다가
	$("#selboxDirectDay").hide();
	$("#selboxDirectTime").hide();
    
	// 봉사요일
	$("#day").change(function() {
		// 직접입력을 누를 때 나타남
		if($("#day").val() == "directDay") {
			$("#selboxDirectDay").show();
			// 직접입력 시 required 속성 추가하기
			$("#selboxDirectDay").attr("required" , true);
			
		}
		else {	
			$("#selboxDirectDay").hide();
			// 값 초기화
			$("#selboxDirectDay").val('');
			// required 속성 없애기
			$("#selboxDirectDay").attr("required" , false);
		}	
	})
	
	// 봉사시간
	$("#time").change(function() {
		// 직접입력을 누를 때 나타남
		if($("#time").val() == "directTime") {
			$("#selboxDirectTime").show();
			// 직접입력 시 required 속성 추가하기
			$("#selboxDirectTime").attr("required" , true);
		}
		else {
			$("#selboxDirectTime").hide();
			// 값 초기화
			$("#selboxDirectTime").val('');
			// required 속성 없애기
			$("#selboxDirectTime").attr("required" , false);
		}	
	})
});

/**
* volunteerBoardEnrollFrm 유효성 검사
*/
function boardValidate(e){
	const $title = $("[name=title]");
	const $contents = $("[name=contents]");
	const $day = $("[name=day]"); // 봉사요일
	const $time = $("[name=time]"); // 봉사시간
	
	// 날짜비교를 위한 설정
	const startDate = $("[name=startDate]").val(); // 봉사시작일값
	const startDateArr = startDate.split('-');
	const endDate = $("[name=endDate]").val(); // 봉사종료일값
	const endDateArr = endDate.split('-');
	const deadlineDate = $("[name=deadlineDate]").val(); // 신청마감일값
	const deadlineDateArr = deadlineDate.split('-');
	
	const startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1])-1, startDateArr[2]);
	const endDateCompare = new Date(endDateArr[0], parseInt(endDateArr[1])-1, endDateArr[2]);
	const deadlineDateCompare = new Date(deadlineDateArr[0], parseInt(deadlineDateArr[1])-1, deadlineDateArr[2]);
	
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
	
	//봉사시작일이 종료일보다 늦으면 폼제출할 수 없음.
	if(startDateCompare.getTime() > endDateCompare.getTime()) {
		alert("봉사 종료일이 봉사 시작일보다 빠를 수 없습니다.")
		return false;
	}
	
	//신청마감일이 봉사종료일보다 늦으면 폼제출할 수 없음.
	if(deadlineDateCompare.getTime() >= endDateCompare.getTime()) {
		alert("봉사 종료일보다 신청 마감일이 앞서야 합니다.");
		return false;
	}
	
	//봉사요일과 봉사시간 선택하지 않고 그대로 유지하면 폼제출할 수 없음.
	if($day.val() == ""){
		alert("봉사요일을 선택해주세요.");
		return false;
	}
	
	if($time.val() == ""){
		alert("봉사시간을 선택해주세요.");
		return false;
	}
	
	return true;
}

$(() => {
	$(document.volunteerBoardEnrollFrm).submit(boardValidate);
});
	
</script>

	<div class="container">
		<h3>봉사 등록</h3>
		<!-- <span class="small text-danger">* 관리자 승인 후 게시글이 등록됩니다.</span> -->
		<span class="small text-danger d-block">* 관리자 게시물 검토 후 연락을 드리며 승인 후 게시글이 등록됩니다.</span>
		<span class="small text-danger d-block">* 등록 후 담당자 정보 수정과 게시글 삭제는 관리자의 권한이 필요합니다. 관리자에게 문의해주세요.</span>
		<form
			name="volunteerBoardEnrollFrm"
			action="<%=request.getContextPath() %>/volunteerBoard/boardEnroll"
			method="post"
			enctype="multipart/form-data"> 

			<div class="row">
				<!-- 이미지 미리보기 작업 중 -->
				<div class="col-md-4">
					<!-- 봉사 게시글 썸네일 이미지 -->
					<img src="<%= request.getContextPath() %>/images/blank-volunteer-640.jpg" class="img-thumbnail" id="img-thumbnail" alt="봉사게시판 썸네일 사진" onchange="setThumbnail(this);">
					<input class="form-control" type="file" name="thumbnail" id="thumbnail" onchange="setThumbnail(this);">	
				</div>
				
				<div class="col-md-8">
					<!-- 제목 -->
					<div class="mb-2 row">
						<label for="title" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" placeholder="제목 입력" class="form-control" name="title" id="title" required>
						</div>
					</div>
					
					<!-- 작성자 -->
					<div class="mb-2 row">
						<label for="writer" class="col-sm-2 col-form-label">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="writer" id="writer" value="<%= _member.getMemberId() %>" readonly>
						</div>
					</div>
					
					<!-- 센터명 -->
					<div class="mb-2 row">
						<label for="centerName" class="col-sm-2 col-form-label">센터명</label>
						<div class="col-sm-10">
							<input type="text" placeholder="센터명 입력" class="form-control" name="centerName" id="centerName" required>
						</div>
					</div>
					
					<!-- 봉사시작일 / 종료일. 유효성 검사에 봉사 시작일보다 종료일이 앞서지 않게 만들것 -->
					<div class="mb-2 row">
						<label for="startDate" class="col-sm-2 col-form-label">봉사 시작일</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" name="startDate" id="startDate" required>
						</div>
						<label for="endDate" class="col-sm-2 col-form-label">봉사 종료일</label>
						<div class="col-sm-4">
							<input type="date" class="form-control" name="endDate" id="endDate" required>
						</div>
					</div>
					
					<!-- 신청 마감일 -->
					<div class="mb-2 row">
						<label for="deadlineDate" class="col-sm-2 col-form-label">신청 마감일</label>
						<div class="col-sm-10">
							<input type="date" class="form-control" name="deadlineDate" id="deadlineDate" required>
						</div>
					</div>
					
					<!-- 모집인원 min max로 조절해도 console창으로 임의로 변경가능하니 유효성 검사로 인원제한 걸기 -->
					<div class="mb-2 row">
						<label for="capacity" class="col-sm-2 col-form-label">모집인원</label>
						<div class="col-sm-10">
							<input type="number" placeholder="모집인원 입력" min="0" max="100" class="form-control" name="capacity" id="capacity" required>
						</div>
					</div>
					
					<!-- 장소 -->
					<div class="mb-2 row">
						<label for="place" class="col-sm-2 col-form-label">장소</label>
						<div class="col-sm-10">
							<input type="text" placeholder="장소 입력" class="form-control" name="place" id="place" required>
						</div>
					</div>

					<!-- 봉사요일 -->
					<div class="mb-2 row">
						<label for="day" class="col-sm-2 col-form-label">봉사요일</label>
						<div class="col-sm-5">
							<select class="form-select" name="day" id="day" aria-label="Default select example">
							  <option value="" selected>봉사요일 선택</option>
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
					
					<!-- 봉사시간 -->
					<div class="mb-2 row">
						<label for="time" class="col-sm-2 col-form-label">봉사시간</label>
						<div class="col-sm-5">
							<select class="form-select" name="time" id="time" aria-label="Default select example">
							  <option value="" selected>봉사시간 선택</option>
							  <option value="시간협의">시간협의</option>
							  <option value="directTime">직접입력</option>
							</select>
						</div>
						<div class="col-sm-5">
							<input type="text" placeholder="예시) 13시 00분 ~ 17시 00분" class="form-control" name="selboxDirectTime" id="selboxDirectTime">
						</div>
					</div>
							
				</div>
				
				<!-- 내용 -->
				<div class="col-md-12">
					<label for="contents" class="col-form-label">내용</label>
					<textarea id="summernote" name="contents" id="contents"></textarea>
				</div>
				
			</div>
			
			
			<%-- 담당자 정보 (이름 / 휴대폰 / 이메일) 이름부분 로그인 기능 구현되면 값 가져오기 --%>
			<label for="" class="col-form-label">담당자 정보</label>
			<div class="row">
				<!-- 이름. 이름부분 로그인 기능 구현되면 값 가져오기 -->
				<div class="col-sm-4">
					<input type="text" class="form-control" name="name" id="name" value="<%= _member.getMemberName() %>" readonly>
				</div>
				
				<!-- 휴대폰 -->
				<div class="col-sm-4">
					<input type="tel" placeholder="(-없이)01012345678" class="form-control" name="phone" id="phone" maxlength="11" required>
				</div>
				
				<!-- 이메일 -->
				<div class="col-sm-4">
					<input type="email" placeholder="이메일 입력" class="form-control" name="email" id="email" required>
				</div>
				
			</div>
			
			<div class="row mt-2 mb-5">
			
				<div class="d-flex justify-content-center my-3">
					<button type="button" class="col-sm-2 btn btn-secondary btn-lg mx-3" onclick="history.back()">취소</button>
					<button type="submit" class="col-sm-2 btn btn-primary btn-lg mx-3">등록하기</button>
				
				</div>
			</div>
		</form>
	</div>

<script>
<!-- 써머노트 웹 에디터 로딩 -->
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '봉사 상세정보 입력',	//placeholder 설정
		  toolbar: [
	          ['style', ['style']],
	          ['fontsize', ['fontsize']],
	          ['font', ['bold', 'underline', 'clear']],
	          ['color', ['forecolor','color']],
	          ['para', ['ul', 'ol', 'paragraph']],
	          ['table', ['table']],
	          ['insert', ['link']],
	          ['view', ['codeview', 'help']]
	        ]	
	});
	
});



	
<!-- 이미지 미리보기 -->
function setThumbnail(input){
	//console.log(input.files.length);
	if(input.files.length == 1) {
		// 파일을 읽기 위한 FileReader객체 생성
		var reader = new FileReader();
		
		//파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
		reader.onload = function(e){
			//이미지 tag의 src속성에 읽어들인 file내용을 지정
			$("#img-thumbnail").attr("src", e.target.result);
		};
		
		//file내용을 읽어 dataURL형식의 문자열로 저장
		reader.readAsDataURL(input.files[0]);
	}
	
	// 파일 고르지 않으면 이미지 속성 초기화
	else if(input.files.length == 0) {
		$("#img-thumbnail").attr("src", "<%= request.getContextPath() %>/images/blank-volunteer-640.jpg");
	}
}

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
