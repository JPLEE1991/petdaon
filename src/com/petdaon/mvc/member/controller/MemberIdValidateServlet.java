package com.petdaon.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;

/**
 * 아이디 중복확인
 * 
 * @author dbwld
 */
@SuppressWarnings("serial")
@WebServlet("/member/memberIdValidate")
public class MemberIdValidateServlet extends HttpServlet {
	
	private MemberService memberService = new MemberService();

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doValidate(req, res);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doValidate(req, res);
	}
	
	private void doValidate(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String memberId = req.getParameter("memberId");
		Member member = memberService.selectOneMember(memberId);
		
		String result = "O"; 
		if (member != null) result = "X";
		
		res.getOutputStream().write(result.getBytes());
		res.getOutputStream().flush();
	}

}
