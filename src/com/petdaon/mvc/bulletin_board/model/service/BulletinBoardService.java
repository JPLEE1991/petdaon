package com.petdaon.mvc.bulletin_board.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.petdaon.mvc.bulletin_board.model.dao.BulletinBoardDao;
import com.petdaon.mvc.bulletin_board.model.vo.BulletinBoard;
import com.petdaon.mvc.common.vo.Attachment;

public class BulletinBoardService {

	private static BulletinBoardDao boardDao = new BulletinBoardDao();
	
	public List<BulletinBoard> selectBoardList(int start, int end) {
		Connection conn = getConnection();
		List<BulletinBoard> list = boardDao.selectBoardList(conn, start, end);
		close(conn);
		return null;
	}

	public static int insertBoard(BulletinBoard board) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			//BulletinBoard테이블 행추가
			result = boardDao.insertBoard(conn, board);
			
			int boardNo = boardDao.selectLastBoardNo(conn);
			System.out.println("bulletinBoard@service = " + boardNo);
			
			//board 객체에 set -> servlet에서 참조
			board.setNo(boardNo);
			
			//attachment테이블 행추가
			Attachment attach = board.getAttach();
			if(attach != null) {
				attach.setBoardNo(boardNo);
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

}
