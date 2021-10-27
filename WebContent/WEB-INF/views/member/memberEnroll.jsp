<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head> 
<title>회원가입</title>
 <style>
    </style>
  </head>
	 <body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<div class="container-fluid" >
	
	<div class="join-title"><h1>회원가입</h1></div>
	<div class="row">
		<div class="col-sm-6 col-sm-offset-3">
			<div class="panel panel-default">
				<div class="panel-body">
					<form id="join" action="<%=request.getContextPath()%>/join.jsp" method="post">
						<div class="form-group">
							<label for="userId">아이디</label>
							<input type="text" id="userId" name="userId" class="form-control" placeholder="아이디를 입력해주세요">
						</div>
						<div class="form-group">
							<label for="userName">이름</label>
							<input type="text" id="userName" name="userName" class="form-control" placeholder="이름을 입력해주세요">
						</div>
						<div class="form-group">
							<label for="userPw">비밀번호</label>
							<input type="password" id="userPw" name="userPw" class="form-control" placeholder="비밀번호를 입력해주세요">
						</div>
						<div class="form-group">
							<label for="pwCon">비밀번호확인</label>
							<input type="password" id="pwCon" name="pwCon" class="form-control" placeholder="비밀번호확인을 입력해주세요">
						</div>
						<div class="form-group">
							<label for="userEmail">이메일</label>
							<input type="text" id="userEmail" name="userEmail" class="form-control" placeholder="이메일을 입력해주세요">
						</div>
						<div class="form-group">
							<label for="date">생년월일</label>
							<input type="text" id="date" name="date" class="form-control" placeholder="생년월일을 입력해주세요">
						</div>
						<div class="form-group">
							<label for="phone">전화번호</label>
							<input type="text" id="phone" name="phone" class="form-control" placeholder="전화번호를 입력해주세요">
						</div>
						<button type="button" id="joinBtn" class="btn btn-info btn-lg btn-block">회원가입</button>
					</form>
				</div>
			</div>
		</div>
	</div>



<script src="<%=request.getContextPath()%>/resource/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>


</body>
</html>






<%@ include file="/WEB-INF/views/common/footer.jsp" %>

