<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.service.AskBoardService"%>
<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard"%>
<%@page import="com.petdaon.mvc.member.model.service.MemberService"%>
<%@page import="com.petdaon.mvc.common.Constants,
				com.petdaon.mvc.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	AskBoard askBoard = (AskBoard) request.getAttribute("askBoard");
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
#view-content div {padding:10px 30px;}
#view-content div span {border:1px solid #eceef2; padding:5px 10px; font-size:14px;}
#view-content div span:nth-child(1) {text-align:center; background-color:#eceef2;}
#content-answer {background-color:#eceef2; height:100px; overflow:scroll;}
#content-answer p:last-child {font-size:12px; color:#8e929f; margin:0;}
#askBoardAnswerFrm textarea {font-size:14px;}
#askBoardAnswerFrm textarea:focus-visible {outline:none;}
#askBoardAnswerFrm a {background-color:#212529; color:#eceef2; padding:5px 10px; border:0; border-radius:0 0 0.2rem 0.2rem; font-size:.9rem;}
#askBoardCancelFrm a {background-color:#ffd749; color:#212529; padding:5px 10px; border:0; border-radius:0 0 0.2rem 0.2rem; font-size:.9rem;}
</style>
	
	<div class="container">
		<div class="row">
		
			<!-- 접수상태, 문의번호, 문의날짜 -->
			<div id="view-title" class="container">
				<div class="col-3">
					<span><%= askBoard.getEnrollDate() %></span>
				</div>
				<div class="col-6">
					<span>문의번호 : <%= askBoard.getInquiryNo() %></span>
				</div>
				<div class="col-3">
					<span><%=
						askBoard.getStatus().equals("D") ? "접수" :
						askBoard.getStatus().equals("C") ? "접수취소" :
						askBoard.getStatus().equals("I") ? "처리중" : "처리완료"
					%></span>
				</div>
			</div>
			
			<hr>
			
			<div id="view-content" class="container">
				<!-- 작성자 -->
				<div id="writer" class="col-12 list-group list-group-horizontal">
					<span class="list-group-item col-6">작성자</span><span class="list-group-item col-6"><%= askBoard.getWriter() %></span>
				</div>
				<!-- 제목 -->
				<div id="title" class="col-12 list-group list-group-horizontal">
					<span class="list-group-item col-6">제목</span><span class="list-group-item col-6"><%= askBoard.getInquiryTitle() %></span>
				</div>
				<!-- 문의 사항 -->
				<div id="content" class="list-group col-12">
					<span class="list-group-item col-12">문의 사항</span>
					<span class="list-group-item col-12"><%= askBoard.getInquiryContent() %></span>
				<!-- 답변이 있을경우에만 답변과 답변날짜 출력 -->
				<% if(askBoard.getAnswer() != null){ %>
					<span id="content-answer" class="list-group-item col-12">
						<p><%= askBoard.getAnswer() %></p>
						<p><%=askBoard.getAnswerDate() %> &nbsp; 관리자 <%=askBoard.getAdminId() %></p>
					</span>
				<% } %>
				
				<%
					if(askBoard.getStatus().equals(AskBoardService.STATUS_DEFAULT) || askBoard.getStatus().equals(AskBoardService.STATUS_ING)){
						if(editable){
				%>
					<form id="askBoardAnswerFrm" name="askBoardAnswerFrm" method="post">
						<input type="hidden" name="inquiryNo" value="<%= askBoard.getInquiryNo() %>"/>
						<textarea class="list-group-item col-12" name="answer" id="answer" rows="5"></textarea>
						<input type="hidden" name="adminId" value="<%= loginMember != null ? loginMember.getMemberId() : "" %>"/>
						<a class="btn list-group-item col-12 " href="javascript:askBoardAnswerEnroll();">답변 등록</a>
					</form>
				<%
						} else {
				%>
					<form id="askBoardCancelFrm" name="askBoardCancelFrm" method="post">
						<input type="hidden" name="inquiryNo" value="<%= askBoard.getInquiryNo() %>"/>
						<a class="btn list-group-item col-12" href="javascript:askBoardCancel();">접수 취소</a>
					</form>
				<%
						}
					}
				%>
				
				<%-- <%
					if(askBoard.getWriter().equals(loginMember)) {
				%>
					<a class="btn list-group-item col-12" href="javascript:deleteNoticeBoard();">삭제</a>	
				<%
					}
				%> --%>
				</div>
			</div>
			
		</div>
	</div>
	
	<br/><br/><br/>
	
<script>
/**
 * askBoardAnswerFrm 유효성 검사
 * 내용 작성하지 않은 경우 폼 제출불가, 로그인 상태에만 접근가능
 */
/* function askBoardValidate(){
	const $answer = $("[name=answer]");
	
	if(!/^(.|\n)+$/.test($answer.val())){
		alert("내용을 입력하세요.");
		$answer.focus();
		return false;
	}
	return true;
};

$(() => {
	$(document.askBoardAnswerFrm).submit(askBoardValidate);
}); */

/* 
 * 상세페이지에서 답변등록버튼 클릭하면, 수정여부 확인후 팝업창이 닫히며 부모창에 액션을 전달하는 구조
 * 팝업창 데이터를 부모창에 넘기면서 페이지 액션 submit을 주기위해 target을 설정해서 사용했다.
 * 1) 팝업창에서 답변등록버튼 클릭하면, updateAskBoard() 스크립트 호출
 * 2) form에 데이터가 target으로 이동하며 페이지 액션 발생
 */
const askBoardAnswerEnroll = () => {
	if(confirm("답변을 등록하시겠습니까?")){
		//부모창의 이름을 설정
		window.opener.name = "parentPage";
		//타겟을 부모창으로 설정
		document.askBoardAnswerFrm.target = "parentPage";
		//부모창에 호출될 url
		document.askBoardAnswerFrm.action = "<%= request.getContextPath() %>/admin/askBoard/askBoardAnswerEnroll";
		document.askBoardAnswerFrm.submit(); //폼 submit
		self.close(); //팝업창을 스스로 닫도록 하는 코드
	}
};

const askBoardCancel = () => {
	if(confirm("접수를 취소하시겠습니까?")){
		//부모창의 이름을 설정
		window.opener.name = "parentPage";
		//타겟을 부모창으로 설정
		document.askBoardCancelFrm.target = "parentPage";
		//부모창에 호출될 url
		document.askBoardCancelFrm.action = "<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardCancel";
		document.askBoardCancelFrm.submit(); //폼 submit
		self.close(); //팝업창을 스스로 닫도록 하는 코드
	}
};
</script>