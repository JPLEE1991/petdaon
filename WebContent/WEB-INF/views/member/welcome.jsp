<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>petdaon</title>
<style>
h1 {padding:30px; margin:0 auto; text-align:center;}
.table td {border-top:0px; padding:30px 10px; text-align:center;}
.table td:last-child {font-size:13px; vertical-align:middle; color:#efbc1f;}
.table tbody tr:hover {background-color:#FAFAFA;}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h1>회원가입이 완료되었습니다</h1>
<h3 text align="center">펫다온의 멤버가 되신걸 환영합니다</h3>
<button type="button" class="col-sm-2 btn btn-secondary btn-lg mx-3" >메인으로 이동하기</button>
<button type="button" class="col-sm-2 btn btn-primary btn-lg mx-3" onclick="location.href='<%= request.getContextPath() %>/member/memberLogin';">로그인</button>

</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>