package com.petdaon.mvc.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.member.model.vo.Member;


/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter({ 
	"/volunteerBoard/boardForm",
	"/views/bulletin_board/boardForm",
	"/bulletin_board/boardUpdate",
	"/bulletin_board/boardDelete"
})
public class LoginFilter implements Filter {

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// login여부 확인
		HttpServletRequest httpReq = (HttpServletRequest) request; // getSession사용하기 위해 작성. 따라서 자식타입으로 변환함
		HttpSession session = httpReq.getSession();
		Member member = (Member)httpReq.getSession(true).getAttribute(Constants.SESSION_KEY);
		
		if(member == null) {
			session.setAttribute("msg", "로그인후 이용할 수 있습니다.");
			HttpServletResponse httpRes = (HttpServletResponse) response;
			httpRes.sendRedirect(httpReq.getContextPath() + "/");
			
			return;
		}
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

}
