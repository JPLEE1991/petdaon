<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.petdaon.mvc.member.model.vo.Member,
				com.petdaon.mvc.common.StringUtils"%>
<%
Member member = (Member)request.getAttribute("member");
%>
<!DOCTYPE html>
<html lang="en">
	<head> 
<title>회원상세</title>
 	<style>
    </style>
<script type="text/javascript">
/**
 * 취소
 */
function fnGoList() {
	location.href = '<%=request.getContextPath()%>/admin/adminmemberList';
	
}

/**
 * 수정
 */
function fnUpdate() {
	// 입력값 검증
	
	$('form[name=enrollFrm]')[0].action	= '<%=request.getContextPath()%>/admin/adminmemberDetail';
	$('form[name=enrollFrm]')[0].submit();
	alert('수정되었습니다'); 
}

/**
 * 탈퇴
 */
function fnLeave() {
	$('form[name=enrollFrm]')[0].action	= '<%=request.getContextPath()%>/admin/adminmemberleave';
	$('form[name=enrollFrm]')[0].submit();
	alert('탈퇴되었습니다'); 
}

/**
 * 블랙리스트 등록
 */
function fnBlack() {
	$('form[name=enrollFrm]')[0].action	= '<%=request.getContextPath()%>/admin/adminmemberBlack';
	$('form[name=enrollFrm]')[0].submit();
	alert('블랙리스트로 등록되었습니다')
	
}
</script>    
	</head>
 	<body>
<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>

	
	<div class="container-fluid" >
	<br>
	<div class="join-title"></div>
	<div class="row">
		<div class="col-sm-6 col-sm-offset-3">
			<div class="panel panel-default">
				<div class="panel-body">
				
					<form name="enrollFrm" action="<%=request.getContextPath()%>/admin/adminmemberDetail"  method="post">
						<div class="form-group">
							<label for="memberId">아이디</label>
							<input type="text" id="memberId" name="memberId" class="form-control" placeholder="아이디를 입력해주세요" value="<%=member.getMemberId() %>" readonly="readonly" />
						</div>
						<div class="form-group">
							<label for="memberName">이름</label>
							<input type="text" id="memberName" name="memberName" class="form-control" placeholder="이름을 입력해주세요" value="<%=member.getMemberName() %>" />
						</div>
						<div class="form-group">
							<label for="memberRole">권한</label>
							<select id="memberRole" name="memberRole">
								<option value="M" <%="M".equals(member.getMemberRole()) ? "selected=\"selected\"" : "" %>>일반회원</option>
								<option value="A" <%="A".equals(member.getMemberRole()) ? "selected=\"selected\"" : "" %>>관리자</option>
							</select>
						</div>
						<div class="form-group">
							<label for="phone">휴대폰</label>
							<input type="text" id="phone" name="phone" class="form-control" placeholder="휴대폰번호" value="<%=member.getPhone() %>">
						</div>
						<div class="form-group">
							<label for="phone">이메일</label>
							<input type="text" id="email" name="email" class="form-control" placeholder="이메일" value="<%=member.getEmail() %>">
						</div>
						<div class="form-group">
							<label for="enrollDate">가입일</label>
							<input type="text" id="enrollDate" name="enrollDate" class="form-control" placeholder="가입일" value="<%=member.getEnroll_date() == null ? "" : member.getEnroll_date() %>" readonly="readonly" />
						</div>
						<div class="form-group">
							<label for="quitDate">탈퇴일</label>
							<input type="text" id="quitDate" name="quitDate" class="form-control" value="<%=StringUtils.getString(member.getQuit_date()) %>" readonly="readonly" />
						</div>
						<div class="form-group">
							<label for="status">상태</label>
							<select id="status" name="status" disabled="disabled">
								<option value="Y" <%="Y".equals(member.getStatus()) ? "selected=\"selected\"" : "" %>>가입</option>
								<option value="N" <%="N".equals(member.getStatus()) ? "selected=\"selected\"" : "" %>>탈퇴</option>
								<option value="B" <%="B".equals(member.getStatus()) ? "selected=\"selected\"" : "" %>>블랙</option>
							</select>
						</div>
						<button type="submit" class="btn btn-info btn-lg btn-block" onclick="javascript:fnGoList(); return false;">취소</button>
						<button type="submit" class="btn btn-info btn-lg btn-block" onclick="javascript:fnUpdate(); return false;">수정</button>
						<button type="submit" class="btn btn-info btn-lg btn-block" onclick="javascript:fnLeave(); return false;">탈퇴</button>
						<button type="submit" class="btn btn-info btn-lg btn-block" onclick="javascript:fnBlack(); return false;">블랙리스트 등록</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	</div>



<script src="<%=request.getContextPath()%>/resource/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<script>
// main-title 변경
$(document).ready(function(){
	$("#main-title").text('회원 상세보기');
})
</script>
</body>
</html>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>



<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>

