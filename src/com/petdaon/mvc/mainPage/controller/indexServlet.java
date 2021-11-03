package com.petdaon.mvc.mainPage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.findMe_board.model.service.BoardService;
import com.petdaon.mvc.findMe_board.model.vo.Board;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.service.NoticeBoardService;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

@WebServlet("/")
public class indexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService findMeBoardService = new BoardService();
	private NoticeBoardService noticeBoardService = new NoticeBoardService();
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cPage = 1;
		int numPerPage = 6;
		int start = cPage * numPerPage - (numPerPage - 1);
		int end = cPage * numPerPage;
		List<Board> findMeBoardList = findMeBoardService.selectBoardList(start, end);
		List<NoticeBoard> noticeList = noticeBoardService.selectNoticeBoardList(start, end);
		List<VolunteerBoard> volunteerBoardList = volunteerBoardService.selectVolunteerBoardList();
		
		//3. view단 forwarding
		request.setAttribute("findMeBoardList", findMeBoardList);
		request.setAttribute("noticeList", noticeList);
		request.setAttribute("volunteerBoardList", volunteerBoardList);
		
		request
				.getRequestDispatcher("/WEB-INF/views/index.jsp")
				.forward(request, response);
	}

}
