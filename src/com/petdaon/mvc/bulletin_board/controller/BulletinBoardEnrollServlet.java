package com.petdaon.mvc.bulletin_board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import com.petdaon.mvc.bulletin_board.model.service.BulletinBoardService;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;
import com.petdaon.mvc.common.MvcFileRenamePolicy;
import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.common.vo.Attachment;
import com.petdaon.mvc.common.vo.BoardComment;



/**
 * Servlet implementation class BulletinBoardEnrollServlet
 */
@WebServlet("/bulletin_board/boardEnroll")
public class BulletinBoardEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BulletinBoardService boardService = new BulletinBoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 0. 파일업로드
				System.out.println("BulletinBoardEnrollServlet...");
				
				// b.파일저장경로
				// ServletContext객체로부터 /WebContent/upload/bulletin_board 절대경로 참조
				ServletContext application = getServletContext(); 
				String saveDirectory = application.getRealPath("/upload/bulletin_board");
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
				String content = multipartRequest.getParameter("content");
				String animal = multipartRequest.getParameter("animal");
				String detail = multipartRequest.getParameter("detail");
				String category = multipartRequest.getParameter("category");
				
				BulletinBoard board = new BulletinBoard(0, "02", title, writer, content, null, 0, 0, 0, animal, detail, category, null, null, null);
				//BulletinBoard board = new BulletinBoard(0, null, writer, title, content, null, null, 0, null, animal, detail, category, null, null);
				
				if(multipartRequest.getFile("upFile") != null) {
					Attachment attach = new Attachment();
					attach.setOriginalFilename(originalFilename);
					attach.setRenamedFilename(renamedFilename);
					board.setAttach(attach);
				}
				
				System.out.println("BulletinBoardEnrollServlet attach 준비완료 = " + board);
				
				// 2. 업무로직
				int result = boardService.insertBoard(board);
				System.out.println("board@servlet = " + board);
				
				// 3. 응답처리 : redirect
				HttpSession session = request.getSession();
				String location = request.getContextPath() + "/bulletin_board/boardList";
				response.sendRedirect(location);
	}

}
				
				//		try {
//					//1.파리미터 글번호
//					int no  = Integer.parseInt(request.getParameter("no"));
//					
//					//2.비지니스로직 호출
//					// 읽음여부 확인(cookie)
//					Cookie[] cookies = request.getCookies();
//					boolean hasRead = false;
//					String boardValue = "";
//					
//					if(cookies != null) {
//						for(Cookie c : cookies) {
//							String name = c.getName();
//							String value = c.getValue();
//							System.out.println(name + " : " + value);
//							
//							if("board".equals(name)) {
//								boardValue = value;
//								// 현재 게시글 읽음여부
//								if(value.contains("|" + no + "|")) {
//									hasRead = true;
//								}
//								break;
//							}
//						}
//					}
//					
//					System.out.printf("hasRead = %b, boardValue = %s%n", hasRead, boardValue);
//					
//					// 게시글을 처음 읽는 경우
//					if(!hasRead) {
//						// 게시글 Cookie
//						Cookie cookie = new Cookie("board", boardValue + "|" + no + "|");
//						cookie.setMaxAge(365 * 24 * 60 * 60);
//						cookie.setPath(request.getContextPath() + "/board/boardView"); // 해당 요청시만 cookie전송
//						response.addCookie(cookie);
//						
//						//조회수 증가
//						int result = boardService.updateReadCount(no);			
//					}
//					
//					
//					//게시글 하나 가져오기
//					BulletinBoard board = boardService.selectOneBoard(no);
//					System.out.println(board);
//					
//					//게시글 가져오기에 실패한경우
//					if(board == null){
//						request.getSession().setAttribute("msg", "조회한 게시글이 존재하지 않습니다.");
//						response.sendRedirect(request.getContextPath() + "/board/boardList");
//						return;
//					}
//					
//					// XSS공격대비 
//					// cross-site script공격. 악성코드를 웹페이지삽입하여 클라이언트의 개인정보탈취하는 공격법
//					String content = MvcUtils.escapeHtml(board.getContent());
//					
//					// 개행문자 br태그 변환처리
//					content = MvcUtils.convertLineFeedToBr(content);
//					board.setContent(content);
//					
//					// 댓글목록 가져오기
////					List<BoardComment> commentList = boardService.selectCommentList(no);
////					System.out.println("commentList@servlet = " + commentList);
//					
//					//3.view단 처리위임
//					request.setAttribute("board", board);
////					request.setAttribute("commentList", commentList);
//					RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/board/boardView.jsp");
//					reqDispatcher.forward(request, response);
		//	
//					
//					
//					
//				} catch (Exception e) {
//					e.printStackTrace();
//					throw e;
//				}
