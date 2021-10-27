package com.petdaon.mvc.findMe_board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.findMe_board.model.service.BoardService;
import com.petdaon.mvc.findMe_board.model.vo.Board;

import oracle.security.o3logon.b;

/**
 * Servlet implementation class findMeBoardListServlet
 */
@WebServlet("/findMe_board/boardList")
public class findMeBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private BoardService boardService = new BoardService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int cPage = 1;
		int numPerPage = 10;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			
		}
		//2. 업무로직
		//a.content 영역 - paging query
		int start = cPage * numPerPage - (numPerPage - 1);
		int end = cPage * numPerPage;
		List<Board> list = boardService.selectBoardList(start,end);
		System.out.println("list@servelt = "+list);
		
		//b. pagebar영역
		int totalContents = boardService.selectTotalContents();
		String url = request.getRequestURI();
		String pagebar = MvcUtils.getPagebar(cPage, numPerPage, totalContents, url);
		
		
		request.setAttribute("list", list);
		request.setAttribute("pagebar", pagebar);
		
		request
			.getRequestDispatcher("/WEB-INF/views/findMe_board/boardList.jsp")
			.forward(request, response);
	}

}
