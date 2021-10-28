package com.petdaon.mvc.serviceBoard.askBoard.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.serviceBoard.askBoard.model.service.AskBoardService;
import com.petdaon.mvc.serviceBoard.askBoard.model.vo.AskBoard;

/**
 * Servlet implementation class AskBoardListServlet
 */
@WebServlet("/serviceCenter/askBoard/askBoardList")
public class AskBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private AskBoardService askBoardService = new AskBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자입력값처리 cPage numPerPage = 10
		int cPage = 1;
		int numPerPage = 10;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch(NumberFormatException e) {
			
		}
		System.out.println("cPage = " + cPage);
		
		//2.업무로직
		//a.content영역 - paging query
		int start = cPage * numPerPage - (numPerPage - 1);
		int end = cPage * numPerPage;
		List<AskBoard> list = askBoardService.selectAskBoardList(start, end);
		
		//b.pagebar영역 
		//totalContents, url 준비
		int totalContents = askBoardService.selectTotalContents();
		String url = request.getRequestURI();
		String pagebar = MvcUtils.getPagebar(cPage, numPerPage, totalContents, url);
		
		//3.view단 forwarding
		request.setAttribute("list", list);
		request.setAttribute("pagebar", pagebar);
		request
			.getRequestDispatcher("/WEB-INF/views/service_board/ask_board/askBoardList.jsp")
			.forward(request, response);
	}
}
