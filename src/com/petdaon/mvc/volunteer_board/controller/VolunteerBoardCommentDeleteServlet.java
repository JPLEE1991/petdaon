package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;

/**
 * Servlet implementation class VolunteerBoardCommentDeleteServlet
 */
@WebServlet("/volunteerBoard/boardCommentDelete")
public class VolunteerBoardCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 파라미터값 가져오기(게시글번호, 댓글번호)
			int boardNo = Integer.parseInt(request.getParameter("boardNo"));
			int no = Integer.parseInt(request.getParameter("no"));
			//System.out.println("boardNo=" + boardNo + ", no = " + no);
			
			// 2. 업무 로직
			// 댓글(문의/답변) 삭제(삭제여부 삭제상태로 변경)
			int result = volunteerBoardService.deleteVolunteerBoardComment(no);
			String msg = (result > 0) ? "문의/답변 삭제 성공!" : "문의/답변 삭제 실패!";	
			
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
