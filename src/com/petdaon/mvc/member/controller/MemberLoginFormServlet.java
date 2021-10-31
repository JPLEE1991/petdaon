package com.petdaon.mvc.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petdaon.mvc.member.model.vo.Member;
import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.member.model.service.MemberService;


/**
 * Servlet implementation class MemberLoginServlet
 */
@WebServlet("/member/memberLoginForm")
public class MemberLoginFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doCustom(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doCustom(request, response);
	}
	
	private void doCustom(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		this.getServletContext().getRequestDispatcher("/WEB-INF/views/member/memberLogin.jsp").forward(request, response);
	}
}





