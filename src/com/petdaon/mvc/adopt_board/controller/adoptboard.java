package com.petdaon.mvc.adopt_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class adoptborad
 */
@WebServlet("/adopt_board/adoptForm")
public class adoptboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//view단 처리
        request
        .getRequestDispatcher("/WEB-INF/views/adopt_board/adopt.jsp")
        .forward(request, response);
	}

	

}
