package com.petdaon.mvc.bulletin_board.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.bulletin_board.model.service.BulletinBoardService;
import com.petdaon.mvc.common.vo.Attachment;

/**
 * Servlet implementation class BulletinBoardFileDownloadServlet
 */
@WebServlet("/bulletin_board/fileDownload")
public class BulletinBoardFileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BulletinBoardService boardService = new BulletinBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자입력값
		int no = Integer.parseInt(request.getParameter("no"));
		
		// 2. 업무로직
		Attachment attach = boardService.selectOneAttachment(no);
		System.out.println("attach@servlet = " + attach);
	
		
		// 3. view단처리
		// 서버컴퓨터의 파일을 읽기 -> Http응답메세지에 쓰기
		
		// 저장된 경로의 파일 입력스트림
		String saveDirectory = getServletContext().getRealPath("/upload/bulletin_board");
		String filename = attach.getRenamedFilename();
		File downFile = new File(saveDirectory, filename);
		System.out.println("downFile@servlet = " + downFile);
		
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(downFile));
		
		//응답메시지 출력스트림
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		
		// 응답메세지 헤더작성
		response.setContentType("application/octet-stream; charset=utf-8");
		// 헤더부 한글깨짐 방지
		String responseFilename = new String(attach.getOriginalFilename().getBytes("utf-8"), "iso-8859-1");
		response.setHeader("Content-Disposition", "attachment;filename=" + responseFilename);
		
		// 입력 & 출력
		int read = -1;
		while((read = bis.read()) != -1) {
			bos.write(read);
			
		}
		
		// 자원반납
		bos.close();
		bis.close();
		
	}

}
