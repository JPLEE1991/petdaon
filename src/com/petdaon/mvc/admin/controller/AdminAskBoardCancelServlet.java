package com.petdaon.mvc.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.serviceBoard.askBoard.model.service.AskBoardService;

/**
 * Servlet implementation class AdminAskBoardStatusUpdateServlet
 */
@WebServlet("/serviceCenter/askBoard/askBoardCancel")
public class AdminAskBoardCancelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AskBoardService askBoardService = new AskBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//사용자입력값 처리 : inquiryNo
		int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
		
		//업무로직
		int result = askBoardService.updateInquiryStatusCancel(inquiryNo);
		String msg = result > 0 ? "문의접수가 성공적으로 취소되었습니다." : "문의접수가 취소되지 않았습니다.";

		//리다이렉트 및 사용자 피드백
		request.getSession().setAttribute("msg", msg);
		response.sendRedirect(request.getContextPath() + "/serviceCenter/askBoard/askBoardList");
	}

}
