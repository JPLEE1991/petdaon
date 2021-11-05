package com.petdaon.mvc.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petdaon.mvc.serviceBoard.noticeBoard.model.service.NoticeBoardService;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard;

/**
 * Servlet implementation class AdminNoticeBoardEnrollServlet
 */
@WebServlet("/admin/noticeBoard/noticeBoardUpdate")
public class AdminNoticeBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeBoardService noticeBoardService = new NoticeBoardService();

	/**
	 * update form 페이지 요청
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자입력값 처리
		int no = Integer.parseInt(request.getParameter("no"));
		
		//2.업무로직
		NoticeBoard noticeBoard = noticeBoardService.selectOneNoticeBoard(no);
		System.out.println("noticeBoard@servlet = " + noticeBoard);
		
		//3.view단 위임
		request.setAttribute("noticeBoard", noticeBoard);
		request
			.getRequestDispatcher("/WEB-INF/views/admin/manage_serviceCenter/noticeBoardUpdate.jsp")
			.forward(request, response);
	}
	
	/**
	 * db update 요청
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 사용자입력값처리
		int no = Integer.parseInt(request.getParameter("no"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		NoticeBoard noticeBoard = new NoticeBoard(no, null, title, content, null, 0, null);
		System.out.println("noticeBoard@servlet = " + noticeBoard);
				
		//2. 업무로직
		int result = noticeBoardService.updateNoticeBoard(noticeBoard);
		String msg = result > 0 ? "공지가 성공적으로 수정되었습니다." : "공지가 수정되지 않았습니다.";
				
		//3. 응답처리
		request.getSession().setAttribute("msg", msg);
		String location = request.getContextPath() + "/admin/noticeBoard";
		response.sendRedirect(location);
	}
}
