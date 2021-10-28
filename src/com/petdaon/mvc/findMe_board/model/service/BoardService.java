package com.petdaon.mvc.findMe_board.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.close;
import static com.petdaon.mvc.common.JdbcTemplate.getConnection;
import static com.petdaon.mvc.common.JdbcTemplate.*;


import java.sql.Connection;
import java.util.List;

import com.petdaon.mvc.common.vo.Attachment;
import com.petdaon.mvc.findMe_board.model.dao.BoardDao;
import com.petdaon.mvc.findMe_board.model.vo.Board;

public class BoardService {

	private BoardDao boardDao = new BoardDao();
	public int insertBoard(Board board) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			// board테이블 행추가
			result = boardDao.insertBoard(conn, board);
			
			// 생성된 board_no 가져오기
			int boardNo = boardDao.selectLastBoardNo(conn);
			System.out.println("boardNo@service = " + boardNo);
			
			// board객체에 set -> servlet에서 참조
			board.setNo(boardNo);
			
			// attachment테이블 행추가
			Attachment attach = board.getAttach();
			if(attach != null) {
				attach.setNo(boardNo);
				result = boardDao.insertAttachment(conn, attach);
			}
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			result = 0;
		}
		
		close(conn);
		return result;
	}
	public List<Board> selectBoardList(int start, int end) {
		Connection conn = getConnection();
		List<Board> list = boardDao.selectBoardList(conn, start, end);
		close(conn);
		return list;
		
	}
	
	public int selectTotalContents() {
		Connection conn = getConnection();
		int totalContents = boardDao.selectTotalContents(conn);
		close(conn);
		return totalContents;
	}
	public Board selectOneBoard(int no) {
		Connection conn = getConnection();
		Board board = boardDao.selectOneBoard(conn, no);
		Attachment attach = boardDao.selectOneAttachmentByBoardNo(conn,no);
		board.setAttach(attach);
		close(conn);
		return board;
	}

}
