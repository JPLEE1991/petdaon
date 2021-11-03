<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.petdaon.mvc.member.model.vo.Member,
				com.petdaon.mvc.member.model.service.MemberService,
				java.util.List"%>
<%
List<Member> list = (List<Member>)request.getAttribute("list");
String searchType = request.getParameter("searchType"); // 검색한 타입 얻어옴?
String searchKeyword = request.getParameter("searchKeyword"); // 검색한 키워드 얻어옴?
%>

<style>
form {
	margin-bottom : 0;
}
select {
	height:30px;
}
select option{
	font-size: 12px;
}
.form-select{
	font-size: 12px;
}

/* 테이블 overflow 설정 */
.table.table-ellipsis tbody td {
    max-width: 100px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

div#search-memberId {display: <%= searchType == null || "memberId".equals(searchType) ? "inline-block" : "none" %>;}
div#search-memberName{display: <%= "memberName".equals(searchType) ? "inline-block" : "none" %>;}
div#search-memberShip{display: <%= "memberShip".equals(searchType) ? "inline-block" : "none" %>;}

.form-control {
	padding: 0;
}
</style>

<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>

	
	<div class="container row" style="margin:0 auto;">
	<div class="col-md-12">
	<div id="search-container" class="d-flex justify-content-start">
		 <!-- 검색타입 :  -->
		        <select id="searchType" class="form-select form-select-sm" style="width:100px;">
		            <option value="memberId" <%= "memberId".equals(searchType) ? "selected" : "" %>>아이디</option>		
		            <option value="memberName" <%= "memberName".equals(searchType) ? "selected" : "" %>>이름</option>
		            <option value="memberShip" <%= "memberShip".equals(searchType) ? "selected" : "" %>>회원권한</option>
		        </select>
		          <div id="search-memberId" class="search-type">
		            <form action="<%=request.getContextPath()%>/admin/memberFinder">
		              <input type="hidden" name="searchType" value="memberId"/>
		                <%-- 사용자 입력값을 받을 부분 --%>
		                <input type="text" class="form-control w-auto d-inline-block" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." value="<%= "memberId".equals(searchType) ? searchKeyword : "" %>"/>
		                <button type="submit" class="btn btn-primary btn-sm">검색</button>			
		            </form>	
		             </div>
		        	<div id="search-memberName" class="search-type">
		        		<form action="<%=request.getContextPath()%>/admin/memberFinder">
		                <input type="hidden" name="searchType" value="memberName"/>
		                <input type="text" class="form-control w-auto d-inline-block" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요." value="<%= "memberName".equals(searchType) ? searchKeyword : "" %>"/>
		                <button type="submit" class="btn btn-primary btn-sm">검색</button>			
		            </form>	
		        	</div>
		        		<div id="search-memberRole" class="search-type">
		        		<form action="<%=request.getContextPath()%>/admin/memberFinder">
		                <input type="hidden" name="searchType" value="memberRole"/>
		                <input type="text" class="form-control w-auto d-inline-block" name="searchKeyword" size="25" placeholder="회원권한을 입력하세요" value="<%= "memberRole".equals(searchType) ? searchKeyword : "" %>"/>
		                <button type="submit" class="btn btn-primary btn-sm">검색</button>			
		            </form>	
		        	</div>
		       </div>
		</div>
		        	
		<div class="col-md-12">
			<!-- 테이블 -->
		  	<div class="table-responsive-xl">
			  	<table class="table table-ellipsis">
				  <thead>
				    <tr class="table-secondary">
				      <th scope="col">아이디</th>
				      <th scope="col">이름</th>
				      <th scope="col">회원권한</th>
				      <th scope="col">휴대폰</th>
				      <th scope="col">가입일</th>
				      <th scope="col">상태</th>
				      <th scope="col">경고횟수</th>
				    </tr>
				  </thead>
				  <tbody>
							<%
							for (int i = 0; i < list.size(); i++) {
								Member member = list.get(i);
							%>
							<tr>
								<td>
									<a href="<%=request.getContextPath()%>/admin/adminmemberDetail?memberId=<%=member.getMemberId() %>"><%=member.getMemberId() %></a>
								</td>
								<td>
									<a href="<%=request.getContextPath()%>/admin/adminmemberDetail?memberId=<%=member.getMemberId() %>"><%=member.getMemberName() %></a>
								</td>
								<td><%=member.getMemberRole() %></td>
								<td><%=member.getPhone() %></td>
								<td><%=member.getEnroll_date() %></td>
								<td><%=member.getStatus() %></td>
								<td><%=member.getWarning_count() %></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				
	<!-- 페이징버튼 -->
	<div style="text-align: center;">
				<div id="pageBar" class="d-inline-block">
					<%= request.getAttribute("pagebar") %>
				</div>
			</div>
			</div>
		</div>
	</div>
	
	



<script src="<%=request.getContextPath()%>/resource/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>


</body>
</html>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>




<%@ include file="/WEB-INF/views/admin/adminFooter.jsp" %>