<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.service.AskBoardService"%>
<%@page import="com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>
<%
	List<AskBoard> list = (List<AskBoard>) request.getAttribute("list");
%>

<style>
.card {border-radius:.8rem;}
#asklist-container {margin:30px; padding:20px;}
#asklist {border:0; margin:0 auto; background-color:white; padding:15px 30px; top:-28.5%;}
.table tbody tr:hover {background-color:none; cursor:pointer;}
.table td {border-top:0px; padding:10px; text-align:center;}
.table td:last-child {font-size:13px; vertical-align:middle; color:#efbc1f;}
#inquirycontent {width:300px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; margin:0 auto; color:#8e929f;}
#btn {padding:30px 0; display:flex; justify-content:center; align-items:center;}
#btn a {display:flex; justify-content:center; align-items:center; text-decoration:none; border-radius:15%; margin:0 2px; color:#212529; width:35px; height:35px; background-color:#eceef2;}
#btn a.cPage {background-color:#ffd749;}
#btn a:hover {background-color:#ffd749;}
</style>

	<!--1:1문의 관리페이지 -->
			
	<!-- 회원 문의내역 -->
	<div id="asklist-container" class="container col-11 col-xxl-10">
		<div id="asklist" class="card col-12">
			<table class="table">
				<tbody>
				    <%
						for(AskBoard askBoard : list) {
					%>
					<tr id="ask">
						<td>문의번호 : <%= askBoard.getInquiryNo() %></td>
						<td onClick="openView(<%= askBoard.getInquiryNo() %>)"><%= askBoard.getInquiryTitle() %></td>
						<td><p class="d-none d-sm-block d-sm-none d-md-block d-md-none d-lg-block" id="inquirycontent"><%= askBoard.getInquiryContent() %></p></td>
						<td>
						<!-- 접수 또는 처리중인 상태만 접수상태 변경 가능 -->
						<% if(AskBoardService.STATUS_DEFAULT.equals(askBoard.getStatus()) || AskBoardService.STATUS_ING.equals(askBoard.getStatus())) { %>
						<!-- 접수상태 select option -->
							<select class="status" data-inquiry-no="<%= askBoard.getInquiryNo() %>">
			            		<option
			            			value="<%= AskBoardService.STATUS_DEFAULT %>"
			            			<%= AskBoardService.STATUS_DEFAULT.equals(askBoard.getStatus()) ? "selected" : "" %>>접수</option>
			            		<option
			            			value="<%= AskBoardService.STATUS_ING %>"
			            			<%= AskBoardService.STATUS_ING.equals(askBoard.getStatus()) ? "selected" : "" %>>처리중</option>
			            		<option
			            			value="<%= AskBoardService.STATUS_FINISH %>"
			            			<%= AskBoardService.STATUS_FINISH.equals(askBoard.getStatus()) ? "selected" : "" %>>처리완료</option>
			            	</select>
			            <% } else { %>
							<!-- 접수취소 또는 처리완료 상태는 select option 제공하지 않음 -->
							<%=
								askBoard.getStatus().equals("C") ? "접수취소" : "처리완료"
							%>
						<% } %>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		
		<!-- 페이징버튼 -->
		<div>
		    <div id="btn"><%= request.getAttribute("pagebar") %></div>
		</div>
	</div>

<form
    action="<%= request.getContextPath() %>/admin/askBoard/updateInquiryStatus"
   	method="POST"
    name="updateStatusFrm">
  	<input type="hidden" name="inquiryNo"/>
    <input type="hidden" name="status"/>
</form>		
<script>
$(document).ready(function(){
	$("#main-title").text('1:1문의');
});

/* 각 문의 클릭하면 해당하는 상세페이지를 팝업창으로 제공 */
function openView(inquiryNo){
	const width = 400;
	const height = 450;
	const x = (screen.availWidth - width) / 2 + screen.availLeft;
	const y = (screen.availHeight - height) / 2 + screen.availTop;
	const url = '<%= request.getContextPath() %>/serviceCenter/askBoard/askBoardView?inquiryNo=' + inquiryNo;
	/*
		window.open('url', '팝업명', '팝업 옵션');
		- width : 팝업창의 너비를 지정
		- height : 팝업창의 x축 위치를 지정
		- left : 팝업창의 y축 위치를 지정
	*/
	open(url, 'popup', `width=\${width}, height=\${height}, left=\${x}, top=\${y}`);
};

/* 접수 상태 변경 */
$(".status").change((e) => {
	const $this = $(e.target);
	const inquiryNo = $this.data("inquiryNo"); //data-속성의 키값을 camelcasing으로 처리
	const status = $this.val();
	
	let str = "";
	if(status == "<%= AskBoardService.STATUS_DEFAULT %>") {
		str = "접수";
	} else if(status == "<%= AskBoardService.STATUS_ING %>") {
		str = "처리중";
	} else {
		str = "처리완료";
	}
	
	const msg = `접수상태를 \${str}(으)로 변경하시겠습니까?`;
	if(confirm(msg)){
		const $frm = $(document.updateStatusFrm);
		$frm.find("[name=inquiryNo]").val(inquiryNo);
		$frm.find("[name=status]").val(status);
		$frm.submit();
	}
	else {
		//초기값으로 복귀
		$this.find("[selected]").prop("selected", true);
	}
});
</script>
			
<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>