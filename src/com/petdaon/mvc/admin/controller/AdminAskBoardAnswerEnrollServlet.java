package com.petdaon.mvc.admin.controller;

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
 * Servlet implementation class AdminAskBoardAnswerEnrollServlet
 */
@WebServlet("/admin/askBoard/askBoardAnswerEnroll")
public class AdminAskBoardAnswerEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AskBoardService askBoardService = new AskBoardService();

	/**
	 * update form 페이지 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자입력값 처리
		int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
		
		//2.업무로직
		AskBoard askBoard = askBoardService.selectOneAskBoard(inquiryNo);
		System.out.println("askBoard@servlet = " + askBoard);
		
		//3.view단 위임
		request.setAttribute("askBoard", askBoard);
		request
			.getRequestDispatcher("/WEB-INF/views/admin/manage_serviceCenter/askBoardView.jsp")
			.forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 사용자입력값처리
		int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
		String answer = request.getParameter("answer");
		String adminId= request.getParameter("adminId");
		AskBoard askBoard = new AskBoard(inquiryNo, null, null, null, null, null, null, answer, null, adminId);
		System.out.println("askBoard@servlet = " + askBoard);
				
		//2. 업무로직
		int result = askBoardService.updateAskBoard(askBoard);
		String msg = result > 0 ? "답변 등록 성공!" : "답변 등록 실패!";
				
		//3. 응답처리
		request.getSession().setAttribute("msg", msg);
		String location = request.getContextPath() + "/admin/askBoard";
		response.sendRedirect(location);
	}
}
