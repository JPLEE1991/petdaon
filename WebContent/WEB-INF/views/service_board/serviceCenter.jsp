<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>고객센터</title>
    <style>
    #ask-container {height:300px; padding:20px;}
    #ask-text {}
    #ask {}
    #asklist {}
    </style>
  </head>
  <body>
  <%@ include file="/WEB-INF/views/common/header.jsp" %>
  
    <h1 class="text-center">고객센터</h1>

	<!-- 문의 -->
    <div class="container card" id="ask-container">
    <p class="card-text" id="ask-text">안녕하세요, 도움이 필요하신가요?</p>
	    <div class="row">
		    <!-- 1:1문의 -->
		    <div class="col-lg-6 col-md-6 col-sm-6">
			    <div class="card" id="ask">
				  <div class="card-body">
				    <a href="<%= request.getContextPath() %>/askBoard/boardForm">1:1문의 ></a>
				    <p class="card-text">질문을 남겨주시면<br/>꼼꼼히 확인하고 답변 드리겠습니다.</p>
				  </div>
				</div>
		    </div>
			<!-- 문의내역 -->
			<div class="col-lg-6 col-md-6 col-sm-6">
				<div class="card" id="asklist">
				  <div class="card-body">
				    <a href="<%= request.getContextPath() %>/askBoard/boardList">나의 문의내역 ></a>
				    <p class="card-text">나의 문의내역에서는<br/>1:1문의 내역을 확인할 수 있습니다.</p>
				  </div>
				</div>
			</div>
	    </div>
    </div>
	
	<!-- 공지사항 -->
	

    <!-- Optional JavaScript; choose one of the two! -->
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->
  <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>