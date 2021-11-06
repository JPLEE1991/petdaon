package com.petdaon.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.common.StringUtils;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;


/**
 * Servlet implementation class MemberLoginServlet
 */
@WebServlet("/member/memberLogin")
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MemberService memberService = new MemberService();
 
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String resultMsg = "";
		String memberId = StringUtils.getString(req.getParameter("memberId"));
		String password = StringUtils.getString(req.getParameter("password"));
		
		Member member = memberService.selectOneMember(memberId);
		if (member == null) {	// 사용자정보 없을때
			resultMsg = "아이디와 비밀번호를 확인하세요";
			
		} else {
			String encPassword = MvcUtils.getEncryptedPassword(password);
			if ("N".equals(member.getStatus())) {				// 탈퇴한 회원.
				resultMsg = "탈퇴한 회원입니다.";
				
			} else if (!encPassword.equals(member.getPassword())) {	// 비밀번호 불일치
				resultMsg = "아이디와 비밀번호를 확인하세요";
				
			} else {											// 인증성공
				req.getSession(true).setAttribute(Constants.SESSION_KEY, member);

				String url = this.getServletContext().getContextPath();
				res.sendRedirect(url);
				return;
			}
		}

		req.setAttribute("resultMsg", resultMsg);
		
		req
		.getRequestDispatcher("/WEB-INF/views/member/memberLogin.jsp")
		.forward(req, res);
	}

}