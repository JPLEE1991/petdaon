package com.petdaon.mvc.serviceBoard.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.service.NoticeBoardService;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard;

/**
 * Servlet implementation class findMeBoardListServlet
 */
@WebServlet("/serviceCenter")
public class ServiceCenterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private NoticeBoardService noticeBoardService = new NoticeBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자입력값처리 cPage numPerPage = 4
		int cPage = 1;
		int numPerPage = 4;
		int start = cPage * numPerPage - (numPerPage - 1);
		int end = cPage * numPerPage;
		List<NoticeBoard> list = noticeBoardService.selectNoticeBoardList(start, end);
				
		//3.view단 forwarding
		request.setAttribute("list", list);
		request
			.getRequestDispatcher("/WEB-INF/views/service_board/serviceCenter.jsp")
			.forward(request, response);
	}
}
