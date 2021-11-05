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
@WebServlet("/admin/noticeBoard/noticeBoardEnroll")
public class AdminNoticeBoardEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeBoardService noticeBoardService = new NoticeBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 사용자입력값처리
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		NoticeBoard noticeBoard = new NoticeBoard(0, writer, title, content, null, 0, null);
		System.out.println("askBoard@servlet = " + noticeBoard);
				
		//2. 업무로직
		int result = noticeBoardService.insertNoticeBoard(noticeBoard);
		String msg = result > 0 ? "공지가 성공적으로 등록되었습니다." : "공지가 등록되지 않았습니다.";
				
		//3. 응답처리
		HttpSession session = request.getSession();
		session.setAttribute("msg", msg);
		String location = request.getContextPath() + "/serviceCenter/noticeBoard/noticeBoardList";
		response.sendRedirect(location);
	}
}
