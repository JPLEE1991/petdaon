<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.petdaon.mvc.common.Constants,
				com.petdaon.mvc.member.model.vo.Member"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<style>
        #mainHeader {
            background: #FFD749;
            height: 100px;
        }
        #login {
            text-align: right;
        }
        #navbar_ul {
            list-style: none;
            display: inline-block;
        }
        li {
            display: inline-block;
        }
        #mainHeader{
          line-height: 100px;
        }
        #mainHeader h2{
          display: inline;
          color: white;
        }
        #mainHeader a{
          text-decoration: none;
        }
        #login{
          display: inline;
          float: right;
          color: white;
        }
        #login>a{
          color: whitesmoke;
          text-decoration: none;
          font-weight: bold;
        }
</style>
<script>
<% 
	String msg = (String) session.getAttribute("msg");
	// System.out.println("msg@header.jsp = " + msg);
	if(msg != null) session.removeAttribute("msg");
	
%>
<% if(msg != null) { %>
	// ????????? ????????? ??????
	alert("<%= msg %>");
<% } %>
</script>
</head>
<body>
  <div id="mainHeader" >
    <div class="container">
      <a href="<%= request.getContextPath() %>"><h2>????????? Petdaon</h2></a>
       <div id="login">
      	<%
      	Member _member = (Member)request.getSession(true).getAttribute(Constants.SESSION_KEY);
      	%>
      	<%
      	if (_member == null) {
      	%>
        <a href="<%= request.getContextPath() %>/member/memberLoginForm">?????????</a>
        <a href="<%= request.getContextPath() %>/member/agreeForm">????????????</a>
        <%
      	} else {
        %>
        <a href="<%= request.getContextPath() %>/member/memberLogout">????????????</a>
        <%
        	if ("A".equals(_member.getMemberRole())) {
        %>
        	<a href="<%= request.getContextPath() %>/admin/adminmemberList">????????? ?????????</a>        
        <%
        	} else {
        %>
        	<a href="<%= request.getContextPath() %>/member/myDetail">???????????????</a>      
        <%
        	}
      	}
        %>
      </div>
    </div>
  </div>
  <nav class="navbar navbar-expand-lg navbar-light container justify-content-end">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-center" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="<%= request.getContextPath() %>/findMe_board/boardList">??????????????? <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= request.getContextPath() %>/bulletin_board/boardList">????????????</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= request.getContextPath() %>/volunteerBoard/boardList">???????????????</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= request.getContextPath() %>/serviceCenter">????????????</a>
        </li>
      </ul>
    </div>
  </nav>
		<section id="content"> 