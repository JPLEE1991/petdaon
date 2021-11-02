package com.petdaon.mvc.findMe_board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.findMe_board.model.service.BoardService;
import com.petdaon.mvc.findMe_board.model.vo.Board;

/**
 * Servlet implementation class FindMeBoardFinderServlet
 */
@WebServlet("/findMe_board/finder")
public class FindMeBoardFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		// 1. 사용자입력값처리 cPage numPerPage
		String searchType = request.getParameter("searchType");
		String searchKeyword = request.getParameter("searchKeyword");
		
		int cPage = 1;
		int numPerPage = 6;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			// 처리코드 없음.
		}
		int start = cPage * numPerPage - (numPerPage - 1);
		int end = cPage * numPerPage;
		
		Map<String, Object> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		param.put("start", start);
		param.put("end", end);
		System.out.println("param@servlet = " + param);
		
		// 2. 업무로직
		// 	가. content영역
		// 		a. select * from member where member_id like '%abc%'
		// 		b. select * from member where member_name like '%길동%'
		// 		c. select * from member where gender = '남'
		List<Board> list = boardService.searchBoard(param);
		System.out.println(list);
		
		// 	나. pagebar영역
		//  totalContents
		// 		a. select count(*) from member where member_id like '%abc%'
		// 		b. select count(*) from member where member_name like '%길동%'
		// 		c. select count(*) from member where gender = '남'
		int totalContents = boardService.searchBoardCount(param);
		
		String queryString = String.format("?searchType=%s&searchKeyword=%s", searchType, searchKeyword);
		String url = request.getRequestURI() + queryString; // /mvc/admin/memberFinder?searchType=memberId&searchKeyword=a 
		
		String pagebar = MvcUtils.getPagebar(cPage, numPerPage, totalContents, url);
		System.out.println("pagebar@servlet = " + pagebar);
		
		// 3. view단처리 (html)
		request.setAttribute("list", list);
		request.setAttribute("pagebar", pagebar);
		request
			.getRequestDispatcher("/WEB-INF/views/findMe_board/boardList.jsp")
			.forward(request, response);
	}
}
