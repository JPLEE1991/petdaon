package com.petdaon.mvc.bulletin_board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.bulletin_board.model.service.BulletinBoardService;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;

/**
 * Servlet implementation class bulletinBoardListServlet
 */
@WebServlet("/bulletin_board/boardList")
public class BulletinBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BulletinBoardService bulletinBoardService = new BulletinBoardService(); 
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자입력값처리 cPage numberPage = 10
		int cPage = 1;
		int numPerPage = 10;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));			
		} catch(NumberFormatException e) {
			
		}
		
		// 2. 업무로직
		// a.content영역 paging처리
		int start = cPage * numPerPage - (numPerPage - 1);
		int end = cPage * numPerPage;
		List<BulletinBoard> list = bulletinBoardService.selectBoardList(start, end);
		System.out.println("list@servlet = " + list);
		
		// b.
		// view단 처리
		request
		.getRequestDispatcher("/WEB-INF/views/bulletin_board/boardList.jsp")
		.forward(request, response);
	}

}
