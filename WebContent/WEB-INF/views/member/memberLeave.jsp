<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/member/mypageHeader.jsp"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member/memberLeave.css" />	
<script>
function fnLeave() {
	$('#leaveFrm')[0].submit();
	alert("탈퇴되었습니다");
}
</script>
<style>
    ul li{
       list-style: circle;
    }

    .yellow_txt {color: gold;}

    .box {
        border: 1px solid #ccc;
        padding: 50px;
    }
</style>
<div class="outer">
	<form id="leaveFrm"
		action="<%=request.getContextPath()%>/member/memberLeave"
		method="post">
		<h2>회원탈퇴</h2>
		<fieldset id="leaveFrm">

			

				<div class="box">
				<ul>
					<li>사용하고 계신 아이디(<%=_member.getMemberId() %>)는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</li>
					<li>회원 탈퇴시 회원 아이디로 작성된 게시물과 댓글을 자동으로 삭제되지 않습니다.</li>
					<li>탈퇴 후에는 재사용이 불가능합니다.</li>
				</ul>
				<input type="checkbox"><span>안내 사항을 모두 확인하였으며, 이에 동의합니다.</span>
        	</div>
			

			<button type="submit" id="leave" onclick="javascript:fnGoList();">취소</button>
			<button type="submit" id="leave" onclick="javascript:fnLeave();">탈퇴</button>
		</fieldset>
	</form>
</div>

    <script>
    	$(function(){
    				
    			($("input:checkbox[id='allCheck']").click(function(){
    			if($("input:checkbox[id='allCheck']").prop("checked")){
    			
    				$(".foot>input[type='checkbox']").attr("checked", true);
    			
    			
    			}else{
    				$(".foot>input[type='checkbox']").attr("checked", false);
    			}
    			agree_checked();
    			
    		}));
    		
    		
    	});
    	$(".foot").change(function(){
    		agree_checked();
    	});
    		function agree_checked(){
    			if($("#c1").prop("checked")){
    				console.log("체크");
    				$("#agree").removeAttr("disabled");
    			}else{
    				console.log("체크안됨");
    			}
    		}
    		
		   
    </script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
