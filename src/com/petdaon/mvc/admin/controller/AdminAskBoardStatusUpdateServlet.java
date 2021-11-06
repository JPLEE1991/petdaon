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
@WebServlet("/admin/askBoard/updateInquiryStatus")
public class AdminAskBoardStatusUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AskBoardService askBoardService = new AskBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//사용자입력값 처리 : inquiryTitle, status
		String inquiryNo = request.getParameter("inquiryNo");
		String status = request.getParameter("status");
		
		//업무로직
		int result = askBoardService.updateInquiryStatus(inquiryNo, status);
		String msg = result > 0 ? "문의 접수상태가 성공적으로 변경되었습니다." : "문의 접수상태가 변경되지 않았습니다.";

		//리다이렉트 및 사용자 피드백
		request.getSession().setAttribute("msg", msg);
		response.sendRedirect(request.getContextPath() + "/admin/askBoard");
	}

}
