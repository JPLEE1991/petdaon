package com.petdaon.mvc.findMe_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class findMeBoardViewServlet
 */
@WebServlet("/findMe_board/boardView")
public class findMeBoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//view단 처리
		System.out.println("findMeBoardViewServlet...");
		request
		.getRequestDispatcher("/WEB-INF/views/findMe_board/boardView.jsp")
		.forward(request, response);
	}

}
