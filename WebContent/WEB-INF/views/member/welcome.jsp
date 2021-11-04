<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
>
<style>
h1 {
	padding: 30px;
	margin: 0 auto;
	text-align: center;
}

</style>
</head>
<body>



	<h1>회원가입이 완료되었습니다</h1>
	<h3 text align="center">펫다온의 멤버가 되신걸 환영합니다</h3>
	<div class="d-flex justify-content-center my-3">
	<button type="button" class="col-sm-2 btn btn-secondary btn-lg mx-3" 
		onclick="location.href='<%=request.getContextPath()%>'">메인으로
		이동하기</button>
	<button type="button" class="col-sm-2 btn btn-primary btn-lg mx-3" 
		onclick="location.href='<%=request.getContextPath()%>/member/memberLoginForm'">로그인</button>
	</div>


<br><br><br><br><br><br><br><br><br><br><br><br><br>







<%@ include file="/WEB-INF/views/common/footer.jsp"%>