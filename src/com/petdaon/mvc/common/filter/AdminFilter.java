package com.petdaon.mvc.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;

/**
 * Servlet Filter implementation class AdminFilter
 */
@WebFilter({ 
	"/admin/memberList",
	"",
	""
})
public class AdminFilter implements Filter {

	/**
	 * 관리자가 아닌 부정요청에 대한 처리
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// servlet 가기전!
		//admin login여부 확인
		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpServletResponse httpRes = (HttpServletResponse) response;
		
		// 세션가져오기
		HttpSession session = httpReq.getSession();
		
		Member member = (Member)httpReq.getSession(true).getAttribute(Constants.SESSION_KEY);
		//System.out.println("[관리자 권한 페이지 요청 @AdminFilter]");
		
		if(member == null || !MemberService.ADMIN_ROLE.equals(member.getMemberRole())) {
			session.setAttribute("msg", "관리자 권한이 없습니다.");
			httpRes.sendRedirect(httpReq.getContextPath() + "/");
			
			return; // 내필기 - 리턴함. 이하코드 실행하지 않음. return문은 현재 실행중인 메서드를 종료하고 호출한 메서드로 되돌아간다.
		}

		// pass the request along the filter chain
		chain.doFilter(request, response);
		
		// servlet 다녀온후!
	}
}
