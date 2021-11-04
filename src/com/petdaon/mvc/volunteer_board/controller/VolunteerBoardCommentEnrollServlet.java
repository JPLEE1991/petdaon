package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.vo.BoardComment;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;

/**
 * Servlet implementation class VolunteerBoardCommentEnrollServlet
 */
@WebServlet("/volunteerBoard/boardCommentEnroll")
public class VolunteerBoardCommentEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * 등록후 /volunteerBoard/boardView?no=현재게시글번호 리다이렉트
	 * 
	 * dao에서 commentRef필드는 setObject를 사용할 것. int, null 모두 ?에 설정가능
	 * - 0이면 null이 대입
	 * - n이면 n이 대입
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자 입력
			int commentLevel = Integer.parseInt(request.getParameter("commentLevel"));
			String writer = request.getParameter("writer");
			String content = request.getParameter("content");
			int boardNo = Integer.parseInt(request.getParameter("boardNo"));
			int commentRef = Integer.parseInt(request.getParameter("commentRef"));
			
			// 객체 생성
			BoardComment bc = new BoardComment(0, writer, commentLevel, content, commentRef, null, volunteerBoardService.DELETE_NO, volunteerBoardService.VOLUNTEER_BOARD_CODE, boardNo);
			//System.out.println("bc@servlet = " + bc);
			
			// 2. 업무 로직
			// 댓글(문의/답변) 등록
			int result = volunteerBoardService.insertVolunteerBoardComment(bc);
			String msg = result > 0 ? "문의/답변 등록 성공!" : "문의/답변 등록 실패!";
			
			// 3. view단 처리 - redirect
			request.getSession().setAttribute("msg", msg);
			String location = request.getContextPath() + "/volunteerBoard/boardView?no=" + boardNo;
			response.sendRedirect(location); // 응답을 보내지만 다시 요청을 하라는 것.
		} catch(Exception e) {
			// 실제 발생한 예외와 전환된 예외 다 처리가능하다.
			e.printStackTrace();
			throw e; // WAS에게 예외페이지 연결알림.
			// WAS는 대단한 일 하는게 아니라 예외가 발생했네? 감지하는 순간 error페이지를 던집니다.
			
		}
	}

}
