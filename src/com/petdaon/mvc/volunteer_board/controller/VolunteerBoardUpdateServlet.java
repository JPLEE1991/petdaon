package com.petdaon.mvc.volunteer_board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.petdaon.mvc.common.MvcFileRenamePolicy;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class VolunteerBoardUpdateServlet
 */
@WebServlet("/volunteerBoard/boardUpdate")
public class VolunteerBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 파라미터값 가져오기
			int no = Integer.parseInt(request.getParameter("no"));
			
			// 2. 업무 로직
			// 봉사게시글 한건조회
			VolunteerBoard board = volunteerBoardService.selectOneVolunteerBoard(no);
			//System.out.println("board@servlet = " + board);
			
			// 봉사 게시글 담당자 이름 가져오기
			String name = volunteerBoardService.selectWriterName(no);
			
			//3. view단 처리
			request.setAttribute("board", board);
			request.setAttribute("name", name);
			request
			.getRequestDispatcher("/WEB-INF/views/volunteer_board/volunteerBoardUpdate.jsp")
			.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 0. MultipartRequest 객체 (첨부파일이 없을 때도 있겠지만 있다고 가정하고 하기)
			String saveDirectory = getServletContext().getRealPath("/upload/volunteer_board");
			
			int maxPostSize = 1024 * 1024 * 10; // 최대파일용량 10mb = 1kb * 1000 * 10
			String encoding = "utf-8"; // 인코딩
			FileRenamePolicy policy = new MvcFileRenamePolicy(); // 파일명 재지정 정책객체 // 커스터마이징함
			
			MultipartRequest multipartRequest = 
					new MultipartRequest(
							request, 
							saveDirectory, 
							maxPostSize, 
							encoding, 
							policy
							);
			
			// 1. 사용자입력값 처리
			int no = Integer.parseInt(multipartRequest.getParameter("no")); // 게시물 번호
			String existThumbnail = multipartRequest.getParameter("existThumbnail"); // 기존 썸네일 경로
			String title = multipartRequest.getParameter("title");
			String writer = multipartRequest.getParameter("writer");
			String centerName = multipartRequest.getParameter("centerName");
			String _startDate = multipartRequest.getParameter("startDate");
			String _endDate = multipartRequest.getParameter("endDate");
			String _deadlineDate = multipartRequest.getParameter("deadlineDate");
			int capacity = Integer.parseInt(multipartRequest.getParameter("capacity"));
			String place = multipartRequest.getParameter("place");
			System.out.println("thumbnail값 : " + multipartRequest.getFilesystemName("thumbnail"));
			
			// 봉사요일 직접입력 유무 사용자 입력값 지정
			String day = "";
			
			if("".equals(multipartRequest.getParameter("selboxDirectDay"))) {
				day = multipartRequest.getParameter("day");
			}
			else {
				day = multipartRequest.getParameter("selboxDirectDay");
			}
			
			// 봉사시간 직접입력 유무 사용자 입력값 지정
			String time = "";
			
			if("".equals(multipartRequest.getParameter("selboxDirectTime"))) {
				time = multipartRequest.getParameter("time");
			}
			else {
				time = multipartRequest.getParameter("selboxDirectTime");
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
			
			// 썸네일 사진 삭제 체크 시 값이 들어온다.
			String delFile = multipartRequest.getParameter("delFile");
			//System.out.println("delFile@servlet : "+ delFile);
			
			VolunteerBoard board = new VolunteerBoard(no, title, centerName, contents, startDate, endDate, email, phone, VolunteerBoardService.APPROVAL_NO, VolunteerBoardService.DELETE_NO, capacity, place, deadlineDate, null, time, day, VolunteerBoardService.VOLUNTEER_BOARD_CODE, writer, volunteerBoardService.ENROLL_YES, existThumbnail);
			System.out.println("board@servlet" + board);
			
			// 첨부파일 (첨부파일이 있다면)
			File f = multipartRequest.getFile("thumbnail");
			if(f != null) { // getFile하면 파일객체를 리턴한다.
				String filePath = "upload/volunteer_board/";
				board.setThumbnail(filePath + multipartRequest.getFilesystemName("thumbnail")); // board에 담아준다.
			}
			
			System.out.println("board.getThumbnail()값확인 : " + board.getThumbnail());
			
			// 2. 업무로직
			int result = 0;
			// 기존파일 삭제(서버컴퓨터 파일 삭제 + db 레코드삭제)
			System.out.println("delFile값 확인 : " + delFile);
			if(delFile != null) { // delFile은 게시글 번호이다.
				int boardNo = Integer.parseInt(delFile);
				saveDirectory = getServletContext().getRealPath("/");
				// 서버컴퓨터 파일 삭제
				// delFileName은 실제 delFile이고 위 delFile은 파라미터delFile이다!
				File delFileName = new File(saveDirectory, existThumbnail);
				delFileName.delete();
				
				// 첨부파일이 없는 경우에 db 레코드 삭제한다. 
				// why? 위의 조건문 if(delFile != null) 부분에서 update.jsp 코드 중 파일 업로드 할 시 $(delFile).prop("checked", true) 상태가 되어 delFile값이 null이 아니므로 조건문을 통과하게 된다. 
				// 따라서 아래 조건문(첨부파일이 없다면 db레코드 삭제)을 넣지 않는다면 파일 업로드를 하고도 db레코드를 삭제하여 파일은 저장되었지만 db상에서는 null 값이 되므로 아래 조건문을 넣어주었다.
				// 이와같이 처리하면 썸네일 사진 삭제 체크박스를 클릭하는 경우와 첨부파일 있는 경우 모두 문제없이 처리된다.(조건문을 넣지 않으면 썸네일 사진 클릭에서 삭제는 되지만 파일 업로드의 경우에는 db 썸네일이 null값이 들어감)
				if(f == null) {
					// db 레코드 삭제
					// 썸네일 제거 - null 처리 // 객체 공유 // 서비스단에서 board.setThumbnail(""); 처리함
					result = volunteerBoardService.deleteThumbnail(board);
					System.out.println(result > 0 ? "첨부파일 삭제 성공!" : "첨부파일 삭제 실패!");
				}
			}
			
			// 게시물 수정 + 첨부파일 등록
			result = volunteerBoardService.updateVolunteerBoard(board);
			String msg = result > 0 ? "봉사 게시물 수정 성공!" : "봉사 게시물 수정 실패!";
			//System.out.println("게시물수정 result 결과 : " + msg);
			
			// view단 처리 - redirect
			request.getSession().setAttribute("msg", msg);
			String location = request.getContextPath() + "/volunteerBoard/boardView?no=" + no;
			response.sendRedirect(location);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
