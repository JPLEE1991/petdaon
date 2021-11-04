<%@page import="com.petdaon.mvc.common.vo.Attachment"%>
<%@page import="com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bulletin_board/board.css" />

<%
	BulletinBoard board = (BulletinBoard) request.getAttribute("board");
%>

<section id="board-container">
<h2>게시판 작성</h2>
<form
	name="boardUpdateFrm"
	action="<%= request.getContextPath() %>/bulletin_board/boardUpdate" 
	method="post"
	enctype="multipart/form-data">
	<input type="hidden" name="no" value="<%= board.getNo() %>" />
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="title" value="<%= board.getTitle() %>" required></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="writer" value="<%= _member.getMemberId() %>" readonly/>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td style="position:relative;">
		   <input type="file" name="upFile">
<% 
	Attachment attach = board.getAttach();
	if(attach != null){ 
%>
			<span id="fname"><%= attach.getOriginalFilename() %></span>	
			<br />
			<input type="checkbox" name="delFile" id="delFile" value="<%= attach.getNo() %>"/>
			<label for="delFile">기존파일삭제</label>
<% } %>
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="40" name="content"><%= board.getContent() %></textarea></td>
	</tr>
	<tr>
		<th>동물분류</th>
		<td>
		  <select class="form-select" name="animal" id="animal">
		  <option value="<%= board.getAnimal()%>" selected>동물을 선택해주세요</option>
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
			  <option value="<%= board.getDetail()%>" selected>세부분류를 선택해주세요</option>
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
			<input type="submit" value="수정하기"/>
			<input type="button" value="취소" onclick="history.go(-1);"/>
		</th>
	</tr>
	</table>
</form>
</section>
<script>
<% if(attach != null) { %>
$("[name=upFile]").change((e) => {
	// 파일 선택여부 
	const $file = $(e.target);
	console.log($file.val());
	if($file.val() != ""){
		// 파일선택한 경우
		$(fname).hide();
		$(delFile)
			.prop("checked", true)
			.hide()
			.next()
			.hide();
	}
	else {
		// 파일선택을 취소한 경우
		$(fname).show();
		$(delFile)
			.show()
			.next()
			.show();
	}
	
});
<% } %>

$(document.boardUpdateFrm).submit(function (){
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
});
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>