package com.petdaon.mvc.findMe_board.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.findMe_board.model.service.BoardService;
import com.petdaon.mvc.findMe_board.model.vo.Board;

/**
 * Servlet implementation class findMeBoardViewServlet
 */
@WebServlet("/findMe_board/boardView")
public class FindMeBoardViewServlet extends HttpServlet {
	BoardService boardService = new BoardService();
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			//1. 파라미터 글번호
			int no = Integer.parseInt(request.getParameter("no"));
			System.out.println("findMeBoardViewServlet no: "+no);
			// 게시글 하나 가져오기
			Board board = boardService.selectOneBoard(no);
			System.out.println("findMeBoardViewServlet board: "+board);
			
			//게시글 가져오기에 실패한경우
			if(board == null){
				request.getSession().setAttribute("msg", "조회한 게시글이 존재하지 않습니다.");
				response.sendRedirect(request.getContextPath() + "/findMe_board/boardList");
				return;
			}
			
			// XSS공격대비 
			// cross-site script공격. 악성코드를 웹페이지삽입하여 클라이언트의 개인정보탈취하는 공격법
			String content = MvcUtils.escapeHtml(board.getContent());
			
			// 개행문자 br태그 변환처리
			content = MvcUtils.convertLineFeedToBr(content);
			board.setContent(content);
			
			
			
			//view단 처리
			System.out.println("findMeBoardViewServlet...");
			request.setAttribute("board", board);
			RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/findMe_board/boardView.jsp");
			reqDispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
