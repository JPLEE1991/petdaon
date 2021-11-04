<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adoptWriting</title>
<style>
/*게시판*/
section#board-container{width:600px; margin:0 auto; text-align:center;}
section#board-container h2{margin:10px 0;}
table#tbl-board{width:100%; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
table#tbl-board th, table#tbl-board td {border:1px solid; padding: 5px 0; text-align:center;} 

/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}

/*페이지바*/
div#pageBar{margin-top:10px; text-align:center; background-color:rgba(0, 188, 212, 0.3); }
div#pageBar span.cPage{color: #0066ff; margin-right: 5px;}
div#pageBar a{margin-right: 5px;}

/*게시글 작성/상세보기 테이블*/
table#tbl-board-view {
	width:500px; 
	margin:0 auto; 
	border:1px solid black; 
	border-collapse:collapse;  
}
table#tbl-board-view th {
	width: 150px; 
	border:1px solid; 
	padding: 10px 0; 
	text-align:center; 
} 
table#tbl-board-view td {
	border:1px solid; 
	padding: 5px 0 5px 15px; 
	text-align:left;
}

/*게시글 수정하기*/
span#fname{
    position: absolute;
    left: 92px;
    top: 10px;
    width: 255px;
    background: #f5f5f5;
}
#del_file+label{font-size:.8em; position:relative; top:-3px;}

/*댓글등록버튼*/
div.comment-container button#btn-insert{width:60px; height:50px; color:white; background:#3300ff; position:relative; top:-20px;}

/*댓글테이블*/
table#tbl-comment{width:580px; margin:0 auto; border-collapse:collapse;} 
table#tbl-comment tr td{border-bottom:1px solid; border-top:1px solid; padding:5px; text-align:left; line-height:120%;}
table#tbl-comment tr td:first-of-type{padding: 5px 5px 5px 50px;}
table#tbl-comment tr td:last-of-type {text-align:right; width: 100px;}
table#tbl-comment button.btn-reply{display:none;}
table#tbl-comment tr:hover {background:lightgray;}
table#tbl-comment tr:hover button.btn-reply{display:inline;}
table#tbl-comment sub.comment-writer {color:navy; font-size:14px}
table#tbl-comment sub.comment-date {color:tomato; font-size:10px}

table#tbl-comment tr.level2 {color:gray; font-size: 14px;}
table#tbl-comment tr.level2 td:first-of-type{padding-left:100px;}
table#tbl-comment tr.level2 sub.comment-writer {color:#8e8eff; font-size:14px}
table#tbl-comment tr.level2 sub.comment-date {color:#ff9c8a; font-size:10px}

/*답글관련*/
table#tbl-comment textarea{margin: 4px 0 0 0;}
table#tbl-comment button.btn-insert2{width:60px; height:23px; color:white; background:#3300ff; position:relative; top:-5px; left:10px;}

/* 삭제버튼관련 */
table#tbl-comment button.btn-delete{background:red; color:white; display:none;}
table#tbl-comment tr:hover button.btn-delete{display:inline;}
</style>
</head>



<script>
/**
* boardEnrollFrm 유효성 검사
*/
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

$(() => {
	$(document.boardEnrollFrm).submit(boardValidate);
});
</script>
<section id="board-container">
<h2>입양/임보 사이트 추가</h2>
<form
	name="boardEnrollFrm"
	action="<%=request.getContextPath() %>/board/boardEnroll" 
	method="post"
	enctype="multipart/form-data">
	<table id="tbl-board-view">
    <tr>
        <th> 사이트 이름</th>
        <td><input type="text" name="title" required></td>
    </tr>
	<tr>
		<th>사이트 링크</th>
		<td><input type="text" name="title" required></td>
	</tr>

	<th>사이트 사진</th>
		<td>			
			<input type="file" name="upFile">
	<tr>
		<th>사이트 정보</th>
		<td><textarea rows="5" cols="40" name="content"></textarea></td>
	</tr>

	<tr>
		<th colspan="2">
			<input type="submit" value="등록하기">
		</th>
	</tr>

</table>
</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<!-- 
<form name="listFrm" action="">
	<fieldset>
		<legeng>등록</legeng>
		<label for="name">이름</label>
		<input type="text" name="name" id="name" />
		<br />
		<input type="file" name="img" id="img" />
		<button type="button" id="btn-list-save">저장</button>
	</fieldset>
</form>

<script>
/**
 * ajax로 폼데이터전송(비동기)
 * - file upload : FormData객체를 통한 전송
 * - enctype="multipart/form-data" 관련 설정
 */
$("#btn-list-save").click((e) => {
	const frmData = new FormData(document.listFrm);
	console.log(frmData);
	
	return;
	
	$.ajax({
		url: "<%= request.getContextPath() %>/celeb/insert",
		data: "",
		success(data){
			console.log(data);
		},
		error: console.log
	});
});
</script>
 -->
