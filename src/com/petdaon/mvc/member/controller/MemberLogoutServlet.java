package com.petdaon.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * logout.
 * 
 * @author dbwld
 *
 */
@SuppressWarnings("serial")
@WebServlet("/member/memberLogout")
public class MemberLogoutServlet extends HttpServlet {
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession(true).invalidate();

		request
		.getRequestDispatcher("/WEB-INF/views/member/memberLogin.jsp")
		.forward(request, response);
	}
	
}
