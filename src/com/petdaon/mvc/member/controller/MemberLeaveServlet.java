package com.petdaon.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;

/**
 * Servlet implementation class MemberBlack
 */
@WebServlet("/member/memberLeave")
public class MemberLeaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private MemberService memberService = new MemberService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		this.getServletContext().getRequestDispatcher("/WEB-INF/views/member/memberLeave.jsp").forward(request, response);
	}
	
	/*
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession	session	= req.getSession(true);
		
		// 세션의 멤버를 가져옴
		Member	member	= (Member)session.getAttribute(Constants.SESSION_KEY);
		String memberId = member.getMemberId();
		
		memberService.leaveMember(memberId);	// 탈퇴
		session.invalidate();					// 로그인정보 제거
		
		// 메인으로 이동.
		String url = this.getServletContext().getContextPath();
		
		System.out.println("url = " + url);
		
		res.sendRedirect(url);
	
	}

}
