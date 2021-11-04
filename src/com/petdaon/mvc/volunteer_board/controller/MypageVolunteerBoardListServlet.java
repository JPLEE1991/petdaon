package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.member.model.vo.Member;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class MypageVolunteerBoardListServlet
 */
@WebServlet("/volunteerBoard/mypage")
public class MypageVolunteerBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Member member = (Member)session.getAttribute(Constants.SESSION_KEY);
			String memberId = member.getMemberId();	// 회원아이디
			
			// 업무 로직
			// 회원아이디가 등록한 봉사 게시글 조회(삭제된것도 포함하기. 관리자에 의해 삭제된 게시물입니다 로 jsp에서 표현하기)
			List<VolunteerBoard> list = volunteerBoardService.selectVolunteerBoardListByWriter(memberId);
			
			// view단 처리
			request.setAttribute("list", list);
			request
				.getRequestDispatcher("/WEB-INF/views/volunteer_board/mypageVolunteerBoardList.jsp")
				.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
			
		}
	}

}
