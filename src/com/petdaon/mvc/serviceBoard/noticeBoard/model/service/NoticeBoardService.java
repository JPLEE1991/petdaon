package com.petdaon.mvc.serviceBoard.noticeBoard.model.service;

import static com.petdaon.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;

import com.petdaon.mvc.serviceBoard.noticeBoard.model.dao.NoticeBoardDao;
import com.petdaon.mvc.serviceBoard.noticeBoard.model.vo.NoticeBoard;

public class NoticeBoardService {
	
	private NoticeBoardDao noticeBoardDao = new NoticeBoardDao();

	public List<NoticeBoard> selectNoticeBoardList(int start, int end) {
		Connection conn = getConnection();
		List<NoticeBoard> list = noticeBoardDao.selectNoticeBoardList(conn, start, end);
		close(conn);
		return list;
	}

	public int selectTotalContents() {
		Connection conn = getConnection();
		int totalContents = noticeBoardDao.selectTotalContents(conn);
		close(conn);
		return totalContents;
	}

	public NoticeBoard selectOneNoticeBoard(int no) {
		Connection conn = getConnection();
		NoticeBoard noticeBoard = noticeBoardDao.selectOneNoticeBoard(conn, no);
		close(conn);
		return noticeBoard;
	}

	public int updateViewNum(int no) {
		Connection conn = getConnection();
		int result = noticeBoardDao.updateViewNum(conn, no);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int deleteNoticeBoard(int no) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			result = noticeBoardDao.deleteNoticeBoard(conn, no);
			if(result == 0)
				throw new IllegalArgumentException("해당 공지글이 존재하지 않습니다. : " + no );
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int insertNoticeBoard(NoticeBoard noticeBoard) {
		Connection conn = getConnection();
		int result = noticeBoardDao.insertNoticeBoard(conn, noticeBoard);
		if(result > 0) commit(conn);
		else rollback(conn);

		close(conn);
		return result;
	}

	public int updateNoticeBoard(NoticeBoard noticeBoard) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = noticeBoardDao.updateNoticeBoard(conn, noticeBoard);
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
}
