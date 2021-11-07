<%@page import="com.petdaon.mvc.member.model.service.MemberService"%>
<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.service.AskBoardService"%>
<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<%
	List<AskBoard> list = (List<AskBoard>) request.getAttribute("list");
%>
<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/css/serviceCenter/boardList.css"/> --%>
<!-- 부트스트랩(CSS & JavaScript Bundle with Popper) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 매테리얼 아이콘 -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">

<style>
h2 {padding:30px; margin:0 auto; text-align:center;}
.material-icons-round {font-size:1em;}
.card {border-radius:.8rem;}
#breadcrumb {border:0; margin:0 auto; background-color:#ffd749; height:300px;}
#breadcrumb nav {padding:30px 15px; font-size:18px;}
#breadcrumb nav li a.nav-link {color:#212529;}
#asklist-container {height:700px;}
#asklist {height:899px; border:0; margin:0 auto; background-color:white; padding:15px 30px; top:-28.5%;}
.table tbody tr:hover {background-color:none; cursor:pointer;}
.table td {border-top:0px; padding:30px 10px; text-align:center;}
.table td:last-child {font-size:13px; vertical-align:middle; color:#efbc1f;}
#inquirycontent {width:300px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; margin:0 auto; color:#8e929f;}
#btn {padding:30px 0; display:flex; justify-content:center; align-items:center;}
#btn a {display:flex; justify-content:center; align-items:center; text-decoration:none; border-radius:15%; margin:0 2px; color:#212529; width:35px; height:35px; background-color:#eceef2;}
#btn a.cPage {background-color:#ffd749;}
#btn a:hover {background-color:#ffd749;}
</style>
	
	<div class="container">
		<div class="row">
		
			<h2>고객센터</h2>
			
			<!-- 사용자경로 -->
			<div id="breadcrumb" class="card col-11 col-xxl-10 position-relative">
				<nav class="navbar justify-content-start">
					<li class="nav-item">
				       <a class="nav-link" href="<%= request.getContextPath() %>/serviceCenter">고객센터</a>
				    </li>
				    <span class="material-icons-round">chevron_right</span>
				    <li class="nav-item">
				       <a class="nav-link" href="#">나의 문의내역</a>
				    </li>
				</nav>
			</div>
			
			<!-- 나의 문의내역 -->
			<div id="asklist-container" class="container col-11 col-xxl-10">
				<div id="asklist" class="card col-11 position-absolute start-50 translate-middle-x">
					<table class="table">
						<tbody>
						    <%
								for(AskBoard askBoard : list) {
									if(_member.getMemberId().equals(askBoard.getWriter())){
							%>
							<tr id="ask" onClick="openView(<%= askBoard.getInquiryNo() %>)">
								<td>문의번호 : <%= askBoard.getInquiryNo() %></td>
								<td><%= askBoard.getInquiryTitle() %></td>
								<td><p class="d-none d-sm-block d-sm-none d-md-block d-md-none d-lg-block" id="inquirycontent"><%= askBoard.getInquiryContent() %></p></td>
								<td>
									<%=
										askBoard.getStatus().equals("D") ? "접수" :
										askBoard.getStatus().equals("C") ? "접수취소" :
										askBoard.getStatus().equals("I") ? "처리중" : "처리완료"
									%>
									<%-- <select class="status">
			            				<option
			            					value="<%= AskBoardService.D_STATUS %>"
			            					<%= AskBoardService.D_STATUS.equals(askBoard.getStatus()) ? "selected" : "" %>>접수</option>
			            				<option
			            					value="<%= AskBoardService.C_STATUS %>"
			            					<%= AskBoardService.C_STATUS.equals(askBoard.getStatus()) ? "selected" : "" %>>접수취소</option>
			            				<option
			            					value="<%= AskBoardService.I_STATUS %>"
			            					<%= AskBoardService.I_STATUS.equals(askBoard.getStatus()) ? "selected" : "" %>>처리중</option>
			            				<option
			            					value="<%= AskBoardService.F_STATUS %>"
			            					<%= AskBoardService.F_STATUS.equals(askBoard.getStatus()) ? "selected" : "" %>>처리완료</option>
			            			</select> --%>
								</td>
							</tr>
							<%
									}
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
			
			<!-- 페이징버튼 -->
			<div>
			    <div id="btn"><%= request.getAttribute("pagebar") %></div>
			</div>
			
		</div>
	</div>
	<br><br>
	
<script>
function openView(inquiryNo){
	const width = 400;
	const height = 400;
	const x = (screen.availWidth - width) / 2 + screen.availLeft;
	const y = (screen.availHeight - height) / 2 + screen.availTop;
	const url = '<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardView?inquiryNo=' + inquiryNo;
	open(url, 'popup', `width=\${width}, height=\${height}, left=\${x}, top=\${y}`);
};
</script>
	
<%@ include file="/WEB-INF/views/common/footer.jsp" %>