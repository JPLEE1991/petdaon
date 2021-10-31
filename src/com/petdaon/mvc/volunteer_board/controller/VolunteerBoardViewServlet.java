package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.vo.BoardComment;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerApplicationExt;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class VolunteerBoardViewServlet
 */
@WebServlet("/volunteerBoard/boardView")
public class VolunteerBoardViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 파라미터 글번호
			int no  = Integer.parseInt(request.getParameter("no"));
			
			// 2. 업무 로직
			// 봉사 게시글 한건 조회
			VolunteerBoard board = volunteerBoardService.selectOneVolunteerBoard(no);
			//System.out.println(board);
			
			// 봉사 게시글 가져오기 실패한 경우
			if(board == null) {
				request.getSession().setAttribute("msg", "조회한 게시글이 존재하지 않습니다.");
				response.sendRedirect(request.getContextPath() + "/volunteerBoard/boardList");
				return;
			}
			
			// 봉사 게시글 담당자 이름 가져오기
			String name = volunteerBoardService.selectWriterName(no);
			//System.out.println(name);
			
			// 봉사 게시글 신청인원 수 가져오기(접수상태이며 신청 승인된 인원수 - 모집인원 초과여부 확인을 위해 가져옴)
			int applicationCnt = volunteerBoardService.selectApplicationCount(no);
			//System.out.println(applicationCnt);
			
			// 신청자 리스트 가져오기(이름, 이메일, 휴대폰 정보까지 가져와야 하므로 VolunteerApplicationExt 이용)
			List<VolunteerApplicationExt> applicationList = volunteerBoardService.selectVolunteerApplicationList(no);
			//System.out.println("applicationList@servlet = " + applicationList);
			
			// 댓글(문의/답변)목록 가져오기
			List<BoardComment> commentList = volunteerBoardService.selectCommentList(no); // 현재 게시글의 코멘트리스트이므로 보드넘버 전달
			//System.out.println("commentList@servlet = " + commentList);
			
			// 3. view단 처리
			request.setAttribute("board", board);
			request.setAttribute("name", name);
			request.setAttribute("applicationCnt", applicationCnt);
			request.setAttribute("applicationList", applicationList);
			request.setAttribute("commentList", commentList);
			request
			.getRequestDispatcher("/WEB-INF/views/volunteer_board/volunteerBoardView.jsp")
			.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
