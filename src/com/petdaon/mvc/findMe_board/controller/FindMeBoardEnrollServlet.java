package com.petdaon.mvc.findMe_board.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.petdaon.mvc.common.MvcFileRenamePolicy;
import com.petdaon.mvc.common.vo.Attachment;
import com.petdaon.mvc.findMe_board.model.service.BoardService;
import com.petdaon.mvc.findMe_board.model.vo.Board;

/**
 * Servlet implementation class BoardEnrollServlet
 */
@WebServlet("/findMe_board/boardEnroll")
public class FindMeBoardEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	
	/**
	 * 1. 파일업로드(사용자파일을 서버컴퓨터에 저장) : MultipartRequest객체 생성
	 * 	a. HttpServletRequest
	 * 	b. saveDirectory 파일이 저장될 directory
	 *  c. maxPostSize 업로드 최대용량(10mb)
	 *  d. encoding
	 *  e. FileRenamePolicy객체 : DefaultFileRenamePolicy객체 -> MvcFileRenamePolicy객체
	 * 	
	 * 
	 * 2. 저장된 파일정보를 db에 저장
	 * 
	 * 
	 * *MultipartRequest객체를 생성하면 기존의 HttpServletRequest객체로부터 사용자입력값을 가져올수 없다.
	 * 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 0. 파일업로드
		System.out.println("findMeBoardEnrollServlet...");
		
		
		// b. 파일저장경로
		// ServletContext객체로부터  /WebContent/upload/board 절대경로 참조
		ServletContext application = getServletContext(); 
		String saveDirectory = application.getRealPath("/upload/findMe_board");
		System.out.println("saveDirectory = " + saveDirectory);
		
		// c.최대파일용량 10mb = 1kb * 1000 * 10
		int maxPostSize = 1024 * 1024 * 10;
		
		// d.인코딩
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
		
		// 1. 사용자입력값처리
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
		String completeYN = multipartRequest.getParameter("complete_yn");
	
		String _latclick = multipartRequest.getParameter("latclick");
		String _lngclick = multipartRequest.getParameter("lngclick");
		String paddress = multipartRequest.getParameter("paddress");
		String animalType = multipartRequest.getParameter("animalType");
		String breed = multipartRequest.getParameter("breed");
		
		//Integer,double 타입 형변환
		int weight = Integer.parseInt(_weight);
		double latclick = Double.valueOf(_latclick);
		double lngclick = Double.valueOf(_lngclick);
		
		System.out.println("_missDate: "+_missDate);
		Date missDate = null;
		if(_missDate != null && !"".equals(_missDate))
			missDate = Date.valueOf(_missDate);
		System.out.println("missDate: "+missDate);
				
		
		Board board = new Board("01",0,title,writer,phone,
								enrollDate,gender,weight,color,character,
								missDate,content,status,"N",completeYN,
								latclick,lngclick,paddress,"N",animalType,
								breed,null);
		System.out.println("findMeBoardEnrollServlet attach 세팅 전 board" +board);
		
		if(multipartRequest.getFile("upFile") != null) {
			Attachment attach = new Attachment();
			attach.setOriginalFilename(originalFilename);
			attach.setRenamedFilename(renamedFilename);
			board.setAttach(attach);
		}
		
		System.out.println("@findMeBoardEnrollServlet attach 세팅 후= " + board);
		
		// 2. 업무로직
		int result = boardService.insertBoard(board);
//		String msg = result > 0 ? "게시물 등록 성공!" : "게시물 등록 실패!";
//		session.setAttribute("msg", msg);
		System.out.println("board@servlet = " + board);
		
		// 3. 응답처리 : redirect
		HttpSession session = request.getSession();
//		게시글 상세보기 페이지
//		String location = request.getContextPath() + "/board/boardView?no=" + board.getNo();
		
		//임시로 리스트 페이지
		String location = request.getContextPath() + "/findMe_board/boardList";
		response.sendRedirect(location);
	}

}
