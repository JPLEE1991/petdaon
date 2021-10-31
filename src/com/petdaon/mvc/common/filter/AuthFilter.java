package com.petdaon.mvc.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.member.model.vo.Member;

/**
 * Servlet Filter implementation class EncodingFilter
 */
@WebFilter("/*")
public class AuthFilter implements Filter {
	private String exceptUrls = "/member/memberLoginForm,/member/memberLogin,/member/memberEnroll,/member/agreeForm,/member/memberIdValidate";
  
	/**
	 * FilterChain에서 실행순서
	 * 1. web.xml에 선언된 순서
	 * 2. @WebFilter annotation을 사용하는 경우. 필터이름순서로 처리
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req 	= (HttpServletRequest)request;
		
		String uri = req.getRequestURI().replace("/petdaon", "");
		System.out.println("AuthFilter]uri = " + uri);
		
		if (exceptUrls.indexOf(uri) == -1) {	// 검증필요
			Member member = (Member)req.getSession(true).getAttribute(Constants.SESSION_KEY);
			if (member == null)	{
				req.setAttribute("resultMsg", ".로그인이 필요합니다.");
				
				req
				.getRequestDispatcher("/WEB-INF/views/member/memberLogin.jsp")
				.forward(request, response);
				return;
			}
		}
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

}
