package com.petdaon.mvc.serviceBoard.askBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.serviceBoard.askBoard.model.service.AskBoardService;
import com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard;

/**
 * Servlet implementation class AskBoardViewServlet
 */
@WebServlet("/serviceCenter/askBoard/askBoardView")
public class AskBoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AskBoardService askBoardService = new AskBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.파라미터 글번호
		int inquiryNo  = Integer.parseInt(request.getParameter("inquiryNo"));
						
		//2.비지니스로직 호출
						
		//게시글 하나 가져오기
		AskBoard askBoard = askBoardService.selectOneAskBoard(inquiryNo);
		System.out.println(askBoard);
						
		//게시글 가져오기에 실패한경우
		if(askBoard == null){
			request.getSession().setAttribute("msg", "조회한 게시글이 존재하지 않습니다.");
			response.sendRedirect(request.getContextPath() + "/serviceCenter/askBoard/askBoardList");
			return;
		}
						
		//XSS공격대비
		String content = MvcUtils.escapeHtml(askBoard.getInquiryContent());
		//개행문자 br태그 변환처리
		content = MvcUtils.convertLineFeedToBr(content);
		askBoard.setInquiryContent(content);
						
		//3.view단 처리위임
		request.setAttribute("askBoard", askBoard);
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/service_board/ask_board/askBoardList.jsp");
		reqDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
