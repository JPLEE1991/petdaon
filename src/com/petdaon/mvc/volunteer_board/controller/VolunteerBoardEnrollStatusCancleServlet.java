package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;

/**
 * Servlet implementation class VolunteerBoardEnrollStatusCancleServlet
 */
@WebServlet("/volunteerBoard/boardCancle")
public class VolunteerBoardEnrollStatusCancleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 파라미터값 가져오기
			int no = Integer.parseInt(request.getParameter("board-no")); // 게시글번호
			
			// 2. 업무 로직
			// 봉사게시글 접수취소 상태로 변경
			int result = volunteerBoardService.updateVolunteerBoardEnrollStatusCancle(no);
			String msg = result > 0 ? "접수 취소 성공!" : "접수 취소 실패!";
			
			// 3. view단 처리
			request.getSession().setAttribute("msg", msg);
			String location = request.getContextPath() + "/volunteerBoard/mypage";
			response.sendRedirect(location);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
