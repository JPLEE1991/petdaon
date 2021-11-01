package com.petdaon.mvc.serviceBoard.askBoard.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petdaon.mvc.serviceBoard.askBoard.model.service.AskBoardService;
import com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard;

/**
 * Servlet implementation class AskBoardEnrollServlet
 */
@WebServlet("/serviceCenter/askBoard/askBoardEnroll")
public class AskBoardEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AskBoardService askBoardService = new AskBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 사용자입력값처리
		String writer = request.getParameter("writer");
		String inquiryTitle = request.getParameter("title");
		String inquiryContent = request.getParameter("content");
		AskBoard askBoard = new AskBoard(0, null, writer, null, inquiryTitle, inquiryContent, null, null, null, null);
		System.out.println("askBoard@servlet = " + askBoard);
				
		//2. 업무로직
		int result = askBoardService.insertAskBoard(askBoard);
		String msg = result > 0 ? "문의 등록 성공!" : "문의 등록 실패!";
				
		//3. 응답처리
		HttpSession session = request.getSession();
		session.setAttribute("msg", msg);
		String location = request.getContextPath() + "/serviceCenter/askBoard/askBoardList";
		response.sendRedirect(location);
	}
}
