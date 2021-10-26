package com.petdaon.mvc.findMe_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class findMeBoardFormServlet
 */
@WebServlet("/findMe_board/boardForm")
public class findMeBoardFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//view단 처리
		request
		.getRequestDispatcher("/WEB-INF/views/findMe_board/boardForm.jsp")
		.forward(request, response);
	}

}
