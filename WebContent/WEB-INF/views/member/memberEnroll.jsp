<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
h1 {
	text-align: center
}

.col-sm-6 {
	margin: auto
}
</style>
<script type="text/javascript">
	function fnDoSubmit() {
		var memberId = $('#memberId').val();
		if (!memberId || !/^[0-9a-zA-Z_]{3,20}$/.test(memberId)) {
			alert('아이디를 3 ~ 20자리로 입력해주세요.');
			return false;
		}

		$('form[name=enrollFrm]')[0].submit();
	}
</script>


<div class="container-fluid">

	<div class="join-title">
		<h1>회원가입</h1>
	</div>
	<div class="row">
		<div class="col-sm-6 col-sm-offset-3">
			<div class="panel panel-default">
				<div class="panel-body">
					<form name="enrollFrm"
						action="<%=request.getContextPath()%>/member/memberEnroll"
						method="post">
						<div class="form-group">
							<label for="memberId">아이디</label> <input type="text"
								id="memberId" name="memberId" class="form-control"
								placeholder="아이디를 입력해주세요">
						</div>
						<div class="form-group">
							<label for="memberName">이름</label> <input type="text"
								id="memberName" name="memberName" class="form-control"
								placeholder="이름을 입력해주세요">
						</div>
						<div class="form-group">
							<label for="password">비밀번호</label> <input type="password"
								id="password" name="password" class="form-control"
								placeholder="비밀번호를 입력해주세요">
						</div>
						<div class="form-group">
							<label for="passwordck">비밀번호확인</label> <input type="password"
								id="passwordck" name="passwordck" class="form-control"
								placeholder="비밀번호확인을 입력해주세요">
						</div>
						<div class="form-group">
							<label for="email">이메일</label> <input type="text" id="email"
								name="email" class="form-control" placeholder="이메일을 입력해주세요">
						</div>
						<div class="form-group">
							<label for="birthday">생년월일</label> <input type="text"
								id="birthday" name="birthday" class="form-control"
								placeholder="생년월일을 입력해주세요">
						</div>
						<div class="form-group">
							<label for="phone">전화번호</label> <input type="text" id="phone"
								name="phone" class="form-control" placeholder="전화번호를 입력해주세요">
						</div>
						<button type="submit" id="joinBtn"
							class="btn btn-info btn-lg btn-block"
							onclick="javascript:fnDoSubmit(); return false;">회원가입</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<script
	src="<%=request.getContextPath()%>/resource/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>

