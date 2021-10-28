<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/volunteer.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  
	<div class="container">
		<h2 class="text-center">1:1문의</h2>
		<p class="text-center">펫다온을 이용하시면서 불편하거나 개선할 사항이 있다면 문의해주세요.</p>
		<form name="askBoardEnrollFrm" action="<%=request.getContextPath() %>/askBoard/askBoardEnroll" method="post">
			<div class="row">
				<div class="col-md-8">
					<div class="input-group mb-3">
					  <span class="input-group-text" id="basic-addon1">작성자</span>
					  <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
					</div>
				</div>
				<div class="col-md-8">
					<label for="title" class="col-form-label">제목</label>
					<input type="text" placeholder="제목 입력" class="form-control" name="title" id="title">
				</div>
				<div class="col-md-10">
					<label for="contents" class="col-form-label">문의사항</label>
					<textarea class="form-control" placeholder="내용 입력" aria-label="With textarea" name="contents" id="contents" cols="20" rows="10"></textarea>
				</div>
			</div>
			
			<div class="row">
				<div class="d-flex justify-content-center my-3">
					<button type="button" class="col-sm-2 btn btn-secondary btn-lg mx-3">취소</button>
					<button type="submit" class="col-sm-2 btn btn-primary btn-lg mx-3">확인</button>
				</div>
			</div>
		</form>
	</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>