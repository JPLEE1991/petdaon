package com.petdaon.mvc.serviceBoard.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class findMeBoardListServlet
 */
@WebServlet("/serviceBoard/serviceCenter")
public class ServiceCenterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//view단 처리
		request
		.getRequestDispatcher("/WEB-INF/views/service_board/serviceCenter.jsp")
		.forward(request, response);
	}
}
