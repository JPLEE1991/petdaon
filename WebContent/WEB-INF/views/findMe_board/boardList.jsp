<%@page import="com.petdaon.mvc.findMe_board.model.vo.BoardExt"%>
<%@page import="com.petdaon.mvc.findMe_board.model.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<style>
	#btn {text-align:center; padding:30px 0;}
	#btn span.cPage {color:black; padding:6px 12px; background-color:#FFD749; border-radius:15%;}
	#btn a {color:black; text-decoration:none; padding:6px 12px; background-color:#eeeeee; border-radius:15%;}
	#btn a:hover {background-color:#FFD749;}
	


.container1 {
  position: relative;
}

.card-img-top {
  display: block;
  height: 15vw;
;
}

.overlay {
  position: absolute; 
  bottom: 0; 
  background: rgba(0, 0, 0, 0.5); /* Black see-through */
  color: #f1f1f1; 
  width: 100%;
  transition: .5s ease;
  opacity:0;
  color: white;
  font-size: 20px;
  text-align: center;
}

.container1 .overlay {
  opacity: 1;
}
	
</style>
    
<!-- header시작 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>




<div class="container"><!-- div 1  -->
  <div class="row row-cols-1 row-cols-md-3"> <!-- div2  -->
<%
	List<Board> list = (List<Board>)request.getAttribute("list");
	for(Board board : list){
%>
    
	<div class="col-md-4">	<!-- div3  -->
      
<!--첨부 이미지가 없을 때,-->
      <div class="card mr-1 mb-3">

<%
	if(board.getAttach() == null) {
%>
			<div class="container1">
				<img class="card-img-top" src="<%= request.getContextPath() %>/images/findMe_list_sample.png" alt=""/>

<!--첨부 이미지가 있을 때, -->									
<%
	}else{
%>
			<div class="container1">
	     	   <img class="card-img-top" src="<%= request.getContextPath() %>/upload/findMe_board/<%= board.getAttach().getRenamedFilename() %>" alt="신고 사진">
<%
	}
%>
<!-- 상태에 따른 표기  -->
				<div 
					class="overlay"
<% if("발견".equals(board.getStatus()) ) { %> 
					style="background: rgba(255, 188, 3, 0.5)"
<% } else if("보호".equals(board.getStatus())){ %>				
					style="background: rgba(51, 255, 0, 0.5)"
<% } %>
					><%=board.getStatus() %>				
				</div>
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
  	
  	
<!--글쓰기 버튼  -->
	<div>
	    <div id="btn"><%= request.getAttribute("pagebar") %></div>
   	<input class="btn-primary float-right" type="button" value="글쓰기" id="btn-add" onclick="location.href='<%= request.getContextPath() %>/findMe_board/boardForm';" />
	</div>
    
    
	
</div><!-- div1  -->

<br />



 

<%-- <%@ include file="/WEB-INF/views/common/footer.jsp" %> --%>
  