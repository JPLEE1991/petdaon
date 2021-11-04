package com.petdaon.mvc.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.common.MvcUtilsBootStrap;
import com.petdaon.mvc.common.StringUtils;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;

/**
 * Servlet implementation class memberEnrollServlet
 */
@WebServlet("/admin/adminmemberList")
public class AdminMemberListServlet extends HttpServlet {
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
		int startRownum = cPage * numPerPage - (numPerPage - 1);
		int endRownum = cPage * numPerPage;
		
		List<Member> list = memberService.selectMemberList(keyword, startRownum, endRownum);
		
		//b.pagebar영역 
		//totalContents, url 준비
		int totalContents = memberService.selectMemberListCount(keyword);
		String url = req.getRequestURI();
		String pagebar = MvcUtilsBootStrap.getPagebar(cPage, numPerPage, totalContents, url);

	//	System.out.println("totalContents = " + totalContents);
		
		//3.view단 forwarding
		req.setAttribute("list", list);
		req.setAttribute("keyword", keyword);
		req.setAttribute("pagebar", pagebar);
		req
			.getRequestDispatcher("/WEB-INF/views/admin/adminmemberList.jsp")
			.forward(req, res);
	}
}
