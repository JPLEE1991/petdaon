<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bulletin_board/board.css" />


<script>
/**
* boardEnrollFrm 유효성 검사
*/

$(() => {
	$(document.boardEnrollFrm).submit(boardValidate);
});

function boardValidate(e){
	const $title = $("[name=title]");
	const $content = $("[name=content]");
	//제목을 작성하지 않은 경우 폼제출할 수 없음.
	if(!/^.+$/.test($title.val())){
		alert("제목을 입력하세요.");
		return false;
	}
					   
	//내용을 작성하지 않은 경우 폼제출할 수 없음.
	// .(임의의 문자)에는 \n(개행문자)가 포함되지 않는다.
	if(!/^(.|\n)+$/.test($content.val())){
		alert("내용을 입력하세요.");
		return false;
	}
	return true;
}
</script>

<h2>게시판 작성</h2>
<form
	name="boardEnrollFrm"
	action="<%= request.getContextPath() %>/bulletin_board/boardEnroll" 
	method="post"
	enctype="multipart/form-data">
	
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="title" required></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="writer" value="<%= _member.getMemberId() %>" readonly/>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>			
			<input type="file" name="upFile">
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="40" name="content"></textarea></td>
	</tr>
	<tr>
		<th>동물분류</th>
		<td>
		  <select class="form-select" name="animal" id="animal">
		  <option value="" selected>동물을 선택해주세요</option>
		  <option value="D">강아지</option>
		  <option value="C">고양이</option>
		  <option value="F">기타</option>
		</select>	
		</td>
	</tr>
	<tr>
		<th>세부분류</th>
		<td>
			<select class="form-select" name="detail" id="detail">
			  <option value="" selected>세부분류를 선택해주세요</option>
			  <option value="G">일반</option>
			  <option value="Q">질문</option>
			  <option value="I">정보공유</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td>
			<input type="text" name="category" value="B" />
		</td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="등록하기">
		</th>
	</tr>
</table>
</form>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>