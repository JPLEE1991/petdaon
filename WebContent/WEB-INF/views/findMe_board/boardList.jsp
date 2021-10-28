<%@page import="com.petdaon.mvc.findMe_board.model.vo.BoardExt"%>
<%@page import="com.petdaon.mvc.findMe_board.model.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- header시작 -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container">
	<input class="float-right" type="button" value="테스트" onclick="location.href='<%= request.getContextPath() %>/findMe_board/boardView';" />
  <div class="row row-cols-1 row-cols-md-3 g-4">
<%
	List<Board> list = (List<Board>)request.getAttribute("list");
	for(Board _board : list){
		BoardExt board = (BoardExt)_board;
%>


<!-- 내용 시작 -->
    
    <div class="col">
      <div class="card h-100">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title"><%= board.getAddress() %></h5>
          <p class="card-text"><%= board.getAnimalType() +"["+ board.getBreed()+"]" %></p>
          <p class="card-text"><%= board.getMissDate() %></p>
        </div>
      </div>
    </div>
    <!-- <div class="col">
      <div class="card h-100">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">서울시 용산구</h5>
          <p class="card-text">고양이(페르시안)</p>
          <p class="card-text">2021-10-09</p>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card h-100">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">서울시 강동구</h5>
          <p class="card-text">고양이(페르시안)</p>
          <p class="card-text">2021-10-09</p>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card h-100">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">서울시 강동구</h5>
          <p class="card-text">고양이(페르시안)</p>
          <p class="card-text">2021-10-09</p>
        </div>
      </div>
    </div>
  </div>
  <br><br><br><br>
  <div class="row row-cols-1 row-cols-md-3 g-4">
    <div class="col">
      <div class="card h-100">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">서울시 강동구</h5>
          <p class="card-text">고양이(페르시안)</p>
          <p class="card-text">2021-10-09</p>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card h-100">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">서울시 용산구</h5>
          <p class="card-text">고양이(페르시안)</p>
          <p class="card-text">2021-10-09</p>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card h-100">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">서울시 강동구</h5>
          <p class="card-text">고양이(페르시안)</p>
          <p class="card-text">2021-10-09</p>
        </div>
      </div>
    </div>
    <div class="col">
      <div class="card h-100">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">서울시 강동구</h5>
          <p class="card-text">고양이(페르시안)</p>
          <p class="card-text">2021-10-09</p>
        </div>
      </div>
    </div>
  </div> -->
  <br />
<%
	}
%>
  		<!--글쓰기 버튼  -->
  	<div class="pagination" id='pageBar'><%= request.getAttribute("pagebar") %></div>
  	
    <div class="container">
    	<input class="btn-primary float-right" type="button" value="글쓰기" id="btn-add" onclick="location.href='<%= request.getContextPath() %>/findMe_board/boardForm';" />
      <div class="row">
        <div class="col">
          <ul class="pagination">
            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">4</a></li>
            <li class="page-item"><a class="page-link" href="#">5</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
          </ul>
        </div>
      </div>
    </div>
</div>
 

<%-- <%@ include file="/WEB-INF/views/common/footer.jsp" %> --%>
  