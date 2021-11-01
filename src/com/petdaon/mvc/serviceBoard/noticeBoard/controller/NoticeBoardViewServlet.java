package com.petdaon.mvc.serviceBoard.noticeBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.service.NoticeBoardService;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard;

/**
 * Servlet implementation class NoticeBoardViewServlet
 */
@WebServlet("/serviceCenter/noticeBoard/noticeBoardView")
public class NoticeBoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	NoticeBoardService noticeBoardService = new NoticeBoardService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//1.파라미터 글번호
			int no  = Integer.parseInt(request.getParameter("no"));
				
			//2.비지니스로직 호출
			//읽음여부 확인(cookie)
			Cookie[] cookies = request.getCookies();
			boolean hasRead = false;
			String noticeBoardValue = "";
		
			if(cookies != null) {
				for(Cookie c : cookies) {
					String name = c.getName();
					String value = c.getValue();
					System.out.println(name + " : " + value);
				
					if("noticeBoard".equals(name)) {
						noticeBoardValue = value;
						//현재 게시글 읽음여부
						if(value.contains("|" + no + "|")) {
							hasRead = true;
						}
						break;
					}
				}
			}
		
			//게시글을 처음 읽는 경우
			if(!hasRead) {
				//게시글 Cookie
				Cookie cookie = new Cookie("noticeBoard", noticeBoardValue + "|" + no + "|");
				cookie.setMaxAge(365 * 24 * 60 * 60);
				cookie.setPath(request.getContextPath() + "/noticeBoard/noticeBoardView"); //해당 요청시만 cookie전송
				response.addCookie(cookie);
					
				//조회수 증가
				int result = noticeBoardService.updateViewNum(no);
			}
		
			//게시글 하나 가져오기
			NoticeBoard noticeBoard = noticeBoardService.selectOneNoticeBoard(no);
			System.out.println(noticeBoard);
		
			//게시글 가져오기에 실패한경우
			if(noticeBoard == null){
				request.getSession().setAttribute("msg", "조회한 게시글이 존재하지 않습니다.");
				response.sendRedirect(request.getContextPath() + "/serviceCenter/noticeBoard/noticeBoardList");
				return;
			}
				
			//XSS공격대비
			String content = MvcUtils.escapeHtml(noticeBoard.getContent());
			//개행문자 br태그 변환처리
			content = MvcUtils.convertLineFeedToBr(content);
			noticeBoard.setContent(content);
				
			//3.view단 처리위임
			request.setAttribute("noticeBoard", noticeBoard);
			RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/service_board/notice_board/noticeBoardView.jsp");
			reqDispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
