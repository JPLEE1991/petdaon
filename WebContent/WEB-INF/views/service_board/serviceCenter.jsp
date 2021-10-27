<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/serviceCenter.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

    <h2 class="text-center">고객센터</h2>

	<!-- 문의 -->
    <div class="container">
    	<div class="card">
	    	<p class="card-text">안녕하세요, 도움이 필요하신가요?</p>
		    <div class="row">
			    <!-- 1:1문의 -->
			    <div class="col-lg-6 col-md-6 col-sm-6">
				    <div class="card">
					  <div class="card-body">
					    <a href="<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardForm">1:1문의 ></a>
					    <p class="card-text">질문을 남겨주시면<br/>꼼꼼히 확인하고 답변 드리겠습니다.</p>
					  </div>
					</div>
			    </div>
				<!-- 문의내역 -->
				<div class="col-lg-6 col-md-6 col-sm-6">
					<div class="card">
					  <div class="card-body">
					    <a href="<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardList">나의 문의내역 ></a>
					    <p class="card-text">나의 문의내역에서는<br/>1:1문의 내역을 확인할 수 있습니다.</p>
					  </div>
					</div>
				</div>
		    </div>
    	</div>
    </div>
	
	<!-- 공지사항 -->
	<div class="card">
	  <div class="card-body text-center">
	  	<a href="<%= request.getContextPath() %>/serviceCenter/noticeBoard/noticeBoardList">공지사항 더보기 ></a>
	  </div>
	</div>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>