package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class VolunteerBoardSelectOneServlet
 */
@WebServlet("/volunteerBoard/selectOne")
public class VolunteerBoardSelectOneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자입력값
		int no = Integer.parseInt(request.getParameter("boardNo")); // 게시글 번호
		
		// 2. 업무로직
		// 봉사게시글 한건조회
		VolunteerBoard board = volunteerBoardService.selectOneVolunteerBoard(no);
		
		// 3. view단 처리 : json문자열 출력
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(board, response.getWriter());
	}

}
