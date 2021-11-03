package com.petdaon.mvc.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.member.model.service.MemberService;

/**
 * Servlet implementation class MemberBlack
 */
@WebServlet("/admin/adminmemberBlack")
public class AdminMemberBlackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private MemberService memberService = new MemberService();

	/*
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String memberId = req.getParameter("memberId");
		
		memberService.blackMember(memberId);
		
		String url = this.getServletContext().getContextPath() + "/admin/adminmemberDetail?memberId=" + memberId;
		
		System.out.println("url = " + url);
		
		res.sendRedirect(url);
	
	}

}
