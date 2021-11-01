<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/serviceCenter/boardList.css"/> --%>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 매테리얼 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<style>
h2 {padding:30px; margin:0 auto; text-align:center;}
h3 {padding-top:50px; margin:0 auto; text-align:center;}
p {padding:40px 0 20px 0; border-bottom:1px solid #eceef2; margin-bottom:40px; color:#8e929f;}
.card {border-radius:.8rem;}
#breadcrumb {border:0; margin:0 auto; background-color:#ffd749; height:300px;}
#breadcrumb nav {padding:30px 15px; font-size:18px;}
#breadcrumb nav li a.nav-link {color:#212529;}
#ask-container {height:600px;}
#ask {height:800px; border:0; margin:0 auto; background-color:white; padding:15px 30px; top:-33%;}
form div:not(:last-child) {padding-bottom:25px; margin:0 auto;}
#inquiry-writer {justify-content:center;}
#inquiry-content {background-color:white; resize:none;}
div.btn-group {padding-top:40px;}
#btn-cancel {padding:10px 0; background-color:#eceef2; color:#8e929f; z-index:0;}
#btn-cancel:hover {background-color:rgb(236, 238, 242, 70%);}
#btn-enroll {padding:10px 0; background-color:#ffd749;}
#btn-enroll:hover {background-color:rgb(255, 215, 73, 70%);}
.form-control:focus {box-shadow:0 0 0 0.25rem #ffd749; border-color:#ffd749;}
.btn:focus {box-shadow:none;}
</style>

<script>
/**
 * askBoardEnrollFrm 유효성 검사
 * 제목 또는 내용을 작성하지 않은 경우 폼 제출불가
 */
function askBoardValidate(){
	const $inquiryTitle = $("[name=title]");
	const $inquiryContent = $("[name=content]");
	
	if(!/^.+$/.test($inquiryTitle.val())){
		alert("제목을 입력하세요.");
		$inquiryTitle.focus();
		return false;
	}
	
	if(!/^(.|\n)+$/.test($inquiryContent.val())){
		alert("내용을 입력하세요.");
		$inquiryContent.focus();
		return false;
	}
	return true;
};

$(() => {
	$(document.askBoardEnrollFrm).submit(askBoardValidate);
});
</script>

	<div class="container">
		<div class="row">
		
			<h2>고객센터</h2>
			
			<!-- 사용자경로 -->
			<div id="breadcrumb" class="card col-11 col-xxl-10 position-relative">
				<nav class="navbar justify-content-start">
					<li class="nav-item">
				       <a class="nav-link" href="<%= request.getContextPath() %>/serviceCenter">고객센터</a>
				    </li>
				    <span class="material-icons">chevron_right</span>
				    <li class="nav-item">
				       <a class="nav-link" href="#">1:1문의</a>
				    </li>
				</nav>
			</div>
			
			<!-- 1:1문의 -->
			<div id="ask-container" class="container col-8 col-xxl-7">
				<div id="ask" class="card col-11 position-absolute start-50 translate-middle-x">
					<h3 class="text-center">1:1문의</h3>
					<p class="text-center">펫다온을 이용하시면서 불편하거나 개선할 사항이 있다면 문의해주세요.</p>		
					
					<!-- 1:1문의폼 -->
					<form name="askBoardEnrollFrm" action="<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardEnroll" method="post">
						<!-- 작성자 : 로그인 상태인 회원아이디 가져오기 -->
						<div class="input-group col-11 col-xl-9">
						  <span id="inquiry-writer" class="input-group-text col-5">작성자</span>
						  <input type="text" name="writer" class="form-control col-7 bg-white" value="작성자 아이디" readonly/>
						  <%-- <input type="text" name="writer" class="form-control col-7 bg-white" value="<%= loginMember.getMemberId() %>" readonly/> --%>
						</div>
						<!-- 제목 -->
						<div class="col-11 col-xl-9">
						  <label for="inquiry-title" class="form-label">제목</label>
						  <input type="text" name="title" id="inquiry-title" class="form-control" placeholder="제목을 입력해주세요.(20자 이내)" maxlength="20"/>
						</div>
						<!-- 내용 -->
						<div class="col-11 col-xl-9">
						  <label for="inquiry-content" class="form-label">문의 사항</label>
						  <textarea name="content" id="inquiry-content" class="form-control" rows="7" placeholder="문의 내용을 상세히 입력해주시기 바랍니다."></textarea>
						</div>
						
						<!-- 버튼 -->
						<div class="btn-group col-12">
							<a id="btn-cancel" href="<%= request.getContextPath() %>/serviceCenter" class="btn">취소</a>
							<input type="submit" id="btn-enroll" class="btn" value="확인">
						</div>
					</form>
					
				</div>
			</div>
			
		</div>
	</div>
	
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>