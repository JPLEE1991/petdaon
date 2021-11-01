package com.petdaon.mvc.volunteer_board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class VolunteerBoardDeleteServlet
 */
@WebServlet("/volunteerBoard/boardDelete")
public class VolunteerBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 파라미터값 가져오기
		int no = Integer.parseInt(request.getParameter("no")); // 봉사게시글 번호
		
		// 2. 업무 로직
		// 게시물 한건 조회
		VolunteerBoard board = volunteerBoardService.selectOneVolunteerBoard(no);
		// 첨부파일 삭제
		if(board != null && board.getThumbnail() != null) {
			ServletContext application = getServletContext();
			// 서버에서 saveDirectory 가져온다.
			String saveDirectory = application.getRealPath("/");
			String filename = board.getThumbnail();
			File delFile = new File(saveDirectory, filename);
			boolean result = delFile.delete();
			//System.out.printf("첨부파일[%s] 삭제여부 : %b%n", filename, result);
		}
		
		// 게시물 삭제 - 삭제여부 변경
		int result = volunteerBoardService.deleteVolunteerBoard(no);
		String msg = result > 0 ? "봉사게시물 삭제 성공!" : "봉사게시물 삭제 실패!";
		
		//3. view단 처리
		request.getSession().setAttribute("msg", msg);
		response.sendRedirect(request.getContextPath() + "/volunteerBoard/boardList");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
