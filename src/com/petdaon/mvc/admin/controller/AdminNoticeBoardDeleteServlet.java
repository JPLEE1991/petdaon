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
 * Servlet implementation class NoticeBoardDeleteServlet
 */
@WebServlet("/admin/noticeBoard/noticeBoardDelete")
public class AdminNoticeBoardDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private NoticeBoardService noticeBoardService = new NoticeBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자입력값처리 cPage numPerPage = 10
		int no = Integer.parseInt(request.getParameter("no"));
		
		//2.업무로직
		NoticeBoard noticeBoard = noticeBoardService.selectOneNoticeBoard(no);
		
		int result = noticeBoardService.deleteNoticeBoard(no);
		String msg = result > 0 ? "공지가 성공적으로 삭제되었습니다." : "공지가 삭제되지 않았습니다.";
		
		//3.사용자메세지 및 redirect처리
		request.getSession().setAttribute("msg", msg);
		response.sendRedirect(request.getContextPath() + "/admin/noticeBoard");
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
