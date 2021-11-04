package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petdaon.mvc.common.Constants;
import com.petdaon.mvc.member.model.vo.Member;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerApplication;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerApplicationExt;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class MypageVolunteerApplicationListServlet
 */
@WebServlet("/volunteerApplication/mypage")
public class MypageVolunteerApplicationListServlet extends HttpServlet {
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
			// 회원아이디가 등록한 봉사신청 조회
			// 봉사 제목까지 받아오기 위해 VolunteerApplicationExt 사용(기존 VolunteerApplicationExt부분에 title 추가함)
			List<VolunteerApplicationExt> list = volunteerBoardService.selectVolunteerApplicationListByWriter(memberId);
			System.out.println("list@servlet = " + list);
			
			// view단 처리
			request.setAttribute("list", list);
			request
				.getRequestDispatcher("/WEB-INF/views/volunteer_board/mypageVolunteerApplicationList.jsp")
				.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
			
		}
	}

}
