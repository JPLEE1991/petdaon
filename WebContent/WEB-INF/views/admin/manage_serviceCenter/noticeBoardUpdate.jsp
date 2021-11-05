<%@page import="com.petdaon.mvc.serviceBoard.noticeBoard.model.service.NoticeBoardService"%>
<%@page import="com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard"%>
<%@page import="com.petdaon.mvc.member.model.service.MemberService"%>
<%@page import="com.petdaon.mvc.common.Constants,
				com.petdaon.mvc.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	NoticeBoard noticeBoard = (NoticeBoard) request.getAttribute("noticeBoard");
	Member loginMember = (Member) request.getSession(true).getAttribute(Constants.SESSION_KEY);
	boolean editable = loginMember != null &&
			(MemberService.ADMIN_ROLE.equals(loginMember.getMemberRole()));
%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/serviceCenter/boardList.css"/> --%>
<!-- 부트스트랩(CSS & JavaScript Bundle with Popper) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 매테리얼 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">

<style>
#view-title {display:flex; height:60px;}
#view-title div {display:inline-flex; justify-content:center; align-items:center; margin:0 auto;}
#view-title div:first-child span {font-size:12px; color:#8e929f;}
#view-title div:nth-child(2) span {font-size:19px; font-weight:500;}
#view-title div:last-child span {font-size:12px; color:#efbc1f;}
hr {background-color:#8e929f;}
#view-content div {padding:10px 18px;}
#view-content div .list-group-item {padding:5px 10px; font-size:14px; border:1px solid #eceef2;}
#view-content div span {text-align:center; background-color:#eceef2;}
#content textarea {height:150px; overflow:scroll;}
#btn .btn:focus {box-shadow:none;}
#btn .btn {background-color:#ffd749; color:#212529; font-size:14px; font-weight:500;}
form[name=noticeBoardUpdateFrm] {padding:0; margin:0;}
input, textarea:focus-visible {outline:none;}
</style>
	
	<div class="container">
		<div class="row">
		
			<!-- 등록일, 공지번호, 조회수 -->
			<div id="view-title" class="container">
				<div class="col-3">
					<span><%= noticeBoard.getEnrollDate() %></span>
				</div>
				<div class="col-6">
					<span>공지번호 : <%= noticeBoard.getNo() %></span>
				</div>
				<div class="col-3">
					<span>조회수 <%= noticeBoard.getViewNum() %></span>
				</div>
			</div>
			
			<hr>
			<form name="noticeBoardUpdateFrm" id="noticeBoardUpdateFrm" method="post">
				<input type="hidden" name="no" value="<%= noticeBoard.getNo() %>"/>
				<div id="view-content" class="container">
					<!-- 작성자 -->
					<div id="writer" class="col-12 list-group list-group-horizontal">
						<span class="list-group-item col-6">작성자</span><input type="text" name="writer" class="list-group-item col-6" value="<%= noticeBoard.getWriter() %>" readonly/>
					</div>
					<!-- 제목 -->
					<div id="title" class="col-12 list-group list-group-horizontal">
						<span class="list-group-item col-6">제목</span><input type="text" name="title" class="list-group-item col-6" value="<%= noticeBoard.getTitle() %>"/>
					</div>
					<!-- 내용 -->
					<div id="content" class="col-12 list-group">
						<span class="list-group-item col-12">내용</span>
						<textarea rows="5" name="content" class="list-group-item col-12"><%= noticeBoard.getContent() %></textarea>
					</div>
					<!-- 수정, 삭제 버튼 제공 -->
					<div id="btn" class="col-12 btn-group list-group-horizontal">
						<a class="btn" href="javascript:updateNoticeBoard();">수정</a>
					</div>
				</div>
			</form>
		</div>
	</div>

<script>
/**
 * noticeBoardUpdateFrm 유효성 검사
 * 제목 또는 내용을 작성하지 않은 경우 폼 제출불가
 */
/* function noticeBoardValidate(){
	const $title = $("[name=title]");
	const $content = $("[name=content]");
	
	if(!/^.+$/.test($title.val())){
		alert("제목을 입력하세요.");
		$title.focus();
		return false;
	}
	
	if(!/^(.|\n)+$/.test($content.val())){
		alert("내용을 입력하세요.");
		$content.focus();
		return false;
	}
	return true;
};

$(() => {
	$(document.noticeBoardUpdateFrm).submit(noticeBoardValidate);
}); */

/* 
 * 상세페이지에서 수정버튼 클릭하면, 수정여부 확인후 팝업창이 닫히며 부모창에 액션을 전달하는 구조
 * 팝업창 데이터를 부모창에 넘기면서 페이지 액션 submit을 주기위해 target을 설정해서 사용했다.
 * 1) 팝업창에서 수정버튼 클릭하면, updateNoticeBoard() 스크립트 호출
 * 2) form에 데이터가 target으로 이동하며 페이지 액션 발생
 */
const updateNoticeBoard = () => {
	if(confirm("공지를 수정하시겠습니까?")){
		//부모창의 이름을 설정
		window.opener.name = "parentPage";
		//타겟을 부모창으로 설정
		document.noticeBoardUpdateFrm.target = "parentPage";
		//부모창에 호출될 url
		document.noticeBoardUpdateFrm.action = "<%= request.getContextPath() %>/admin/noticeBoard/noticeBoardUpdate";
		document.noticeBoardUpdateFrm.submit(); //폼 submit
		self.close(); //팝업창을 스스로 닫도록 하는 코드
	}
};
</script>

