<%@page import="com.petdaon.mvc.member.model.service.MemberService"%>
<%@page import="com.petdaon.mvc.common.Constants,
				com.petdaon.mvc.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>
<%
	Member loginMember = (Member) request.getSession(true).getAttribute(Constants.SESSION_KEY);
	boolean editable = loginMember != null &&
			(MemberService.ADMIN_ROLE.equals(loginMember.getMemberRole()));
%>
<style>
</style>

	<div class="container">
		<div class="row">
		
			<!-- 1:1문의 -->
			<div id="notice" class="card col-11">
				<h3 class="text-center">공지사항</h3>	
					
				<!-- 공지사항폼 -->
				<form name="noticeBoardEnrollFrm" action="<%= request.getContextPath() %>/admin/noticeBoard/noticeBoardEnroll" method="post">
					<!-- 작성자 : 로그인 상태인 관리자아이디 가져오기 -->
					<div class="input-group col-11 col-xl-9">
					  <span id="writer" class="input-group-text col-5">작성자</span>
					  <input type="text" name="writer" class="form-control col-7 bg-white" value="<%= loginMember.getMemberId() %>" readonly/>
					</div>
					<!-- 제목 -->
					<div class="col-11 col-xl-9">
					  <label for="title" class="form-label">제목</label>
					  <input type="text" name="title" id="title" class="form-control" placeholder="제목을 입력해주세요.(20자 이내)" maxlength="20"/>
					</div>
					<!-- 내용 -->
					<div class="col-11 col-xl-9">
					  <label for="content" class="form-label">내용</label>
					  <textarea name="content" id="content" class="form-control" rows="7" placeholder="공지 내용을 상세히 입력해주시기 바랍니다."></textarea>
					</div>
					<!-- 버튼 -->
					<div class="btn-group col-12">
						<a id="btn-cancel" href="<%= request.getContextPath() %>/admin/noticeBoard" class="btn">취소</a>
						<input type="submit" id="btn-enroll" class="btn" value="확인">
					</div>
				</form>
					
			</div>
			
		</div>
	</div>
	
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	
<script>
$(document).ready(function(){
	$("#main-title").text('공지사항 등록');
});

/**
 * noticeBoardEnrollFrm 유효성 검사
 * 제목 또는 내용을 작성하지 않은 경우 폼 제출불가
 */
function noticeBoardValidate(){
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
	$(document.noticeBoardEnrollFrm).submit(noticeBoardValidate);
});
</script>

<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>