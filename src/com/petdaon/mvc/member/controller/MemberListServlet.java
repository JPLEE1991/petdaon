package com.petdaon.mvc.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.common.StringUtils;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;

/**
 * Servlet implementation class memberEnrollServlet
 */
@WebServlet("/member/memberList")
public class MemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberService();

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doList(req, res);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doList(req, res);
	}
	
	/**
	 * 회원목록 조회
	 * 
	 * @param req
	 * @param res
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doList(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String keyword = StringUtils.getString(req.getParameter("keyword"));

		//1.사용자입력값처리 cPage numPerPage = 10
		int cPage = 1;
		int numPerPage = 10;
		try {
			cPage = Integer.parseInt(req.getParameter("cPage"));
		} catch(NumberFormatException e) {
		}
		
		//2.업무로직
		//a.content영역 - paging query
		int start = cPage * numPerPage - (numPerPage - 1);
		int end = cPage * numPerPage;

		System.out.println("cPage = " + cPage);
		System.out.println("keyword = " + keyword);
		System.out.println("start = " + start);
		System.out.println("end = " + end);
		
		List<Member> list = memberService.selectMemberList(keyword, start, end);
		
		//b.pagebar영역 
		//totalContents, url 준비
		int totalContents = memberService.selectMemberListCount(keyword);
		String url = req.getRequestURI();
		String pagebar = MvcUtils.getPagebar(cPage, numPerPage, totalContents, url);

		System.out.println("totalContents = " + totalContents);
		
		//3.view단 forwarding
		req.setAttribute("list", list);
		req.setAttribute("pagebar", pagebar);
		req
			.getRequestDispatcher("/WEB-INF/views/member/memberList.jsp")
			.forward(req, res);
	}
}
