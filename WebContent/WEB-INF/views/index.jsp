<%@page import="com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard"%>
<%@page import="com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard"%>
<%@page import="com.petdaon.mvc.findMe_board.model.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
.card-img-top {
  display: block;
  height: 8vw;
}

.overlay {
  position: absolute; 
  bottom: 7em; 
  background: rgba(0, 0, 0, 0.5); /* Black see-through */
  width: 100%;
  transition: .5s ease;
  opacity:0;
  color: white;
  font-size: 15px;
  text-align: center;
}

.container1 .overlay {
  opacity: 1;
}

.comOverlay{
  position: absolute; 
  top: 1vh;
  right: 10px;
  background: rgba(255, 0, 0, 0.5); /* Black see-through */
  width: 15%;
  color: white;
  font-size: .6vw; 
  text-align: center;
  border-radius: 5px;
}
.card-text, .card-title{
	font-size: 10px;
	margin-bottom: 2px;
}

 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: black;}

.title{
	margin: auto;
	width: 10%;
	border-bottom-style: solid;
	border-bottom-color: #ffbc03;
	border-bottom-width: 0.2vw;
	text-align: center;
	margin-bottom: 3vh;
}
h5{
	margin: 1px;
}
</style>
<div class="container">
<!--서블릿에서 리스트 불러오기  -->
<%
	List<Board> findMeBoardList = (List<Board>)request.getAttribute("findMeBoardList");
	List<VolunteerBoard> volunteerBoardList = (List<VolunteerBoard>)request.getAttribute("volunteerBoardList");
	List<NoticeBoard> noticeList = (List<NoticeBoard>)request.getAttribute("noticeList");
%>



<!-- 나를 찾아줘 게시물  목록-->
<div class="title">
	<h5>나를 찾아줘</h5>
</div>

  <div class="row justify-content-center"> <!-- div2  -->
<%
	for(Board board : findMeBoardList){
%>
	<div class="col-md-2">	<!-- div3  -->
      
	<!--첨부 이미지가 없을 때,-->
      <div class="card mr-1 mb-3">

			<div class="container1">
	<%
		if(board.getAttach() == null) {
	%>
				<img class="card-img-top" src="<%= request.getContextPath() %>/images/findMe_list_sample.png" alt=""/>

	<!--첨부 이미지가 있을 때, -->									
	<%
		}else{
	%>
	     	   <img class="card-img-top" src="<%= request.getContextPath() %>/upload/findMe_board/<%= board.getAttach().getRenamedFilename() %>" alt="신고 사진">
	<%
		}
	%>
<!-- 상태에 따른 표기  -->
				<div 
					class="overlay"
	<% if("목격".equals(board.getStatus()) ) { %> 
					style="background: rgba(255, 188, 3, 0.5)"
	<% } else if("보호".equals(board.getStatus())){ %>				
					style="background: rgba(51, 255, 0, 0.5)"
	<% } %>
					><%=board.getStatus() %>				
				</div>
	<% if("Y".equals(board.getCompleYN())) { %>
				<div
					class="comOverlay"
				><%= "Y".equals(board.getCompleYN())? "완료":"진행중" %></div>
	<% } %>				
			</div>
	        <div class="card-body">
		       	 <a href="<%=request.getContextPath() %>/findMe_board/boardView?no=<%= board.getNo()%>">
			          <p class="card-title text-truncate"><%= board.getAddress() %></p>
			          <p class="card-text text-truncate"><%= board.getAnimalType() +"["+ board.getBreed()+"]" %></p>
			          <p class="card-text text-truncate"><%= board.getCharacter() %></p>
			          <p class="card-text"><%= board.getMissDate() %></p>        
		       	 </a>
	        </div>
		</div>
        
      </div><!-- /div3  -->
 
<%
	}
%>
	</div><!-- div2 -->
<hr />
<!-- 봉사게시물  목록-->
<div class="title">
	<h5>봉사게시판</h5>
</div>

  <div class="row "> <!-- div2  -->
<%
	for(VolunteerBoard volunteerBoard : volunteerBoardList){
%>
	<div class="col-md-4">	<!-- div3  -->
      
	<!--첨부 이미지가 없을 때,-->
      <div class="card mr-1 mb-3">

			<div class="container1">
	<%
		if(volunteerBoard.getThumbnail() == null) {
	%>
				<img class="card-img-top" src="<%= request.getContextPath() %>/<%= volunteerBoard.getThumbnail() %>" alt=""/>

	<!--첨부 이미지가 있을 때, -->									
	<%
		}else{
	%>
	     	   <img class="card-img-top" src="<%= request.getContextPath() %>/upload/volunteer_board/<%= volunteerBoard.getThumbnail() %>" alt="신고 사진">
	<%
		}
	%>

			
			</div>
	        <div class="card-body">
		       	 <a href="<%=request.getContextPath() %>/volunteerBoard/boardView?no=<%= volunteerBoard.getNo()%>">
			          <p class="card-title text-truncate">위치: <%= volunteerBoard.getTitle() %></p>
			          <p class="card-text text-truncate">종류: <%= volunteerBoard.getDay()%></p>
			          <p class="card-text text-truncate">특징: <%= volunteerBoard.getCapacity() %></p>
		       	 </a>
	        </div>
		</div>
        
      </div><!-- /div3  -->
 
<%
	}
%>
	</div><!-- div2 -->	
	
<hr />
	<div class="row">
		<!-- 공지사항 게시물  목록-->
		<div class="col-6">
			<table class="table">
			  <thead>
			    <tr>
			      <th colspan="4" style="text-align: center">공지사항</th>
			    </tr>
			  </thead>
			  <tbody>
<% for(NoticeBoard noticeBoard : noticeList){ %>
				<a href="<%= request.getContextPath() %>/serviceCenter/noticeBoard/noticeBoardView?no=<%= noticeBoard.getNo() %>">
				  	<tr>
				      <td><%= noticeBoard.getTitle() %></td>
				      <td><a href=""><%= noticeBoard.getContent() %></a></td>
				    </tr>
				</a>
<% } %>					    				  	
			  </tbody>
			</table>
		</div>
		
		<!-- 입양임보 게시물  목록-->
		<div class="col-6">
			<table class="table">
			  <thead>
			    <tr>
			      <th colspan="4" style="text-align: center">입양임보</th>
			    </tr>
			  </thead>
			  <tbody>
<% for(NoticeBoard noticeBoard : noticeList){ %>
			  	<tr>
			      <td><%= noticeBoard.getTitle() %></td>
			      <td><%= noticeBoard.getContent() %></td>
			    </tr>
<% } %>					    				  	
			  </tbody>
			</table>
		</div>		
				
	</div>
		
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>