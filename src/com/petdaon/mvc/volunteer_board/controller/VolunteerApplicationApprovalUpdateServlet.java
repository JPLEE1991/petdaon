package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;

/**
 * Servlet implementation class VolunteerApplicationApprovalUpdateServlet
 */
@WebServlet("/volunteerApplication/applicationApproval")
public class VolunteerApplicationApprovalUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 파라미터값 가져오기
			String approvalStatus = request.getParameter("approvalStatus"); // 승인상태 변경할 값
			int no = Integer.parseInt(request.getParameter("no")); // 댓글번호
			int boardNo = Integer.parseInt(request.getParameter("boardNo")); // 봉사 게시글 번호
			
			// 2. 업무 로직
			// 봉사신청 승인여부 변경
			int result = volunteerBoardService.updateVolunteerApplicationApproval(approvalStatus, no);
			String msg = (result > 0) ? "봉사 승인여부 변경 완료!" : "봉사 승인여부 변경 실패!";
			
			//3. view단 처리
			request.getSession().setAttribute("msg", msg);
			String location = request.getContextPath() + "/volunteerBoard/boardView?no=" + boardNo;
			response.sendRedirect(location);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
