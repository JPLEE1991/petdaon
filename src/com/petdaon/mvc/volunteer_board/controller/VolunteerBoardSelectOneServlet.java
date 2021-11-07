package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class VolunteerBoardSelectOneServlet
 */
@WebServlet("/volunteerBoard/selectOne")
public class VolunteerBoardSelectOneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자입력값
		int no = Integer.parseInt(request.getParameter("boardNo")); // 게시글 번호
		
		// 2. 업무로직
		// 봉사게시글 한건조회
		VolunteerBoard board = volunteerBoardService.selectOneVolunteerBoard(no);
		
		// 3. view단 처리 : json문자열 출력
		response.setContentType("application/json; charset=utf-8");
		//new Gson().toJson(board, response.getWriter());
		// new GsonBuilder()을 이용하여 Gson 객체를 생성하면, 몇 가지 옵션을 추가해서 객체를 생성할 수 있음.
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create(); // 데이터 형식이 yyyy-MM-dd 형식으로 나오게 된다.(마이페이지 - 봉사등록확인에서 gson으로 json 리턴 시 날짜 타입이 미국식으로 나와서 코드 추가함)
		gson.toJson(board, response.getWriter());
	}

}
