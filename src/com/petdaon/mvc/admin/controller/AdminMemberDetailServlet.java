package com.petdaon.mvc.admin.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.StringUtils;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;

/*
 * Servlet implementation class MemberDetailServlet
 */
@WebServlet("/admin/adminmemberDetail")
public class AdminMemberDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//view단 처리
		String memberId = req.getParameter("memberId");
		Member member = memberService.selectMemberView(memberId);
		req.setAttribute("member", member);
		
		req
		.getRequestDispatcher("/WEB-INF/views/admin/adminmemberDetail.jsp")
		.forward(req, res);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String memberId = req.getParameter("memberId");
		String memberName = req.getParameter("memberName");
		String memberRole = req.getParameter("memberRole");
		String email = StringUtils.getString(req.getParameter("email"));
		String phone = StringUtils.getString(req.getParameter("phone"));
		String birthday = req.getParameter("birthday");
		
		// yyyy-MM-dd
		Date date = null;
		try {
			date = Date.valueOf(birthday);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberName(memberName);
		member.setMemberRole(memberRole);
		member.setEmail(email);
		member.setPhone(phone);
		member.setBirthday(date);
		
		memberService.updateMember(member);
		
		String url = this.getServletContext().getContextPath() + "/admin/adminmemberDetail?memberId=" + memberId;
		
		System.out.println("url = " + url);
		
		res.sendRedirect(url);
	}

}
