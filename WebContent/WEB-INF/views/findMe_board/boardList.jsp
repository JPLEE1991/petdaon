<%@page import="com.petdaon.mvc.findMe_board.model.vo.BoardExt"%>
<%@page import="com.petdaon.mvc.findMe_board.model.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- header시작 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	List<Board> list = (List<Board>)request.getAttribute("list");
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
%>

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
}

.overlay {
  position: absolute; 
  bottom: 0; 
  background: rgba(0, 0, 0, 0.5); /* Black see-through */
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

.comOverlay{
  position: absolute; 
  top: 10px;
  right: 10px;
  background: rgba(255, 0, 0, 0.5); /* Black see-through */
  width: 15%;
  color: white;
  /* font-size: 15px; */
  text-align: center;
  border-radius: 5px;
}

/* 검색영역 css */
div#search-container {margin:0 0 10px 0; padding:3px;}
div#search-memberId {display: <%= searchType == null || "writer".equals(searchType) ? "inline-block" : "none" %>; }
div#search-gender {display: <%= "gender".equals(searchType) ? "inline-block" : "none" %>;}	
div#search-animalType {display: <%= "animalType".equals(searchType) ? "inline-block" : "none" %>;}
div#search-status {display: <%= "status".equals(searchType) ? "inline-block" : "none" %>;}
div#search-completeYN {display: <%= "completeYN".equals(searchType) ? "inline-block" : "none" %>;}
form{margin:0 0}
div#search-container button{font-size: 0.7em; padding: 8px 15px; margin-bottom: 5px }
#searchType{height: 30px; margin-top: 2.5px; margin-right: 5px; width:8vw;}
div input{margint-right:5px}

</style>



<div class="container"><!-- div 1  -->

<!--검색 기능  -->
 <div id="search-container" class="d-flex justify-content-center">
	        <select id="searchType">검색: 
	            <option value="memberId" <%= "memberId".equals(searchType) ? "selected" : "" %>>아이디</option>		
	            <option value="animalType" <%= "animalType".equals(searchType) ? "selected" : "" %>>종류</option>
	            <option value="gender" <%= "gender".equals(searchType) ? "selected" : "" %>>성별</option>
	            <option value="status" <%= "status".equals(searchType) ? "selected" : "" %>>상태</option>
	            <option value="completeYN" <%= "completeYN".equals(searchType) ? "selected" : "" %>>완료여부</option>
	        </select>
	        <div id="search-memberId" class="search-type">
	            <form action="<%=request.getContextPath()%>/findMe_board/finder">
	                <input type="hidden" name="searchType" value="writer"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." value="<%= "writer".equals(searchType) ? searchKeyword : "" %>" class=""/>
	                <button type="submit" class="btn btn-primary">검색</button>			
	            </form>	
	        </div>
	        <div id="search-animalType" class="search-type">
	            <form action="<%=request.getContextPath()%>/findMe_board/finder">
	                <input type="hidden" name="searchType" value="animalType"/>
	                <input type="radio" name="searchKeyword" value="강아지" <%= "animalType".equals(searchType) && "강아지".equals(searchKeyword) ? "checked" : "" %>> 강아지
	                <input type="radio" name="searchKeyword" value="고양이" <%= "animalType".equals(searchType) && "고양이".equals(searchKeyword) ? "checked" : "" %>> 고양이
   	                <input type="radio" name="searchKeyword" value="기타" <%= "animalType".equals(searchType) && "기타".equals(searchKeyword) ? "checked" : "" %>>기타
	                <button type="submit" class="btn btn-primary">검색</button>
	            </form>	           	
	        </div>
	        <div id="search-gender" class="search-type">
	            <form action="<%=request.getContextPath()%>/findMe_board/finder">
	                <input type="hidden" name="searchType" value="gender"/>
	                <input type="radio" name="searchKeyword" value="수컷" <%= "gender".equals(searchType) && "수컷".equals(searchKeyword) ? "checked" : "" %>> 수컷
	                <input type="radio" name="searchKeyword" value="암컷" <%= "gender".equals(searchType) && "암컷".equals(searchKeyword) ? "checked" : "" %>> 암컷
   	                <input type="radio" name="searchKeyword" value="미확인" <%= "gender".equals(searchType) && "미확인".equals(searchKeyword) ? "checked" : "" %>>미확인
	                <button type="submit" class="btn btn-primary">검색</button>
	            </form>
	        </div>
	        <div id="search-status" class="search-type">
	        	<form action="<%=request.getContextPath()%>/findMe_board/finder">
	                <input type="hidden" name="searchType" value="status"/>	        	
	        		<select id="searchType" name="searchKeyword" id="">
	        			<option value="실종" <%= "실종".equals(searchKeyword) ? "selected":"" %>>실종</option>
	        			<option value="보호" <%= "보호".equals(searchKeyword) ? "selected":"" %>>보호</option>
	        			<option value="목격" <%= "목격".equals(searchKeyword) ? "selected":"" %>>목격</option>
	        		</select>
		                <button type="submit" class="btn btn-primary">검색</button>	        			
	        	</form>
	        </div>
	        <div id="search-completeYN" class="search-type">
	        	<form action="<%=request.getContextPath()%>/findMe_board/finder">
	                <input type="hidden" name="searchType" value="completeYN"/>	        	
	        		<select id="searchType" name="searchKeyword" id="">
	        			<option value="N" <%= "N".equals(searchKeyword) ? "selected":"" %>>진행 중</option>
	        			<option value="Y" <%= "Y".equals(searchKeyword) ? "selected":"" %>>완료</option>
	        		</select>
		                <button type="submit" class="btn btn-primary">검색</button>	        			
	        	</form>
	        </div>	        
	    </div>

<!--/검색 기능  -->

  <div class="row "> <!-- div2  -->
<%
	for(Board board : list){
%>
	<div class="col-md-4">	<!-- div3  -->
      
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
			          <p class="card-title text-truncate">위치: <%= board.getAddress() %></p>
			          <p class="card-text text-truncate">종류: <%= board.getAnimalType() +"["+ board.getBreed()+"]" %></p>
			          <p class="card-text text-truncate">특징: <%= board.getCharacter() %></p>
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
<%
	if(_member.getMemberId()!=null && _member.getMemberId()!=""){
%>
	<div>
   	<input class="btn btn-primary float-right" type="button" value="글쓰기" id="btn-add" onclick="location.href='<%= request.getContextPath() %>/findMe_board/boardForm';" />
	    <div id="btn"><%= request.getAttribute("pagebar") %></div>
	</div>
<%
	}
%>
    
	
</div><!-- div1  -->

<br />

<script>
$("#searchType").change((e) => {
	console.log("searchType 테스트");
	// e.target 이벤트발생객체 -> #searchType
	const type = $(e.target).val();
	
	// 1. .search-type 감추기
	$(".search-type").hide();
	
	// 2. #search-${type} 보여주기(display:inline-block)
	$(`#search-\${type}`).css("display", "inline-block");
});
</script>

 
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<%-- <%@ include file="/WEB-INF/views/common/footer.jsp" %> --%>
  