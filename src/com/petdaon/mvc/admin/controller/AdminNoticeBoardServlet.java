package com.petdaon.mvc.admin.controller;

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
 * Servlet implementation class AdminNoticeBoardServlet
 */
@WebServlet("/admin/noticeBoard")
public class AdminNoticeBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private NoticeBoardService noticeBoardService = new NoticeBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자입력값처리 cPage numPerPage = 10
		int cPage = 1;
		int numPerPage = 10;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
				
		}
		int start = cPage * numPerPage - (numPerPage - 1);
		int end = cPage * numPerPage;
				
		//2.업무로직
		//a.content영역 - paging query
		List<NoticeBoard> list = noticeBoardService.selectNoticeBoardList(start, end);
				
		//b.pagebar영역 
		//totalContents, url 준비
		int totalContents = noticeBoardService.selectTotalContents();
		String url = request.getRequestURI();
		String pagebar = MvcUtils.getPagebar(cPage, numPerPage, totalContents, url);
				
		//3.view단 forwarding
		request.setAttribute("list", list);
		request.setAttribute("pagebar", pagebar);
		request
			.getRequestDispatcher("/WEB-INF/views/admin/manage_serviceCenter/noticeBoard.jsp")
			.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
