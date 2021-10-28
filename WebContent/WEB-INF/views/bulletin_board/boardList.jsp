<%@page import="java.util.List"%>
<%@page import="com.petdaon.mvc.bulletin_board.model.vo.BoardExt"%>
<%@page import="com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bulletin_board</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<style>
	@CHARSET "UTF-8";
/*게시판*/
section#board-container{width:800px; margin:0 auto; text-align:center;}
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

.nav-item>a {
  	text-align:center;
  }
 .nav-item {
  	margin: 30px;
  }
 .btn-w {
	display: flex;
	justify-content:flex-end;
	margin-right:30px;
  }
</style>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<BulletinBoard> list = (List<BulletinBoard>) request.getAttribute("list");
%>

<section id="board-container">
	<h2>자유게시판</h2>
	<!-- animal icon nav -->
  <nav class="navbar navbar-expand-lg navbar-light container justify-content-end">
    <div class="collapse navbar-collapse justify-content-center">
      <ul class="navbar-nav">
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/all.png" width="70"; />
          <a class="nav-link" href="<%= request.getContextPath() %>/findMe_board/boardList">전체</a>
        </li>
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/pet.png" width="70";/>
          <a class="nav-link" href="#">강아지</a>
        </li>
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/cat.png" width="70"; />
          <a class="nav-link" href="#">고양이</a>
        </li>
        <li class="nav-item">
          <img src="<%= request.getContextPath() %>/images/pawprint.png" width="70"; />
          <a class="nav-link" href="#">자유</a>
        </li>
      </ul>
    </div>
  </nav>
	<table id="tbl-board">
		<tr>
			<th>번호</th>		
			<th>말머리</th>		
			<th>제목</th>	
			<th>작성자</th>	
			<th>작성일</th>
			<th>첨부파일</th>	
			<th>조회수</th>				
		</tr>
<%
	for(BulletinBoard board : list){		
%>
	<tr>
		<td><%= board.getNo() %></td>
		<td></td>
		<td><%= board.getTitle() %></td>
		<td><%= board.getWriter() %></td>
		<td><%= board.getRegDate() %></td>
		<td></td>
		<td><%= board.getReadCount() %></td>
	</tr>
<%
	}
%>		
		
		
	</table>
</section>
<br />


<div class="btn-w">
<a type="button" class="btn btn-outline-secondary" href="<%= request.getContextPath() %>/views/bulletin_board/boardForm.jsp">글쓰기</a>
</div>

<br />
<br />
<br />
<br />
<br />

<%@ include file="/WEB-INF/views/common/footer.jsp" %>