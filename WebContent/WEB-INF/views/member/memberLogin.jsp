<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
String resultMsg = (String)request.getAttribute("resultMsg");
resultMsg = resultMsg == null ? "" : resultMsg;
%>

<style>
#div{
	width:100px;
	margin: 0 auto; 
	
}
.col-lg-4{margin:auto}
h1 {text-align:center}
</style>
 
 <script type="text/javascript">
	var resultMsg = '<%=resultMsg%>';
	if (resultMsg != '') alert(resultMsg);
	
    function fnDoLogin() { 
    	$('form[name=loginFrm]')[0].submit();
    }
    
   	$(() => {
   		/**
   		* 로그인 유효성 검사
   		*/
   		$(document.loginFrm).submit(e => {
   			const $memberId = $(memberId);
   			const $password = $(password);
   			//memberId체크
   			if(!/^.{4,}$/.test($memberId.val())){
   				alert("아이디를 입력하세요.");
   				$memberId.select();
   				e.preventDefault();
   				return;
   			}
   			//비밀번호 체크
   			if(!/^.{4,}$/.test($password.val())){
   				alert("비밀번호를 입력하세요.");
   				$password.select();
   				e.preventDefault();
   				return;

   			}
   		});
   	});
    </script>
			
<%
    // 로그인 유지작업 
    Cookie[] cookies = request.getCookies();
    if(cookies != null ){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("id")){
                /* 실행흐름이 서버에 있을 경우 서버코드로써 강제이동
                       서버에서 클라이언트()에게 특정페이지로 이동하는 정보만 응답으로 준다.
                   java코드로 페이지 이동 -> sendRedirect("url");
                */
                response.sendRedirect("index.jsp");
            }
        }
    }
%>

<br><br><br><br>

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
		

<%@ include file="/WEB-INF/views/common/footer.jsp" %>