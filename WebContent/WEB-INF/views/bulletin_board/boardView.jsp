<%@page import="com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard"%>

<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	BulletinBoard board = (BulletinBoard) request.getAttribute("board");
%>

<style>
/* SNS공유 */
.link-icon { position: relative; display: inline-block; width: auto;    font-size: 14px; font-weight: 500; color: #333; margin-right: 10px; padding-top: 50px; width:40px }
.link-icon.twitter { background-image: url(<%=request.getContextPath()%>/images/icon-twitter.png); background-repeat: no-repeat; }
.link-icon.facebook { background-image: url(<%=request.getContextPath()%>/images/icon-facebook.png); background-repeat: no-repeat; } 
.link-icon.kakao { background-image: url(<%=request.getContextPath()%>/images/icon-kakao.png); background-repeat: no-repeat; }

.shareBtn { 
	display: inline-block; 
	margin-top: 20px;
	margin-left: 320px;
	}
</style>
<!--SNS 카카오톡 공유  -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>


<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bulletin_board/board.css" />
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		<tr>
			<th>글번호</th>
			<td><%= board.getNo() %></td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><%= board.getTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%= board.getWriter() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%= board.getReadCount() %></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<% 	if(board.getAttach() != null){ %>
				<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
				<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width=16px>
				<a href="<%= request.getContextPath() %>/board/fileDownload?no=<%= board.getAttach().getNo() %>"><%= board.getAttach().getOriginalFilename() %></a>
				<% 	} %>
			</td>
		</tr>
		<tr>
			<th>내 용</th>
			<td>
				<%= board.getContent() %>
			</td>
		</tr>
		
		<tr>
			<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
			<th colspan="2">
				<input type="button" value="수정하기" onclick="updateBoard()">
				<input type="button" value="삭제하기" onclick="deleteBoard()">
			</th>
		</tr>

	</table>
	
		<!-- SNS 공유버튼 모음  -->
		<div class="row text-center" style="float: none; margin 0 center">
			<div class="shareBtn">
				<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();"></a>
				<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();"></a>    
				<a id="btnKakao" class="link-icon kakao" href="javascript:shareKakao();"></a>   			
			</div>
		</div>
		<!-- / SNS공유 버튼 모음 end-->
	
	<hr style="margin-top:30px"/>
	
	
	<div class="comment-container">
		<div class="comment-editor">
			<form 
				action="<%= request.getContextPath() %>/board/boardCommentEnroll" 
				name="boardCommentFrm" 
				method="POST">
				<textarea name="content" cols="60" rows="3"></textarea>
				<button id="btn-insert">등록</button>
				
				<input type="hidden" name="commentLevel" value="1" />
				<input type="hidden" name="writer" value="" />
				<input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
				<input type="hidden" name="commentRef" value="0" />
			</form>
		</div>
	</div>
<form 
	action="<%= request.getContextPath() %>/board/boardCommentDelete" 
	name="boardCommentDelFrm"
	method="POST">
	<input type="hidden" name="no" />
	<input type="hidden" name="boardNo" value="<%= board.getNo() %>"/>
</form>

<script>
$(".btn-delete").click(function(e){
	//이벤트핸들러 안 this는 이벤트발생객체(일반익명함수)
	console.log(this);
	console.log(e.target);
	console.log(e.target === this);
	
	if(confirm("해당 댓글을 삭제하시겠습니까?")){
		var $frm = $(document.boardCommentDelFrm);
		var no = $(this).val();
		$frm.find("[name=no]").val(no);
		$frm.submit();
	}
});	
</script>

</section>

<form action="<%= request.getContextPath() %>/bulletin_board/boardDelete" name="deleteBoardFrm">
	<input type="hidden" name="no" value="<%= board.getNo() %>" />
</form>
<script>
const updateBoard = 
() => location.href = "<%= request.getContextPath() %>/bulletin_board/boardUpdate?no=<%= board.getNo() %>";
/**
 * 삭제할 때 저장된 첨부파일이 있다면, 파일삭제!
 * - java.io.File API참조
 */
const deleteBoard = () => {
	if(confirm("정말 이 게시물을 삭제하시겠습니까?")){
		$(document.deleteBoardFrm).submit();
	}
};
</script>



<script>
$(".btn-reply").click((e) => {
	const commentRef = $(e.target).val();
	const tr = `<tr>
	<td colspan="2" style="text-align: left;">
		<form 
			action="<%= request.getContextPath() %>/board/boardCommentEnroll" 
			method="POST">
			<textarea name="content" cols="60" rows="1"></textarea>
			<button class="btn-insert2">등록</button>
			
			<input type="hidden" name="commentLevel" value="2" />
			<input type="hidden" name="writer" value="<%= _member != null ? _member.getMemberId() : "" %>" />
			<input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
			<input type="hidden" name="commentRef" value="\${commentRef}" />
		</form>
	</td>
</tr>`;
	console.log(tr);
	
	const $trOfBtn = $(e.target).parent().parent();
	// $trOfBtn.after(tr);
	$(tr)
		.insertAfter($trOfBtn)
		.find("form")
		.submit((e) => {

			loginAlert();
			return false;

			// 내용검사
			// const textarea = $("[name=content]", document.boardCommentFrm);	
			const $textarea = $("[name=content]", e.target);	
			
			if(!/^(.|\n)+$/.test($textarea.val())){
				alert("댓글 내용을 작성해주세요.");
				$textarea.focus();
				return false;
			}
		})
		.find("[name=content]")
		.focus();
	
	// 현재버튼의 handler 제거
	$(e.target).off('click');
});



$("[name=content]", document.boardCommentFrm).focus((e) => {

	loginAlert();

});

$(document.boardCommentFrm).submit((e) => {

	loginAlert();
	return false;


	// 내용검사
	// const textarea = $("[name=content]", document.boardCommentFrm);	
	const $textarea = $("[name=content]", e.target);	
	
	if(!/^(.|\n)+$/.test($textarea.val())){
		alert("댓글 내용을 작성해주세요.");
		$textarea.focus();
		return false;
	}
	
});

const loginAlert = () => {
	alert("로그인후 이용할 수 있습니다.");
	$("#memberId").focus();
};


/* SNS공유  */
//트위터 공유
function shareTwitter() {
  var sendText = "<%=board.getTitle()%>"; // 전달할 텍스트
  var sendUrl = "http://192.168.0.43:9090/<%=request.getContextPath()%>"; // 전달할 URL
  window.open("https://twitter.com/intent/tweet?text=" + sendText + "&url=" + sendUrl);
}
//페북 공유 기능
function shareFacebook() {
  var sendUrl = "http://192.168.0.43:9090/<%=request.getContextPath()%>"; // 전달할 URL
  window.open("http://www.facebook.com/sharer/sharer.php?u=" + sendUrl);
}
//카카오 공유 기능
function shareKakao() {
	 
	  // 사용할 앱의 JavaScript 키 설정
	  Kakao.init('81fc3c40931e5c23dfea9c79c1a7abc4');
	 
	  // 카카오링크 버튼 생성
	  Kakao.Link.createDefaultButton({
	    container: '#btnKakao', // 카카오공유버튼ID
	    objectType: 'feed',
	    content: {
	      title: "<%=board.getTitle()%>", // 보여질 제목
	      description: "<%=board.getContent()%>", // 보여질 설명
	      //local 서버 내에 있는 이미지라 링크가 걸리지 않음. 임의 이미지 링크 걸어놓음.
	      imageUrl: "https://i.ytimg.com/vi/1aDQnoGS_2c/maxresdefault.jpg", // 콘텐츠 URL
	      link: {
	         mobileWebUrl: 'http://localhost:9090<%=request.getContextPath()%>/findMe_board/boardView?no=<%= board.getNo() %>',
	         webUrl: 'http://localhost:9090<%=request.getContextPath()%>/findMe_board/boardView?no=<%= board.getNo() %>'
	      }
	    }
	  });
	}

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
