package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class volunteerBoardListServlet
 */
@WebServlet("/volunteerBoard/boardList")
public class VolunteerBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
			.getRequestDispatcher("/WEB-INF/views/volunteer_board/volunteerBoardList.jsp")
			.forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 업무로직
		List<VolunteerBoard> list = volunteerBoardService.selectVolunteerBoardList();
		//System.out.println("list@VolunteerBoardListServlet = " + list);
		
		// view단 처리
		//request.setAttribute("list", list);
		
		response.setContentType("application/json; charset=utf-8"); // json이라는 것을 헤더에 명시한다.

		new Gson().toJson(list, response.getWriter());
	}
	

}
