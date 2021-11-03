package com.petdaon.mvc.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;

/**
 * Servlet implementation class AdminVolunteerBoardApprovalUpdateServlet
 */
@WebServlet("/admin/volunteerBoardApproval")
public class AdminVolunteerBoardApprovalUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 파라미터값 가져오기
			int boardNo = Integer.parseInt(request.getParameter("boardNo")); // 봉사 게시글 번호
			String approvalStatus = request.getParameter("approvalStatus"); // 승인상태 변경할 값
			System.out.printf("boardNo = %d, approvalStatus = %s\n", boardNo, approvalStatus);
			
			// 2. 업무 로직
			// 봉사게시글 승인여부 변경
			int result = volunteerBoardService.updateVolunteerBoardApproval(approvalStatus, boardNo);
			String msg = (result > 0) ? "봉사게시글 승인여부 변경 완료!" : "봉사게시글 승인여부 변경 실패!";
			
			//3. view단 처리
			request.getSession().setAttribute("msg", msg);
			String location = request.getHeader("Referer");
			response.sendRedirect(location);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
