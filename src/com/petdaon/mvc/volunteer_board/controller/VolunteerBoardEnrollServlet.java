package com.petdaon.mvc.volunteer_board.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.petdaon.mvc.common.MvcFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class volunteerBoardEnrollServlet
 */
@WebServlet("/volunteerBoard/boardEnroll")
public class VolunteerBoardEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 0. 파일업로드
			
			// b. 파일저장경로
			// ServletContext객체로부터  /WebContent/upload/board 절대경로 참조
			ServletContext application = getServletContext(); 
			String saveDirectory = application.getRealPath("/upload/volunteer_board");
			System.out.println("saveDirectory = " + saveDirectory);
			
			// c.최대파일용량 10mb = 1kb * 1000 * 10
			int maxPostSize = 1024 * 1024 * 10;
			
			// d.인코딩
			String encoding = "utf-8";
			
			// e.파일명 재지정 정책객체
//			FileRenamePolicy policy = new DefaultFileRenamePolicy(); // cos.jar에서 재공해주는것 사용하겠다.
			FileRenamePolicy policy = new MvcFileRenamePolicy(); // 커스터마이징함
			
			
			MultipartRequest multipartRequest = 
					new MultipartRequest(
							request, 
							saveDirectory, 
							maxPostSize, 
							encoding, 
							policy
						);
			
			// 파일정보 가져오기
			String originalFilename = multipartRequest.getOriginalFileName("thumbnail");
			String renamedFilename = multipartRequest.getFilesystemName("thumbnail");
			
			
			// 1. 사용자입력값처리
			String title = multipartRequest.getParameter("title");
			String writer = multipartRequest.getParameter("writer");
			String centerName = multipartRequest.getParameter("centerName");
			String _startDate = multipartRequest.getParameter("startDate");
			String _endDate = multipartRequest.getParameter("endDate");
			String _deadlineDate = multipartRequest.getParameter("deadlineDate");
			int capacity = Integer.parseInt(multipartRequest.getParameter("capacity"));
			String place = multipartRequest.getParameter("place");
			
			
//			String time = multipartRequest.getParameter("time");
//			String timeDirect = multipartRequest.getParameter("selboxDirectTime");
			
			// 봉사시간 직접입력 유무 사용자 입력값 지정
			String time = "";
			
			if("".equals(multipartRequest.getParameter("selboxDirectTime"))) {
				time = multipartRequest.getParameter("time");
			}
			else {
				time = multipartRequest.getParameter("selboxDirectTime");
			}
			
			
//			String day = multipartRequest.getParameter("day");
//			String dayDirect = multipartRequest.getParameter("selboxDirectDay");
			
			// 봉사요일 직접입력 유무 사용자 입력값 지정
			String day = "";
			
			if("".equals(multipartRequest.getParameter("selboxDirectDay"))) {
				day = multipartRequest.getParameter("day");
			}
			else {
				day = multipartRequest.getParameter("selboxDirectDay");
			}
			
			String contents = multipartRequest.getParameter("contents");
			String name = multipartRequest.getParameter("name");
			String phone = multipartRequest.getParameter("phone");
			String email = multipartRequest.getParameter("email");
			
			//java.sql.Date 날짜타입으로 변경 : 1990-09-09 
			//아무것도 입력안한 경우, ""이 전송된다.
			Date startDate = null;
			Date endDate = null;
			Date deadlineDate = null;
			
			if(_startDate != null && !"".equals(_startDate))
				startDate = Date.valueOf(_startDate);
			
			if(_endDate != null && !"".equals(_endDate))
				endDate = Date.valueOf(_endDate);
			
			if(_deadlineDate != null && !"".equals(_deadlineDate))
				deadlineDate = Date.valueOf(_deadlineDate);
			
			
			VolunteerBoard board = new VolunteerBoard(0, title, centerName, contents, startDate, endDate, email, phone, VolunteerBoardService.APPROVAL_NO, VolunteerBoardService.DELETE_NO, capacity, place, deadlineDate, null, time, day, VolunteerBoardService.VOLUNTEER_BOARD_CODE, writer, volunteerBoardService.ENROLL_YES, "");
			
			
			if(multipartRequest.getFile("thumbnail") != null) {// getFile하면 파일객체를 리턴한다.
				String filePath = "upload/volunteer_board/";
				board.setThumbnail(filePath + renamedFilename); // board에 담아준다.
			}
			
			// 2. 업무로직
			int result = volunteerBoardService.insertVolunteerBoard(board);
			//String msg = (result > 0) ? "봉사 게시글 등록 완료" : "봉사 게시글 등록 실패";	
			
			// 3. 응답처리 : redirect
			//request.getSession().setAttribute("msg", msg);
			String location = request.getContextPath() + "/volunteerBoard/boardList";
			response.sendRedirect(location);
			
		} catch(Exception e) {
			// 실제 발생한 예외와 전환된 예외 다 처리가능하다.
			e.printStackTrace();
			throw e; // WAS에게 예외페이지 연결알림.
			// WAS는 대단한 일 하는게 아니라 예외가 발생했네? 감지하는 순간 error페이지를 던집니다.
			
		}
		
		
		
	}

}
