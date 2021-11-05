package com.petdaon.mvc.admin.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.service.NoticeBoardService;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard;

/**
 * Servlet implementation class AdminNoticeBoardViewServlet
 */
@WebServlet("/admin/noticeBoard/noticeBoardView")
public class AdminNoticeBoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	NoticeBoardService noticeBoardService = new NoticeBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.파라미터 글번호
		int no  = Integer.parseInt(request.getParameter("no"));
						
		//2.비지니스로직 호출
						
		//공지글 하나 가져오기
		NoticeBoard noticeBoard = noticeBoardService.selectOneNoticeBoard(no);
		System.out.println(noticeBoard);
						
		//게시글 가져오기에 실패한경우
		if(noticeBoard == null){
			request.getSession().setAttribute("msg", "조회한 공지가 존재하지 않습니다.");
			response.sendRedirect(request.getContextPath() + "/admin/noticeBoard");
			return;
		}
						
		//XSS공격대비
		String content = MvcUtils.escapeHtml(noticeBoard.getContent());
		//개행문자 br태그 변환처리
		content = MvcUtils.convertLineFeedToBr(content);
		noticeBoard.setContent(content);
						
		//3.view단 처리위임
		request.setAttribute("noticeBoard", noticeBoard);
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/admin/manage_serviceCenter/noticeBoardView.jsp");
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
