<%@page import="com.petdaon.mvc.member.model.vo.Member,
				com.petdaon.mvc.common.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/member/mypageHeader.jsp" %>
    
<%
Member member = (Member)request.getAttribute("member");
%>

<script type="text/javascript">
function fnUpdate() {
	$('#uploadForm').submit();
}

function fnDelPhoto() {
	$('input[name=delPhoto]').val('Y');
	$('#uploadForm').submit();
}

</script>
	

<div class="container">
		
		<form id="uploadForm" action="<%= request.getContextPath() %>/member/myDetail" method="post" enctype="multipart/form-data">
		<%--이미지 업로드 --%>  
			<div id="photo">
				<%
				if (StringUtils.isEmpty(member.getPhoto())) { 
				%>
				<img id="profile" src="<%= request.getContextPath() %>/images/findMe_sampleImg.png" alt="대표 사진" style="width:100px"/>
				<%
				} else {
				%>		
				<img id="profile" src="<%= request.getContextPath() %><%=member.getPhoto() %>" alt="대표 사진" style="width:100px"/>
				<%  
				
				}
				%>			
				<br />
				<input 
					type="file" 
				    onchange="document.getElementById('profile').src = window.URL.createObjectURL(this.files[0])"
				    name="upFile">
			</div>
			
			<div class="form-group">
				<label for="memberId">아이디</label>
				<input type="text" id="memberId" name="memberId" class="form-control" placeholder="아이디를 입력해주세요" value="<%=member.getMemberId() %>" readonly="readonly" />
				<input type="hidden" name="delPhoto" value="N" />
			</div>
			<div class="form-group">
				<label for="memberName">이름</label>
				<input type="text" id="memberName" name="memberName" class="form-control" placeholder="이름을 입력해주세요" value="<%=member.getMemberName() %>" readonly="readonly" />
			</div>
			<div class="form-group">
				<label for="phone">휴대폰</label>
				<input type="text" id="phone" name="phone" class="form-control" placeholder="휴대폰번호" value="<%=member.getPhone() %>"/>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="text" id="email" name="email" class="form-control" placeholder="이메일" value="<%=member.getEmail() %>"/>
			</div>
			<div class="form-group">
				<label for="birthday">생년월일</label>
				<input type="text" id="birthday" name="birthday" class="form-control" placeholder="생년월일" value="<%=member.getBirthday()%>"/>
			</div>
			<button type="submit" class="btn btn-info btn-lg btn-block" onclick="javascript:fnGoList(); return false;">취소</button>
			<button type="submit" class="btn btn-info btn-lg btn-block" onclick="javascript:fnUpdate(); return false;">수정</button>
			<button type="submit" class="btn btn-info btn-lg btn-block" onclick="javascript:fnDelPhoto(); return false;">사진삭제</button>
		</form>
	</div>
	
	<br><br><br><br><br>
	<%@ include file="/WEB-INF/views/member/mypageFooter.jsp" %>
