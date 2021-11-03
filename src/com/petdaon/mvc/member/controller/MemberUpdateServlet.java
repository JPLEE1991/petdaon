package com.petdaon.mvc.member.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.common.MvcFileRenamePolicy;
import com.petdaon.mvc.common.StringUtils;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;

/**
 * Servlet implementation class MemberDetailServlet
 */
@WebServlet("/member/memberupdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	private static final String	UPLOAD_DIR	= "/upload/member_profile";

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		//view단 처리
		Member	sessionObj	= (Member)req.getSession(true).getAttribute(Constants.SESSION_KEY);
		
		String memberId = sessionObj.getMemberId();
		Member member = memberService.selectMemberView(memberId);
		req.setAttribute("member", member);
		
		req
		.getRequestDispatcher("/WEB-INF/views/member/memberUpdate.jsp")
		.forward(req, res);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String saveDirectory = getServletContext().getRealPath(UPLOAD_DIR);
		int maxPostSize = 1024 * 1024 * 10; 
		String encoding = "utf-8";
		FileRenamePolicy policy = new MvcFileRenamePolicy();
		MultipartRequest multipartRequest = new MultipartRequest(req, saveDirectory, maxPostSize, encoding, policy);
		String memberId = multipartRequest.getParameter("memberId");
		String email = StringUtils.getString(multipartRequest.getParameter("email"));
		String phone = StringUtils.getString(multipartRequest.getParameter("phone"));
		String birthday = multipartRequest.getParameter("birthday");
		String delPhoto = multipartRequest.getParameter("delPhoto");
		
		// yyyy-MM-dd
		Date date = null;
		try {
			date = Date.valueOf(birthday);
		} catch (Exception e) {
//			e.printStackTrace();
		}
		
		Member member = new Member();
		member.setMemberId(memberId);
		member.setPhone(phone);
		member.setEmail(email);
		member.setBirthday(date);
		
		// 첨부파일
		File f = multipartRequest.getFile("upFile");
		if(f != null) {
			System.out.println(UPLOAD_DIR + "/" + f.getName());
			member.setPhoto(UPLOAD_DIR + "/" + f.getName());
		}
		
		if ("Y".equals(delPhoto)) {
			member.setPhoto(null);
		}
		
		int	result	= memberService.updateMemberview(member);
		
		String url = this.getServletContext().getContextPath() + "/member/memberupdate";

		System.out.println("member=" + member);
		System.out.println("result=" + result + ", url = " + url);
		
		res.sendRedirect(url);
	}

}