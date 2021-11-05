package com.petdaon.mvc.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminNoticeBoardFormServlet
 */
@WebServlet("/admin/noticeBoard/noticeBoardForm")
public class AdminNoticeBoardFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//view단 처리
		request
			.getRequestDispatcher("/WEB-INF/views/admin/manage_serviceCenter/noticeBoardForm.jsp")
			.forward(request, response);
	}
}
