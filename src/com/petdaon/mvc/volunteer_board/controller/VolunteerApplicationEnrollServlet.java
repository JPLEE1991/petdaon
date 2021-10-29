package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;

/**
 * Servlet implementation class VolunteerApplicationEnrollServlet
 */
@WebServlet("/volunteerApplication/applicationEnroll")
public class VolunteerApplicationEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값처리
			String memberId = request.getParameter("memberId");
			int boardNo = Integer.parseInt(request.getParameter("boardNo"));
			
			// 2. 업무로직
			int result = volunteerBoardService.insertVolunteerApplication(memberId, boardNo);
			String msg = (result > 0) ? "봉사 신청 완료" : "봉사 신청 실패";
			
			// 3. 응답처리 : redirect
			request.getSession().setAttribute("msg", msg);
			String location = request.getContextPath() + "/volunteerBoard/boardView?no=" + boardNo;
			response.sendRedirect(location);
		} catch(Exception e) {
			// 실제 발생한 예외와 전환된 예외 다 처리가능하다.
			e.printStackTrace();
			throw e; // WAS에게 예외페이지 연결알림.
			// WAS는 대단한 일 하는게 아니라 예외가 발생했네? 감지하는 순간 error페이지를 던집니다.
			
		}
	}

}
