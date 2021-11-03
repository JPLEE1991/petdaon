package com.petdaon.mvc.bulletin_board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.bulletin_board.model.service.BulletinBoardService;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;

/**
 * Servlet implementation class BulletinBoardDeleteServlet
 */
@WebServlet("/bulletin_board/boardDelete")
public class BulletinBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BulletinBoardService boardService = new BulletinBoardService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자입력값
		int no = Integer.parseInt(request.getParameter("no"));
		
		// 2. 업무로직
		BulletinBoard board = boardService.selectOneBoard(no);
		// 첨부파일 삭제
		if(board != null && board.getAttach() != null) {
			ServletContext application = getServletContext();
			String saveDirectory = application.getRealPath("/upload/bulletin_board");
			String filename = board.getAttach().getRenamedFilename();
			File delFile = new File(saveDirectory, filename);
			boolean result = delFile.delete();
			System.out.printf("첨부파일[%s] 삭제여부 : %b%n", filename, result);
		}
		
		int result = boardService.deleteBoard(no);
		String msg = result > 0 ? "게시물 삭제 성공!" : "게시물 삭제 실패!";
		
		// 3. 사용자메시지 및 redirect처리
		request.getSession().setAttribute("msg", msg);
		response.sendRedirect(request.getContextPath() + "/bulletin_board/boardList");
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
