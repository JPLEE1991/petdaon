<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/WEB-INF/views/member/mypageHeader.jsp" %>
<section id=enroll-container>
		<h2>비밀번호변경</h2>
		<form 
			name="updatePwdFrm" 
			action="<%=request.getContextPath()%>/member/updatePassword" 
			method="post" >
			<table>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="oldPassword" id="oldPassword" required></td>
				</tr>
				<tr>
					<th>변경할 비밀번호</th>
					<td>
						<input type="password" name="newPassword" id="newPassword" required>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>	
						<input type="password" id="newPasswordCheck" required><br>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<input type="submit"  value="변경" />
					</td>
				</tr>
			</table>
		</form>
	</section>
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
