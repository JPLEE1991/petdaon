package com.petdaon.mvc.bulletin_board.model.service;


import static com.petdaon.mvc.common.JdbcTemplate.close;
import static com.petdaon.mvc.common.JdbcTemplate.commit;
import static com.petdaon.mvc.common.JdbcTemplate.getConnection;
import static com.petdaon.mvc.common.JdbcTemplate.rollback;

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
        return list;
    }
    
	public int insertBoard(BulletinBoard board) {
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

	public int selectTotalContents() {
		Connection conn = getConnection();
		int totalContents = boardDao.selectTotalContents(conn);
		close(conn);
		return totalContents;
	}
	
	public BulletinBoard selectOneBoard(int no) {
		Connection conn = getConnection();
		BulletinBoard board = boardDao.selectOneBoard(conn, no);
		Attachment attach = boardDao.selectOneAttachment(conn, no);
		board.setAttach(attach);
		close(conn);
		return board;
	}

	public int updateReadCount(int no) {
		Connection conn = getConnection();
		int result = boardDao.updateReadCount(conn, no);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public Attachment selectOneAttachment(int no) {
		Connection conn = getConnection();
		Attachment attach = boardDao.selectOneAttachment(conn, no);
		close(conn);
		return attach;
		
	}

	public int deleteBoard(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = boardDao.deleteBoard(conn, no);
			if(result == 0)
				throw new IllegalArgumentException("해당 게시글이 존재하지 않습니다. : " + no );
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e; //controller가 예외처리를 결정할 수 있도록 넘김.
		} finally {
			close(conn);
		}
		return result;
	}

	public int updateBoard(BulletinBoard board) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 1.게시글 수정 update board문
			result = boardDao.updateBoard(conn, board);
			
			// 2.첨부파일이 있는 경우, insert into attachment문 실행
			Attachment attach = board.getAttach();
			if(attach != null) {
				result = boardDao.insertAttachment(conn, attach);
			}
			
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		
		return result;
	}

	public int deleteAttachment(int no) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = boardDao.deleteAttachment(conn, no);
			if(result == 0)
				throw new IllegalArgumentException("해당 첨부파일이 존재하지 않습니다. : " + no);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e; //controller가 예외처리를 결정할 수 있도록 넘김.
		} finally {
			close(conn);
		}
		return result;
	}
	
	
	
	
}