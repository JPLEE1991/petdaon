<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/member/mypageHeader.jsp" %>
<div class="container-fluid" >
	
	<div class="join-title"><h1>비밀번호 변경</h1></div>
	<div class="row">
		<div class="col-sm-6 col-sm-offset-3">
			<div class="panel panel-default">
				<div class="panel-body">
		<form 
			name="updatePwdFrm" 
			action="<%=request.getContextPath()%>/member/updatePassword" 
			method="post" >
			<div class="form-group">
					<label for="oldPassword">현재 비밀번호</label>
							<input type="password" id="oldPassword" name="oldPassword" class="form-control" required>
						</div>
						<div class="form-group">
							<label for="newPassword">새로운 비밀번호</label>
							<input type="password" id="newPassword" name="newPassword" class="form-control" required>
						</div>
						<div class="form-group">
							<label for="newPasswordCheck">비밀번호 확인</label>
							<input type="password" id="newPasswordCheck" name="newPasswordCheck" class="form-control" required>
						</div>
						<td colspan="2" style="text-align: center;">
					<input type="submit"  value="변경" />
					</td>
				</div>
			</div>
		</div>
	</div>	
	</div>			
	
	<script>
	/**
	 * 폼제출 유효성검사
	 */ 
	$("[name=updatePwdFrm]").submit(function(){
		var $oldPassword = $("#oldPassword");
		var $newPassword = $("#newPassword");
		
		if(!passwordValidate()){
			return false;
		}
		
		if($oldPassword.val() == $newPassword.val()){
			alert("기존비밀번호와 신규비밀번호는 같을 수 없습니다.");
			$oldPassword.select();
			return false;
		}
		
		return true;	
	
	});
	
	/**
	 * 
	 */ 
	$("#newPasswordCheck").blur(passwordValidate);
	
	/**
	 * 신규비밀번호 일치 검사 
	 */ 
	function passwordValidate(){
		var $newPassword = $("#newPassword");
		var $newPasswordCheck = $("#newPasswordCheck");
		if($newPassword.val() != $newPasswordCheck.val()){
			alert("입력한 비밀번호가 일치하지 않습니다.");
			$newPassword.select();
			return false;
		}
		return true;	
	}
	
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
