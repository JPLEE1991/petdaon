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
import com.petdaon.mvc.common.MvcUtils;

/**
 * Servlet implementation class bulletinBoardListServlet
 */
@WebServlet("/bulletin_board/boardList")
public class BulletinBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BulletinBoardService boardService = new BulletinBoardService(); 
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
			// 처리코드 없음.
		}
		System.out.println("cPage = " + cPage);
		
		// a.content영역 paging처리
		int startRownum = cPage * numPerPage - (numPerPage - 1);
		int endRownum = cPage * numPerPage;
		
		// 2. 업무로직
		List<BulletinBoard> list = boardService.selectBoardList(startRownum, endRownum);
		System.out.println("list@servlet = " + list);
		
		// b.pagebar영역
		// totalContents, url 준비
		int totalContents = boardService.selectTotalContents(); //총게시물수
		System.out.println("totalContents@servlet = " + totalContents); //12
		String url = request.getRequestURI();
		System.out.println(url);
		String pagebar = MvcUtils.getPagebar(cPage, numPerPage, totalContents, url);
		System.out.println("pagebar@servlet = " + pagebar);
		
		
	
		// view단 처리
		request.setAttribute("list", list);
		request.setAttribute("pagebar", pagebar);
		request
			.getRequestDispatcher("/WEB-INF/views/bulletin_board/boardList.jsp")
			.forward(request, response);
	}

}
