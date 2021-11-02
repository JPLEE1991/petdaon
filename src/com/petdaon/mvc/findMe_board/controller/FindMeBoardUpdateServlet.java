package com.petdaon.mvc.findMe_board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcFileRenamePolicy;
import com.petdaon.mvc.common.vo.Attachment;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.petdaon.mvc.findMe_board.model.service.BoardService;
import com.petdaon.mvc.findMe_board.model.vo.Board;


/**
 * Servlet implementation class findMeBoardUpdateServlet
 */
@WebServlet("/findMe_board/boardUpdate")
public class FindMeBoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BoardService boardService = new BoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1.사용자입력값 처리
		int no = Integer.parseInt(request.getParameter("no"));
		
		// 2.업무로직
		Board board = boardService.selectOneBoard(no);
		System.out.println("board@servlet = " + board);
		
		// 3.view단 위임
		request.setAttribute("board", board);
		request
			.getRequestDispatcher("/WEB-INF/views/findMe_board/boardUpdate.jsp")
			.forward(request, response);
	}

	/**
	 * db update 요청!
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 0. MultipartRequest 객체
			String saveDirectory = getServletContext().getRealPath("/upload/findMe_board");
			int maxPostSize = 1024 * 1024 * 10; 
			String encoding = "utf-8";
			FileRenamePolicy policy = new MvcFileRenamePolicy();
			MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
			
			// 1. 사용자입력
			int no = Integer.parseInt(multipartRequest.getParameter("no"));
			String title = multipartRequest.getParameter("title");
			String writer = multipartRequest.getParameter("writer");
			String phone = multipartRequest.getParameter("phone");
			Date enrollDate = null;
			String gender = multipartRequest.getParameter("gender");
			String _weight = multipartRequest.getParameter("weight");
			String color = multipartRequest.getParameter("color");
			String character = multipartRequest.getParameter("character");
			String _missDate = multipartRequest.getParameter("missDate");
			String content = multipartRequest.getParameter("content");
			String status = multipartRequest.getParameter("status");
			String _completeYN = multipartRequest.getParameter("complete_yn");
		
			String _latclick = multipartRequest.getParameter("latclick");
			String _lngclick = multipartRequest.getParameter("lngclick");
			String paddress = multipartRequest.getParameter("paddress");
			String animalType = multipartRequest.getParameter("animalType");
			String breed = multipartRequest.getParameter("breed");
			
			//Integer,double 타입 형변환
			int weight = Integer.parseInt(_weight);
			double latclick = Double.valueOf(_latclick);
			double lngclick = Double.valueOf(_lngclick);
			String completeYN= "완료".equals(_completeYN)? "Y":"N";
			
			System.out.println("_missDate: "+_missDate);
			Date missDate = null;
			if(_missDate != null && !"".equals(_missDate))
				missDate = Date.valueOf(_missDate);
			System.out.println("missDate: "+missDate);
					
			
			Board board = new Board("01",no,title,"kh1231",phone,
									enrollDate,gender,weight,color,character,
									missDate,content,status,"N",completeYN,
									latclick,lngclick,paddress,"N",animalType,
									breed,null);
			
			// 첨부파일
			File f = multipartRequest.getFile("upFile");
			if(f != null) {
				Attachment attach = new Attachment();
				attach.setNo(board.getNo()); 
				attach.setOriginalFilename(multipartRequest.getOriginalFileName("upFile"));
				attach.setRenamedFilename(multipartRequest.getFilesystemName("upFile"));
				board.setAttach(attach);
			}
			
			System.out.println("@FindMeBoardUpdateServlet attach세팅후 board = " + board);
			
			// 2. 업무로직 
			int result = 0;
			// 기존파일 삭제 (서버컴퓨터 파일 삭제 + db 레코드삭제)
			String delFile = multipartRequest.getParameter("delFile");
			System.out.println("@FindMeBoardUpdateServlet delFile: "+delFile);
			if(delFile != null) {
				int attachNo = Integer.parseInt(delFile);
				Attachment attach = boardService.selectOneAttachment(attachNo);
				// 서버컴퓨터 파일 삭제
				File _delFile = new File(
						saveDirectory, 
						attach.getRenamedFilename());
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
			String location = request.getContextPath() + "/findMe_board/boardView?no=" + no;
			response.sendRedirect(location);
	}

}
