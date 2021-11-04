<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String resultMsg = (String)request.getAttribute("resultMsg");
resultMsg = resultMsg == null ? "" : resultMsg;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
 <script type="text/javascript">
	var resultMsg = '<%=resultMsg%>';
	if (resultMsg != '') alert(resultMsg);
	
    function fnDoLogin() {
    	$('form[name=loginFrm]')[0].submit();
    }
    </script>
</head>

<style>
.col-lg-4{margin:auto}
</style>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<h1>로그인</h1>

	<div class="login-container">
		<div class="row">
			<!-- 입력폼 그리드 -->
			<div class="col-lg-4">
				<form id="loginFrm" action="<%= request.getContextPath() %>/member/memberLogin" method="POST">
					<!-- ID입력 -->
					<div class="input-group mt-3 mb-1">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">ID</span>
						</div>
						<input type="text" name="memberId" class="form-control"
							placeholder="아이디를 입력하세요" aria-label="Input ID"
							aria-describedby="basic-addon1" required>
					</div>
					<!-- PW입력 -->
					<div class="input-group mb-2">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">PW</span>
						</div>
						<input type="password" name="password" class="form-control"
							placeholder="비밀번호를 입력하세요" aria-label="Input Password"
							aria-describedby="basic-addon1" required>
					</div>
					<!-- 자동 로그인 -->
					<div class="custom-control custom-checkbox mb-1">
						<input type="checkbox" class="custom-control-input"
							name="isAutoLogin" value="true" id="customCheck1"> <label
							class="custom-control-label" for="customCheck1">로그인 유지</label>
					</div>
					<!-- 로그인 버튼 -->
					<button type="submit" class="btn btn-black btn-sm btn-block" onclick="javascript:fnLogin();">
						로그인</button>
				</form>
			</div>
		</div>
	</div>
		
		
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>