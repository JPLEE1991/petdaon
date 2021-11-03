package com.petdaon.mvc.bulletin_board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.petdaon.mvc.bulletin_board.model.service.BulletinBoardService;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;
import com.petdaon.mvc.common.MvcFileRenamePolicy;
import com.petdaon.mvc.common.vo.Attachment;
import com.petdaon.mvc.findMe_board.model.vo.Board;

/**
 * Servlet implementation class BulletinBoardUpdateServlet
 */
@WebServlet("/bulletin_board/boardUpdate")
public class BulletinBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private BulletinBoardService boardService = new BulletinBoardService(); // 의존객체
	
	/**
	 * update form 페이지 요청!
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1.사용자입력값 처리
		int no = Integer.parseInt(request.getParameter("no"));
		
		// 2.업무로직
		BulletinBoard board = boardService.selectOneBoard(no);
		System.out.println("board@servlet = " + board);
		
		// 3.view단 위임
		request.setAttribute("board", board);
		request
			.getRequestDispatcher("/WEB-INF/views/bulletin_board/boardList.jsp")
			.forward(request, response);
	}

	/**
	 * db update 요청!
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 0. MultipartRequest 객체
		String saveDirectory = getServletContext().getRealPath("/upload/bulletin_board");
		int maxPostSize = 1024 * 1024 * 10; 
		String encoding = "utf-8";
		FileRenamePolicy policy = new MvcFileRenamePolicy();
		MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		// 1. 사용자입력
		int no = Integer.parseInt(multipartRequest.getParameter("no"));
		String title = multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content");
		String animal = multipartRequest.getParameter("animal");
		String detail = multipartRequest.getParameter("detail");
		String category = multipartRequest.getParameter("category");

		BulletinBoard board = new BulletinBoard(0, "02", title, null, content, null, 0, 0, 0, animal, detail, category, null, null, null);
		
		// 첨부파일
		File f = multipartRequest.getFile("upFile");
		if(f != null) {
			Attachment attach = new Attachment();
			attach.setNo(no); 
			attach.setOriginalFilename(multipartRequest.getOriginalFileName("upFile"));
			attach.setRenamedFilename(multipartRequest.getFilesystemName("upFile"));
			board.setAttach(attach);
		}
		
		System.out.println("board@servlet = " + board);
		
		// 2. 업무로직 
		int result = 0;
		// 기존파일 삭제 (서버컴퓨터 파일 삭제 + db 레코드삭제)
		String delFile = multipartRequest.getParameter("delFile");
		if(delFile != null) {
			int attachNo = Integer.parseInt(delFile);
			Attachment attach = boardService.selectOneAttachment(attachNo);
			// 서버컴퓨터 파일 삭제
			File _delFile = new File(saveDirectory, attach.getRenamedFilename());
			_delFile.delete();
			// db 레코드삭제
			result = boardService.deleteAttachment(attachNo);
			System.out.println(result > 0 ? "첨부파일 삭제 성공!" : "첨부파일 삭제 실패!");
		}
		
		// 게시물 수정 + 첨부파일 등록
		result = boardService.updateBoard(board);
		String msg = result > 0 ? "게시물 수정 성공!" : "게시물 수정 실패!";
		
		// 3. redirect
		request.getSession().setAttribute("msg", msg);
		String location = request.getContextPath() + "/bulletn_board/boardView?no=" + no;
		response.sendRedirect(location);
		
		
		
	}
}
