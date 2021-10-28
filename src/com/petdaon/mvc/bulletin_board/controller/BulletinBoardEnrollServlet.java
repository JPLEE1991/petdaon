package com.petdaon.mvc.bulletin_board.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.petdaon.mvc.bulletin_board.model.service.BulletinBoardService;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;
import com.petdaon.mvc.common.MvcFileRenamePolicy;
import com.petdaon.mvc.common.vo.Attachment;

/**
 * Servlet implementation class GalleryBoardEnrollServlet
 */
@WebServlet("/views/bulletin_board/boardForm")
public class BulletinBoardEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 0. 파일업로드
		
		// b. 파일저장결로
		// SerlvetContext객체로부터 
		ServletContext application = getServletContext();
		String saveDirectory = application.getRealPath("/upload/bulletinBoard");
		System.out.println("saveDirectory = " + saveDirectory);
		
		// c.최대파일용량 10mb = 1kb * 1000 * 10
		int maxPostSize = 1024 * 1024 * 10;
		
		// d. 인코딩
		String encoding = "utf-8";
		
		// e.파일명 재지정 정책 객체
		FileRenamePolicy policy = new MvcFileRenamePolicy();
		
		MultipartRequest multipartRequest =
				new MultipartRequest(
							request,
							saveDirectory,
							maxPostSize,
							encoding,
							policy
						);
		// 파일정보 가져오기
		String originalFilename = multipartRequest.getOriginalFileName("upFile");
		String renamedFilename = multipartRequest.getFilesystemName("upFile");
		
		// 1.사용자입력값처리
		String title = multipartRequest.getParameter("title");
		String writer = multipartRequest.getParameter("writer");
		String content = multipartRequest.getParameter("context");
		BulletinBoard board = new BulletinBoard(0, title, writer, content, null, 0, null);
		
		if(multipartRequest.getFile("upFile") != null) {
			Attachment attach = new Attachment();
			attach.setOriginalFilename(originalFilename);
			attach.setRenamedFilename(renamedFilename);
			board.setAttach(attach);
		}
		
		System.out.println("BulletinBoard@servlet = " + board);
		
		// 2. 업무로직
		int result = BulletinBoardService.insertBoard(board);
		System.out.println("BulletinBoard@servlet = " + board);
		
		// 3. 응답처리 : redirect
		HttpSession session = request.getSession();
		String location = request.getContextPath() + "/views/gallery_board/galleryBoardView?no=" + board.getNo();
		response.sendRedirect(location);
	}

}
