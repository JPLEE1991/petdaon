package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import java.util.List;

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
 * Servlet implementation class volunteerBoardListServlet
 */
@WebServlet("/volunteerBoard/boardList")
public class VolunteerBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 업무 로직
			// 삭제여부가 'N' 이며 승인여부가 'Y'인 게시글 최근 등록일 순 4개 조회
			List<VolunteerBoard> list = volunteerBoardService.selectVolunteerBoardListFourOrderByRegDateDesc();
			//System.out.println("list@VolunteerBoardListServlet = " + list);
			
			// view단 처리
			request.setAttribute("list", list);
			request
			.getRequestDispatcher("/WEB-INF/views/volunteer_board/volunteerBoardList.jsp")
			.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;

		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 업무로직
		List<VolunteerBoard> list = volunteerBoardService.selectVolunteerBoardList();
		//System.out.println("list@VolunteerBoardListServlet = " + list);
		
		// view단 처리
		response.setContentType("application/json; charset=utf-8"); // json이라는 것을 헤더에 명시한다.
		//new Gson().toJson(list, response.getWriter());
		// new GsonBuilder()을 이용하여 Gson 객체를 생성하면, 몇 가지 옵션을 추가해서 객체를 생성할 수 있음.
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create(); 
		// 데이터 형식이 yyyy-MM-dd 형식으로 나오게 설정. (코드를 작성하지 않을 시 gson으로 json 리턴 시 날짜 타입이 "Nov 4, 2021"와 같이 읽어들여 달력에 제대로 반영되지 않아 코드 추가함)
		
		gson.toJson(list, response.getWriter());
	}
	

}
