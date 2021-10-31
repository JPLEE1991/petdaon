package com.petdaon.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;

/**
 * Servlet implementation class memberEnrollServlet
 */
@WebServlet("/member/memberEnroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//view단 처리
		req
		.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp")
		.forward(req, res);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String memberId = req.getParameter("memberId");
		String memberName = req.getParameter("memberName");
		String memberRole = Constants.MEMBER_ROLE_M;
		String password = MvcUtils.getEncryptedPassword(req.getParameter("password"));
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String status = Constants.STATUS_Y;
		String photo = req.getParameter("photo");
		String quitdate = req.getParameter("guitdate");
		
		
		Member member = new Member(memberId, password, memberName, memberRole, null, email, phone, null, status, quitdate, photo, null);
		
		memberService.insertMember(member);
		
		req
		.getRequestDispatcher("/WEB-INF/views/member/welcome.jsp")
		.forward(req, res);
	}
}
